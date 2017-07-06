create table m3.prisonerwages as 
SELECT  a.*
	, (to_date(exityr||'-'||exitmo||'-'||exitda,'YYYY-MM-DD')-to_date(curadmyr||'-'||curadmmo||'-'||cast(substring(cast(curadmdt as char(8)),2,2) as int),'YYYY-MM-DD'))/365.25 as PrisonTime
	, b.priorwage
       ,q0.baselinepoverty/4 as BaselinePovertyq0,q0.additionalpersons/4 as additionalpersonsq0
       ,q1.baselinepoverty/4 as BaselinePovertyq1,q1.additionalpersons/4 as additionalpersonsq1
       ,q2.baselinepoverty/4 as BaselinePovertyq2,q2.additionalpersons/4 as additionalpersonsq2
       ,q3.baselinepoverty/4 as BaselinePovertyq3,q3.additionalpersons/4 as additionalpersonsq3
       ,q4.baselinepoverty/4 as BaselinePovertyq4,q4.additionalpersons/4 as additionalpersonsq4
       ,q5.baselinepoverty/4 as BaselinePovertyq5,q5.additionalpersons/4 as additionalpersonsq5
       ,q6.baselinepoverty/4 as BaselinePovertyq6,q6.additionalpersons/4 as additionalpersonsq6
       ,q7.baselinepoverty/4 as BaselinePovertyq7,q7.additionalpersons/4 as additionalpersonsq7
       ,c."SPSS_CLASS" as spss_class
       ,c."SPSS_OFFCD" as spss_offcd
FROM m3.wagebyqtr_forcohort a
Left Join M3.WagesPrior2Prison b
	on a.docnbr=b.docnbr
Left Join m3.povertystats q0 
	on a.exityr=q0.year
Left Join m3.povertystats q1 
	on a.exityr=q1.year
Left Join m3.povertystats q2 
	on a.exityr=q2.year
Left Join m3.povertystats q3 
	on a.exityr=q3.year
Left Join m3.povertystats q4
	on a.exityr=q4.year
Left Join m3.povertystats q5 
	on a.exityr=q5.year
Left Join m3.povertystats q6 
	on a.exityr=q6.year
Left Join m3.povertystats q7 
	on a.exityr=q7.year
Left join M3.holding_offense_codes c
	on a.hofnscd=c."SPSS_Code";
ALTER TABLE m3.prisonerwages
  OWNER TO m3_admin;
GRANT ALL ON TABLE m3.prisonerwages TO kpatrick;
GRANT ALL ON TABLE m3.prisonerwages TO m3_admin;
GRANT SELECT ON TABLE m3.prisonerwages TO m3_select;
