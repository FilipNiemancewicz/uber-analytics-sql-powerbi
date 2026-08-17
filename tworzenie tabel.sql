DROP TABLE IF EXISTS factbookings;
DROP TABLE IF EXISTS DimVehicle;
DROP TABLE IF EXISTS DimCancellationReason;
DROP TABLE IF EXISTS DimPaymentMethod;


CREATE TABLE DimVehicle (
    VehicleTypeID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleTypeName VARCHAR(255)
);

INSERT INTO DimVehicle (VehicleTypeName)
SELECT DISTINCT `Vehicle Type` 
FROM ncr_ride_bookings 
WHERE `Vehicle Type` IS NOT NULL AND `Vehicle Type` != '';


CREATE TABLE DimCancellationReason (
    ReasonID INT AUTO_INCREMENT PRIMARY KEY,
    ReasonDescription VARCHAR(255)
);

INSERT INTO DimCancellationReason (ReasonDescription)
SELECT DISTINCT Reason FROM (
    SELECT `Reason for cancelling by Customer` AS Reason FROM ncr_ride_bookings WHERE `Reason for cancelling by Customer` IS NOT NULL AND `Reason for cancelling by Customer` != ''
    UNION
    SELECT `Driver Cancellation Reason` AS Reason FROM ncr_ride_bookings WHERE `Driver Cancellation Reason` IS NOT NULL AND `Driver Cancellation Reason` != ''
    UNION
    SELECT `Incomplete Rides Reason` AS Reason FROM ncr_ride_bookings WHERE `Incomplete Rides Reason` IS NOT NULL AND `Incomplete Rides Reason` != ''
) sub;


CREATE TABLE DimPaymentMethod (
    PaymentMethodID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentMethodName VARCHAR(255)
);

INSERT INTO DimPaymentMethod (PaymentMethodName)
SELECT DISTINCT `Payment Method` 
FROM ncr_ride_bookings 
WHERE `Payment Method` IS NOT NULL AND `Payment Method` != '';


CREATE TABLE factbookings AS
SELECT 
    ROW_NUMBER() OVER () AS FactBookingID,
    b.`Booking ID` AS BookingID,
    b.`Date` AS BookingDate,
    b.`Time` AS BookingTime,
    b.`Customer ID` AS CustomerID,
    b.`Booking Status` AS BookingStatus,
    v.VehicleTypeID,
    r.ReasonID,
    p.PaymentMethodID,
    b.`Pickup Location` AS PickupLocation,
    b.`Drop Location` AS DropLocation,
    
    CASE 
        WHEN b.`Booking Value` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(b.`Booking Value` AS DECIMAL(10,2))
        ELSE NULL 
    END AS BookingValue,
    
    CASE 
        WHEN b.`Ride Distance` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(b.`Ride Distance` AS DECIMAL(8,2))
        ELSE NULL 
    END AS RideDistance,
    
    CASE 
        WHEN b.`Driver Ratings` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(b.`Driver Ratings` AS DECIMAL(3,2))
        ELSE NULL 
    END AS DriverRating,
    
    CASE 
        WHEN b.`Customer Rating` REGEXP '^[0-9]+(\.[0-9]+)?$' THEN CAST(b.`Customer Rating` AS DECIMAL(3,2))
        ELSE NULL 
    END AS CustomerRating

FROM ncr_ride_bookings b
LEFT JOIN DimVehicle v 
    ON b.`Vehicle Type` = v.VehicleTypeName
LEFT JOIN DimCancellationReason r 
    ON COALESCE(
        NULLIF(TRIM(b.`Reason for cancelling by Customer`), ''), 
        NULLIF(TRIM(b.`Driver Cancellation Reason`), ''), 
        NULLIF(TRIM(b.`Incomplete Rides Reason`), '')
    ) = r.ReasonDescription
LEFT JOIN DimPaymentMethod p 
    ON b.`Payment Method` = p.PaymentMethodName;


ALTER TABLE factbookings 
    ADD PRIMARY KEY (FactBookingID),
    ADD CONSTRAINT fk_vehicle FOREIGN KEY (VehicleTypeID) REFERENCES DimVehicle(VehicleTypeID),
    ADD CONSTRAINT fk_reason FOREIGN KEY (ReasonID) REFERENCES DimCancellationReason(ReasonID),
    ADD CONSTRAINT fk_payment FOREIGN KEY (PaymentMethodID) REFERENCES DimPaymentMethod(PaymentMethodID);