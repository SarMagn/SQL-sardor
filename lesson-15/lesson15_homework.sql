
--Hometask

create table Hierarchy(id int, name varchar(100), manager_id int, manager varchar(100))

insert into Hierarchy values 
(150, 'John Ryden', 111, 'Jack Tarkowski'),
(165, 'Sara Miller', 111, 'Jack Tarkowski'), 
(180, 'Rebecca Carson', 211, 'Thomas Kim'), 
(107, 'Sean Sullivan', 180, 'Rebecca Carson'), 
(142, 'Floyd Kan', 122, 'Alex Pereira'), 
(122, 'Alex Pereira', 107, 'Sean Sullivan'), 
(111, 'Jack Tarkowski', 107, 'Sean Sullivan'), 
(211, 'Thomas Kim', 191, 'Nicolas Jackson'), 
(177, 'Michael Rim', Null, Null), 
(191, 'Nicolas Jackson', 177, 'Michael Rim')



select * from Hierarchy



WITH EmployeeHierarchy AS (
   
    SELECT id, name, manager_id, manager, 1 AS Level
    FROM Hierarchy
    WHERE manager_id IS NULL

    UNION ALL
	 
    SELECT h.id, h.name, h.manager_id, h.manager, eh.Level + 1
    FROM Hierarchy h
    JOIN EmployeeHierarchy eh ON h.manager_id = eh.id
)

SELECT * FROM EmployeeHierarchy
ORDER BY Level, manager_id;


select * from tblActor
where filmid in (
select FilmID from tblFilm
where FilmName = 'Annie Hall')










select * from INFORMATION_SCHEMA.TABLES

