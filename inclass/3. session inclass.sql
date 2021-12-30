SELECT FirstName, LastName, City, Address
FROM customers
WHERE FirstName like '___';   -- % ise sayisiz karakter



SELECT FirstName, LastName, City
FROM customers
WHERE LastName like "Sch%" or LastName like "go%";

-- dikkat burada iki kez like iki kez lastname ister

-- SELECT FirstName, LastName, City
-- FROM customers
-- WHERE LastName like ("Sch%" or "go%");  -- bu sekilde calismaz

-- like i case sensitive yapma; yukaridan edit pragmas


/*===================================================
	AGGREGATE FUNCTION COUNT,SUM,MIN,MAX, AVG)
====================================================*/
	
	-- COUNT
	-------------------------------------------------------------------------------------------------	
	/* invoices tablosunda kaç adet fatura bulunduğunu döndüren sorgu
*/
	
SELECT count(*)
FROM invoices;


SELECT count(InvoiceId) as fatura_sayisi
FROM invoices;


SELECT count(BillingState)
FROM invoices;



/* tracks tablosunda kaç adet farklı Composer bulunduğunu döndüren sorguyu yazınız*/

SELECT count(DISTINCT Composer) as besteci_sayisi
from tracks;      --- normalde 2525 tane

-------  Ödev:
/* invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız*/



-- MIN,MAX
	-------------------------------------------------------------------------------------------------	
	/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresi listeleyen
	sorguyu yaziniz */
	

SELECT name as Song_Name, min(Milliseconds)/1000.0 as Duration
FROM tracks;



SELECT min(Grade) as min_not, max(grade) as max_not
FROM students;



-- SUM,AVG
	-------------------------------------------------------------------------------------------------	
	/* invoices  tablosundaki faturaların toplam değerini listeyiniz */


SELECT sum(total) as toplam_gelir
FROM invoices;




--- ödev:
/* invoices  tablosunda 2009 ile 2013(tamami dahil) tarihileri arasındaki faturaların toplam değerini listeyiniz */


SELECT round(avg(total), 4) as ortalama_gelir
from(invoices);

	/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 
	şarkıların adlarını listeleyiniz */
	
-- SELECT Milliseconds
-- FROM tracks
-- WHERE Milliseconds>(SELECT avg(Milliseconds) FROM tracks);



SELECT round(avg(Milliseconds))
FROM tracks;

SELECT name, Milliseconds -- bu hard coded dinamic degil
FROM tracks
WHERE Milliseconds > 393599;



SELECT name, Milliseconds       -- bu dinamic
FROM tracks
WHERE Milliseconds > (SELECT avg(Milliseconds)
					   FROM tracks);
					   


					   
select Composer, count(name) as Song_Count
FROM tracks
WHERE Composer is NOT NULL
GROUP by Composer;



SELECT country, count(FirstName) as nu_of_cust
FROM customers
GROUP by country
ORDER by nu_of_cust DESC;


SELECT country, City, count(FirstName) as nu_of_cust -- burada parantez icinde yazan firstname dgisebilir
FROM customers
GROUP by country, City;



	/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
	hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/

SELECT BillingCountry, round(avg(total)) as ort_fatura
FROM invoices
GROUP by BillingCountry;



SELECT BillingCountry, round(avg(total), 3) as ort_fatura
FROM invoices
WHERE InvoiceDate BETWEEN "2009-01-01" and "2011-12-13 23:59:59"
GROUP by BillingCountry;


/*===================================================
        JOINS
====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--   	1) FULL JOIN:  Tablodaki tum sonuclari gosterir
--     2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
--     3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
--     4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--		NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
 /*===================================================*/   

  /* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
 
 
 
 SELECT * FROM markalar;
 
 
 
 SELECT markalar.marka_id, markalar.marka_adi,
		siparisler.siparis_adedi, siparisler.siparis_tarihi
 FROM markalar
 JOIN siparisler     -- DEFAULT u inner join dir
 on markalar.marka_id = siparisler.marka_id;
 




