--Homework

use W3Resource
--1

select md.match_no, sc.country_name from SOCCER.match_details as md, (select * from SOCCER.soccer_country) as sc
where md.team_id = sc.country_id and md.match_no = 1

--2

select sc.country_name from SOCCER.match_details as md, (select * from SOCCER.soccer_country) as sc
where md.team_id =  sc.country_id and md.play_stage = 'F' and md.win_lose = 'W'

--3

select match_no, play_stage, goal_score, audience from SOCCER.match_mast
where audience = (select max(audience) from SOCCER.match_mast)

--4
select match_no from SOCCER.match_details as md
where team_id in (select country_id from SOCCER.soccer_country where country_name = 'Germany' or country_name = 'Poland')
group by match_no
having COUNT(team_id) = 2

--5
select match_no, play_stage, play_date, results, goal_score from SOCCER.match_mast
where match_no =( select match_no from SOCCER.match_details
where team_id in (select country_id from SOCCER.soccer_country where country_name = 'Portugal' or country_name = 'Hungary')
group by match_no
having COUNT(team_id) = 2  )

--6
select match_no, sc.country_name, player_name ,COUNT(goal_id) as count	 from SOCCER.goal_details as gd, 
					(select * from SOCCER.soccer_country) as sc, (select * from SOCCER.player_mast) as pm
 
where gd.team_id = sc.country_id and pm.player_id = gd.player_id
group by match_no, goal_id, player_name, country_name

--7
select * from SOCCER.soccer_country
where  country_id in (
select team_id from SOCCER.goal_details
where match_no = (
select match_no from SOCCER.match_mast
where audience = (select MAX(audience) from SOCCER.match_mast))
)
select * from SOCCER.match_mast

--8
select player_name from SOCCER.player_mast
where player_id = (
select player_id from SOCCER.goal_details as gd, (select MAX(goal_time) as maxtime, match_no from SOCCER.goal_details
where match_no =(
select match_no from SOCCER.match_details
where team_id in (
select country_id from SOCCER.soccer_country
where country_name = 'Portugal' or country_name = 'Hungary')
group by match_no
having COUNT(team_id) = 2)
group by match_no) as mm
where gd.match_no = mm.match_no and gd.goal_time = mm.maxtime)

--9

select MAX(stop2_sec) from SOCCER.match_mast
where stop2_sec <> (select MAX(stop2_sec) from SOCCER.match_mast)

--10

select country_name from SOCCER.soccer_country
where country_id in (
select team_id from SOCCER.match_details
where match_no =( select match_no from SOCCER.match_mast
where stop2_sec =(
select MAX(stop2_sec) from SOCCER.match_mast
where stop2_sec <> (select MAX(stop2_sec) from SOCCER.match_mast))))

--11
select match_no , play_date, stop2_sec from SOCCER.match_mast
where stop2_sec = ( select MAX(stop2_sec) from SOCCER.match_mast
where stop2_sec <> (select MAX(stop2_sec) from SOCCER.match_mast))

--12

select country_name from SOCCER.soccer_country
where country_id = ( select team_id from SOCCER.match_details
where play_stage = 'F' and win_lose = 'L')

--13
select team_id, COUNT(player_id) from SOCCER.player_mast
group by team_id


select playing_club, COUNT(player_id) as count1 from SOCCER.player_mast
group by playing_club
having COUNT(player_id) = (
 select MAX(count1) from (select playing_club, COUNT(player_id) as count1 from SOCCER.player_mast
group by playing_club) as club1)

--14

select player_name, jersey_no from SOCCER.player_mast
where player_id = (
select player_id from SOCCER.goal_details
where goal_id = (
select MIN(goal_id) as goal_id from SOCCER.goal_details
where goal_type = 'P'))
--group by goal_id


--15


select player_name, jersey_no, country_name from SOCCER.player_mast as pm, (select * from SOCCER.soccer_country) as sc
where player_id = (
select player_id from SOCCER.goal_details
where goal_id = (
select MIN(goal_id) as goal_id from SOCCER.goal_details
where goal_type = 'P')) and pm.team_id = sc.country_id

--16

select player_name from SOCCER.player_mast
where player_id = (
select player_gk from SOCCER.penalty_gk
where team_id = (
select country_id from SOCCER.soccer_country
where country_name = 'Italy'))

