create or replace procedure base_size(name_base varchar) as
$$
begin
	raise notice '{base : %} {size : %}', name_base, pg_database_size(name_base);
end
$$ language plpgsql;

call base_size('BMSTU');