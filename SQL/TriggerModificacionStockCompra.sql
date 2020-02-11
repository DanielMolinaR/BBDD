-- Trigger que modifica el stock del producto al comprar, actualiza el precio del ticket y le aplica descuento si es necesario --

CREATE FUNCTION gestion_compra() RETURNS trigger AS $$
DECLARE
    condicionNumeroMayorQueCero boolean;
    condicion boolean;
    condicionOferta float;
    condicionCupon boolean;

    idCupon integer;
    nSocio text;

    precioLocal float;
BEGIN
    condicionNumeroMayorQueCero := new.cantidad > 0;
	condicion := new.cantidad <= (select stock from producto where codigo = new.codigo_producto);

    condicionOferta := (select descuento from ticket, oferta where id_ticket = new.id_ticket_ticket and new.codigo_producto = oferta.codigo_producto and 
                       (select fecha from ticket where id_ticket=new.id_ticket_ticket) between (select f_ini from oferta where oferta.codigo_producto=new.codigo_producto) 
                       and (select f_fin from oferta where oferta.codigo_producto=new.codigo_producto));

    condicionCupon := ((select n_socio_socio from ticket where ticket.id_ticket = new.id_ticket_ticket) is not null);
    
    -- Si la la cantidad que se quiere comprar es inferior igual al stock, entonces se procede a comprar
    if ( not condicionNumeroMayorQueCero)
    then
        raise exception 'La cantidad debe de ser mayor que 0';

    else
        if ( not condicion) 
        then 
            raise exception 'No hay suficiente stock';

        else
            update producto set stock = stock - new.cantidad where codigo=new.codigo_producto;
            precioLocal := (select p_sin_iva from producto where codigo = new.codigo_producto) * 1.21 * new.cantidad;

            -- Si el producto que quiere comprarse está dentro de las fechas en las que el producto tiene oferta, se aplica descuento 

            if(condicionOferta is not null)
            then
                precioLocal = precioLocal - precioLocal * (select descuento from oferta where oferta.codigo_producto = new.codigo_producto);
            end if;

            -- Aplica cupon

            if (condicionCupon)
            then
                if ((select codigo from producto where codigo = new.codigo_producto) in (select codigo_producto from cupon))
                then
                    nSocio = (select n_socio_socio from ticket where id_ticket = new.id_ticket_ticket);

                    idCupon = (select id_cupon from socio, genera_cupon, cupon, producto where 
                        n_socio = genera_cupon.n_socio_socio and genera_cupon.id_cupon_cupon = id_cupon and
                        cupon.codigo_producto = codigo and n_socio = nSocio and codigo = new.codigo_producto);

                    precioLocal := precioLocal - precioLocal * (select descuento from cupon where id_cupon = idCupon);
                end if;
            end if;

            -- Si el el ticket está a NULL, entonces el precio será el del producto que se introduzca el primero. Sino, se le sumara a la cantidad anterior

            if((select precio from ticket where id_ticket = new.id_ticket_ticket) is null)
            then
                update ticket set precio = precioLocal where id_ticket = new.id_ticket_ticket;
            else
                update ticket set precio = precio + precioLocal where id_ticket = new.id_ticket_ticket;
            end if;            
        end if;
    end if;

    return new;
END

$$ LANGUAGE 'plpgsql';

CREATE TRIGGER gestion_compra AFTER INSERT ON compra_producto
FOR EACH ROW EXECUTE PROCEDURE gestion_compra();