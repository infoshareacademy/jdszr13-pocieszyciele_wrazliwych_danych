--Governors  - jaki % głosów nieważnych per lokalizacja
select * 
from governors_county gc 


--Governors - wygrani w stanach per partia

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


--Presidents  - jaki % głosów nieważnych per lokalizacja
select * 
from president_county pc  

-- presidents total votes 
select candidate, sum(total_votes)s
from president_county_candidate pcc 
group by candidate
order by sum(total_votes) desc

--Presidents - wygrani w stanach per partia per candidate wg electoral votes 
with a as(
SELECT state, party, candidate, winners, total_votes
FROM (
    SELECT state, candidate,party, COUNT(won) AS winners, SUM(total_votes) AS total_votes,
           ROW_NUMBER() OVER (PARTITION BY state ORDER BY SUM(total_votes) DESC) AS row_num
    FROM president_county_candidate pcc
    GROUP BY state, candidate, party
    order by SUM(total_votes) desc
) subquery
WHERE row_num = 1
ORDER BY state)
select a.*, ec.electoral_votes
from a
join electoral_votes ec on a.state = ec.state