--Creación de usuarios --

CREATE USER alvaro WITH PASSWORD 'alvaro'; -- Administrador

CREATE USER cristobal WITH PASSWORD 'cristobal'; -- Gestor

CREATE USER abigail WITH PASSWORD 'abigail'; -- Cajero

CREATE USER ana WITH PASSWORD 'ana'; -- Reponedora

CREATE USER lucia WITH PASSWORD 'lucia'; -- Socia

--Creación de grupos --

CREATE GROUP administradores WITH user alvaro;

CREATE GROUP gestores WITH user cristobal;

CREATE GROUP cajeros WITH user abigail;

CREATE GROUP reponedores WITH user ana;

CREATE GROUP socios WITH user lucia;

-- Asignación de privilegios --

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO administradores;

-- REVOKE CREATE ON SCHEMA public FROM gestores

GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO gestores;

GRANT SELECT, INSERT, UPDATE ON ticket, compra_producto, devuelve_producto TO cajeros;

GRANT SELECT, UPDATE(comentario) ON opinion TO socios;

GRANT SELECT(codigo_producto, descuento) ON cupon TO socios;

GRANT SELECT, UPDATE(stock) ON producto TO reponedores;