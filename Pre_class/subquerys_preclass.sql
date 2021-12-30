------------  Subquery

-- A subquery is a SELECT statement that is nested 
-- within another statement. The subquery is also 
-- called the inner query or nested query. 
-- A subquery may be used in:

-- SELECT clause
-- FROM clause
-- WHERE clause


-- A subquery is usually embedded inside the WHERE clause. 
-- You may use comparison operators such as 
--      >, <, =, IN, NOT IN with WHERE clause.



-- SELECT column_name
-- FROM table_1, table_2
-- WHERE column_name OPERATOR (
--	SELECT column_name
--	FROM table_1, table_2);



-- SELECT column_name
-- FROM table_1, table_2
-- WHERE column_name OPERATOR

-- Buraya kadar olan sorgu;  outer query olarak adlandirilir



-- (SELECT column_name
-- FROM table_1, table_2)
-- sonradan gelen bu sorgu ise 
-- inner query (nested or subquery query) olaral adlandirilir


--  İç sorgu, dış sorgudan önce calistirilir. 
-- ve İç sorgunun sonuçları dış sorguya uygulanir


-- Alt sorguyu kullanırken bazı kurallar vardır:

-- Bir alt sorgu parantez içine alınmalıdır.
-- ORDER BY'in bir alt sorguda kullanılmasına izin verilmez.
-- BETWEEN Operatörü dis sorguyu alt sorguya baglayan
-- operatör olarak kullanılamaz. 
-- Ancak alt sorgu içinde kullanilabilir.


--- task:
-- tracks tablosunda, UnitPrice'i 1 den büyük olan
-- verilerin, albums tablosundaki Albumid ve title bilgilerini getirelim:

SELECT AlbumId, Title
FROM albums
WHERE AlbumId in (SELECT AlbumId
				  FROM tracks
				  WHERE UnitPrice > 1);
				  

				  
--- task:

-- artists listesinde artistid si 50 den kücük olan 
-- sarkicilarin albums tablosundaki albumid lerini ve 
-- title larin yazdiralim

SELECT AlbumId, Title
FROM albums
WHERE ArtistId in (SELECT ArtistId
				   FROM artists
				   WHERE ArtistId < 50);

--  burada saglama yapiyoruz. tabi ki artistid 50 den kücük olan
-- 49 tane sarkici var. ama bir kisinin birden cok albümü olabilecegi icin
-- yukaridaki sorguda sayi 49 dan fazla cikti
			   
SELECT ArtistId
FROM artists
WHERE ArtistId < 50;



-- There are three main types of subqueries:

-- Single-row subqueries
-- Multiple-row subqueries
-- Correlated subqueries*  (bunu derslerde islemeyecegiz)



-- Interview: 

--  Alt sorgu nedir?
-- Alt sorgu, iç içe sorgu veya iç sorgu olarak da bilinen 
-- başka bir sorgu içindeki bir sorgudur. Ana sorgu 
-- tarafından sorgulanacak verileri kısıtlamak veya 
-- geliştirmek, böylece ana sorgunun çıktısını sırasıyla 
-- kısıtlamak veya geliştirmek için kullanılır.



-- Single-Row Subqueries:

-- Single-row subqueries return one row with only 
-- one column and are used with single-row operators 
-- such as =, >, >=, <=, <>, != . 

-- yani eger alt sorgumuz sadece tek satirli ve tek sütunlu
-- bir output döndürüyor ise, bu durumda kullandigimiz
-- alt sorgu tek satirli bir sorgudur.
-- yukaridaki iki örnekte de tek satirlik alt sorgu kullandik


-- Alt sorgularda aggregate func lari da kullanabiliriz.
-- avg, sum, max, min gibi func lar


-- task:

--tracks tablosunda, unitprice'i 1 den büyük olan sarkilarin
-- albums tablosundaki albimid ve title larini cikti alalim

-- Burada ic ice 3 tane sorgu yaptik:

SELECT AlbumId, Title
FROM albums
WHERE AlbumId in (SELECT AlbumId
				  FROM tracks
				  WHERE UnitPrice > (SELECT avg(UnitPrice)   -- buradaki alt sorguda kullandigimiz avg ye odaklaniyoruz
									 FROM tracks));

									 

	

---- task:
-- invoices tablosunda, total degeri ortalama total degerinden büyük olan customer larin
-- customers tablosundaki customer id, firstname ve lastname lerini print edelim

SELECT CustomerId, FirstName, LastName
FROM customers
WHERE CustomerId in (SELECT CustomerId
					 FROM invoices
					 WHERE total > (SELECT avg(total)
									FROM invoices));	

									

--- Not:

-- eger sorgumuzu, aggregate func lar ile combine edersek
-- bu durumda sorgumuz daha kuvvetli olacaktir




---- Multiple-Row Subqueries:::::

-- Multiple-row subqueries return sets of rows and 
-- are used with multiple-row operators 
-- such as IN, NOT IN, ANY, ALL.  

-- yani bu sorgular ile birden cok satir, yani
-- satir  kümeleri return edilir




-- task:

-- invoices tablosunda, billingcountry si germany olmayanlarin
-- customers tablosundaki firstname, lastname ve customer id lerini print edelim

SELECT FirstName, LastName, CustomerId
FROM customers
WHERE CustomerId NOT in (SELECT CustomerId
						 FROM invoices
						 WHERE BillingCountry = "Germany");  -- buradaki sorguda country si germany olanlari sececegiz
															 -- cünkü ana sorguda not in kullandik
															 
