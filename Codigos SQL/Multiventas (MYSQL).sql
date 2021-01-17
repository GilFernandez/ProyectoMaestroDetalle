DROP database MultiVentas;
Create Database MultiVentas;
Use MultiVentas;

create table Empresa
(Cla_Empresa Int PRIMARY KEY not null,
Nombre_Empresa varchar(80) not null,
Dirección_Empresa varchar(50) not null,
RFC_Empresa varchar(20) not null,
Estatus_Empresa varchar(4));

create table Depto
(Cla_Empresa Int not null,
Id_Depto Int  not null,
Nombre_Depto varchar(20) not null,
Fecha_Creación Date not null,
Primary Key (Cla_Empresa,Id_Depto));

Create Table Puesto
(Cla_Empresa Int not null,
Id_Puesto int not null,
Nombre_Puesto varchar(20) not null,
Fecha_Creación Date not null,
Primary Key (Cla_Empresa,Id_Puesto));

CREATE TABLE Empleado
(Cla_Empresa Int not null,
Id_Empleado int not null,
Nombre varchar(30) not null ,
Ap_Paterno varchar(30)not null,
Ap_Materno varchar(30) not null,
Id_Depto int not null,
Id_Puesto int not null,
RFC varchar(20) UNIQUE not null,
Fecha_Nac date not null,
Estado_Civil varchar(10) not null,
Sueldo_Diario decimal(10,2)not null,
Fecha_Ingreso date not null,
Fecha_Baja date not null,
No_Seguro_Social varchar(20) not null,
CURP char(15) UNIQUE not null,
Primary Key (Cla_Empresa,Id_Empleado));

CREATE TABLE ClienteTipo
(Cla_Empresa Int not null,
Id_TipoCliente int not null,
Descp_TipoCliente varchar(30) not null,
Status_TipoCliente varchar(4),
Primary Key (Cla_Empresa,Id_TipoCliente));

CREATE TABLE Cliente
(Cla_Empresa Int not null,
Id_Cliente varchar(12) not null,
Nombre_ClienteSmall varchar(30) not null,
Nombre_ClienteLarge varchar(80) not null ,
RFC_Cliente char(14) UNIQUE not null,
Id_TipoCliente int not null,
Fecha_Alta date not null,
Direccion_Cliente varchar(80) not null ,
Status_Cliente varchar(4),
Primary Key (Cla_Empresa,Id_Cliente));

CREATE TABLE CondicionPago
(Cla_Empresa Int not null,
Id_CondPago Int not null,
Descp_CondPago varchar(50) not null,
Dias_CondPago int, 
Status_CondPago varchar(4),
Primary Key (Cla_Empresa,Id_CondPago));

CREATE TABLE TipoUnidad
(Cla_Empresa Int not null,
Id_TipoUnidad varchar(6) not null,
Descp_TipoUnidad varchar(50) not null,
Status_TipoUnidad varchar(4),
Primary Key (Cla_Empresa,Id_TipoUnidad));

CREATE TABLE Producto
(Cla_Empresa Int not null,
Id_Producto varchar(12) not null,
Descp_Producto varchar(50) not null,
Id_TipoUnidad varchar(6) not null,
Cantidad_Producto decimal (10,2) not null,
Precio_Producto decimal (10,2) not null,
Existencia_Producto decimal (10,2) not null,
Min_Producto decimal (10,2) not null,
Max_Producto decimal (10,2) not null,
Status_Producto varchar(4),
Primary Key (Cla_Empresa,Id_Producto));

CREATE TABLE OrdenVenta
(Cla_Empresa Int not null,
Id_OrdenVenta int not null,
Id_Cliente varchar(12) not null,
Id_CondPago Int not null,
Id_Empleado int not null,
Fecha_Creacion Date not null,
Status_OrdenVenta tinyint not null,
Primary Key (Cla_Empresa,Id_OrdenVenta));

