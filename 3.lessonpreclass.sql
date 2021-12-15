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





--------------  Aggregating with Grouping

--- GROUP BY Clause

-- GROUP BY, satırları özet satırlar halinde gruplandırır.
--  Her grup için bir değer döndürür ve genellikle 
-- toplama işlevleriyle (COUNT, MAX, MIN, SUM, AVG) kullanılır.

--- syntax:

-- SELECT column_1, aggregate_function(column_2)
-- FROM table_name
-- GROUP BY column_1;

-- Group by ifadesinden sonra bir sütun yada birden cok sütun belirtilir



-- Önemli:

-- GROUP BY returns only one result per group of data.
-- GROUP BY Clause always follows the WHERE Clause.
-- GROUP BY Clause daima ORDER BY dan önce gelir



-- GROUP BY with COUNT Function

SELECT  AlbumId, count(AlbumId)
FROM tracks
GROUP BY MediaTypeId;


-- GROUP BY , toplama işlevini çağırmadan önce sonuçları 
-- gruplandırır. Bu, tüm sorgudan ziyade gruplara toplama işlevi uygulamanıza olanak tanır.


-- WHERE clause operates on the data before the aggregation.
-- WHERE clause happens before the GROUP BY clause. 
-- Only the rows that meet the conditions in the WHERE clause are grouped. 



SELECT PlaylistId, count(TrackId)
FROM playlist_track
GROUP BY PlaylistId;




-- SELECT gender, COUNT(job_title)
-- FROM employees
-- WHERE job_title = 'Data Scientist'
-- GROUP BY gender;

-- Bu komutta; output da iki sütun olur. 
-- sol tarafta gender sag tarafta ise job_title in hesap edilmis hali olur

-- sol tarafta bulunan sütunun iceriginde ise gender lar gruplanmis olarak bulunur

-- yani select kismina output daki tabloda sol kisimda 
-- bulunmasini istedigimiz veri yazilir
-- count, sum gibi kisima da sag tarafta görmek istedigimiz kismi

-- sol tarafta gruplama istedigimiz veriyi de group by kismina yazariz




----  GROUP BY with MIN&MAX Functions

-- tabi ki bu ifadelerin hepsinde de as kullanabiliriz

SELECT Title, min(ReportsTo) as minimum
from employees
GROUP BY Title;



SELECT Title, max(ReportsTo) as maximum
from employees
GROUP BY Title;



---  group by ile birlikte tabiki order by da kullanabilir ve outputumuzu 
-- siralamaya sokabiliriz.

-- Dikkat: order by en son cikan islemi siralamaya sokacagi icin
-- biz öncelikle tüm islemlerimizi bitiririr sonuca variriz
-- en son satira da order by yazariz. 

-- yani group by daha önce gelir

SELECT Title, max(ReportsTo) as maximum
from employees
GROUP BY Title
ORDER BY ReportsTo DESC;



-- Not: sütun ismi olarak alias kullandigimizda 
-- bunu kodumuzun en son satirinda order by ile siralamaya sokarken
-- isimlendirmeye dikkat:

-- SELECT gender,
-- MAX(salary) AS max_salary
-- FROM employees
-- GROUP BY gender
-- ORDER BY max_salary DESC;  -- bu satirda ister yukarida yazdigimiz alias name'i yazariz yada orijinal ismi yazariz





---- GROUP BY with SUM&AVG Functions


SELECT AlbumId, sum(MediaTypeId) as Total
from tracks
GROUP BY AlbumId
ORDER BY MediaTypeId DESC;





----  What is JOIN?

-- JOIN, iki veya daha fazla tabloyu tek bir tabloda
 -- birleştirmek için kullanılır. Birleştirmeler genellikle
 --  bu tablolar arasındaki ilişkiyi tanımlayan anahtarlara 
 -- veya ortak alanlara göre uygulanır.



 --Çoğu durumda bu birleştirmeler, bir tablonun birincil anahtarı 
 -- ve katılmak istediğimiz tablonun yabancı anahtarı kullanılarak 
 -- oluşturulur.


 -- JOIN Types

 -- There are basically five types of JOINs: 
 -- INNER JOIN, 
 -- LEFT JOIN, 
 -- RIGHT JOIN, 
 -- FULL OUTER JOIN and 
 -- CROSS JOIN. 
 
 -- As a special case, a table can join to itself and this type is called SELF JOIN.


---  Interview: What is a Join?

-- SQL Join , iki tablo arasındaki ilgili bir sütuna dayalı olarak 
-- bir SQL veritabanındaki iki veya daha fazla tablodaki 
-- (satırları) birleştirmek için kullanılır.


