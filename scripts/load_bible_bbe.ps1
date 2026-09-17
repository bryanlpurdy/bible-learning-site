# ── Firstlight Bible Loader ────────────────────────────────────────────────
# Loads the Bible in Basic English (BBE) into the bible_verses Supabase table.
# Run once after creating the table with create_bible_verses.sql.
#
# Before running:
#   1. Run create_bible_verses.sql in the Supabase SQL editor
#   2. Replace YOUR_SERVICE_ROLE_KEY_HERE with your Supabase service role key
#      (Supabase dashboard → Settings → API → service_role secret)
# ---------------------------------------------------------------------------

$SUPABASE_URL = "https://api.bluestarrealtygroup.com"
$SERVICE_KEY  = "YOUR_SERVICE_ROLE_KEY_HERE"
$JSON_PATH    = "C:\Git\Projects\bible-learning-site\bible-basic-english\en_bbe.json"
$BATCH_SIZE   = 500

$headers = @{
    "apikey"        = $SERVICE_KEY
    "Authorization" = "Bearer $SERVICE_KEY"
    "Content-Type"  = "application/json"
    "Prefer"        = "return=minimal"
}

Write-Host "Reading BBE JSON..."
$books = Get-Content $JSON_PATH -Raw | ConvertFrom-Json

# Build flat list of all verse rows
$rows   = [System.Collections.Generic.List[hashtable]]::new()
$bookId = 0

foreach ($book in $books) {
    $bookId++
    $testament = if ($bookId -le 39) { "OT" } else { "NT" }
    $chapNum   = 0

    foreach ($chapter in $book.chapters) {
        $chapNum++
        $verseNum = 0

        foreach ($verseText in $chapter) {
            $verseNum++
            $rows.Add(@{
                book_id   = $bookId
                book_name = $book.name
                testament = $testament
                chapter   = $chapNum
                verse     = $verseNum
                text      = $verseText
            })
        }
    }
}

Write-Host "Total verses to insert: $($rows.Count)"

# Insert in batches
$total    = $rows.Count
$inserted = 0

for ($i = 0; $i -lt $total; $i += $BATCH_SIZE) {
    $end   = [Math]::Min($i + $BATCH_SIZE - 1, $total - 1)
    $batch = $rows[$i..$end]
    $body  = $batch | ConvertTo-Json -Depth 3

    try {
        Invoke-RestMethod `
            -Uri     "$SUPABASE_URL/rest/v1/bible_verses" `
            -Method  POST `
            -Headers $headers `
            -Body    $body | Out-Null

        $inserted += $batch.Count
        Write-Host "  Inserted $inserted / $total"
    } catch {
        Write-Host "ERROR at batch starting $i`: $_" -ForegroundColor Red
        break
    }
}

Write-Host ""
Write-Host "Done. $inserted verses loaded." -ForegroundColor Green
