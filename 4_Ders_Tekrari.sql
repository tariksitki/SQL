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











