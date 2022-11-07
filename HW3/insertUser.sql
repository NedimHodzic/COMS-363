-- Author: Nedim Hodzic

drop procedure if exists practice.insertUser;
delimiter //
create procedure practice.insertUser(in screen_name varchar(80), in user_name varchar(80), in category varchar(80),
in subcategory varchar(80), in state varchar(80), in numFollowers int, in numFollowing int, out success int)
begin
	declare screen_name_to_insert varchar(80);
    declare new_screen_name varchar(80);
	set success = 0;

	set screen_name_to_insert = screen_name;
    
    insert into practice.users values(screen_name, user_name, category, subcategory, state, numFollowers, numFollowing);
    
    select u.screen_name into new_screen_name
    from practice.users u where u.screen_name = screen_name;
    
	if new_screen_name = screen_name_to_insert then
		set success = 1;
    end if;
end; //
delimiter ;

set @screen_name="pakatisu";
set @user_name="pak at ISU";
set @category = null;
set @subcategory = "Independent"; set @state = "Iowa";
set @numFollows=0;
set @numFollowing=0;
set @success=0;

call practice.insertUser(@screen_name, @user_name, @category, @subcategory, @state, @numFollowers, @numFollowing, @success);
select @success;