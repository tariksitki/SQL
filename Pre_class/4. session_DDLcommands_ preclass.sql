

-- SQL Dersinin başında SQL'in veritabanı üzerinde 
-- geri alma, ekleme, güncelleme, oluşturma gibi 
-- bazı işlemleri yaptığıni duymustuk. 
-- Bunlardan sadece veri tabanındaki verileri alma 
-- işlemleri için SELECT' i gördük


-- Ek bir not olarak, bazı kaynaklarda statementlara
-- "commands" de denir.

-- Aslında statement lar dört ana kategoride 
-- gruplandırılmıştır:

-- DDL - Data Definition Language
-- DML - Data Manipulation Language
-- DCL - Data Control Language
-- TCL - Transaction Control Language (islem kontrol dili)


-- Data Definition Language (DDL) specifies 
-- the database schema. 
-- The statements used in DDL are 
-- CREATE, ALTER, DROP. 
-- DDL statements are typically used to 
-- set up and configure a new database 
-- before we insert data.



-- Data Manipulation Language (DML) 
-- enables users to access or manipulate data. 
-- INSERT, UPDATE, DELETE, SELECT 
-- are the statements used in DML.


-- Data Control Language (DCL) 
-- is used to grant or revoke access control. 
-- yani giris controlüne izin vermek veya 
-- izni iptal etmek icin kullanilir

-- Its statements are REVOKE and GRANT.




-- Transaction Control Language (TCL) 
-- controls the transactions of DML and 
-- DDL commands. Its statements are BEGIN and COMMIT.




-- DDL, DML, DCL, TCL ayrı diller değildir. 
-- Tek bir veritabanı dili olan SQL in 
-- parçalarını oluştururlar. Bunlar 
-- kategorik amaçlar içindir. 
-- Biz DDL komutlarını öğreneceğiz. 
-- Diğer dillerin komutlarını ele almayacağız.



-- öncelikle Data Types'i ele alalim:

-- SQL'de veri türleri, bir sütunun ne tür verileri 
-- içerebileceğini veya depolayabileceğini tanımlar.

-- Bir sütundaki verilerin tipini ögrenebilmek icin
-- "type of" özel func'i kullanilir

-- task:

-- customers tablosundaki 3 sütunun veri tiplerini bulalim

SELECT typeof(FirstName),
	   typeof(LastName),
	   typeof(CustomerId)
FROM customers;



-- Sütundaki veriler ayni tip olacagindan
-- limit de kullanabiliriz:

SELECT typeof(FirstName),
	   typeof(LastName),
	   typeof(CustomerId)
FROM customers
LIMIT 1;




-- SQLite'de beş temel veri türü vardır. 
-- Bunlara (storage classes) depolama sınıfları denir


-- 1)  NULL: The value is a NULL value. 
--  NULL values mean missing information or unknown.
-- (yani eksik bilgi yada bilinmeyen demektir)


-- 2) INTEGER: The value is a whole number 
-- (positive or negative), 
-- stored in 1, 2, 3, 4, 6 or 8 bytes 
-- depending on the magnitude of the value.
-- (yani degerin büyüklügüne baglidir)



-- 3) REAL: The value is a floating-point value, 
-- stored as an 8-byte float. 
-- They are real numbers with decimal values.



-- 4_) TEXT: The value is a text string, 
-- stored using the database encoding 
-- (UTF-8, UTF-16BE or UTF-16LE).
 

 
-- 5) BLOB: BLOB stands for a binary large object 
-- that can store any kind of data.



-- SQL de ayri bir Boolean class yoktur.
-- Boolean degerler, integer olarak depolanir.
-- 0 (False)   1 ise True dur


-- SQL de tarihler icin de ayri bir class yoktur.
-- Tarih yazarken, Text, integer yada REAL veri 
-- tiplerini kullanabilirz.


-- Not:  Storage class (depolama sınıfı), 
-- bir veri türünden biraz daha geneldir. 
-- Örneğin, INTEGER depolama sınıfı, 
-- farklı uzunluklarda altı farklı tamsayı 
-- veri türünü kapsar. 
-- Depolama sınıflarinin çoğu, veri türünden 
-- ayırt edilemez ve iki terim birbirinin 
-- yerine kullanılabilir.






-- SQLite, bir değerin veri tipini 
-- aşağıdaki kurallara göre belirler:


