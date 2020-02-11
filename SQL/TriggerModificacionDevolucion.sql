-- Trigger que modifica el stock del producto al devolver --

CREATE FUNCTION modifica_stock_devolucion() RETURNS trigger AS $$
DECLARE
    condicion boolean;
BEGIN
	condicion := new.cantidad <= (select cantidad from compra_producto where id_ticket_ticket=new.id_ticket_ticket and 
        codigo_producto = new.codigo_producto);

    if (not condicion) 
    then
        raise exception 'No puede devolver mas productos de los comprados'; 
    else
        update producto set stock = stock + new.cantidad where codigo=new.codigo_producto;
	end if;
    return new;
END

$$ LANGUAGE 'plpgsql';

CREATE TRIGGER modifica_stock_devolucion AFTER INSERT ON devuelve_producto
FOR EACH ROW EXECUTE PROCEDURE modifica_stock_devolucion();