CREATE TABLE DetalleOrdenVenta
(Cla_Empresa Int not null,
Id_OrdenVenta int not null,
Id_PartidaDetOV int not null,
Id_Producto varchar(12) not null,
Descp_Producto varchar(50) not null,
Id_TipoUnidad varchar(6) not null,
Cantidad_Producto decimal (10,2) not null,
Precio_Producto decimal (10,2) not null,
Iva_Producto decimal (10,2) not null,
Descuento_Producto decimal (10,2) not null,
Total_Producto decimal (10,2) not null,
Status_OrdenVenta tinyint not null,
Comentarios varchar(90),
PRIMARY KEY(Cla_Empresa,Id_OrdenVenta,Id_PartidaDetOV));

/*Definir Indices*/
CREATE INDEX IX_Depto ON Depto (Cla_Empresa,Id_Depto);
CREATE INDEX IX_Puesto ON Puesto (Cla_Empresa,Id_Puesto);
CREATE INDEX IX_Empleado ON Empleado (Cla_Empresa,Id_Empleado);
CREATE INDEX IX_ClienteTipo ON ClienteTipo (Cla_Empresa,Id_TipoCliente);
CREATE INDEX IX_Cliente ON Cliente (Cla_Empresa,Id_Cliente);
CREATE INDEX IX_CondicionPago ON CondicionPago(Cla_Empresa,Id_CondPago);
CREATE INDEX IX_TipoUnidad ON TipoUnidad (Cla_Empresa,Id_TipoUnidad);
CREATE INDEX IX_Producto ON Producto (Cla_Empresa,Id_Producto);
CREATE INDEX IX_OrdenVenta ON OrdenVenta (Cla_Empresa,Id_OrdenVenta);
CREATE INDEX IX_DetalleOrdenVenta ON DetalleOrdenVenta (Cla_Empresa,Id_OrdenVenta,Id_PartidaDetOV);

/* SQLINES DEMO *** iones*/ 
ALTER TABLE Cliente
ADD FOREIGN KEY (Cla_Empresa,Id_TipoCliente)REFERENCES ClienteTipo(Cla_Empresa,Id_TipoCliente);

ALTER TABLE Empleado
ADD FOREIGN KEY (Cla_Empresa,Id_Depto)REFERENCES Depto(Cla_Empresa,Id_Depto);
ALTER TABLE Empleado
ADD FOREIGN KEY (Cla_Empresa,Id_Puesto)REFERENCES Puesto(Cla_Empresa,Id_Puesto);
    
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_Cliente)REFERENCES Cliente(Cla_Empresa,Id_Cliente);
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_CondPago)REFERENCES CondicionPago(Cla_Empresa,Id_CondPago);
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_Empleado)REFERENCES Empleado(Cla_Empresa,Id_Empleado);
    
ALTER TABLE DetalleOrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_OrdenVenta) REFERENCES OrdenVenta(Cla_Empresa,Id_OrdenVenta);
ALTER TABLE DetalleOrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_Producto)REFERENCES Producto(Cla_Empresa,Id_Producto);
ALTER TABLE DetalleOrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_TipoUnidad)REFERENCES TipoUnidad(Cla_Empresa,Id_TipoUnidad);
    
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa)REFERENCES Empresa(Cla_Empresa);

Insert Into Empresa	Values (3, 'Walmart', 'Blvd. Francisco I Madero 227, Zona Centro, 25700 Monclova, Coah.', 'AME970109GW0', 'ACT');
Insert Into Empresa	Values (4, 'HEB', 'Blvd Harold R. Pape 1065, Jardines del Valle, 25730 Monclova, Coah.' ,'36 WCA100914BD2', 'ACT');

