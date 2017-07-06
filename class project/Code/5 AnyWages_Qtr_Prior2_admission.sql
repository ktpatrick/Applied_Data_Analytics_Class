create table m3.WagesPrior2Prison as
SELECT 	docnbr, ssn_hash,
	sum(wage) as PriorWage
    
  FROM m3.wagebyqtr_forcohort a
 Left Join ides.il_wage b
	on a.ssn_hash=b.ssn and (case  
		When a.curadmmo in (1,2,3) 	Then cast('4' as char(1))||cast(a.curadmyr-1 as char(4))
		When a.curadmmo in (4,5,6) 	Then cast('1' as char(1))||cast(a.curadmyr as char(4))
		When a.curadmmo in (7,8,9) 	Then cast('2 'as char(1))||cast(a.curadmyr as char(4))
		When a.curadmmo in (10,11,12) 	Then cast('3' as char(1))||cast(a.curadmyr as char(4))
		else '0'
	end)=cast(b.quarter as char(1))||cast(b.year as char(4))
	group by docnbr, ssn_hash;
