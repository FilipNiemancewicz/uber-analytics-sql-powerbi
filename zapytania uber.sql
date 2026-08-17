select 
	count(distinct BookingID) as total_orders
	,SUM(CASE WHEN BookingStatus = 'Completed' THEN 1 ELSE 0 END) as completed
	,round((SUM(CASE WHEN BookingStatus = 'Completed' THEN 1 ELSE 0 END)/(count(distinct BookingID))*100),2)
	,SUM(CASE WHEN BookingStatus = 'Completed' THEN BookingValue  ELSE 0 END) as total_revenue
	,round(SUM(CASE WHEN BookingStatus = 'Completed' THEN BookingValue  ELSE 0 END)/SUM(CASE WHEN BookingStatus = 'Completed' THEN 1 ELSE 0 END),2) as avg_price
	,SUM(CASE WHEN BookingStatus IN('NO DRIVER FOUND','Incomplete','Cancelled by Driver','Cancelled by Customer') THEN BookingValue  ELSE 0 END) as lost_money
from factbookings 

/* Która kategoria pojazdów generuje największy przychód, ma najdłuższe średnie dystanse i uzyskuje najlepsze oceny od kierowców? */

SELECT 
    dv.VehicleTypeName,
    COUNT(f.FactBookingID) AS total_orders,
    ROUND(SUM(f.BookingValue), 2) AS total_revenue,
    ROUND(AVG(f.RideDistance), 2) AS avg_distance_km,
    ROUND(AVG(f.DriverRating), 4) AS avg_driver_rating 
FROM factbookings f
JOIN dimvehicle dv ON f.VehicleTypeID = dv.VehicleTypeID
WHERE f.BookingStatus = 'Completed'
GROUP BY dv.VehicleTypeName
ORDER BY total_revenue DESC


/* Jakie są TOP 5 najczęstszych powodów rezygnacji z kursu i jaki mają procentowy udział we wszystkich odwołanych przejazdach? */

select 
	 dc.ReasonDescription
	,count(f.BookingID) as number_of_description
from dimcancellationreason dc
join factbookings f on dc.ReasonID = f.ReasonID 
where dc.ReasonDescription != 'NULL'
group by 1
order by count(f.BookingID) desc

/* Jakie metody płatności są najpopularniejsze i czy różnią się średnią wartością przejazdu? */

select 
	 PaymentMethodName
	,count(BookingID)
	,round(avg(f.BookingValue),2) as avg_price
from factbookings f 
join dimpaymentmethod dpm on f.PaymentMethodID = dpm.PaymentMethodID 
group by 1
order by 2 desc

/* W jakich godzinach w ciągu doby jest największe zapotrzebowanie na przejazdy i jak zmienia się wtedy % anulowanych kursów? */

SELECT 
    HOUR(BookingTime) AS booking_hour,
    COUNT(BookingID) AS total_orders,
    SUM(CASE WHEN BookingStatus != 'Completed' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(100.0 * SUM(CASE WHEN BookingStatus != 'Completed' THEN 1 ELSE 0 END) / COUNT(BookingID), 2) AS cancellation_rate_pct
FROM factbookings
GROUP BY HOUR(BookingTime)
ORDER BY total_orders DESC;


/*  Ilu klientów odpowiada za top 10% łącznego przychodu firmy? */ 
with 
wydatki as 
(
	select 
		 CustomerID
		,sum(BookingValue) as total_spent
		,NTILE(10) OVER (ORDER BY SUM(BookingValue) DESC) AS decile
	from factbookings
	WHERE BookingStatus = 'Completed'
	group by 1
	order by 2 desc
)
SELECT 
    COUNT(CustomerID) AS top_10_percent_customers_count,
    ROUND(SUM(total_spent), 2) AS top_10_percent_revenue
FROM wydatki
WHERE decile = 1;


select 
CustomerID
,BookingValue
from factbookings
where CustomerID = "CID2706299"










