# e-Tri Dharma ARS

Arsip dokumen Tri Dharma Program Studi S1 Administrasi Rumah Sakit — Universitas Borneo Lestari.

- **Frontend:** HTML + Bootstrap 5 (statis, di-hosting Netlify)
- **Backend:** Supabase (Auth, Postgres, Storage)

## Struktur

| File | Fungsi |
|---|---|
| `index.html` | Aplikasi (login, input dokumen, daftar & statistik) |
| `config.js` | URL & publishable key Supabase — **wajib diisi** |
| `supabase-setup.sql` | Skrip pembuatan tabel, bucket, dan keamanan (RLS) |
| `netlify.toml` | Pengaturan deploy Netlify |

## Setup singkat

1. Supabase → SQL Editor → jalankan `supabase-setup.sql`.
2. Supabase → Authentication → matikan *Allow new users to sign up*, lalu **Add user** (centang *Auto Confirm*).
3. Isi `config.js` dengan Project URL + Publishable key.
4. Push ke GitHub → Netlify *Import from Git* → Deploy.
5. Supabase → Authentication → URL Configuration → isi *Site URL* dengan alamat Netlify.

> Jangan pernah menaruh **secret / service_role key** di repository ini.
