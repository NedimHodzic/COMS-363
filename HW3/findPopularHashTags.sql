-- Author: Nedim Hodzic

drop procedure if exists practice.findPopularHashTags;
delimiter //
create procedure practice.findPopularHashTags(in k int, in year int)
begin
	select distinct count(distinct u.state, h.name) as statenum, group_concat(distinct u.state) as states, h.name as hashtagname
    from practice.hashtags h
    inner join practice.tweets t on t.tid = h.tid
    inner join practice.users u on u.screen_name = t.posting_user
    where t.post_year = year and u.state != 'na'
    group by h.name order by statenum desc limit k;
end; //
delimiter ;
call practice.findPopularHashTags(5, 2016);
