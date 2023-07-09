--View focuses on OrderID, Quantity 
--and Cost columns within the Orders table
--for all orders with a quantity greater than 2.  
CREATE VIEW OrderView AS
		SELECT o.Id as "Order Id", 
				mio.Quantity,
				(mio.Quantity*mi.Price) as "Total amount"
		FROM Orders o
		INNER JOIN MenuItemsOrdered mio
			ON o.Id = mio.Orders_Id
		INNER JOIN Menu_Has_MenuItems mm
			ON mm.Id = mio.Menu_has_MenuItems_Id
		INNER JOIN MenuItems mi
			ON mi.Id = mm.MenuItems_Id
		WHERE mio.Quantity > 2


--View to see all customers with orders that cost more than $150
CREATE VIEW CustomerOrders AS    
		SELECT  c.Id as "Customer Id",
				CONCAT(c.FirstName, c.LastName) as "Customer FullName",
				o.Id as "Order Id", 
				mi.Price as "Cost",
                m.Name as "Menu Name",
                mi.Name as "Course Name"
		FROM Customers c
        INNER JOIN Bookings b
			ON c.Id = b.Customer
		INNER JOIN  Orders o
			ON o.Booking = b.Id
		INNER JOIN MenuItemsOrdered mio
			ON o.Id = mio.Orders_Id
		INNER JOIN Menu_Has_MenuItems mm
			ON mm.Id = mio.Menu_has_MenuItems_Id
		INNER JOIN MenuItems mi
			ON mi.Id = mm.MenuItems_Id
		INNER JOIN Menu m
			ON m.Id = mm.Menu_Id
		WHERE mi.Price > 150


--View to see all menu items for which more than 2 orders have been placed.
CREATE VIEW MenuItemsOrderedMoreThanTwo AS  
		SELECT mi.Name as "Course"
		FROM MenuItems mi
		WHERE mi.Id IN (
						SELECT MenuItems_Id
						FROM Menu_has_MenuItems mmi
						INNER JOIN MenuItemsOrdered mio
							ON mmi.Id = mio.Menu_has_MenuItems_Id
						GROUP BY mmi.MenuItems_Id
						HAVING COUNT(*)>2
		);