create view users_view as
select *
from users;

create trigger person_deleted
	instead of delete on users_view
	for each row 
	execute procedure update_table()
	
create or replace function update_table()
returns trigger as
$$
begin
	update users
	set username = 'deleted'
	where id = old.id ;
	return old;
end;
$$ language plpgsql;

delete from users_view 
where username = 'Sonya Hale'

Через триггер реализовать проверку
если добавляется что-то с нерпавильной ценой, то не добавлять