INSERT INTO Producto VALUES(03,1,'Escritorio',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(03,2,'Librero',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(03,3,'Archivero',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(03,4,'Laptop',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(03,5,'Silla Ejecutiva',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(03,6,'Cortador de papel',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,7,'Banco',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,8,'Gillotina',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,9,'Grapadora',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,10,'Mesa',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,11,'Tablet',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,12,'Sofa',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(04,13,'Sillon',1,500,200,1500,1,1000,1);

INSERT INTO DEPTO	VALUES (03,1,'	Recursos Humanos','	2020-09-09');
INSERT INTO DEPTO	VALUES (03,2,'	Informatica','	2020-09-09');
INSERT INTO DEPTO	VALUES (03,3,'	Compras','	2020-09-09');
INSERT INTO DEPTO	VALUES (03,4,'	Ventas','	2020-09-09');
INSERT INTO DEPTO	VALUES (03,5,'	Inventario','	2020-09-09');
INSERT INTO DEPTO	VALUES (04,6,'	Contabilidad','	2020-09-09');
INSERT INTO DEPTO	VALUES (04,7,'	Cuentas Por Pagar','	2020-09-09');
INSERT INTO DEPTO	VALUES (04,8,'	Cuentas Por Cobrar','	2020-09-09');
INSERT INTO DEPTO	VALUES (04,9,'	Produccion','	2020-09-09');

INSERT INTO ClienteTipo VALUES(03,1,'AlContado','Alta');
INSERT INTO ClienteTipo VALUES(03,2,'TarjetaDebito','Alta');
INSERT INTO ClienteTipo VALUES(03,3,'TarjetaCredito','Alta');
INSERT INTO ClienteTipo VALUES(03,4,'CreditoDeLaEmpresa','Alta');
INSERT INTO ClienteTipo VALUES(03,5,'MesesSinIntereses','Alta');

INSERT INTO ClienteTipo VALUES(04,1,'AlContado','Alta');
INSERT INTO ClienteTipo VALUES(04,2,'TarjetaDebito','Alta');
INSERT INTO ClienteTipo VALUES(04,3,'TarjetaCredito','Alta');
INSERT INTO ClienteTipo VALUES(04,4,'CreditoDeLaEmpresa','Alta');
INSERT INTO ClienteTipo VALUES(04,5,'MesesSinIntereses','Alta');

INSERT INTO Cliente VALUES (03,'1','Lara Tobias',		'Ivan',			'LATI9208245E5',2,'2020-12-09','Venustiano Carranza 120,Zona Centro, 25700 Monclova','1');
INSERT INTO Cliente VALUES (03,'2','Sanchez Gomez',	'Juan Ramon',	'SAGJ910520H55',4,'2020-12-09','Jalapa,Guadalupe,25750 Monclova','1');
INSERT INTO Cliente VALUES (03,'3','Lopez Suarez',		'Abigail',		'LOSA951207K34',1,'2020-12-09','Guadalupe,25750 Monclova','1');
INSERT INTO Cliente VALUES (03,'4','Hernandez Perez',	'Jose Maria',	'HEPJ0001091P3',2,'2020-12-09','Obrera Sur,25790 Monclova','1');
INSERT INTO Cliente VALUES (03,'5','Gonzalez Rodriguez','Francisco',	'GORF960527E57',2,'2020-12-09','Calle 8,Otilio Montaño,25796','1');
INSERT INTO Cliente VALUES (04,'6','Ramirez Flores',	'Alma Monserrat','RAFA9808305H5',3,'2020-12-09','Villa Florida 517-539,Praderas Casas Nuevas','1');
INSERT INTO Cliente VALUES (04,'7','Gomez Cruz',		'Juan Pablo',	'GOCJ870318L12',4,'2020-12-09','Rogelio Montemayor,25790','1');
INSERT INTO Cliente VALUES (04,'8','Lopez Martinez',	'Ramiro',		'LOMR851103R85',3,'2020-12-09','Adolfo Fisher 1222-1200,Obrera Sur 3ER. Sector,25790','1');
INSERT INTO Cliente VALUES (04,'9','Garcia Gonzalez',	'Susana ',		'GAGS980620K55',4,'2020-12-09','La Cañada 1427-1401,Colinas de Santiago','1');
INSERT INTO Cliente VALUES (04,'10','Perez Suarez',	'Raul Alejandro','PESR9911206R6',2,'2020-12-09','Francisco de Luna 696-727,10 de Mayo,25668','1');
INSERT INTO Cliente VALUES (04,'11','Jimenez Valdez',	'Victor Manuel','JIVV8705107A8',1,'2020-12-09','Internacional 14-6,Americana','1');

INSERT INTO PUESTO VALUES(03,1,'Gerente','2020-09-09');
INSERT INTO PUESTO VALUES(03,2,'Gerente Financiero','2020-09-09');
INSERT INTO PUESTO VALUES(03,3,'Jefe de RH','2020-09-09');
INSERT INTO PUESTO VALUES(03,4,'Director de Calidad','2020-09-09');
INSERT INTO PUESTO VALUES(03,5,'Director Tecnico','2020-09-09');
INSERT INTO PUESTO VALUES(03,6,'Jefe de Área ','2020-09-09');
INSERT INTO PUESTO VALUES(04,7,'Promotor de Ventas','2020-09-09');
INSERT INTO PUESTO VALUES(04,8,'Ing. Informatico','2020-09-09');
INSERT INTO PUESTO VALUES(04,9,'Operador','2020-09-09');
INSERT INTO PUESTO VALUES(04,10,'Recepcionista','2020-09-09');
INSERT INTO PUESTO VALUES(04,11,'Tecnico de reparacion','2020-09-09');
INSERT INTO PUESTO VALUES(04,12,'Encargado de bodega','2020-09-09');
INSERT INTO PUESTO VALUES(04,13,'Contador','2020-09-09');

Insert into Empleado VALUES(03,1,'Esteban','Guajardo','Lopez',4,1,'GULE8003121MC','1980-12-03','Casado',500.00,'2020-10-09','2020-12-09','32988080031','GULE8003121MC03');
Insert into Empleado VALUES(03,3,'Miguel','Rodriguez','Martinez',2,5,'ROMM8504152PR','1985-12-04','Casado',400.00,'2020-10-09','2020-12-09','32988585032','ROMM8504152ML04');
Insert into Empleado VALUES(03,4,'Arturo','Diaz','Meraz',2,5,'DIMA8910251Z1','1989-02-10','Casado',400.00,'2020-10-09','2020-12-09','32928986033','DIMA8910251MC05');
Insert into Empleado VALUES(03,5,'Maria','Amaya','Gutierrez',3,6,'AMGM900505MC','1990-05-05','Soltero',300.00,'2020-10-09','2020-12-09','32929090032','AMGM900505MC03');
Insert into Empleado VALUES(03,6,'Luis','Sepulveda','Perez',4,6,'SEPL8603128MC','1986-12-03','Casado',300.00,'2020-10-09','2020-12-09','32128686161','SEPL860312MCN1');
Insert into Empleado VALUES(03,7,'Carlos','Cortez','Rios',2,5,'CORC8511046MC','1985-04-11','Soltero',400.00,'2020-10-09','2020-12-09','32118585041','CORC8511046MC');
Insert into Empleado VALUES(03,8,'Anahi','Miranda','Espinoza',1,1,'MREA8903127MC','1989-06-06','Soltero',500.00,'2020-10-09','2020-12-09','32108989131','MREA8903127MCR1');
Insert into Empleado VALUES(03,9,'Laura','Perez	','Montiel',4,2,'PEML910415MC','1991-10-22','Soltero',400.00,'2020-10-09','2020-12-09','32129191011','PEML910415MC33');
Insert into Empleado VALUES(04,10,'Martin','Ramos','Galindo',9,7,'RAGM8201058MC','1981-05-01','Casado',500.00,'2020-10-09','2020-12-09','32328282112','RAGM8201058MC');
Insert into Empleado VALUES(04,11,'Myrna','Tovar','Casas',6,13,'TOCM9203319TY','1992-03-31','Casado',200.00,'2020-10-09','2020-12-09','32259292131','TOCM9203319MC1');
Insert into Empleado VALUES(04,12,'Martha','Peña','Alvarado',7,10,'PEAM9710106RI','1997-10-10','Casado',200.00,'2020-10-09','2020-12-09','32219797568','PEAM9710106MC80');
Insert into Empleado VALUES(04,13,'Roberto','Garcia','Martinez',7,12,'GAMR9612124MC','1996-12-12','Casado',500.00,'2020-10-09','2020-12-09','31189696125','GAMR9612124MC');
Insert into Empleado VALUES(04,14,'Pamela','Estrada','Mijares',6,13,'ESMP8810097MC','1988-09-10','Casado',300.00,'2020-10-09','2020-12-09','32158888912','ESMP8810097MC2');
Insert into Empleado VALUES(04,15,'Carmen','Gonzalez','Castañeda',9,9,'GOCC7915200WQ','1979-05-20','Divorciado',150.00,'2020-10-09','2020-12-09','32117979891','GOCC7915200MC12');
Insert into Empleado VALUES(04,16,'Roman','Ramirez','Quintana',8,10,'RAQR7702201MP','1977-02-20','Casado',200.00,'2020-10-09','2020-12-09','32107777928','RAQR7702201MC33');
Insert into Empleado VALUES(04,17,'Lourdes','Guerra','Garza',7,10,'GEGL9511083M1','1995-08-11','Soltero',200.00,'2020-10-09','2020-12-09','32099595235','GEGL9511083RT1');

Insert into CondicionPago VALUES(03,1,'Contador',0,'Alta');
Insert into CondicionPago VALUES(03,2,'Semanal',8,'Alta');
Insert into CondicionPago VALUES(03,3,'Quincenal',15,'Alta');
Insert into CondicionPago VALUES(03,4,'Mensual',30,'Alta');
Insert into CondicionPago VALUES(03,5,'Bimestral',60,'Alta');
Insert into CondicionPago VALUES(03,6,'Trimestral',90,'Alta');
Insert into CondicionPago VALUES(03,7,'Anual',360,'Alta');

Insert into CondicionPago VALUES(04,1,'Contador',0,'Alta');
Insert into CondicionPago VALUES(04,2,'Semanal',8,'Alta');
Insert into CondicionPago VALUES(04,3,'Quincenal',15,'Alta');
Insert into CondicionPago VALUES(04,4,'Mensual',30,'Alta');
Insert into CondicionPago VALUES(04,5,'Bimestral',60,'Alta');
Insert into CondicionPago VALUES(04,6,'Trimestral',90,'Alta');
Insert into CondicionPago VALUES(04,7,'Anual',360,'Alta');

Insert into TipoUnidad VALUES(03,1,'Pieza','Alta');
Insert into TipoUnidad VALUES(03,2,'Paquete','Alta');
Insert into TipoUnidad VALUES(03,3,'Caja','Alta');
Insert into TipoUnidad VALUES(03,4,'Kilogramo','Alta');
Insert into TipoUnidad VALUES(03,5,'Litro','Alta');
Insert into TipoUnidad VALUES(03,6,'Libra','Alta');
Insert into TipoUnidad VALUES(03,7,'Bolsa','Alta');
Insert into TipoUnidad VALUES(03,8,'Bulto','Alta');

Insert into TipoUnidad VALUES(04,1,'Pieza','Alta');
Insert into TipoUnidad VALUES(04,2,'Paquete','Alta');
Insert into TipoUnidad VALUES(04,3,'Caja','Alta');
Insert into TipoUnidad VALUES(04,4,'Kilogramo','Alta');
Insert into TipoUnidad VALUES(04,5,'Litro','Alta');
Insert into TipoUnidad VALUES(04,6,'Libra','Alta');
Insert into TipoUnidad VALUES(04,7,'Bolsa','Alta');
Insert into TipoUnidad VALUES(04,8,'Bulto','Alta');

select*from Empresa; /*ya*/
select*from Depto; /*ya*/
select*from Empleado; /*ya*/
select*from Puesto; /*ya*/
select*from ClienteTipo; /*ya*/
select*from Cliente; /*ya*/
select*from CondicionPago; /*ya*/
select*from TipoUnidad; /*ya*/
select*from Producto; /*ya*/