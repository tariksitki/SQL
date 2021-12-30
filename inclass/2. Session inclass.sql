/*===================================================
														LIMIT
====================================================*/
 	/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
	InvoiceDate ve total bilgilerini sorgulayiniz */

SELECT InvoiceId, InvoiceDate, total
FROM invoices
WHERE total > 10
LIMIT 4;

/*===================================================
													ORDER BY
====================================================*/
	
	/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
	ARTAN sırada sıralayarak sorgulayiniz */
	
SELECT *
FROM invoices
WHERE total > 10
ORDER BY total ASC;


/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
	(InvoiceDate) 	en yeni olan 10 kaydın tüm bilgilerini listeyiniz */ 
	
SELECT *
FROM invoices
WHERE total > 10
ORDER BY InvoiceDate DESC
LIMIT 10;


/*===================================================
								 LOGICAL OPERATORS (AND,OR,NOT)
====================================================*/

	/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
	göre  AZALAN sırada listeyiniz */ 
	
SELECT *
FROM invoices
WHERE NOT BillingCountry = "ABD"  -- WHERE BillingCountry <> "USA"
ORDER BY total DESC;

	/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
	InvoiceId sırasına göre artan sırada listeyiniz */ 
	

SELECT *
FROM invoices
WHERE BillingCountry = "USA" or BillingCountry = "Germany"
ORDER BY InvoiceId;

/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 03-01-2012 
	tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */ 
	
SELECT *
FROM invoices
WHERE InvoiceDate > "2012-01-01" and InvoiceDate < "2013-01-02";

SELECT *
FROM invoices
WHERE InvoiceDate > "2012-01-01" and InvoiceDate < "2013-01-02 00:00:00";


SELECT *
from invoices
where InvoiceDate BETWEEN "2009-01-01" and "2011-12-31"  -- Between de tekrar InvoiceDate kullanmamiza gerek yoktur
ORDER BY InvoiceDate DESC
LIMIT 1;



SELECT FirstName, LastName, country
FROM customers
WHERE country IN ("Belgium", "USA", "Norway", "Canada");


/* The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.
There are two wildcards often used in conjunction with the LIKE operator:
 The percent sign (%) represents zero, one, or multiple characters
 The underscore sign (_) represents one, single character
SQL LIKE Operatörü
LIKE operatörü, bir sütunda belirtilen bir kalıbı aramak için bir WHERE yan tümcesinde kullanılır.

LIKE operatörüyle birlikte sıklıkla kullanılan iki joker karakter vardır:

 Yüzde işareti (%) sıfır, bir veya birden çok karakteri temsil eder
 Alt çizgi işareti (_) tek bir karakteri temsil eder */
 
 
 
 
 /*===================================================
								                    LIKE
====================================================*/
/* tracks tablosunda Composer sutunu Bach ile biten kayıtların Name bilgilerini 
listeyen sorguyu yazınız*/
	
	
SELECT name, Composer
from tracks
WHERE Composer like "%Bach";



SELECT *
FROM albums
WHERE Title like "%Greatest%";




/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
	aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/

	
SELECT *
FROM invoices
WHERE InvoiceDate like "201_-02%";


/* SQL sorgu performansı için bazı ipuçları:
(İçinde henüz görmediğiniz konular da var kafanız karışmasın. Bir kenarda bulunsun diye size sundum. Aldığım siteyi hemen aşağıda paylaşacağım onu da yıldızlayabilirsiniz!)
5. OR KULLANIMI
Aşağıdaki sorguyu ele alalım. Or ‘un boolean ifadenin tüm kombinasyonları için kontrol yapılması gerektiğinden performans kaybına yol açabilir. Burada hem user_name’i hem de post_time’ı indexlemek kulağa mantıklı bir çözüm gibi gelebilir. Ancak çoğu durumda SQL bu indexleri kullanmayacaktır.
SELECT COUNT(*)
         FROM  fb_posts
         WHERE user_name = 'Mark' OR post_time > '2018-01-01'
Or kullanımına alternatif olarak sorguları aşağıdaki gibi UNION kullanarak split edebiliriz. Bu yol tablonun indexleri kullanmasına olanak sağlayacaktır. Böylece veritabanı sonuçları aramak için indexleri kullanacak ve sonuçları UNION deyimi ile birleştirecektir.
SELECT …
   FROM …
   WHERE username = 'Mark'
 UNION
SELECT …
   FROM …
   WHERE post_time > '2018-01-01'
Eğer duplicate kayıtlar için bir endişeniz yok ise union yerine union all’ı kullanarak performansı daha da artırabilirsiniz.
10. IN YERINE EXIST KULLANIMI
In kullanımı aslında arka planda Or kullanımına eşdeğerdir.Databasede In ile birden fazla opsiyonun kombinasyonlarını bir bir check ederken aynı sorguyu EXIST ile aşağıdaki gibi yazarsak, uygun bir kayıt bulduğu an aramayı kesecektir.
Aşağıdaki gibi bir sorgu yerine
Select * from product p 
        where product_id IN (select product_id from order_items)
Aşağıdaki gibi bir sorgu tercih etmek yerinde olacaktır.
Select * from product p 
        where EXISTS (select * from order_items o where o.product_id = p.product_id)
http://cagataykiziltan.net/sql-sorgu-performans-ipuclari/ */