CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department)
VALUES 
(1, 'John', 'Doe', 'HR'),
(2, 'Jane', 'Smith', 'IT'),
(3, 'Emily', 'Johnson', 'HR'),
(4, 'Michael', 'Williams', 'Finance'),
(5, 'Sarah', 'Brown', 'IT');


select * from employees


procedure 
function 
use Movies

select * from tblFilm
go 





create proc DailyFilm33
@Runtime int 
as
begin	
		select  top 1 *  from tblFilm
		where FilmRunTimeMinutes < @Runtime and suggestions <> 'Suggested'
		order by FilmOscarWins desc 
		if not exists( select * from sys.columns where name = 'Suggestionofmovies' and Object_ID = OBJECT_ID('tblFilm') )
		begin
			create table suggestedMovies( Suggestions varchar(50))
		end
			insert into suggestedMovies

end
--film ni suggest qilishi kerak va har safar boshqa boshqa movie larni suggest qilishi kerak 
-- bitta boshqa table ochib oshanga har bir suggest qilganini otkazib kynhi suggestda shuni tekshirsa bo'ladi, shunday qilaman



dailyfilm33 150


alter table tblfilm add Suggestions varchar(50)


select * from tblFilm


alter table tblfilm
drop column suggestions






