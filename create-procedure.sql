--Procedure that displays the maximum ordered quantity in the Orders table
CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(mio.Quantity) AS "Max Quantity in Order"
    FROM MenuItemsOrdered mio;

PREPARE GetOrderDetail 
FROM
'SELECT o.Id as OrderId,
		mio.Quantity,
        (mio.Quantity*mi.Price) as Cost
FROM Bookings b
INNER JOIN Orders o
	ON b.Id = o.Booking
INNER JOIN MenuItemsOrdered mio
			ON o.Id = mio.Orders_Id
INNER JOIN Menu_Has_MenuItems mm
			ON mm.Id = mio.Menu_has_MenuItems_Id
INNER JOIN MenuItems mi
			ON mi.Id = mm.MenuItems_Id
WHERE b.Customer=?';

--Procedure to delete an order record based on the user input of the order id.
CREATE PROCEDURE CancelOrder(IN OrderId INT) 
DELETE FROM Orders o WHERE o.Id = OrderId ;