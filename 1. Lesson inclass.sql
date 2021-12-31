
SELECT name FROM tracks;
SELECT Composer, name FROM tracks;
SELECT * FROM tracks;
/* burasi comment*/
-- burasi da comment

SELECT Composer FROM tracks;
SELECT DISTINCT Composer FROM tracks;
-- distict tekrarsizlari alir
-- string verilerde bir nokta bile farkli olsa farkli olur

SELECT DISTINCT AlbumId, MediaTypeId FROM tracks;
-- 2 column secip distinct yaparsak iki satirin ayni olmasi icin iki colon verisi ayni olmasi lazim

SELECT name FROM tracks WHERE Composer = 'Jimi Hendrix';
-- burada H büyük olmali

SELECT CustomerId, InvoiceDate, total FROM invoices WHERE total > 10;

/* limit clause */






