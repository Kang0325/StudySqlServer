select * from BikeStores.sales.customers
where state = 'ny'
and phone is not null
and last_name like 's%';