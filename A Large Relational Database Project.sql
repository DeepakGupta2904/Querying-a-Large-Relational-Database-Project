----------- Project:- Quering a Large Relational Database -----------


----- 1. Get all the details from the person table including email ID, phonenumber and phone number type.

SELECT Person.Person.*,Person.EmailAddress.EMAILADDRESS,Person.PersonPhone.PhoneNumber,PERSON.PHONENUMBERTYPE.PhoneNumberTypeID FROM
Person.Person INNER JOIN Person.EmailAddress ON  Person.Person.BusinessEntityID=Person.EmailAddress.BusinessEntityID
INNER JOIN Person.PersonPhone on Person.Person.BusinessEntityID=Person.PersonPhone.BusinessEntityID INNER JOIN Person.PhoneNumberType on
Person.PersonPhone.PhoneNumberTypeID=Person.PhoneNumberType.PhoneNumberTypeID

OR 

SELECT * FROM Person.PersonPhone
SELECT * FROM Person.PhoneNumberType
SELECT * FROM Person.EmailAddress


----- 2. Get the details of the sales header order made in May 2011.

SELECT * FROM Sales.SalesOrderHeader
WHERE Month(OrderDate) = 5 AND YEAR(OrderDate) = 2011


----- 3. Get the details of the sales details order made in the month of May 2011.

SELECT * FROM Sales.SalesOrderHeader  INNER JOIN
Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID=sales.SalesOrderDetail.SalesOrderID
WHERE Month(SalesOrderHeader.OrderDate) = 5 AND YEAR(SalesOrderHeader.OrderDate) = 2011


----- 4. Get the total sales made in May 2011.
SELECT SUM(TotalDue) AS Total_Sales FROM Sales.SalesOrderHeader 
WHERE Month(OrderDate) = 5 AND YEAR(OrderDate) = 2011


----- 5. Get the total sales made in the year 2011 by month order by increasing sales.
SELECT * FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011
ORDER BY Month(OrderDate), TotalDue


----- 6. Get the total sales made to the customer with FirstName='Gustavo' and LastName ='Achong'

SELECT p.Title, p.FirstName, p.MiddleName, p.LastName, tmp.TotalAmount
FROM Sales.Customer           c
     INNER JOIN Person.Person AS p ON p.BusinessEntityID=c.PersonID
     LEFT JOIN
       (
         SELECT
                  soh.CustomerID, SUM(LineTotal) AS TotalAmount
         FROM     Sales.SalesOrderDetail            AS sod
                  INNER JOIN Sales.SalesOrderHeader AS soh ON soh.SalesOrderID=sod.SalesOrderID
         GROUP BY soh.CustomerID
       )                      tmp ON tmp.CustomerID=c.CustomerID
	   where firstName='Gustavo' and LastName='Achong'