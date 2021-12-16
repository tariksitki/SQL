
-- Soru 1:
SELECT AlbumId, count(name) as toplam_track
FROM tracks
GROUP by AlbumId
ORDER by toplam_track DESC;

-- soru 2:

SELECT 
tracks.name, albums.Title
FROM tracks
INNER JOIN albums
on tracks.AlbumId = albums.AlbumId;


----  soru3:

SELECT
albums.AlbumId,
albums.Title,
min(tracks.Milliseconds) as minimum_duration
FROM albums
INNER JOIN tracks						-- bu soruda gruplandirma eksik
on albums.AlbumId = tracks.AlbumId
GROUP by albums.AlbumId
ORDER by minimum_duration DESC;



-- soru 4:

SELECT
albums.AlbumId,
albums.Title,
sum(tracks.Milliseconds) as total_duration
FROM albums
INNER JOIN tracks
on albums.AlbumId = tracks.AlbumId
GROUP by albums.AlbumId
ORDER by total_duration DESC;


-- soru5:

SELECT
albums.Title,
sum(tracks.Milliseconds) as toplam
FROM albums
INNER JOIN tracks
on albums.AlbumId = tracks.AlbumId
WHERE Milliseconds > 4200000  -- 1 dk 60.000 milisaniye
GROUP by albums.AlbumId;





