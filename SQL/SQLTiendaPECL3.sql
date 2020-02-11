-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: "BBDDTienda" | type: DATABASE --
-- -- DROP DATABASE IF EXISTS "BBDDTienda";
-- CREATE DATABASE "BBDDTienda";
-- -- ddl-end --
-- 

-- object: public.tienda | type: TABLE --
-- DROP TABLE IF EXISTS public.tienda CASCADE;
CREATE TABLE public.tienda(
	id_tienda varchar(3) NOT NULL,
	ciudad text,
	barrio text,
	CONSTRAINT tienda_pk PRIMARY KEY (id_tienda)

);
-- ddl-end --
ALTER TABLE public.tienda OWNER TO postgres;
-- ddl-end --

-- object: public.socio | type: TABLE --
-- DROP TABLE IF EXISTS public.socio CASCADE;
CREATE TABLE public.socio(
	n_socio text NOT NULL,
	email text NOT NULL,
	saldo float NOT NULL,
	direccion text NOT NULL,
	telefono text NOT NULL,
	nombre text NOT NULL,
	CONSTRAINT socio_pk PRIMARY KEY (n_socio)

);
-- ddl-end --
ALTER TABLE public.socio OWNER TO postgres;
-- ddl-end --

-- object: public.opinion | type: TABLE --
-- DROP TABLE IF EXISTS public.opinion CASCADE;
CREATE TABLE public.opinion(
	n_socio_socio text NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	puntuacion float NOT NULL,
	comentario text NOT NULL,
	CONSTRAINT opinion_pk PRIMARY KEY (fecha,hora,n_socio_socio)

);
-- ddl-end --
ALTER TABLE public.opinion OWNER TO postgres;
-- ddl-end --

-- object: public.cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.cupon CASCADE;
CREATE TABLE public.cupon(
	id_cupon integer NOT NULL,
	codigo_producto integer NOT NULL,
	descuento float NOT NULL,
	CONSTRAINT cupon_pk PRIMARY KEY (id_cupon)

);
-- ddl-end --
ALTER TABLE public.cupon OWNER TO postgres;
-- ddl-end --

-- object: public.producto | type: TABLE --
-- DROP TABLE IF EXISTS public.producto CASCADE;
CREATE TABLE public.producto(
	codigo integer NOT NULL,
	p_sin_iva float NOT NULL,
	stock integer NOT NULL,
	CONSTRAINT producto_pk PRIMARY KEY (codigo)

);
-- ddl-end --
ALTER TABLE public.producto OWNER TO postgres;
-- ddl-end --

-- object: public.ticket | type: TABLE --
-- DROP TABLE IF EXISTS public.ticket CASCADE;
CREATE TABLE public.ticket(
	id_ticket integer NOT NULL,
	fecha date NOT NULL,
	hora time NOT NULL,
	precio float,
	nss_trabajador_cajero text NOT NULL,
	n_socio_socio text,
	CONSTRAINT ticket_pk PRIMARY KEY (id_ticket)

);
-- ddl-end --
ALTER TABLE public.ticket OWNER TO postgres;
-- ddl-end --

-- object: public.trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador CASCADE;
CREATE TABLE public.trabajador(
	nss text NOT NULL,
	nombre text NOT NULL,
	tlfno_fijo text NOT NULL,
	tlfno_movil text NOT NULL,
	nota_media float,
	id_tienda_tienda varchar(3) NOT NULL,
	CONSTRAINT trabajador_pk PRIMARY KEY (nss)

);
-- ddl-end --
ALTER TABLE public.trabajador OWNER TO postgres;
-- ddl-end --

-- object: public.reponedor | type: TABLE --
-- DROP TABLE IF EXISTS public.reponedor CASCADE;
CREATE TABLE public.reponedor(
	nss_trabajador text NOT NULL,
	n_horas float NOT NULL,
	CONSTRAINT reponedor_pk PRIMARY KEY (nss_trabajador)

);
-- ddl-end --
ALTER TABLE public.reponedor OWNER TO postgres;
-- ddl-end --

-- object: public.cajero | type: TABLE --
-- DROP TABLE IF EXISTS public.cajero CASCADE;
CREATE TABLE public.cajero(
	nss_trabajador text NOT NULL,
	CONSTRAINT cajero_pk PRIMARY KEY (nss_trabajador)

);
-- ddl-end --
ALTER TABLE public.cajero OWNER TO postgres;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.opinion DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.opinion ADD CONSTRAINT socio_fk FOREIGN KEY (n_socio_socio)
REFERENCES public.socio (n_socio) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: tienda_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador DROP CONSTRAINT IF EXISTS tienda_fk CASCADE;
ALTER TABLE public.trabajador ADD CONSTRAINT tienda_fk FOREIGN KEY (id_tienda_tienda)
REFERENCES public.tienda (id_tienda) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.reponedor DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.reponedor ADD CONSTRAINT trabajador_fk FOREIGN KEY (nss_trabajador)
REFERENCES public.trabajador (nss) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.cajero DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.cajero ADD CONSTRAINT trabajador_fk FOREIGN KEY (nss_trabajador)
REFERENCES public.trabajador (nss) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: cajero_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS cajero_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT cajero_fk FOREIGN KEY (nss_trabajador_cajero)
REFERENCES public.cajero (nss_trabajador) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.ticket DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.ticket ADD CONSTRAINT socio_fk FOREIGN KEY (n_socio_socio)
REFERENCES public.socio (n_socio) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.genera_cupon | type: TABLE --
-- DROP TABLE IF EXISTS public.genera_cupon CASCADE;
CREATE TABLE public.genera_cupon(
	n_socio_socio text NOT NULL,
	id_cupon_cupon integer NOT NULL,
	CONSTRAINT genera_cupon_pk PRIMARY KEY (n_socio_socio,id_cupon_cupon)

);
-- ddl-end --
ALTER TABLE public.genera_cupon OWNER TO postgres;
-- ddl-end --

