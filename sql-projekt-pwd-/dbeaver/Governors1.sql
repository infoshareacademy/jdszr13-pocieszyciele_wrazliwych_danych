select *
from governors_county_candidate

select distinct state
	, county 
	, count(won)
	, candidate
	, party
	, votes
from governors_county_candidate gcc
where won is true 
group by county, state, candidate, party, votes
order by count(won) desc


select distinct state
	, county 
	, count(won)
	, candidate
	, party
	, votes
	, sum(votes) over (partition by state) Sum_per_state
from governors_county_candidate gcc
group by county, state, candidate, party, votes
order by count(won) desc


select *
from governors_county gc 