create procedure sp_searching_data (@words as varchar(50))
as
begin
/**
* Created by : Gyeonglim Seo
* Date: 2019.07.29
* Description: Searching data for building reports in PowerInsight. It's imported from an excel file.
*/
	declare @select_string nvarchar(1000); 
	declare @result_string nvarchar(3000);

	declare @table_count int; -- this variable stores the total number of tables for finding the last rows of a cursor
	declare @cursor_count int;-- this variable counts rows of cusor for comparing with table_count

	-- Those two varibles should be initialized in global area
	set @result_string=''; 
	set @cursor_count=0;

	-- How many rows will be in Cursor
	select @table_count=count(*) from INFORMATION_SCHEMA.TABLES where table_name like 'Powerinsight%'

	declare table_cursor cursor for 
		select 'select * from '+table_name+
		' where def like ''%'+@words+'%'' or objectName  like ''%'+@words+'%''' 
		from INFORMATION_SCHEMA.TABLES
		where table_name like 'Powerinsight%'

	open table_cursor 
	fetch next from table_cursor
	into @select_string

		while @@FETCH_STATUS=0
		begin
			set @cursor_count=@cursor_count+1
			
			-- If it's a last row, the union all clause must be removed. 
			if @cursor_count!=@table_count
				set @result_string=@result_string+@select_string+' union all '
			else 
				set @result_string=@result_string+@select_string

			fetch next from table_cursor
			into @select_string
		end
	close table_cursor
	deallocate table_cursor

	-- execute a string query
	exec sp_executesql @result_string

end;

exec sp_searching_columnName 'deni';
