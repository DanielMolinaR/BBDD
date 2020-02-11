-- 1. Mostrar los artículos presentes en la base de datos, mostrando su código de barras y el precio de venta sin IVA --

select codigo, p_sin_iva from producto

-- 2. Mostrar el nombre de todos los trabajadores de la tienda indicando si son cajeros o reponedores --

select (case when n_horas is null then concat (nombre, ' (Cajero)') else concat (nombre, ' (Reponedor)') end) as nombre from trabajador left join reponedor on reponedor.nss_trabajador = trabajador.nss

-- 3. Mostrar el nombre de los reponedores de la tienda que trabajan más de 20 horas semanales --

select nombre from trabajador, reponedor where trabajador.nss = reponedor.nss_trabajador and n_horas>20

-- 4. Obtener el total del dinero facturado por el supermercado desde la implementación de la base de datos. --
-- SOLUCIÓN: Para ello recogemos el precio de compra registrado en los tickets --

select sum(precio) as total_facturado from ticket

-- 5. Mostrar los cupones de los clientes, junto con los productos a los que afectan y el descuento realizado --
-- SOLUCIÓN: Hacemos el producto cartesiano del argumento detrás del select, y lo condicionamos para que se genere el resultado que queremos. Añadimos que aparezca nombre del socio para dejarlo más claro --

select n_socio, nombre, id_cupon, concat (descuento, ' (%)') as porcentaje_descuento, codigo_producto from socio, genera_cupon, cupon, aplica_descuento where socio.n_socio=genera_cupon.n_socio_socio and genera_cupon.id_cupon_cupon=cupon.id_cupon 
and cupon.id_cupon=aplica_descuento.id_cupon_cupon order by n_socio

-- 6. Mostrar los 5 productos sobre los cuales los socios disponen de cupones de descuento --

select codigo from producto where codigo in (select codigo_producto from cupon) order by codigo

-- 7. Determinar el grado de satisfacción medio de las opiniones que los clientes han realizado por internet, mostrando la puntuación media --

select avg(puntuacion) as Media_Socios from opinion

-- 8. Determinar el número de tickets que ha emitido cada tienda, mostrando el número de tickets, el nombre del cajero y la ciudad de la tienda donde trabaja el mismo. Ordenar la salida de mayor a menor --

select distinct ciudad, barrio, nombre, count(id_ticket) as contador from tienda, trabajador, cajero, ticket
where tienda.id_tienda=trabajador.id_tienda_tienda and trabajador.nss = cajero.nss_trabajador and cajero.nss_trabajador=ticket.nss_trabajador_cajero 
group by ciudad, barrio, nombre order by count(id_ticket) desc

-- 9. Determinar el número trabajadores que tiene cada tienda, ordenando la salida de menor a mayor --

select ciudad, barrio, count(nss) as contador from tienda inner join trabajador on tienda.id_tienda=trabajador.id_tienda_tienda group by ciudad, barrio order by count(nss) asc

-- 10. Mostrar el nombre y los teléfonos del empleado que tenga la mejor puntuación

select nombre, tlfno_fijo, tlfno_movil, nota_media from trabajador where nota_media in (select max(nota_media) from trabajador)

-- 11. Mostrar el nombre de los trabajadores por orden alfabético de las tiendas situadas en ciudades que empiezan por “M” --

select nombre from trabajador inner join tienda on tienda.id_tienda=trabajador.id_tienda_tienda and ciudad like 'M%' order by nombre asc

-- 12. Mostrar el email del socio que más saldo total ha acumulado --

select nombre, email, saldo from socio where saldo in (select max(saldo) from socio)

-- 13. Mostrar el producto que más veces se ha devuelto (TENEMOS QUE HABLARLO, PORQUE PUEDE SER LAS VECES QUE SE HA REGISTRADO LA DEVOLUCIÓN O LA CANTIDAD DE PRODUCTOS) --
-- SOLUCIÓN: Ordenamos de mayor a menor las veces que aparece un producto en devuelve_producto, y luego cogemos el primero, ya que será el que más veces se ha devuelto

select codigo_producto, count(codigo_producto) as cuantas_veces_devuelto from devuelve_producto group by codigo_producto order by count(codigo_producto) desc limit 1

-- 14. Mostrar el nombre del cajero que más tickets ha emitido --

select nombre, count(id_ticket) as n_tickets from trabajador, cajero, ticket 
where trabajador.nss=cajero.nss_trabajador and ticket.nss_trabajador_cajero=cajero.nss_trabajador 
group by nombre order by count(id_ticket) desc limit 1

-- 15. Mostrar el nombre del socio que ha emitido la mejor opinión (la de mayor puntuación) --

select nombre, puntuacion from socio, opinion where opinion.n_socio_socio=socio.n_socio and puntuacion in (select max(puntuacion) from opinion)

-- 16. Mostrar los tickets emitidos por cajeros cuyo nombre empiece por “A” y trabajen en ciudades que empiezan por “M” --

select nombre, id_ticket, ciudad from ticket, cajero, trabajador, tienda where trabajador.nss=cajero.nss_trabajador and ticket.nss_trabajador_cajero=cajero.nss_trabajador 
and tienda.id_tienda = trabajador.id_tienda_tienda and nombre like 'A%' and ciudad like 'M%'

-- 17. Mostrar el id de los tickets emitidos en las tiendas de Alcalá de Henares junto con el nombre del cajero --

select nombre, id_ticket from ticket, cajero, trabajador, tienda where trabajador.nss=cajero.nss_trabajador and ticket.nss_trabajador_cajero=cajero.nss_trabajador 
and trabajador.id_tienda_tienda = tienda.id_tienda and ciudad like 'Alcala de Henares'