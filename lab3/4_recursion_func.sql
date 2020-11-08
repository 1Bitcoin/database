drop function if exists recursion_func;

create function recursion_func (id_user int) returns table (my_user_id int, my_friend_id int)
as $$
declare res int;
begin
	res := (SELECT friend_id from users where id = id_user);
    return query select id_user, res;
    if res is not null then
        return query 	
			select * 
			from recursion_func(res);
    end if;
end $$ language plpgsql;

select * from recursion_func(1);


