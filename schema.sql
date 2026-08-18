-- BANCO DE DADOS — Gestão Educacional
-- Execute este script no SQL Editor do Supabase.

create extension if not exists pgcrypto;

create table if not exists students (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  student_class text not null,
  created_at timestamptz not null default now(),
  unique(name, student_class)
);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  student_class text not null default 'TODAS',
  questions jsonb not null default '[]'::jsonb,
  published boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists submissions (
  id uuid primary key default gen_random_uuid(),
  activity_id uuid not null references activities(id) on delete cascade,
  student_id uuid not null references students(id) on delete cascade,
  answers jsonb not null default '[]'::jsonb,
  score integer not null default 0,
  total integer not null default 0,
  submitted_at timestamptz not null default now()
);

alter table students enable row level security;
alter table activities enable row level security;
alter table submissions enable row level security;

-- Para uma primeira versão escolar simples. Em produção, troque por autenticação
-- de professor/aluno e políticas por usuário/turma.
create policy "students_read" on students for select to anon using (true);
create policy "students_insert" on students for insert to anon with check (true);
create policy "students_update" on students for update to anon using (true) with check (true);

create policy "activities_read" on activities for select to anon using (true);
create policy "activities_insert" on activities for insert to anon with check (true);
create policy "activities_update" on activities for update to anon using (true) with check (true);

create policy "submissions_read" on submissions for select to anon using (true);
create policy "submissions_insert" on submissions for insert to anon with check (true);

-- IMPORTANTE: habilite Realtime para as tabelas.
alter publication supabase_realtime add table activities;
alter publication supabase_realtime add table submissions;