-- Bir değer tek veya çift tırnak içine alınmışsa, 
-- TEXT depolama sınıfına atanır.

-- Bir değerde tırnak işareti ve ondalık nokta 
-- veya üs yoksa, INTEGER depolama sınıfı atanır.


-- Bir değer tırnak içinde değil, 
-- ondalık nokta veya üs varsa, REAL 
-- depolama sınıfına atanır.

-- Bir değer tırnak işaretleri olmadan NULL ise, 
-- NULL depolama sınıfına atanır.

-- Bir değer X'ABCD' veya x'abcd' içeriyorsa, 
-- BLOB depolama sınıfına atanır.

 
 
-- Example:

-- Her sorgumuzda From table_name ifadesini
-- kullanmak zorunda degiliz.

-- eger kendi istedigimiz bir verinin veri tipini
-- ögrenmek istiyorsak, su sorguyu yazabiliirz

SELECT typeof(1000),	-- dikkat her satir sonuna
	   typeof("100"),	-- virgül koyuyoruz
	   typeof(10.0),
	   typeof(NULL),
	   typeof(x'1000');
	   
-- yani buradan ortaya cikan sonuc sudur:

-- verinin yazilis formati, storage class'i belirler




---  DDL Komutlari:

-- CREATE TABLE::

-- Database imizde bir tablo olusturmak istedigimizde,
-- CREATE TABLE komutunu kullaniriz

-- syntax'imiz su sekildedir:

-- CREATE TABLE database_name.table_name (
--  column1 data_type,
--  column2 data_type,
--  ...
--);



-- A CREATE TABLE statement specifies 
-- the following attributes of the new table:

-- 1) The name of the new table
-- 2) The database in which the new table is created.
--  This is optional. You don't have to specify. 
-- Örnegin, su sekilde de yapabiliriz
-- CREATE TABLE table_name (...);

-- 3) The name of the columns
-- 4) The declared data type of each column




--- task:

-- chinook DATABASE in de teachers adinda bir tablo
-- olusturacagiz.
-- ve her bir ögretmen asagidaki bilgilere 
-- sahip olacaktir

-- name
-- Lesson
-- salary


CREATE TABLE teachers(
			name TEXT,
			lesson TEXT,
			salary INTEGER); -- burada database ismi kullanmadik
			
			

CREATE TABLE ogretmenler(
			name TEXT,
			lesson TEXT,
			salary INTEGER);
			
-- database ismi kullanarak komut calismadi
		
CREATE TABLE chinook.ögretmenler(
			name TEXT,
			lesson TEXT,
			salary INTEGER);
			
			

.table




-- Constraints  (kisitlamalar):

-- Kısıtlamalar, bir tablodaki veriler için 
-- belirtilen kurallardır. 
-- Bir tabloya girilmesini istedigimiz
-- veri türünü kısıtlamalarla sınırlayabiliriz. 
-- Kısıtlamaları CREATE TABLE satatement veya 
-- ALTER TABLE statement ile tanımlayabiliriz 


-- syntax:

-- CREATE TABLE table_name (
--   column1 DATATYPE CONSTRAINT, -- normal create den tek farki constraint olmasidir
--   column2 DATATYPE CONSTRAINT,
--   ...
--);


-- SQL de kullanilan en yaygin constraints ler:

--NOT NULL	Ensures that a column cannot 
-- have a NULL value


-- DEFAULT: eger bir column icin bir deger
-- belirtilmezse bu column icin default 
-- bir deger atar


-- UNIQUE	Ensures that all values 
-- in a column are different


-- PRIMARY KEY	Uniquely identifies 
-- each row in a table


-- FOREIGN KEY	Uniquely identifies 
-- a row/record in another table
-- baska bir tablodaki row ve column icin
-- referans saglar




-- Primary Key:

-- her row'u unique bir bicimde tanimlamada
-- kullanilir

-- Bir tablonun yalnızca bir birincil anahtarı 
-- olabilir. 
-- Birincil anahtar, bir veya birden çok 
-- sütundan oluşabilir

-- Primary key'i CREATE TABLE statement iceriisnde
-- kullaniriz. syntax su sekildedir:

-- CREATE TABLE table_name(
--  column_1 INT PRIMARY KEY,
--  column_2 TEXT,
--  ...
--);


