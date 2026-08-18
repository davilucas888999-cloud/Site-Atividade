-- =========================================================
-- GESTÃO EDUCACIONAL V2 — SUPABASE
-- Execute no SQL Editor do seu projeto.
-- =========================================================
create extension if not exists pgcrypto;

create table if not exists profiles (
 id uuid primary key default gen_random_uuid(),
 username text unique not null,
 password_hash text not null,
 full_name text not null,
 role text not null check(role in ('student','teacher','admin')),
 class_id uuid,
 created_at timestamptz default now()
);

create table if not exists classes (
 id uuid primary key default gen_random_uuid(),
 name text unique not null,
 grade text,
 shift text,
 created_at timestamptz default now()
);

alter table profiles add constraint profiles_class_fk foreign key(class_id) references classes(id) on delete set null;

create table if not exists activities (
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text,
 class_id uuid references classes(id) on delete cascade,
 created_by uuid not null references profiles(id) on delete cascade,
 questions jsonb not null default '[]'::jsonb,
 published boolean not null default false,
 due_at timestamptz,
 created_at timestamptz default now()
);

create table if not exists submissions (
 id uuid primary key default gen_random_uuid(),
 activity_id uuid not null references activities(id) on delete cascade,
 student_id uuid not null references profiles(id) on delete cascade,
 answers jsonb not null default '[]'::jsonb,
 score integer not null default 0,
 total integer not null default 0,
 submitted_at timestamptz default now(),
 unique(activity_id,student_id)
);

-- Hash de senha simples para MVP usando pgcrypto.
-- Para produção, prefira Supabase Auth/identidade externa e não armazene
-- senhas da aplicação dessa maneira.
create or replace function login_user(p_username text,p_password text)
returns json
language plpgsql
security definer
as $$
declare r profiles;
begin
 select * into r from profiles where username=p_username and password_hash=crypt(p_password,password_hash) limit 1;
 if not found then return json_build_object('id',null); end if;
 return json_build_object(
  'id',r.id,'username',r.username,'full_name',r.full_name,'role',r.role,'class_id',r.class_id,
  'class_name',(select name from classes where id=r.class_id)
 );
end $$;

-- =========================================================
-- RLS
-- IMPORTANTE: este MVP usa uma RPC para login. Para produção,
-- migre a autenticação para Supabase Auth e políticas baseadas
-- em auth.uid().
-- =========================================================
alter table profiles enable row level security;
alter table classes enable row level security;
alter table activities enable row level security;
alter table submissions enable row level security;

create policy "public class read" on classes for select to anon using (true);
create policy "public activities read" on activities for select to anon using (published=true);
create policy "public submissions insert" on submissions for insert to anon with check (true);

-- O painel administrativo deste MVP usa anon para simplificar o protótipo.
-- NÃO use estas permissões em produção com dados reais sem migrar para Auth.
create policy "prototype profiles read" on profiles for select to anon using (true);
create policy "prototype classes insert" on classes for insert to anon with check (true);
create policy "prototype activities insert" on activities for insert to anon with check (true);
create policy "prototype activities update" on activities for update to anon using (true) with check (true);
create policy "prototype submissions read" on submissions for select to anon using (true);

-- Realtime
alter publication supabase_realtime add table activities;
alter publication supabase_realtime add table submissions;

-- =========================================================
-- DADOS INICIAIS
-- Senha inicial dos exemplos: 123456
-- Troque/remova antes de uso real.
-- =========================================================
insert into classes(name,grade,shift)
values ('701','7º ano','Manhã'),('702','7º ano','Manhã')
on conflict(name) do nothing;

insert into profiles(username,password_hash,full_name,role,class_id)
values
('professor',crypt('123456',gen_salt('bf')),'Professor Demo','teacher',null)
on conflict(username) do nothing;

insert into profiles(username,password_hash,full_name,role,class_id)
select 'aluno702',crypt('123456',gen_salt('bf')),'Aluno Demo','student',id
from classes where name='702'
on conflict(username) do nothing;
