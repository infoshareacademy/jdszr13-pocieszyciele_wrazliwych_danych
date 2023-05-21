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

2315445

select sum(total_votes), 2315445 - sum(total_votes), 2315445 - sum(total_votes) + sum(total_votes)
from senate_county_candidate scc 
where state = 'Alabama'

2 31
sdadsa
