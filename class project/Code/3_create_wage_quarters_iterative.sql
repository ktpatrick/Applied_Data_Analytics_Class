-- View: m3.wagebyqtr_view

-- DROP VIEW m3.wagebyqtr_view;

CREATE TABLE m3.wagebyqtr_forcohort AS 
 SELECT e.*,
    p.name_full_hash,
    p.ssn_hash,
    p.ildoc_docnbr,
    p.name_first_hash,
    p.name_middle_hash,
    p.name_last_hash
    
   FROM ( SELECT DISTINCT a.*
           FROM m3.exitqtr a
           WHERE (EXISTS ( SELECT b.docnbr,
                    		  b.minreleasedt
                   	   FROM ( SELECT exitqtr.docnbr,
                            		 min(to_date((((exitqtr.exityr || '-'::text) || exitqtr.exitmo) || '-'::text) || exitqtr.exitda, 'yyyy-mm-dd'::text)) AS minreleasedt
                           	  FROM m3.exitqtr
                                  GROUP BY exitqtr.docnbr) b
                  	   WHERE a.docnbr = b.docnbr AND to_date((((a.exityr || '-'::text) || a.exitmo) || '-'::text) || a.exitda, 'yyyy-mm-dd'::text) = b.minreleasedt))) e
     	  LEFT JOIN class1.person p 
		ON e.docnbr = p.ildoc_docnbr;

ALTER TABLE m3.wagebyqtr_forcohort
  OWNER TO m3_admin;
GRANT ALL ON TABLE m3.wagebyqtr_forcohort TO kpatrick;
GRANT ALL ON TABLE m3.wagebyqtr_forcohort TO m3_admin;
GRANT SELECT ON TABLE m3.wagebyqtr_forcohort TO m3_select;

