-- ==========================================================
-- BANCO PARA A VERSÃO COMPLETA
-- IMPORTANTE: em produção, use Supabase Auth para senhas.
-- O frontend contém apenas contas DEMO para visualização.
-- ==========================================================
create extension if not exists pgcrypto;

create table if not exists classes(
 id uuid primary key default gen_random_uuid(),
 name text unique not null,
 grade text,
 shift text,
 created_at timestamptz default now()
);

create table if not exists profiles(
 id uuid primary key default gen_random_uuid(),
 username text unique not null,
 full_name text not null,
 email text,
 role text not null check(role in('student','teacher','admin')),
 class_id uuid references classes(id) on delete set null,
 created_at timestamptz default now()
);

create table if not exists activities(
 id uuid primary key default gen_random_uuid(),
 title text not null,
 description text,
 class_id uuid references classes(id) on delete cascade,
 created_by uuid references profiles(id) on delete cascade,
 questions jsonb not null default '[]',
 published boolean default false,
 due_at timestamptz,
 created_at timestamptz default now()
);

create table if not exists submissions(
 id uuid primary key default gen_random_uuid(),
 activity_id uuid references activities(id) on delete cascade,
 student_id uuid references profiles(id) on delete cascade,
 answers jsonb not null default '[]',
 score integer not null default 0,
 total integer not null default 0,
 submitted_at timestamptz default now(),
 unique(activity_id,student_id)
);

insert into classes(name,grade,shift)
values('702','7º ano','Manhã')
on conflict(name) do nothing;

-- Perfil de demonstração. Para produção, crie o usuário no Supabase Auth
-- e vincule o auth.users.id a profiles.id.
insert into profiles(username,full_name,email,role,class_id)
select 'davi702','DAVI LUCAS PAULINO DA COSTA','davilucascosta031@gmail.com','student',id
from classes where name='702'
on conflict(username) do update set full_name=excluded.full_name,email=excluded.email;

insert into profiles(username,full_name,email,role)
values('gracinha','MARIA DAS GRAÇAS DE AMORIM SOUSA SILVA',null,'teacher')
on conflict(username) do update set full_name=excluded.full_name;

alter table classes enable row level security;
alter table profiles enable row level security;
alter table activities enable row level security;
alter table submissions enable row level security;

-- Políticas iniciais para protótipo.
-- Antes de dados reais: substitua por políticas usando auth.uid().
create policy "classes_read" on classes for select to anon using(true);
create policy "profiles_read" on profiles for select to anon using(true);
create policy "activities_read" on activities for select to anon using(published=true);
create policy "submissions_insert" on submissions for insert to anon with check(true);
create policy "submissions_read" on submissions for select to anon using(true);

alter publication supabase_realtime add table activities;
alter publication supabase_realtime add table submissions;
