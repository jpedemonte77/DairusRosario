-- ============================================================
--  CARTA DIGITAL — estructura de la base de datos
--  Pegá TODO este archivo en Supabase → SQL Editor → Run.
--  Se puede volver a correr sin romper nada.
-- ============================================================

-- ------------------------------------------------------------
-- 1. TABLAS
-- ------------------------------------------------------------

-- Ajustes generales del bar: una sola fila (id = 1)
create table if not exists public.settings (
  id              int primary key default 1,
  bar_name        text not null default 'Mi Bar',
  tagline         text default '',
  logo_url        text,
  bg_url          text,
  bg_dim          numeric not null default 0.60,   -- 0 = foto nítida, 1 = fondo negro
  accent          text not null default '#e2b263',
  font            text not null default 'serif',   -- serif | sans | condensed
  currency_symbol text not null default '$',
  footer_text     text default '',
  updated_at      timestamptz not null default now(),
  constraint settings_una_sola_fila check (id = 1)
);

-- Secciones de la carta (Tragos, Cervezas, Cocina…)
create table if not exists public.categories (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  description text default '',
  sort_order  int  not null default 0,
  visible     boolean not null default true,
  created_at  timestamptz not null default now()
);

-- Productos de cada sección
create table if not exists public.products (
  id          uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.categories(id) on delete cascade,
  name        text not null,
  description text default '',
  price       numeric(12,2),
  price_note  text default '',            -- "473 ml", "para 2"…
  sort_order  int  not null default 0,
  visible     boolean not null default true,
  created_at  timestamptz not null default now()
);

create index if not exists products_category_idx on public.products (category_id, sort_order);
create index if not exists categories_order_idx  on public.categories (sort_order);

-- Fila única de ajustes
insert into public.settings (id) values (1) on conflict (id) do nothing;


-- ------------------------------------------------------------
-- 2. PERMISOS  (RLS)
--    Cualquiera puede LEER la carta.
--    Sólo un usuario logueado puede MODIFICARLA.
-- ------------------------------------------------------------

alter table public.settings   enable row level security;
alter table public.categories enable row level security;
alter table public.products   enable row level security;

do $$
declare t text;
begin
  foreach t in array array['settings','categories','products'] loop
    execute format('drop policy if exists "lectura publica" on public.%I', t);
    execute format('drop policy if exists "escritura admin" on public.%I', t);

    -- lectura para todo el mundo (clientes del bar, sin cuenta)
    execute format(
      'create policy "lectura publica" on public.%I for select to anon, authenticated using (true)', t);

    -- alta/baja/modificación sólo para usuarios logueados
    execute format(
      'create policy "escritura admin" on public.%I for all to authenticated using (true) with check (true)', t);
  end loop;
end $$;

-- ⚠️  IMPORTANTE: en Supabase → Authentication → Sign In / Providers,
--     DESACTIVÁ "Allow new users to sign up".
--     Si no, cualquiera podría crearse una cuenta y editar la carta.
--     (Al final del archivo hay una variante todavía más estricta.)


-- ------------------------------------------------------------
-- 3. IMÁGENES  (Storage)
-- ------------------------------------------------------------

insert into storage.buckets (id, name, public)
values ('carta', 'carta', true)
on conflict (id) do update set public = true;

drop policy if exists "carta imagenes lectura"  on storage.objects;
drop policy if exists "carta imagenes subir"    on storage.objects;
drop policy if exists "carta imagenes editar"   on storage.objects;
drop policy if exists "carta imagenes borrar"   on storage.objects;

create policy "carta imagenes lectura" on storage.objects
  for select to anon, authenticated using (bucket_id = 'carta');

create policy "carta imagenes subir" on storage.objects
  for insert to authenticated with check (bucket_id = 'carta');

create policy "carta imagenes editar" on storage.objects
  for update to authenticated using (bucket_id = 'carta') with check (bucket_id = 'carta');

create policy "carta imagenes borrar" on storage.objects
  for delete to authenticated using (bucket_id = 'carta');


-- ------------------------------------------------------------
-- 4. DATOS DE EJEMPLO  (opcional — borralos desde el panel)
--    Sólo se cargan si la carta está vacía.
-- ------------------------------------------------------------

do $$
declare c1 uuid; c2 uuid; c3 uuid;
begin
  if (select count(*) from public.categories) > 0 then return; end if;

  insert into public.categories (name, description, sort_order)
    values ('Para picar', '', 1) returning id into c1;
  insert into public.categories (name, description, sort_order)
    values ('Tragos de autor', 'Preparados al momento', 2) returning id into c2;
  insert into public.categories (name, description, sort_order)
    values ('Cervezas', '', 3) returning id into c3;

  insert into public.products (category_id, name, description, price, price_note, sort_order) values
    (c1, 'Papas bravas',        'Con alioli de ajo asado y pimentón ahumado',      6500, '',        1),
    (c1, 'Tabla de fiambres',   'Tres quesos, jamón crudo y encurtidos',          12800, 'para 2',  2),
    (c2, 'Negroni de la casa',  'Gin infusionado en pomelo, vermut rosso, campari', 8200, '',       1),
    (c2, 'Gin tonic botánico',  'Gin nacional, tónica, romero y enebro',            7600, '',       2),
    (c3, 'Pinta rubia tirada',  '',                                                 4500, '473 ml', 1),
    (c3, 'IPA rotativa',        'Preguntá cuál está de turno',                      5200, '473 ml', 2);

  update public.settings
     set bar_name    = 'Mi Bar',
         tagline     = 'Cocina de barra · Coctelería',
         footer_text = E'Tu dirección · Horarios\n@tuinstagram'
   where id = 1;
end $$;


-- ============================================================
--  VARIANTE ESTRICTA (opcional)
--  Si preferís no depender de tener los registros desactivados,
--  descomentá este bloque y reemplazá el email por el tuyo.
--  Así, aunque alguien se cree una cuenta, no podrá editar nada.
-- ============================================================
--
-- create table if not exists public.admins (
--   user_id uuid primary key references auth.users(id) on delete cascade
-- );
-- alter table public.admins enable row level security;
--
-- insert into public.admins (user_id)
--   select id from auth.users where email = 'TUEMAIL@ejemplo.com'
--   on conflict do nothing;
--
-- do $$
-- declare t text;
-- begin
--   foreach t in array array['settings','categories','products'] loop
--     execute format('drop policy if exists "escritura admin" on public.%I', t);
--     execute format(
--       'create policy "escritura admin" on public.%I for all to authenticated
--          using (exists (select 1 from public.admins a where a.user_id = auth.uid()))
--          with check (exists (select 1 from public.admins a where a.user_id = auth.uid()))', t);
--   end loop;
-- end $$;