-- INNER JOIN: Returns the common records in both tables.
-- LEFT JOIN: Returns all records from the left table and matching records from the right table.
-- RIGHT JOIN: Returns all records from the right table and matching records from the left table.
-- FULL OUTER JOIN: Returns all records of both left and right tables.
-- CROSS JOIN: Returns the Cartesian product of records in joined tables.
-- SELF JOIN: A join of a table to itself.





---- Inner JOIN:

-- INNER JOIN, JOIN'lerin en yaygın türüdür. İki veya daha fazla
--  tablodan ortak sütunlardaki değerleri temel alarak 
-- yeni bir sonuç tablosu oluşturur. INNER JOIN yalnızca 
-- belirtilen birleştirme koşullarını karşılayan eşleşen satırları 
-- içeren bir tablo döndürür.


-- syntax:

-- SELECT columns
-- FROM table_A
-- INNER JOIN table_B ON join_conditions


-- A join condition generally takes the following form: 

-- table_A.column = table_B.column. 
-- The operator in this statement is usually an equal sign (=), 
-- but any comparison operator can also be used.



-- Note: INNER JOIN koşulunu belirtmek için "on" anahtar sözcüğü 
-- kullanilir

-- AND veya OR deyimleri kullanılarak çoklu birleştirme koşulları yazılabilir.



--  INNER JOIN kullanılarak üç veya daha fazla tablo birleştirilebilir . 
-- Üç veya daha fazla tabloyu birleştirmek için kullanılan syntax aşağıdaki gibidir:


-- SELECT columns
-- FROM table_A
-- INNER JOIN table_B 
-- ON join_conditions1 AND join_conditions2
-- INNER JOIN table_C
-- ON join_conditions3 OR join_conditions4


-- inner join i anlamak icin su sekilde düsünebiliriz:

-- iki kümenin kesisim kümesi inner join'i olusturur



-- Soru: iki tane tablomuz var. birisinin adi employees digeri departments
-- bu iki tabloyu birlestirelim

--select 
-- employees.emp_id,
-- employees.first_name,
-- employees.last_name,
-- departments.dept_id,
-- departments.dept_name
-- from employees
-- inner join departments
-- on employees.emp_id = departments.emp_id;



SELECT 
tracks.TrackId,
tracks.Name,
tracks.AlbumId,
albums.Title,
albums.ArtistId
FROM tracks
INNER JOIN albums
ON tracks.AlbumId = albums.AlbumId;




--- Left JOIN:

-- Bu JOIN deyiminde, soldaki tablonun tüm kayıtları 
-- ve sağdaki tablonun ortak kayıtları sorguda döndürülür. 
-- JOIN işlemi sırasında sağdaki tabloda eşleşen satır bulunamazsa, 
-- bu değerler NULL olarak atanır.

-- syntax:

-- SELECT columns
-- FROM table_A
-- LEFT JOIN table_B ON join_conditions

-- LEFT JOIN and LEFT OUTER JOIN keywords are exactly the same. OUTER keyword is optional.

-- SELECT columns
-- FROM table_A
-- LEFT OUTER JOIN table_B ON join_conditions


-- Belirli bir satır için eşleşme bulunamazsa, NULL döndürülür.
-- yani bu sunu ifade eder:

-- mesela iki tabloda da ortak olan bir sütunu almis olalim.
-- ancak ilk tabloda bu sütunun 20 elemani ikinci tabloda ise 10 elelamni olsun.
-- 10 eleman 20 elemana karsilik gelmediginden ve left join de soldaki tablonun
-- tüm elemanlari alindigindan sagdaki tabloda bos kalan bu 10 elemanin
-- karsisinda null döndürülür. 


-- left join i daha iyi ifade debilmek icin sunu söyleyebilirz:

-- left join de iki tablo birlesiminde:

-- soldaki tablo da olup sagdaki tabloda olmayan kümenin elemanlari alinir
-- bir de kesisim kümesinin elemanlari alinir
-- ancak sagdaki tabloda olup soldaki tabloda olmayanlar alinmaz


-- örnek:

-- SELECT
-- employees.emp_id,
-- employees.first_name,
-- employees.last_name,
-- departments.dept_name,
-- departments.dept_id
-- FROM employees
-- LEFT JOIN departments
-- ON employees.emp_id = departments.emp_id;



-- örnek soru:

-- Using the Left JOIN method, write a query to 
-- return the departments of all male employees in the 
-- "employees" table. Show just first name, last name, 
-- department and department ID of the employees.

-- cevap

-- select
-- employees.first_name,
-- employees.last_name,
-- departments.dept_name,
-- departments.dept_id
-- from employees
-- left join departments
-- on employees.emp_id = departments.emp_id
-- where gender = "Male";




