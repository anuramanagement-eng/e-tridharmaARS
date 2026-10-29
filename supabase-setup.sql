-- =====================================================================
--  SETUP DATABASE e-Tri Dharma ARS  (jalankan SEKALI di Supabase SQL Editor)
--  Aman dijalankan ulang: tidak menghapus data yang sudah ada.
-- =====================================================================

-- 1) TABEL DOKUMEN ------------------------------------------------------
create table if not exists public.dokumen (
  id               uuid primary key default gen_random_uuid(),
  created_at       timestamptz not null default now(),
  pengunggah       text default '-',
  kategori         text default '-',
  tahun_ajaran     text default '-',
  semester         text default '-',
  nama_file        text default '-',
  mata_kuliah      text default '-',
  semester_mk      text default '-',
  metode           text default '-',
  kurikulum_rps    text default '-',
  bentuk_hasil     text default '-',
  indeks_jurnal    text default '-',
  penerbit_buku    text default '-',
  isbn             text default '-',
  jenis_produk     text default '-',
  deskripsi_produk text default '-',
  nomor_ec         text default '-',
  link_publikasi   text default '-',
  keterangan       text default '-',
  file_path        text,            -- lokasi file di Supabase Storage (dokumen baru)
  file_url         text,            -- link lama (mis. Google Drive) untuk data impor
  file_name        text,
  sdg_terpilih     text default '-',
  sdg_persentase   text default '-',
  uploaded_by      uuid default auth.uid() references auth.users(id) on delete set null
);

create index if not exists dokumen_created_at_idx on public.dokumen (created_at desc);
create index if not exists dokumen_kategori_idx   on public.dokumen (kategori);

-- 2) KEAMANAN TABEL (RLS): hanya pengguna yang sudah login -------------
alter table public.dokumen enable row level security;

drop policy if exists "dokumen_select_login" on public.dokumen;
drop policy if exists "dokumen_insert_login" on public.dokumen;
drop policy if exists "dokumen_update_login" on public.dokumen;
drop policy if exists "dokumen_delete_login" on public.dokumen;

create policy "dokumen_select_login" on public.dokumen
  for select to authenticated using (true);
create policy "dokumen_insert_login" on public.dokumen
  for insert to authenticated with check (true);
create policy "dokumen_update_login" on public.dokumen
  for update to authenticated using (true) with check (true);
create policy "dokumen_delete_login" on public.dokumen
  for delete to authenticated using (true);

-- 3) STORAGE BUCKET (privat, batas 40 MB per file) ---------------------
insert into storage.buckets (id, name, public, file_size_limit)
values ('dokumen', 'dokumen', false, 41943040)
on conflict (id) do update set file_size_limit = excluded.file_size_limit;

drop policy if exists "dokumen_storage_select" on storage.objects;
drop policy if exists "dokumen_storage_insert" on storage.objects;
drop policy if exists "dokumen_storage_delete" on storage.objects;

create policy "dokumen_storage_select" on storage.objects
  for select to authenticated using (bucket_id = 'dokumen');
create policy "dokumen_storage_insert" on storage.objects
  for insert to authenticated with check (bucket_id = 'dokumen');
create policy "dokumen_storage_delete" on storage.objects
  for delete to authenticated using (bucket_id = 'dokumen');

-- Selesai. Cek: Table Editor → dokumen, dan Storage → bucket "dokumen".
