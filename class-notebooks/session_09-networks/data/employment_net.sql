/*
Make network where the nodes are anyone who exited and 
the the tie is the employer they worked for as identified 
by an EIN.
*/


drop table if exists docnbr_ein_temp, docnbr_ein, ein_network, ein_network_name,
sub_ein_network_name; 

\echo "Grabbing the ein and docnbr of everyone in the wage table"

create temp table if not exists docnbr_ein_temp as
select  docnbr, ein
from il_wage_exit
where docnbr in (select distinct(docnbr) from ildoc_exit)
and ein is not null
and year = 2015;  

create table if not exists docnbr_ein as
select docnbr, ein, count(*) 
from docnbr_ein_temp 
group by docnbr, ein 
order by 3 desc;


\echo "making the network"; 
create table class1.ein_network as 
select a.docnbr docnbr_l,  a.ein, b.docnbr docnbr_r
from docnbr_ein a
join docnbr_ein b on a.ein = b.ein;

delete from ein_network where docnbr_l = docnbr_r; 
delete from ein_network where ein = '000000000';

\echo "create a table with ein and legal name"
create table if not exists ein_name as
select ein, name_legal, count(*) 
from il_qcew_employers
group by ein, name_legal
order by 3 desc;  

create table if not exists class1.ein_network_name as
select n.docnbr_l, n.ein, e.name_legal, n.docnbr_r
from class1.ein_network n
join ein_name e on n.ein = e.ein;

delete from ein_network_name where name_legal ='nan'; 

\echo "count the legal names for the network"
create table ein_network_legal_name_count as 
select name_legal, count(*) from ein_network_name
group by name_legal order by 2 desc; 


create table if not exists sub_ein_network_name as
select docnbr_l, name_legal, docnbr_r
from ein_network_name
where name_legal in (select name_legal from ein_network_legal_name_count
where count < 5000); 

\echo "make a network based on holding class"
create temp table if not exists docnbr_max_date as
select docnbr, max(exit_date) max_date 
from ildoc_exit
group by docnbr; 

create temp table if not exists docnbr_hclass as
select e.docnbr, e.hclass
from ildoc_exit e
join docnbr_max_date m 
on e.docnbr = m.docnbr and e.exit_date = m.max_date; 

create temp table if not exists docnbr_hclass_ein as
select d.docnbr, d.hclass, e.ein
from docnbr_hclass d 
join docnbr_ein e on d.docnbr = e.docnbr;  

drop table if exists ein_hclass_network; 
create table ein_hclass_network as 
select a.docnbr docnbr_l, a.ein, a.hclass, b.name_legal, c.docnbr docnbr_r
from docnbr_hclass_ein a
join docnbr_hclass_ein c on a.ein = c.ein and a.hclass = c.hclass
join ein_name b on a.ein = b.ein;

delete from ein_hclass_network 
where docnbr_l = docnbr_r 
or ein = '000000000' 
or name_legal = 'nan';
