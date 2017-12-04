use mydb_sran2;
#A1
select count(TransID) from Transactions
where TransDate like '%2012-08%' and 
Expenses > (select avg(Expenses) from Transactions where TransDate like '%2012-08%');
#A2
select Reps.RepID, RepName, sum(Sales) from Transactions,Reps
where Transactions.RepID = Reps.RepID and Market = 'West'
group by RepID
order by sum(Sales) desc;
#A3
select Reps.RepID, RepName, sum(Sales-Expenses) as TotalProfit from Reps, Transactions
where Transactions.RepID = Reps.RepID
group by RepID
order by TotalProfit asc;
#A4
select Customers.CustID, CustName,sum(Sales-Expenses) as TotalProfit from Customers,Transactions
where Transactions.CustID = Customers.CustID 
and ProductLine = 'Mowers'
group by CustID
order by TotalProfit desc;
#A5
select ProductLine, State, sum(Sales) from Customers,Transactions
where Transactions.CustID = Customers.CustID and ProductLine = 'Mowers'
group by State
order by sum(Sales) desc;
#A5
select ProductLine, State, sum(Sales) from Customers,Transactions
where Transactions.CustID = Customers.CustID and ProductLine = 'Mowers'
group by State
having sum(Sales) >= all(select sum(Sales) from Customers,Transactions
where Transactions.CustID = Customers.CustID and ProductLine = 'Mowers'
group by State)
#A6
select Reps.RepID,RepName,sum(Sales) from Reps
join Transactions on Reps.RepID = Transactions.RepID
join Customers on Transactions.CustID = Customers.CustID
where Gender = 'M' and State = 'Arkansas' and TransDate like '%2012%'
group by Reps.RepID
having sum(Sales) >= all(select sum(Sales)from Reps
join Transactions on Reps.RepID = Transactions.RepID
join Customers on Transactions.CustID = Customers.CustID
where Gender = 'M' and State = 'Arkansas' and TransDate like '%2012%'
group by Reps.RepID)
#A7
select ProductLine, sum(Sales), MarketSize from Transactions
group by ProductLine, MarketSize
order by sum(Sales) desc limit 2;
#A8
select CustName,avg(Sales) from Customers
join Transactions on Customers.CustID = Transactions.CustID
join Reps on Transactions.RepID = Reps.RepID
where State = 'Texas' and Gender = 'F' 
and Sales > (select avg(Sales) from Transactions where ProductType = 'Electric' and MarketSize = 'Small Market')
group by CustName;


