--#1
-- unique users
-- total
select count(distinct(player_id)) as unique_users
from players

-- por mês
select count(distinct(player_id)) as unique_users,
	   strftime('%m',cadastrado_em) as month
from players
group by strftime('%m',cadastrado_em)

--#2
-- unique users após 06/02/20
select count(distinct(player_id)) as unique_users
from matchmaking_stats
where created_at >= '2020-02-06'

--#3
-- usuários únicos que não jogaram após 03/02
with tb_players as (

		select distinct(t1.player_id) as registered_users

		from players as t1
		left join matchmaking_stats as t2
		on t1.player_id = t2.player_id

		where t1.cadastrado_em < '2020-02-03'
		and t2.created_at > '2020-02-03'
)

select (count(distinct(t1.player_id)) - count(distinct(t2.registered_users)))

from players as t1
left join tb_players as t2
on t1.player_id = t2.registered_users

where t1.cadastrado_em < '2020-02-03'

--#4
-- dia de fev com menos players ativos
select count(distinct(player_id)) as unique_users,
	   strftime('%d',created_at) as day
from matchmaking_stats
where created_at between '2020-02-01' and '2020-02-29'
group by strftime('%d',created_at)
order by count(distinct(player_id)) asc
limit 1

--#5
-- avg daily players
--da base
select count(distinct(player_id)) / count(distinct(date(created_at))) as avg_daily_players
from matchmaking_stats

--de janeiro
select count(distinct(player_id)) / count(distinct(date(created_at))) as avg_daily_players
from matchmaking_stats
where created_at between '2020-01-01' and '2020-01-31'

-- de fevereiro
select count(distinct(player_id)) / count(distinct(date(created_at))) as avg_daily_players
from matchmaking_stats
where created_at between '2020-02-01' and '2020-02-29'

--#6
-- jogadores que se cadastraram em jan, mas não em fev
with tb_players as (

		select distinct(t1.player_id) as registered_users

		from players as t1
		left join matchmaking_stats as t2
		on t1.player_id = t2.player_id

		where t1.cadastrado_em between '2020-01-01' and '2020-01-31'
		and t2.created_at between '2020-02-01' and '2020-02-29'
)

select (count(distinct(t1.player_id)) - count(distinct(t2.registered_users)))

from players as t1
left join tb_players as t2
on t1.player_id = t2.registered_users

where t1.cadastrado_em between '2020-01-01' and '2020-01-31'

--#7
--10 players com mais hs
select player_id,
	   sum(hs) / sum(matches_played) as avg_hs
	   
from matchmaking_stats
group by player_id
order by avg_hs desc
limit 10

--10 players com menos hs
select player_id,
	   sum(hs) / sum(matches_played) as avg_hs
	   
from matchmaking_stats
group by player_id
order by avg_hs asc
limit 10


--#8
--win_rate dos cadastrados em jan e fev/20
select strftime('%m',t1.cadastrado_em) as register_month,
	   sum(t2.total_wins) / sum(t2.matches_played) as win_rate 
	   
from players as t1
left join matchmaking_stats as t2
on t1.player_id = t2.player_id

where t1.cadastrado_em between '2020-01-01' and '2020-02-29'

group by register_month

