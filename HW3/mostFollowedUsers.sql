-- Author: Nedim Hodzic

drop procedure if exists practice.mostFollowedUsers;
delimiter //
create procedure practice.mostFollowedUsers(in k int, in political_party varchar(80))
begin
	select distinct u.screen_name, u.subcategory, u.numFollowers from practice.users u
    where u.subcategory = political_party
    order by u.numFollowers desc limit k;
end; //
delimiter ;
call practice.mostFollowedUsers(5, 'GOP');