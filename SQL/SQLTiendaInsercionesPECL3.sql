-- Inserciones correspondientes a la PECL3 teniendo en cuenta los nuevos cambios --

-- TIENDA --

insert into tienda values ('001', 'Madrid', 'Salamanca'),  
('002' ,'Alcala de Henares', 'Chorrillo');

-- TRABAJADOR --

insert into trabajador values ('11111111111', 'Carlos', '918888777', '645893067', null, '001'),
('22222222222', 'Ana', '918777333', '678346123', null, '001'),
('33333333333', 'Abigail', '913222111', '632678321', null, '001'),
('44444444444', 'Segismundo', '921834222', '643912398', null, '002'),
('55555555555', 'Daniel', '918328213', '645893456', null, '002'),
('66666666666', 'Maria', '921345219', '621123489', null, '002');
-- REPONEDOR --

insert into reponedor values ('11111111111', 20.0),
('22222222222', 25.0),
('44444444444', 30.0),
('55555555555', 30.0);

-- CAJERO --

insert into cajero values ('33333333333'), ('66666666666');

-- SOCIO --

insert into socio values ('001', 'a@hotmail.com', 500.5, 'C/ San Petersburgo', '666555333', 'Lucrecio'),
('002', 'b@hotmail.com', 600.0, 'C/ Alcarria', '655633644', 'Lucia'),
('003', 'c@hotmail.com', 1000.0, 'C/ Talamanca', '666555222', 'Filberto'),
('004', 'd@hotmail.com', 750.0, 'C/ Santorcaz', '666551112', 'Ricardo'),
('005', 'e@hotmail.com', 150.5, 'C/ Poligono', '666551211', 'Montse');

-- OPINION --

-- Insertamos la opinion de los socios, primero 3 y luego 1 para comprobar los triggers y la consistencia de los datos --
insert into opinion values ('003', NULL, NULL, 3.5, 'No ha estado mal, podría mejorar mucho mas el servicio >:('),
('005', NULL, NULL, 4.5, 'Buen servicio y buenos productos'),
('001', NULL, NULL, 2.5, 'Aceptable');
--insert into opinion values ('005', NULL, NULL, 4.7, 'Progresan adecuadamente'); Se hace después sino salta error--

-- PRODUCTO --
insert into producto values (1000, 10.0, 10000),
(1001, 20.0, 5000),
(1002, 15.0, 20000),
(1003, 5.0, 30000),
(1004, 50.0, 500), 
(1005, 100.0, 500),
(1006, 200.0, 100);

-- CUPON --
insert into cupon values (101, 1000, 0.2), 
(102, 1000, 0.15), 
(103, 1002, 0.1), 
(104, 1004, 0.5), 
(105, 1006, 0.25);

-- GENERA_CUPON --

insert into genera_cupon values ('001', 101), 
('002', 102), 
('003', 103), 
('001', 104), 
('001', 105);

-- OFERTA --
insert into oferta values(1002, '2003-02-01', '2003-02-07', 0.2),
(1001, '2003-02-08', '2003-02-14', 0.15),
(1004, '2003-02-15', '2003-02-21', 0.3),
(1006, '2019-05-01', '2019-05-06', 0.5);

-- TICKET --

insert into ticket values (1, '2003-02-10', '12:11:31', null, '33333333333', null), 
(2, '2003-04-21', '14:17:11', null, '33333333333', null),
(3, '2019-07-20', '19:31:12', null, '66666666666', '001'); -- Aqui se registra un socio, por lo que hay que ver si tiene cupon y si lo tiene aplicarlo

-- COMPRA_PRODUCTO --

insert into compra_producto values (1001, 1, 2), -- Tiene oferta --
(1003, 1, 2),
(1005, 1, 1),
(1000, 1, 10),
(1004, 2, 1), 
(1005, 2, 1),
(1006, 2, 50),
(1000, 3, 150); -- Le afecta un cupon -- 

-- DEVUELVE_PRODUCTO --

insert into devuelve_producto values (1006, 2, 20);
insert into devuelve_producto values (1000, 3, 50);
insert into devuelve_producto values (1000, 1, 5);

-- TRABAJADOR_EVALUA_TRABAJADOR --

-- Evaluacion trabajadores tienda con id 002 --
insert into trabajador_evalua_trabajador values ('55555555555', '44444444444', 8);
insert into trabajador_evalua_trabajador values ('66666666666', '44444444444', 2);
insert into trabajador_evalua_trabajador values ('44444444444', '55555555555', 5);
insert into trabajador_evalua_trabajador values ('66666666666', '55555555555', 7);
insert into trabajador_evalua_trabajador values ('44444444444', '66666666666', 3);
insert into trabajador_evalua_trabajador values ('55555555555', '66666666666', 9);

-- Evaluacion trabajadores tienda con id 002 --
insert into trabajador_evalua_trabajador values ('22222222222', '11111111111', 7);
insert into trabajador_evalua_trabajador values ('33333333333', '11111111111', 9);
insert into trabajador_evalua_trabajador values ('11111111111', '22222222222', 4);
insert into trabajador_evalua_trabajador values ('33333333333', '22222222222', 10);
insert into trabajador_evalua_trabajador values ('11111111111', '33333333333', 5);
insert into trabajador_evalua_trabajador values ('22222222222', '33333333333', 7);