--17

select COUNT(*) as Count from SOCCER.goal_details
where team_id = (
select country_id from SOCCER.soccer_country
where country_name = 'Germany')

--18

select player_name, jersey_no, playing_club from SOCCER.player_mast
where team_id = (
select country_id from SOCCER.soccer_country
where country_name = 'England') and posi_to_play = 'GK'

--19

select * from SOCCER.player_mast
where playing_club = 'Liverpool' and team_id = (select country_id from SOCCER.soccer_country where country_name = 'England')

--20

select * from SOCCER.goal_details

select * from SOCCER.match_details
where match_no = 50

--21
select player_name from SOCCER.player_mast
where player_id = (
select distinct player_captain from SOCCER.match_captain
where team_id = ( select team_id from SOCCER.match_details
where play_stage = 'F' and win_lose = 'W'))

--22

select COUNT(*)+11 from SOCCER.player_in_out
where match_no = (
select match_no from SOCCER.match_mast
where play_stage = 'F') and team_id =(
select country_id from SOCCER.soccer_country
where country_name = 'France') and in_out = 'I'

--23

select player_name, jersey_no from SOCCER.player_mast
where player_id = (
select distinct player_gk from SOCCER.match_details
where team_id = (
select country_id from SOCCER.soccer_country
where country_name = 'Germany'))

--23

select country_name from soccer.match_details as md, (select * from SOCCER.soccer_country ) as sc
where play_stage = 'F' and win_lose = 'L' and md.team_id = sc.country_id

--25

select top 1 with ties sc.country_name , COUNT(kick_no) as Total_kicks from SOCCER.penalty_shootout as ps, (Select * from SOCCER.soccer_country) as sc
where sc.country_id=ps.team_id 
group by team_id, country_name
order by Total_kicks desc



select country_name, COUNT(kick_no) from SOCCER.penalty_shootout as a, SOCCER.soccer_country as b
where a.team_id= b.country_id
group by country_name
having COUNT(kick_no) =(
select max(Shots) from (select COUNT(kick_no) as Shots from SOCCER.penalty_shootout
group by team_id) c)


--26

select c.country_name, p.player_name, jersey_no ,COUNT(kick_no) as shots from SOCCER.player_mast as p, SOCCER.penalty_shootout as sh, SOCCER.soccer_country as c
where p.player_id=sh.player_id and c.country_id = p.team_id
group by p.player_id, p.player_name,country_name, jersey_no
having COUNT(kick_id) =(select MAX(kicks) from (select COUNT(kick_id) as kicks from SOCCER.penalty_shootout
group by player_id) as a)


--27
select match_no, COUNT(kick_no) as shots from SOCCER.penalty_shootout
group by match_no
having COUNT(kick_no) =(
select MAX(kicks) from (
select  COUNT(kick_id) as kicks from SOCCER.penalty_shootout
group by match_no) as a
)

--28


select p.team_id, sc.country_name  from SOCCER.penalty_shootout as p, SOCCER.soccer_country as sc
where p.team_id=sc.country_id and match_no =(
select match_no from SOCCER.penalty_shootout as s
group by match_no
having COUNT(kick_no) =(
	select MAX(kicks) from (
	select  COUNT(kick_id) as kicks from SOCCER.penalty_shootout
	group by match_no) as a))
group by team_id, country_name


--29


select match_no, player_name, kick_no from SOCCER.penalty_shootout as ps,SOCCER.player_mast as pm
where ps.player_id=pm.player_id and match_no = (
select match_no from SOCCER.penalty_shootout
where team_id = (select country_id from SOCCER.soccer_country
where country_name = 'Portugal') 
group by match_no) and kick_no = 7


select * from SOCCER.penalty_shootout

--30

select match_no, play_stage from SOCCER.match_mast
where match_no = (
select match_no from SOCCER.penalty_shootout
where kick_id =23)

--31 

select venue_name from SOCCER.soccer_venue
where venue_id in(  select venue_id from SOCCER.match_mast
where match_no in (
select match_no from SOCCER.penalty_shootout
group by match_no))

--32
select play_date from SOCCER.match_mast
where match_no in (
select match_no from SOCCER.penalty_shootout
group by match_no)


--33

select MIN(goal_time) as [Most quickest goal after 5 minutes] from SOCCER.goal_details
where goal_time > 5




