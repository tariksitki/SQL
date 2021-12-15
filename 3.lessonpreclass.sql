-- Aggregate Functions

-- What is an aggregate function?

-- SQL'in beş yerleşik toplama işlevi vardır:
-- COUNT (Count)
-- MIN (Minimum)
-- MAX (Maximum)
-- SUM (Total)
-- AVG (Average)

-- Bu islemlerde Birden cok girdi vardir.ama tek bir cikti vardir

-- SUM ve AVG sadece sayisal degerler alabilir digerleri ise farkli deger alabilir

-- Null, Bize bir bilgi parçasının bilinmediğini veya eksik olduğunu veya uygulanabilir olmadığını gösterir.

-- NULL değeri, bilinmeyen değeri veya eksik değeri temsil eder veya uygulanamaz.
-- NULL, sıfıra veya boş dizeye eşit değildir.
-- NULL, kendisine eşit değildir.
-- aggregate islemlerinde gözardi edilirler

-- Interview: What is an aggregate function?

-- Toplama işlevi, tek bir skaler değer döndürmek 
-- için bir değerler koleksiyonu üzerinde işlemler 
-- gerçekleştirir. Toplama işlevleri genellikle 
-- SELECT ifadesinin GROUP BY ve HAVING yan tümceleriyle 
-- birlikte kullanılır.


-- COUNT:

-- Bir tablodaki recordlarin sayısını saymak için kullanırız 
-- Syntax:

-- SELECT COUNT(column_name)
-- FROM table_name;

SELECT count(Title)
FROM albums;        -- albums tablosunda 347 tane row varmis

SELECT count(FirstName)
FROM employees;

--  count ile * kullanimi

SELECT count(*)
FROM students;

SELECT count(*)
FROM tracks;


--  Önemli:
-- su ana kadar yaptigimiz islemler de output un basliginda hep count yaziyordu.
-- simdi bu basligi sekillendirecegiz:

SELECT count(Name) AS Name_of_Singer  -- kelimeler arasinda _ olmazsa hata aliriz
FROM tracks;

-- Bu komuttan sonra sadece bizim yazdigimiz cikar count cikmaz



-- Önemli:
-- Eger count(*) kullanirsak bu durumda Null olan degerlerde output da sayilir.
-- Eger sadece None olmayan veriler olsun istersek bu durumda
-- count(column_name) kullanmamiz gerekir

SELECT count(Composer)
FROM tracks;


-- count where ile kullanimi:

SELECT count(Composer) as Composer_name
FROM tracks
WHERE MediaTypeId == 2;


--------------   COUNT DISTINCT

SELECT count(AlbumId)
FROM tracks;   -- normalde 3503 adet Albimid var


SELECT count(DISTINCT AlbumId)
FROM tracks;


-- count distinct ve where birlesimi:

-- Not: mesela albumId si 1 olan sarkicilarin sayisini istersek bu durumda 
-- count(*) kullanilabilir. cünkü count da tablo listelenmez. Bunun yerine
-- sayilar print edilir.

SELECT count(DISTINCT AlbumId) as AlbumId
FROM tracks
WHERE MediaTypeId = 1;


-- Önemli:
-- select count(*) as number_of_students
-- from student_info
-- where gender = "F" and state = "Virginia";

-- Bu kod da dikkat edilmesi gereken noktalar:

-- "F" burada f yazarsak hata aliriz
-- birden cok sart kullanacak isek bu durumda sartlar arasinda , degil
-- and kullaniriz






------  MIN Function:

-- MIN function returns the minimum value in the selected column.

-- syntax:

-- SELECT MIN(column_name)
-- FROM table_name;


-- employees tablosunda en yasli olani bulalim:

SELECT min(BirthDate) as en_yasli
FROM employees;

-- Bu soruyu min kullanmadan cözelim:

SELECT BirthDate as en_yasli
FROM employees
order by BirthDate
LIMIT 1;


-- customer tablosunda ülkeyi minimum secelim.
-- alfabetik siralama yapar

SELECT min(country) 
FROM customers;






---- MAX Function:

-- syntax:

-- SELECT MAX(column_name)
-- FROM table_name;

-- The MAX function ignores the NULL values. 


SELECT max(SupportRepId)
FROM customers;

-- Note: aradigimiz bu sütunda en yüksek sayi 5 ama 5 sayisina sahip olan cok sayida customer var.
-- ama bu önemli degil. sadece en yüksek sayi ne ise o aliniyor


-- max func kullanmadan ayni islemi yapalim:

SELECT InvoiceDate as en_yakin_tarih
FROM invoices
ORDER BY InvoiceDate DESC
LIMIT 1;



-- SUM Function:
-- bir sütundaki tüm degerleri toplar eger bir sart yazilmaz ise

-- syntax:

-- SELECT SUM(column_name)
-- FROM table_name;

SELECT sum(MediaTypeId) as toplam
FROM tracks;

-- tabi ki where ile kullanilabilir

SELECT sum(MediaTypeId) as toplam
FROM tracks
WHERE AlbumId = 1 or AlbumId = 3;  -- dikkat ikisinin de toplami oldugu icin or



SELECT sum(SupportRepId) as toplam
FROM customers
WHERE country = "Brazil";






--- AVG Function:

-- AVG function calculates the average of a numeric column.

-- syntax

-- SELECT AVG(column_name)
-- FROM table_name;


SELECT avg(UnitPrice) as ortalama
FROM invoice_items;



SELECT avg(UnitPrice) as ortalama
from invoice_items
WHERE InvoiceId = 10;



