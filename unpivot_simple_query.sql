SELECT waitlistentryID,column_name, column_date 
FROM   
   (SELECT [WAITLISTENTRYID],[ERDATE], [ADMIT], [PREOP], [OPDATE], [CVICU]  
   FROM cabg_pathway) p  
UNPIVOT  
   (column_date FOR column_name IN   
      ([ERDATE], [ADMIT], [PREOP], [OPDATE], [CVICU])  
)AS unpvt;
