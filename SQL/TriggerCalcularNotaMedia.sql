-- Disparador que calcular la nota media de un trabajador --

CREATE FUNCTION calcular_nota_media_trabajador() RETURNS trigger AS $$
DECLARE
   condicionValorNumerico boolean;
   condicionTrabajadorMismaTienda boolean;
   notaMedia float;
   sumaNotaTrabajadoresQueEvaluan float;
   cantidadTrabajadoresQueEvaluan float;
BEGIN

   condicionValorNumerico := new.nota >= 0 and new.nota <=10;
   condicionTrabajadorMismaTienda :=  (select id_tienda_tienda from trabajador where nss = new.nss_trabajador) 
                                        = 
                                      (select id_tienda_tienda from trabajador where nss = new.nss_trabajador1);

   if ( not condicionValorNumerico)
   then
        raise exception 'Solo se permiten valores del 0 al 10';
   else
        if ( not condicionTrabajadorMismaTienda)
        then
            raise exception 'Los trabajadores deben de pertenenecer a la misma tienda';
        else
            sumaNotaTrabajadoresQueEvaluan := (select sum(nota) from trabajador_evalua_trabajador where nss_trabajador1 = new.nss_trabajador1);
            cantidadTrabajadoresQueEvaluan := (select count(nss_trabajador) from trabajador_evalua_trabajador 
                                                where nss_trabajador1 = new.nss_trabajador1);
            notaMedia := sumaNotaTrabajadoresQueEvaluan / cantidadTrabajadoresQueEvaluan;

            update trabajador set nota_media = notaMedia where nss = new.nss_trabajador1;  
        end if;        
   end if;

   return new;
END

$$ LANGUAGE 'plpgsql';

CREATE TRIGGER calcular_nota_media_trabajador AFTER INSERT ON trabajador_evalua_trabajador
FOR EACH ROW EXECUTE PROCEDURE calcular_nota_media_trabajador();