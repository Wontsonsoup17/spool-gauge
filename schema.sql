-- Spool Gauge — Supabase schema
-- Paste this whole file into your Supabase project's SQL Editor and run it once.
-- It creates one table, turns on row-level security, and restricts every row
-- to the signed-in user who owns it.

create table if not exists public.spool_state (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  payload    jsonb not null default '{"activeId":null,"spools":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.spool_state enable row level security;

-- Each signed-in user can read and write exactly one row: their own.
drop policy if exists "own row select" on public.spool_state;
create policy "own row select" on public.spool_state
  for select using (auth.uid() = user_id);

drop policy if exists "own row insert" on public.spool_state;
create policy "own row insert" on public.spool_state
  for insert with check (auth.uid() = user_id);

drop policy if exists "own row update" on public.spool_state;
create policy "own row update" on public.spool_state
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own row delete" on public.spool_state;
create policy "own row delete" on public.spool_state
  for delete using (auth.uid() = user_id);

-- Live updates between your devices.
alter publication supabase_realtime add table public.spool_state;
