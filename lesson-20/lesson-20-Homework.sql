
alter proc DailyFilms
@Runtime int 
as
begin	
		declare @MovieName as varchar(max)
		declare @NewMovie as varchar(max)
		
		if not exists ( select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'SuggestedMovies' )
		begin
			create table SuggestedMovies(FilmName varchar(max))
		end


		select   top 1 @MovieName = FilmName  from tblFilm
		where FilmRunTimeMinutes < @Runtime and 
		NOT EXISTS (SELECT 1 FROM SuggestedMovies WHERE SuggestedMovies.FilmName = tblFilm.FilmName)
		ORDER BY FilmOscarWins DESC
		
		if  not exists( select 1 from SuggestedMovies where FilmName = @MovieName )
		begin
			insert into SuggestedMovies(FilmName) values (@MovieName)
		end	
			if  exists ( select 1 from SuggestedMovies where FilmName = @MovieName )
		begin
				select  top 1 @NewMovie = FilmName  from tblFilm
				where FilmRunTimeMinutes < @Runtime and   FilmName <> @MovieName  
				AND NOT EXISTS (SELECT 1 FROM SuggestedMovies WHERE SuggestedMovies.FilmName = tblFilm.FilmName)
				ORDER BY FilmOscarWins DESC end
			if @NewMovie is not null
			begin 
				select @NewMovie as NewMovie
			end
			else 
			begin
				select @MovieName as MovieName
			end
end

exec dailyFilms 120


