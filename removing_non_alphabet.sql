Create Function [dbo].[RemoveNonAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin
/**
*Create by: Gyeonglim Seo
*Date : 2019.07.19
*Description: It removes special characters in columns
*Causion: !!Never use it without the where clause or over 1000 rows !!! 
*/
    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^a-z]%'

    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End;

select Column_name1, dbo.RemoveNonAlphaCharacters([Column_name2]) from [table name] where [must user where clause!!];