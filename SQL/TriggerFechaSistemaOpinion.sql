-- Trigger que registra la fecha y la hora del sistema en una instancia de OPINION --

CREATE FUNCTION insertar_fecha_opinion() RETURNS trigger AS $$
DECLARE
   
BEGIN
   new.fecha := current_date;
   new.hora := current_time;
   return new;
END

$$ LANGUAGE 'plpgsql';

CREATE TRIGGER insertar_fecha_opinion BEFORE INSERT ON opinion
FOR EACH ROW EXECUTE PROCEDURE insertar_fecha_opinion();