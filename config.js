// =====================================================================
//  KONFIGURASI e-Tri Dharma ARS
//  Isi dua nilai di bawah dari dashboard Supabase:
//    Project Settings  →  Data API   → "Project URL"
//    Project Settings  →  API Keys   → "Publishable key" (sb_publishable_...)
//                                      atau "anon public" key (legacy)
//
//  Kunci publishable/anon AMAN ditaruh di sini (data dilindungi RLS).
//  JANGAN PERNAH menaruh "secret" / "service_role" key di file ini!
// =====================================================================
window.APP_CONFIG = {
  SUPABASE_URL: "https://XXXXXXXX.supabase.co",
  SUPABASE_KEY: "sb_publishable_XXXXXXXX",
  BUCKET: "dokumen"
};
