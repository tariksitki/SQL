-- Günümüzde yüksek seviye diller ile
-- sorgulama yapmak cok yaygindir.
-- yani python yada java gibi dillerle
-- sorgulama yapmak. Burada arada
-- bir cevirici bulunur ve bizim kodlarimizi
-- sql diline cevirir


-- bizim ögrenmedigimiz konular
-- triger
-- prosedürler
-- exceptionlar
-- func'lar


-- cross join kartezyen carpimi return eder

-- full join birlesim kümesi
-- inner da kesisim


-- Not: vs code da ekranin altinda db yazan yere
-- tiklarsak baska bir db secebiliriz


SELECT *
FROM siparisler;

-- 1001 ve 1003  id li arabalardan ikiser adet siparis 
-- verilmistir

-- 1004 den ise sadece 1 tane


-- Bizim alacagimiz verilerin hepsi tek bior tabloda ise o zaman
-- join kullanmamiza gerek yoktur


--- select satirinda sütunlari yazarken birden cok tablo
-- kullandigimiz icin, önce tablo ismi sonra sütun ismi
-- yaziyoruz. eger sütun isimleri tamamen farkli olursa iki
-- tabloda da o zaman yazmasak da olur. ama 
-- best practice de yazmamiz gerekir


-- yazma kolayligi saglamasi icin join islemlerinde
-- tablo isimleri kisaltilabilir

-- Bu islemde, önce kisaltmalari tanimlamak zorundayiz
-- tanimlama islemi de from ve join satirlarinda olur

-- from satirinda tablo1 in kisaltmasi yapilir
-- join satirinda ise tablo2 nin

SELECT m.marka_id, s.siparis_adedi
FROM markalar m 
JOIN siparisler s 
ON m.marka_id = s.marka_id;


-- tablo adi kisaltma islemi, as ile de yapilabilir

SELECT m.marka_id, s.siparis_adedi
FROM markalar as m 
JOIN siparisler as s 
ON m.marka_id = s.marka_id;


SELECT m.marka_id, s.siparis_adedi
FROM markalar as m 
JOIN siparisler as s 
ON m.marka_id = s.marka_id;


-- git branch -m yeni branchadi
-- bu komut ile ana branch imizin adini degistiririz


-- Normalde kullanim su sekildedir.
-- markalar tablosu agirlikli:  left
-- siparisler agirlikli :  right
-- ortak noktalar:  inner
-- hepsi   : full


-- chinook veri tabaninda tracks tablosunda her bir sarkinin
-- türü genre listeleyiniz
-- yani genres tablosu ile tracks tablosu join

SELECT *
FROM genres;

SELECT *
FROM tracks;


SELECT t.Name as song_name, g.Name as song_genre
FROM tracks t 
JOIN genres g 
ON t.GenreId = g.GenreId;


-- Burada left join de yapsak ayni sonucu
-- alacagizdir. yani ilk tabloda olan hersey
-- ikinci tabloda da bulunmaktadir
-- yani null yok demektir



-- Soru:  invoice tablosunda faturalarin her birinin
-- first name lastname fatura tarihi
 -- ve fatura meblagini total
-- listeleyen sorgu yaziniz
-- diger tablo customers olmali

SELECT *
from invoices;

SELECT *
FROM customers;



SELECT c.FirstName, c.LastName, i.InvoiceDate, i.Total
FROM customers c 
JOIN invoices i 
on c.CustomerId = i.CustomerId;


-- Burada da left join yaparsak birsey degismez

-- simdi de ayni soruyu, isim ve soyisimleri gruplandirip
-- yapalim.. yani her bir isim ve soyismin toplami ne kadar
-- onu bulalim

SELECT c.FirstName, c.LastName, sum(i.Total)
FROM customers c 
JOIN invoices i 
on c.CustomerId = i.CustomerId
GROUP BY c.FirstName, c.LastName;



--- Soru: artists tablosunda bulunan  her bir kisinin
-- albums tablosundaki tüm albümlerini listeleyen sorgu.
-- sorgu da artistid, name, title ve albumid olmali

SELECT *
FROM artists;


SELECT ar.ArtistId, ar.Name, al.Title, al.AlbumId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId;


-- left yaparsak sayi artar

SELECT ar.ArtistId, ar.Name, al.Title, al.AlbumId
FROM artists ar 
LEFT JOIN albums al 
ON ar.ArtistId = al.ArtistId;


-- simdi artist isimlerini gruplandirarak her bir sarkiciya 
-- ait kac tane albüm oldugunu hesaplayalim

SELECT ar.ArtistId, ar.Name, count(al.AlbumId)
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId, ar.Name;


-- title lari da count yapabiliriz

SELECT ar.ArtistId, ar.Name, count(al.Title)
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
GROUP BY ar.ArtistId, ar.Name;



--- not: eger soldaki tablo ile sagdaki tablonun
-- sorgudaki yerlerini degistirirsek ve daha sonra left 
-- join yaparsak bu durumda zorlama ile right join
-- yapmis oluruz


