SELECT 	zip5,
	count(zip5),
	
	sum(Case drugalcf
		when 'Y' Then 1
		else 0
	    end) as Alcohol_flag_count,
	sum(Case drugcocf
		when 'Y' Then 1
		else 0
	    end) as cocaine_flag_count,
	sum(Case drugherf
		when 'Y' Then 1
		else 0
	    end) as heroin_flag_count,
	sum(Case drugmarf
		when 'Y' Then 1
		else 0
	    end) as marijuana_flag_count,
	sum(Case drugampf
		when 'Y' Then 1
		else Case drugpcpf
			when 'Y' Then 1
			else Case drugunkf
				when 'Y' Then 1
				else Case drugothf
					when 'Y' Then 1
					else 0
				     end
			      end
		      End
	       End) as otherdrug_flag_count,
	sum(meritorious_good_time) as meritorious_good_time,
	sum(education_in_prison) as education_in_prison,
	sum(substanceabuse_treatment) as substanceabuse_treatment,
	sum("HasKids") as haskids,
	sum(birthdecade1950orprior) as birthdecade1950orprior,
	sum(active_gang_member) as active_gang_member,
	sum(anypriorwage) as anypriorwage,
	sum(Case sexreg
		when 'Y' Then 1
		else case sexreg
			when 'Y' Then 1
			else 0
		     end
	    End) as sexreg_or_sexoff,
     avg(prisontime) as avg_prison_time
  FROM m3.cleaned_data
  group by zip5
  order by 2 desc
  limit 100;