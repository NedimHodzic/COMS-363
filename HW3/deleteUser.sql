-- Author: Nedim Hodzic

drop procedure if exists practice.deleteUser;
delimiter //
create procedure practice.deleteUser(in screen_name varchar(80), out errorcode int)
begin
	declare exists_check varchar(80);
    declare delete_check varchar(80);
	set errorcode = 1;
    
    select u.screen_name into exists_check
    from practice.users u where u.screen_name = screen_name;
    
	delete m from practice.mentions m
    inner join practice.users u on u.screen_name = m.mentioned_user_scr
    where u.screen_name = screen_name;
    
    delete m from practice.mentions m
    inner join practice.tweets t on t.tid = m.tid
    where t.posting_user = screen_name;
    
    delete h from practice.hashtags h
    inner join practice.tweets t on t.tid = h.tid
    where t.posting_user = screen_name;

    delete u from practice.urls u
    inner join practice.tweets t on t.tid = u.tid
    where t.posting_user = screen_name;

    delete t from practice.tweets t
    inner join practice.users u on u.screen_name = t.posting_user
    where t.posting_user = screen_name;

	delete u from practice.users u where u.screen_name = screen_name;

    select u.screen_name into delete_check
    from practice.users u where u.screen_name = screen_name;
    
    if delete_check is null then
		set errorcode = 0;
	end if;
    
    if exists_check is null then
		set errorcode = -1;
	end if;
end; //
delimiter ;

set @errorcode = -2;
call practice.deleteUser("pakatisu", @errorcode);
select @errorcode;