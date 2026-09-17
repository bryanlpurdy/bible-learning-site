-- Run this in the Supabase SQL editor before running the PowerShell load script.

create table bible_verses (
  id        serial primary key,
  book_id   integer not null,   -- 1–66
  book_name text    not null,   -- "Genesis", "Matthew", etc.
  testament text    not null,   -- 'OT' or 'NT'
  chapter   integer not null,
  verse     integer not null,
  text      text    not null
);

-- Fast lookup by reference (e.g. book 43, chapter 3, verse 16)
create index idx_bible_ref on bible_verses (book_id, chapter, verse);

-- Full-text search across all verse text
create index idx_bible_fts on bible_verses using gin(to_tsvector('english', text));

-- Public read — no auth required (Bible text is static, read-only)
alter table bible_verses enable row level security;

create policy "Public read bible verses"
  on bible_verses for select
  using (true);
