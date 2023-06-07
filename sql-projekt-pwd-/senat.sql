select *, scc.total_votes  / sc.current_votes * 100
from senate_county_candidate scc 
join senate_county sc on sc.state  = scc.state 
join senate_state ss on sc.state  = ss.state 
where percent <> 100

select * , round((current_votes::numeric/total_votes::numeric)*100,0) as calculate
from senate_county sc 
where percent <>100

-- wybory senat Alabama
select candidate , sum(total_votes)
from senate_county_candidate scc 
where state = 'Alabama'
group by candidate 
order by sum(total_votes) DESC

-- 	 ... 
select * 
from senate_state ss 
where state = 'Alabama'

select sum(total_votes) total, sum(current_votes) current
from senate_county sc 
where state = 'Alabama'

select *
from senate_county_candidate scc 
where state = 'Alabama'

select candidate, sum(total_votes)
from senate_county_candidate scc 
where state = 'Alabama'
group by candidate
order by sum(total_votes) desc

2316445

select sum(total_votes), 2316445 - sum(total_votes), 2316445 - sum(total_votes) + sum(total_votes)
from senate_county_candidate scc 
where state = 'Alabama'
--Tommy 1,392,076
--Jones 920,478
2 31
sdadsa





-- tabela house
select * 
from house_state ss 
select *
from house_candidate scc 


-- tabela president check danych
select * 
from president_state ss 
where state = 'Delaware'

select sum(total_votes) total, sum(current_votes) current
from president_county sc 
where state = 'Delaware'

select *
from president_county_candidate scc 
where state = 'Delaware'

select candidate, sum(total_votes)
from president_county_candidate scc 
where state = 'Delaware'
group by candidate
order by sum(total_votes) desc

select  sum(total_votes)
from president_county_candidate scc 
where state = 'Delaware'


-- tabela governors check danych
select * 
from governors_state ss 
where state = 'Delaware'

select sum(total_votes) total, sum(current_votes) current
from governors_county sc 
where state = 'Delaware'

select *
from governors_county_candidate scc 
where state = 'Delaware'

select candidate, sum(votes)
from governors_county_candidate scc 
where state = 'Delaware'
group by candidate
order by sum(votes) desc

select  sum(votes)
from governors_county_candidate scc 
where state = 'Delaware'

-- tabela governors 
select * 
from governors_county gc 

select * 
from governors_county_candidate gcc 

select * 
from governors_state gs 

-- governors kto wygrał per county
select * 
	, case when 
from governors_county_candidate gcc 
where won = true

select distinct(party)
from governors_county_candidate gcc 


select *
	, case when (round((current_votes::numeric / total_votes::numeric)*100,0))>100 
	then round((total_votes::numeric / current_votes::numeric)*100,2)
	else round((current_votes::numeric / total_votes::numeric)*100,2)
	end aa
	,  current_votes - total_votes  not_valid
from governors_county gc 
where current_votes > total_votes 


