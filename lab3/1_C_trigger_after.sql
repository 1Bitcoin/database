CREATE OR REPLACE FUNCTION add_to_log() RETURNS TRIGGER AS $$
DECLARE
    mstr varchar(30);
    astr varchar(100);
    retstr varchar(254);
BEGIN
    IF  TG_OP = 'INSERT' THEN
        astr = NEW.username; -- переменная NEW будет содержать новую строку, а OLD будет пустая
        mstr := 'Add new user ';
        retstr := mstr || astr;
        INSERT INTO logs(text, added) values (retstr, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        astr = NEW.username; -- обе переменные будут определены (соответствующими данными)
        mstr := 'Update user ';
        retstr := mstr || astr;
        INSERT INTO logs(text, added) values (retstr, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        astr = OLD.username; -- переменная NEW будет пустая, OLD содержать удаляемую строку.
        mstr := 'Remove user ';
        retstr := mstr || astr;
        INSERT INTO logs(text, added) values (retstr, NOW());
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_products_trigger
AFTER INSERT OR UPDATE OR DELETE ON users 
FOR EACH ROW EXECUTE PROCEDURE add_to_log();
