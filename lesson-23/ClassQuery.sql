use ForPractise

create table abc (id int primary key identity, name varchar(50), email varchar(50), adress varchar(100))
	

declare @value int = 1
while @value <= 100000
begin
  declare @name varchar(50) = 'Person' + cast(@value as varchar(50))
  declare @email varchar(50) = 'Person' + cast(@value as varchar(50)) + '@gmail.com'
  declare @address varchar(50) = 'Person ' + cast(@value as varchar(50)) + ' lives in home No.' + cast(@value as varchar(50))

  insert into ABC values (@name, @email, @address)
  set @value = @value + 1
end

select COUNT(*) from abc



select * from abc
where id = 46464 




select * from abc
where name = 'Person46464' 

create nonclustered index NewIndex
on ABC (name desc)

select * from abc
where email = 'Person46464@gmail.com' 