-- object: socio_fk | type: CONSTRAINT --
-- ALTER TABLE public.genera_cupon DROP CONSTRAINT IF EXISTS socio_fk CASCADE;
ALTER TABLE public.genera_cupon ADD CONSTRAINT socio_fk FOREIGN KEY (n_socio_socio)
REFERENCES public.socio (n_socio) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: cupon_fk | type: CONSTRAINT --
-- ALTER TABLE public.genera_cupon DROP CONSTRAINT IF EXISTS cupon_fk CASCADE;
ALTER TABLE public.genera_cupon ADD CONSTRAINT cupon_fk FOREIGN KEY (id_cupon_cupon)
REFERENCES public.cupon (id_cupon) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.compra_producto | type: TABLE --
-- DROP TABLE IF EXISTS public.compra_producto CASCADE;
CREATE TABLE public.compra_producto(
	codigo_producto integer NOT NULL,
	id_ticket_ticket integer NOT NULL,
	cantidad integer,
	CONSTRAINT compra_producto_pk PRIMARY KEY (codigo_producto,id_ticket_ticket)

);
-- ddl-end --
ALTER TABLE public.compra_producto OWNER TO postgres;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.compra_producto DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.compra_producto ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.compra_producto DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.compra_producto ADD CONSTRAINT ticket_fk FOREIGN KEY (id_ticket_ticket)
REFERENCES public.ticket (id_ticket) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.devuelve_producto | type: TABLE --
-- DROP TABLE IF EXISTS public.devuelve_producto CASCADE;
CREATE TABLE public.devuelve_producto(
	codigo_producto integer NOT NULL,
	id_ticket_ticket integer NOT NULL,
	cantidad integer,
	CONSTRAINT devuelve_producto_pk PRIMARY KEY (codigo_producto,id_ticket_ticket)

);
-- ddl-end --
ALTER TABLE public.devuelve_producto OWNER TO postgres;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.devuelve_producto DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.devuelve_producto ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: ticket_fk | type: CONSTRAINT --
-- ALTER TABLE public.devuelve_producto DROP CONSTRAINT IF EXISTS ticket_fk CASCADE;
ALTER TABLE public.devuelve_producto ADD CONSTRAINT ticket_fk FOREIGN KEY (id_ticket_ticket)
REFERENCES public.ticket (id_ticket) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.cupon DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.cupon ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public.oferta | type: TABLE --
-- DROP TABLE IF EXISTS public.oferta CASCADE;
CREATE TABLE public.oferta(
	codigo_producto integer NOT NULL,
	f_ini date NOT NULL,
	f_fin date NOT NULL,
	descuento float,
	CONSTRAINT oferta_pk PRIMARY KEY (f_ini,f_fin,codigo_producto)

);
-- ddl-end --
ALTER TABLE public.oferta OWNER TO postgres;
-- ddl-end --

-- object: producto_fk | type: CONSTRAINT --
-- ALTER TABLE public.oferta DROP CONSTRAINT IF EXISTS producto_fk CASCADE;
ALTER TABLE public.oferta ADD CONSTRAINT producto_fk FOREIGN KEY (codigo_producto)
REFERENCES public.producto (codigo) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.trabajador_evalua_trabajador | type: TABLE --
-- DROP TABLE IF EXISTS public.trabajador_evalua_trabajador CASCADE;
CREATE TABLE public.trabajador_evalua_trabajador(
	nss_trabajador text NOT NULL,
	nss_trabajador1 text NOT NULL,
	nota float NOT NULL,
	CONSTRAINT trabajador_evalua_trabajador_pk PRIMARY KEY (nss_trabajador,nss_trabajador1)

);
-- ddl-end --

-- object: trabajador_fk | type: CONSTRAINT --
-- ALTER TABLE public.trabajador_evalua_trabajador DROP CONSTRAINT IF EXISTS trabajador_fk CASCADE;
ALTER TABLE public.trabajador_evalua_trabajador ADD CONSTRAINT trabajador_fk FOREIGN KEY (nss_trabajador)
REFERENCES public.trabajador (nss) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: trabajador_fk1 | type: CONSTRAINT --
-- ALTER TABLE public.trabajador_evalua_trabajador DROP CONSTRAINT IF EXISTS trabajador_fk1 CASCADE;
ALTER TABLE public.trabajador_evalua_trabajador ADD CONSTRAINT trabajador_fk1 FOREIGN KEY (nss_trabajador1)
REFERENCES public.trabajador (nss) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --