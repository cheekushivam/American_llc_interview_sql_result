create table Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);

insert into Ameriprise_LLC values
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

with judge_first_qualification_criteria AS (
	select 
		*,
		case 
			when criteria1 = criteria2 then 'YES'
			else 'NO'
		end as first_qualification_pass
	from Ameriprise_LLC
)
,judge_second_qualification_criteria AS (
	select
		*,
		case
			when x.count_condition >=2 then 'YES'
			else 'NO'
		end as second_qualification_pass
	From (
		select teamID, count(*) as count_condition
		from Ameriprise_LLC 
		where criteria1 in ('y', 'Y') and criteria2 in ('y', 'Y')
		group by teamID, criteria1, criteria2
		) as x
)
select 
	a.teamid,
	a.memberid,
	a.criteria1,
	a.criteria2,
	case
		when a.first_qualification_pass = 'YES' and b.second_qualification_pass = 'YES' then 'YES'
		else 'NO'
	end as Qualification_for_Program
from judge_first_qualification_criteria as a 
join judge_second_qualification_criteria as b
on a.teamid = b.teamid;