-- yukarida yazdigimiz tanimlama birinci yöntemdi.
-- ikinci yöntem ise, primary key statement'i
-- kodumuzun sonunda yazmaktir.
-- syntax su sekildedir:

-- CREATE TABLE table_name(
--  column_1 INT,
--  column_2 TEXT,
--  ...
-- PRIMARY KEY (column_1)
-- );

-- primary key belirlerken cok dikkatli olmamiz
-- gerekir. bu column'daki verilerin
-- tekrarsiz olmasi gerekir


-- primary key sütununda NULL deger olamaz
-- iyi bir veri tabani tasarimi, ancak PRIMARY
-- key kullanimi ile baslar

-- task:

-- diyelim ki; employees tablomuz veri tabanimizda 
-- mevcut degil. ve biz bu tabloyu sifirdan 
-- olusturalim:

-- syntax:

--CREATE TABLE employees(
--emp_id INT NOT NULL PRIMARY KEY,
--first_name TEXT,
--last_name TEXT,
--salary INT,
--job_title TEXT,
--gender TEXT,
--hire_date TEXT);

-- Dikkat edersek, primary key ile Not NULL
-- kullandik. ancak primary key dolayli olarak
-- unique oldugunda kullanilmasi zorunlu degildir





-- Foreign Key:

-- Yabancı anahtar, başka bir tablonun 
-- her satırını benzersiz şekilde tanımlayan 
-- bir tablodaki sütundur. 
-- Bu sütun, başka bir tablonun 
-- birincil anahtarına başvurur. 
-- Bu, tablolar arasında bir tür bağlantı oluşturur. 




-- task:

-- store adında bir veritabanımız olduğunu 
-- varsayalım . Bu veritabanında 
-- customer ve order olarak iki tablo 
-- oluşturalım 


-- CREATE TABLE customers (customer_id INT PRIMARY KEY,
-- first_name TEXT,
-- second_name TEXT);

-- bu kod ile henüz sadece customers tablomuzu
-- olusturduk.
-- simdi ise orders tablomuzu olusturacagiz ve
-- foreign key belirleyecegiz:



--CREATE TABLE orders (
--    order_id INT PRIMARY KEY,
--    order_number INT,
--    customer_id INT,
--    FOREIGN KEY (customer_id)
--     REFERENCES customers (customer_id)
--);


-- dikkat edersek hem foreign key belirledik
-- hem de bunun refere ettigi tablodaki
-- column'u belirledik


-- Dikkat:

-- The customer_id column in the customers table
--  is the PRIMARY KEY in the customers table.

-- The customer_id column in the orders table 
-- is the FOREIGN KEY in the orders table.

-- The customers table is called a parent table

-- The orders table is called a child table





-- Olusturdugumuz tablo icerisine veri girme:

-- Veri girisi icin "INSERT INTO" statements
-- kullanilir

-- syntax:

-- INSERT INTO table_name (column1, column2)
-- VALUES (value1, value2);


-- yukarida olusturdugumuz tabloya
-- veri girisi su sekilde olur:

-- INSERT INTO customers (customer_id, first_name, last_name)
-- VALUES (1, 'Robert', 'Cursor'),
--       (2, 'Julia', 'Loyds'),
--       (3, 'Jack', 'Morgten');



-- simdi de orders tablosuna veri girelim:

-- INSERT INTO orders (order_id, order_number, customer_id)
-- VALUES (1, 101, 3),
--       (2, 102, 3),
--       (3, 103, 2),
--       (4, 104, 1);



-- FOREIGN KEY tanımlayarak ne elde ettik? 
-- Bunlarin  kullanılması tablolar arasındaki 
-- bağlantıların bozulmamasını sağlar. 
-- Ayrıca yabancı anahtar sütununa 
-- geçersiz veri girişini engeller. 
-- Örneğin, orders tablosuna yeni bir 
-- customer_id değeri ekleyemeyiz


-- örnegin:

-- INSERT INTO orders (order_id, order_number, customer_id)
-- VALUES (5, 105, 4);

-- biz bu kodu calistirdigimizda hata aliriz
-- bu hatanin adi;
-- "FOREIGN KEY constraint failed" error dur.

-- Bu ayni zamanda "referential integrity"
-- yani bilgi tutarliligi olarak da adlandirilir

-- customers tablosunda customer_id '4' 
-- olmadığı için bu tabloda  
-- yeni bir customer_id oluşturamıyoruz.

