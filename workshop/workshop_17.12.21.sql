SELECT name, Composer
FROM tracks;

---------------
/*  */

SELECT *
FROM tracks;

--------------

SELECT DISTINCT Composer
FROM tracks;

-----------------

SELECT DISTINCT AlbumId, MediaTypeId
FROM tracks;

-------------

SELECT name, TrackId
FROM tracks
WHERE Composer = "Jorge Ben";

--------------------

SELECT *
FROM invoices
WHERE total > 25;

---------------------

SELECT * 
FROM invoices
WHERE total < 15
ORDER by total
LIMIT 5;
------------------------

SELECT *
FROM invoices
WHERE total > 10
order by total DESC
LIMIT 2;
------------------

SELECT *
FROM invoices
WHERE NOT BillingCountry = "Canada"
ORDER by total ASC
LIMIT 10;
---------------------
SELECT *
FROM invoices
WHERE BillingCountry <> "Canada"
ORDER by total ASC
LIMIT 10;

----------------------------
SELECT InvoiceId, CustomerId, total
FROM invoices
ORDER by CustomerId ASC, total DESC;
------------------------------

SELECT name
FROM tracks
WHERE name like "B%s";
-------------------------

SELECT name
FROM tracks
WHERE name like "B__ A_____";
----------------------------------

SELECT max(InvoiceDate)
FROM invoices
WHERE InvoiceDate BETWEEN "2008-01-01" and "2011-12-31";
------------------------------

SELECT InvoiceDate
FROM invoices
WHERE InvoiceDate BETWEEN "2008-01-01" and "2011-12-31"
ORDER by InvoiceDate DESC
LIMIT 1;
-----------------------------------

SELECT FirstName, LastName, country
FROM customers
WHERE country = "Norway" or country = "Belgium";

-----------------------

SELECT FirstName, LastName, country
FROM customers
WHERE country in("Norway", "Belgium");
-------------------------------------

SELECT name
FROM tracks
WHERE Composer in("Frank Zappa");
-----------------------------------

SELECT name
FROM tracks
WHERE Composer like "% Zappa";

------------------------------

SELECT count(TrackId)
FROM tracks;
--------------------

SELECT count(InvoiceId)
FROM invoices;

------------------------

SELECT count(*)
FROM tracks;


-----------------------

SELECT count(*)
FROM tracks;
------------------------
SELECT count(Composer)
FROM tracks;
---------------------

SELECT count(DISTINCT Composer)
FROM tracks;
---------------------

SELECT AlbumId, count(name) as toplam
FROM tracks
GROUP by AlbumId
ORDER by toplam DESC;
-----------------------------

SELECT AlbumId, count(*) as toplam
FROM tracks
GROUP by AlbumId
ORDER by toplam DESC;
----------------------------
-- minimum
SELECT name, min(Milliseconds)  -- sadece buna min yazmamiz yterli
FROM tracks;
---------------------------
-- minimum
SELECT name, Milliseconds
FROM tracks
ORDER by Milliseconds
LIMIT 1;
----------------------
SELECT name, max(Milliseconds)
FROM tracks;
---------------------------

SELECT avg(Milliseconds)
FROM tracks;

-----------------------

SELECT round(avg(Milliseconds), 3)
FROM tracks;
--------------------------

SELECT name, Milliseconds
FROM tracks
WHERE Milliseconds > 393599.212;
-------------------------

SELECT name, Milliseconds
FROM tracks
WHERE Milliseconds > (SELECT avg(Milliseconds)
					   FROM tracks);
					   
--------------------------------------

SELECT Composer, count(name) as toplam_track
FROM tracks
GROUP by Composer;
--------------------------

SELECT DISTINCT Composer
FROM tracks;
---------------------------------

SELECT GenreId, name
FROM tracks;

-------------------------

SELECT genres.GenreId, tracks.name, genres.name
FROM genres
JOIN tracks
on genres.GenreId = tracks.GenreId;

----------------------------------

SELECT tracks.name, genres.GenreId, genres.Name
FROM tracks
JOIN genres
on genres.GenreId = tracks.GenreId;

------------------------------------------

SELECT artists.ArtistId, albums.AlbumId, albums.Title
FROM artists
JOIN albums
on artists.ArtistId = albums.ArtistId;
-----------------------------------------

SELECT *
FROM artists
LEFT JOIN albums
on artists.ArtistId = albums.AlbumId;

-----------------------------------------

SELECT albums.AlbumId, albums.Title, min(tracks.Milliseconds)
FROM albums
JOIN tracks
on albums.AlbumId = tracks.AlbumId
GROUP by albums.AlbumId, albums.Title
ORDER by min(tracks.Milliseconds) DESC;

-------------------------------------------

SELECT albums.Title, sum(tracks.Milliseconds) as toplam
FROM albums
JOIN tracks
on albums.AlbumId = tracks.AlbumId
GROUP by albums.Title
HAVING toplam > 3600000		-- join de having 
ORDER by toplam DESC;
---------------------------------------

SELECT tracks.TrackId, tracks.name, albums.AlbumId
FROM tracks
JOIN albums
on tracks.AlbumId = albums.AlbumId
WHERE albums.Title = "Prenda Minha" or albums.Title = "Heart of the Night" or albums.Title = "Out Of Exile";


---------------------------------------------


select TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId in(SELECT AlbumId
				 FROM albums
				 WHERE Title in("Prenda Minha", "Heart of the Night", "Out Of Exile"));