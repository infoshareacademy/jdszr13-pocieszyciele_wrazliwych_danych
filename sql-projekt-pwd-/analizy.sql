

--Governors  - jaki % głosów nieważnych per lokalizacja
select * 
from governors_county gc 


--Governors - wygrani w stanach per partia

select county, sum(votes) county_total_votes
from governors_county_candidate gcc 
group by county


select *
	,SUM(votes) over (partition by county) county_votes
	,round((votes::numeric  / SUM(votes) over (partition by county))*100,2) county_votes_percent
	,SUM(votes) over (partition by state) state_votes
	,SUM(votes) over (partition by party, state) party_votes
	,round((SUM(votes) over (partition by party, state)::numeric / SUM(votes) over (partition by state))*100,2) percent_party_votes_by_state
	,case when won = true then 1 else 0 end winners
	,sum(case when won = true then 1 else 0 end) over (partition by state,party) party_winners_by_state
from governors_county_candidate gcc
where state = 'Indiana'



with a as(
select candidate, state 
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
from governors_county_candidate gcc
group by state,candidate
order by sum(case when won = true then 1 else 0 end) desc)
select state, max(winners), concat(state,(max(winners))) vlookup
from a
group by state

select candidate, state
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
	,concat(state,sum(case when won = true then 1 else 0 end)) vlookup
from governors_county_candidate gcc
group by candidate, state
order by sum(case when won = true then 1 else 0 end) desc
-- połączenie zapytań
with a as(
select candidate, state 
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
from governors_county_candidate gcc
group by state,candidate
order by sum(case when won = true then 1 else 0 end) desc),
b as(select candidate, state
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
	,concat(state,sum(case when won = true then 1 else 0 end)) vlookup
from governors_county_candidate gcc
group by candidate, state
order by sum(case when won = true then 1 else 0 end) desc),
select a.state, max(a.winners), concat(state,(max(a.winners))) vlookup
from a
group by state

--test
with b(
with a as(
select candidate, state 
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
from governors_county_candidate gcc
group by state,candidate
order by sum(case when won = true then 1 else 0 end) desc)
select state, max(winners), concat(state,(max(winners))) vlookup
from a
group by state),
c as(select candidate, state
	,sum(case when won = true then 1 else 0 end) winners
	,sum(votes) votes
	,concat(state,sum(case when won = true then 1 else 0 end)) vlookup
from governors_county_candidate gcc
group by candidate, state
order by sum(case when won = true then 1 else 0 end) desc),
select * 
from b 
join c on c.vlookup = b.vlookup



select distinct(state)
from governors_county_candidate gcc 


-- połączone zapytania

WITH a AS (
    SELECT candidate, state,
        SUM(CASE WHEN won = true THEN 1 ELSE 0 END) winners,
        SUM(votes) votes
    FROM governors_county_candidate gcc
    GROUP BY state, candidate
    ORDER BY SUM(CASE WHEN won = true THEN 1 ELSE 0 END) DESC
),
b AS (
    SELECT state, MAX(winners), CONCAT(state, MAX(winners)) AS vlookup
    FROM a
    GROUP BY state
),
c AS (
    SELECT candidate, state, party,
        SUM(CASE WHEN won = true THEN 1 ELSE 0 END) winners,
        SUM(votes) votes,
        CONCAT(state, SUM(CASE WHEN won = true THEN 1 ELSE 0 END)) AS vlookup
    FROM governors_county_candidate gcc
    GROUP BY candidate, state, party
    ORDER BY SUM(CASE WHEN won = true THEN 1 ELSE 0 END) DESC
)
SELECT b.state, c.candidate, c.party, b. max, c.votes
FROM b
JOIN c ON c.vlookup = b.vlookup


--Governors - jaki % głosów per partia per lokalizacja (state i county)
-- total glosy per state 
-- total per partia per state
with a as(select state, party
	,sum(votes) total_votes_by_party_by_state
from governors_county_candidate gcc 
group by state, party),
b as (select state
	,sum(votes) total_votes_by_state
from governors_county_candidate gcc 
group by state)
select a.*, b.total_votes_by_state
	,concat(round((a.total_votes_by_party_by_state::numeric / b.total_votes_by_state::numeric)*100,2),'%')
from a
join b on a.state = b.state