--  SQLite'in sorguyu calistirma sirasi:

-- from + join
-- where
-- group by
-- having
-- select
-- order by
-- limit



-- subquery = nested query = inner query

-- önce icteki sorgu calisir

-- ic ice sorgularda icteki ve distaki sorgular 
-- farkli tablolardan olabilir


-- icteki sorgu tek deger döndürüyorsa bu single row dur

-- birden cok deger döndürüyorsa multiple row dur


-- Soru:  Albums tablosunda, "Minha Historia"
-- isimli Title'in ait oldugu artistin artist id sinden
-- daha büyük olan artist id lere ait id lerin
-- artists tablosundaki namelerini yazalim
-- Bu isme ait id 17
-- yani 17 den büyük olanlar gelecek

SELECT ar.Name, al.ArtistId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId > (SELECT albums.ArtistId
                     FROM albums
                     WHERE Title = "Minha Historia");




-- ic ice 3 sorgu da olabilir

-- single row alt sorgularda genellikle > < = gibi
-- operatörler kullanilir



SELECT ar.Name, al.ArtistId
FROM artists ar 
JOIN albums al 
ON ar.ArtistId = al.ArtistId
WHERE ar.ArtistId > (SELECT albums.ArtistId
                     FROM albums);


-- mülakatta cikabilir
-- aggregate func'lar nelerdir?





------------ subquery



-- Soru: album title'i faceless olan
-- sarkilarin track id, track name ve album id 
-- sini gösteren sorguyu yazalim


-- simdi join ile cözelim
-- join de sart kullanacagiz

SELECT t.TrackId, t.Name, a.AlbumId, a.Title
FROM tracks t 
JOIN albums a 
ON t.AlbumId = a.AlbumId
WHERE a.Title = "Faceless";



-- eger tek bir kosulumuz varsa bu durumda where kullanmak yerine
-- on icerisinde and de kullanabiliriz

SELECT t.TrackId, t.Name, a.AlbumId, a.Title
FROM tracks t 
JOIN albums a 
ON t.AlbumId = a.AlbumId AND a.Title = "Faceless";




-- simdi ise subquery ile
-- önce albums tablosunda title'i faceless olan  album id lerini bulacagiz
-- bunu kullanarak subquery kullanarak, bu degere esit olan
-- kayitlari bulacagiz: 

-- Faceless in albumid si 88


SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId = (SELECT AlbumId
                 FROM albums
                 WHERE Title = "Faceless");




-- Not: eger group by kullandigimizda sartimiz varsa
-- bu durumda having kullaniriz. ve syntax'i group by dan sonra gelir
-- group by da sart icin where kullanilirsa hata verir



SELECT Name, AlbumId
FROM tracks
GROUP BY AlbumId
HAVING AlbumId > 3;






-------  multiply row subquery


-- bu tipteki alt sorgu birden cok output return ettigi icin
-- = kullanmak mümkün olmayacaktir


-- in, not in, all, any kullanilir





--- soru:  albums tablosundaki title sütunu Faceless
-- yada "Let There Be Rock" olan kayitlarin
-- albumidlerini elde ederek tracks tablosunda bu id lere 
-- esit olan kayitlarin bilgilerini subquery
-- kullanarak listeleyiniz. trackid, name ve albumid
-- bilgileri olmali



SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId in (SELECT AlbumId
                 FROM albums
                 where Title = "Faceless" or Title = "Let There Be Rock");



--- ikinci bir secenek olarak, alt query de de in kullanabiliriz


SELECT TrackId, Name, AlbumId
FROM tracks
WHERE AlbumId in (SELECT AlbumId
                 FROM albums
                 where Title in("Faceless", "Let There Be Rock"));


-- in kullandigimizda birden cok secenek oldugu icin
-- burada parantez kullanmak zorundayiz





--- Önemli: from satirinda birden cok tablo kullanabiliriz
-- mesela ciktidaki sütunlarimiza bir de title ekleyelim


-- Önemli: bu islem mümkün ama biraz karisik. 
-- eger where deki = olan ilk sart kullanilmazz ise bu durumda
-- yaklasik 6000 tane sonuc return eder

-- ve where deki iki sart arasinda and kullanilir

-- yani burada su ortaya cikiyor: 
-- join siz ve subquery siz iki tablodan veri alinabiliyor


SELECT tracks.TrackId, Name, tracks.AlbumId, albums.Title 
FROM tracks, albums
WHERE tracks.AlbumId = albums.AlbumId AND
                 tracks.AlbumId in(SELECT AlbumId
                 FROM albums
                 where Title in("Faceless", "Let There Be Rock"));










---------------------  SQL Statements

--- DDL: Data definition language
--- DML: Data manipulation Language
--- DCL: Data control language
--- TCL: Transaction Control Language


--- select DML kismina girer

--- DML tablodaki verilerle ugrasir


