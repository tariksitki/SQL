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



