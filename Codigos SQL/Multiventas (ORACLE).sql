create table Empresa
(Cla_Empresa Int PRIMARY KEY not null,
Nombre_Empresa varchar(80) not null,
Dirección_Empresa varchar(100) not null,
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
Status_OrdenVenta smallint not null,
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
Status_OrdenVenta smallint not null,
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

Insert Into Empresa	Values (5, 'FAMSA', 'V Carranza 607, Zona Centro, 25700 Monclova, Coah', 'Gfa971015267', 'ACT');
Insert Into Empresa	Values (6, 'Coppel', 'Huemac #1301, Anáhuac, 25750 Monclova, Coah' ,'COP920428Q20', 'ACT');

INSERT INTO Producto VALUES(5,1,'Escritorio',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(5,2,'Librero',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(5,3,'Archivero',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(5,4,'Laptop',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(5,5,'Silla Ejecutiva',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(5,6,'Cortador de papel',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,7,'Banco',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,8,'Gillotina',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,9,'Grapadora',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,10,'Mesa',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,11,'Tablet',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,12,'Sofa',1,500,200,1500,1,1000,1);
INSERT INTO Producto VALUES(6,13,'Sillon',1,500,200,1500,1,1000,1);

INSERT INTO DEPTO	VALUES (5,1,'Recursos Humanos','09/09/2020');
INSERT INTO DEPTO	VALUES (5,2,'Informatica','09/09/2020');
INSERT INTO DEPTO	VALUES (5,3,'Compras','09/09/2020');
INSERT INTO DEPTO	VALUES (5,4,'Ventas','09/09/2020');
INSERT INTO DEPTO	VALUES (5,5,'Inventario','09/09/2020');
INSERT INTO DEPTO	VALUES (6,6,'Contabilidad','09/09/2020');
INSERT INTO DEPTO	VALUES (6,7,'Cuentas Por Pagar','09/09/2020');
INSERT INTO DEPTO	VALUES (6,8,'Cuentas Por Cobrar','09/09/2020');
INSERT INTO DEPTO	VALUES (6,9,'Produccion','09/09/2020');

INSERT INTO ClienteTipo VALUES(5,1,'AlContado','Alta');
INSERT INTO ClienteTipo VALUES(5,2,'TarjetaDebito','Alta');
INSERT INTO ClienteTipo VALUES(5,3,'TarjetaCredito','Alta');
INSERT INTO ClienteTipo VALUES(5,4,'CreditoDeLaEmpresa','Alta');
INSERT INTO ClienteTipo VALUES(5,5,'MesesSinIntereses','Alta');

INSERT INTO ClienteTipo VALUES(6,1,'AlContado','Alta');
INSERT INTO ClienteTipo VALUES(6,2,'TarjetaDebito','Alta');
INSERT INTO ClienteTipo VALUES(6,3,'TarjetaCredito','Alta');
INSERT INTO ClienteTipo VALUES(6,4,'CreditoDeLaEmpresa','Alta');
INSERT INTO ClienteTipo VALUES(6,5,'MesesSinIntereses','Alta');

INSERT INTO Cliente VALUES (5,'1','Lara Tobias','Ivan','LATI9208245E5',2,'09/09/2020','Venustiano Carranza 120,Zona Centro, 25700 Monclova','1');
INSERT INTO Cliente VALUES (5,'2','Sanchez Gomez','Juan Ramon','SAGJ910520H55',4,'09/09/2020','Jalapa,Guadalupe,25750 Monclova','1');
INSERT INTO Cliente VALUES (5,'3','Lopez Suarez','Abigail','LOSA951207K34',1,'09/09/2020','Guadalupe,25750 Monclova','1');
INSERT INTO Cliente VALUES (5,'4','Hernandez Perez','Jose Maria','HEPJ0001091P3',2,'09/09/2020','Obrera Sur,25790 Monclova','1');
INSERT INTO Cliente VALUES (5,'5','Gonzalez Rodriguez','Francisco','GORF960527E57',2,'09/09/2020','Calle 8,Otilio Montano,25796','1');
INSERT INTO Cliente VALUES (6,'6','Ramirez Flores','Alma Monserrat','RAFA9808305H5',3,'09/09/2020','Villa Florida 517-539,Praderas Casas Nuevas','1');
INSERT INTO Cliente VALUES (6,'7','Gomez Cruz','Juan Pablo','GOCJ870318L12',4,'09/09/2020','Rogelio Montemayor,25790','1');
INSERT INTO Cliente VALUES (6,'8','Lopez Martinez','Ramiro','LOMR851103R85',3,'09/09/2020','Adolfo Fisher 1222-1200,Obrera Sur 3ER. Sector,25790','1');
INSERT INTO Cliente VALUES (6,'9','Garcia Gonzalez','Susana','GAGS980620K55',4,'09/09/2020','La Canada 1427-1401,Colinas de Santiago','1');
INSERT INTO Cliente VALUES (6,'10','Perez Suarez','Raul Alejandro','PESR9911206R6',2,'09/09/2020','Francisco de Luna 696-727,10 de Mayo,25668','1');
INSERT INTO Cliente VALUES (6,'11','Jimenez Valdez','Victor Manuel','JIVV8705107A8',1,'09/09/2020','Internacional 14-6,Americana','1');

INSERT INTO PUESTO VALUES(5,1,'Gerente','09/09/2020');
INSERT INTO PUESTO VALUES(5,2,'Gerente Financiero','09/09/2020');
INSERT INTO PUESTO VALUES(5,3,'Jefe de RH','09/09/2020');
INSERT INTO PUESTO VALUES(5,4,'Director de Calidad','09/09/2020');
INSERT INTO PUESTO VALUES(5,5,'Director Tecnico','09/09/2020');
INSERT INTO PUESTO VALUES(5,6,'Jefe de Area ','09/09/2020');
INSERT INTO PUESTO VALUES(6,7,'Promotor de Ventas','09/09/2020');
INSERT INTO PUESTO VALUES(6,8,'Ing. Informatico','09/09/2020');
INSERT INTO PUESTO VALUES(6,9,'Operador','09/09/2020');
INSERT INTO PUESTO VALUES(6,10,'Recepcionista','09/09/2020');
INSERT INTO PUESTO VALUES(6,11,'Tecnico de reparacion','09/09/2020');
INSERT INTO PUESTO VALUES(6,12,'Encargado de bodega','09/09/2020');
INSERT INTO PUESTO VALUES(6,13,'Contador','09/09/2020');

Insert into Empleado VALUES(5,1,'Esteban','Guajardo','Lopez',4,1,'GULE8003121MC','12/03/1980','Casado',500.00,'10/09/2020','09/12/2020','32988080011','GULE8003121MC03');
Insert into Empleado VALUES(5,3,'Miguel','Rodriguez','Martinez',2,5,'ROMM8504152PR','12/08/1986','Casado',400.00,'10/09/2020','09/12/2020','32988585012','ROMM8504152ML04');
Insert into Empleado VALUES(5,4,'Arturo','Diaz','Meraz',2,5,'DIMA8910251Z1','22/01/1979','Casado',400.00,'10/09/2020','09/12/2020','32928986013','DIMA8910251MC05');
Insert into Empleado VALUES(5,5,'Maria','Amaya','Gutierrez',3,6,'AMGM900505MC','12/10/1988','Soltero',300.00,'10/09/2020','09/12/2020','32929090012','AMGM900505MC01');
Insert into Empleado VALUES(5,6,'Luis','Sepulveda','Perez',4,6,'SEPL8603128MC','31/03/1998','Casado',300.00,'10/09/2020','09/12/2020','32128686161','SEPL860312MCN1');
Insert into Empleado VALUES(5,7,'Carlos','Cortez','Rios',2,5,'CORC8511046MC','19/10/1976','Soltero',400.00,'10/09/2020','09/12/2020','32118585041','CORC8511046MC');
Insert into Empleado VALUES(5,8,'Anahi','Miranda','Espinoza',1,1,'MREA8903127MC','05/10/1987','Soltero',500.00,'10/09/2020','09/12/2020','32108989131','MREA8903127MCR1');
Insert into Empleado VALUES(5,9,'Laura','Perez	','Montiel',4,2,'PEML910415MC','24/08/1994','Soltero',400.00,'10/09/2020','09/12/2020','32129191011','PEML910415MC33');
Insert into Empleado VALUES(6,10,'Martin','Ramos','Galindo',9,7,'RAGM8201058MC','07/03/1977','Casado',500.00,'10/09/2020','09/12/2020','32328282112','RAGM8201058MC');
Insert into Empleado VALUES(6,11,'Myrna','Tovar','Casas',6,13,'TOCM9203319TY','12/12/1980','Casado',200.00,'10/09/2020','09/12/2020','32259292131','TOCM9203319MC1');
Insert into Empleado VALUES(6,12,'Martha','Pe�a','Alvarado',7,10,'PEAM9710106RI','10/02/1985','Casado',200.00,'10/09/2020','09/12/2020','32219797568','PEAM9710106MC80');
Insert into Empleado VALUES(6,13,'Roberto','Garcia','Martinez',7,12,'GAMR9612124MC','14/09/1980','Casado',500.00,'10/09/2020','09/12/2020','31189696125','GAMR9612124MC');
Insert into Empleado VALUES(6,14,'Pamela','Estrada','Mijares',6,13,'ESMP8810097MC','02/04/1985','Casado',300.00,'10/09/2020','09/12/2020','32158888912','ESMP8810097MC2');
Insert into Empleado VALUES(6,15,'Carmen','Gonzalez','Casta�eda',9,9,'GOCC7915200WQ','16/07/1986','Divorciado',150.00,'10/09/2020','09/12/2020','32117979891','GOCC7915200MC12');
Insert into Empleado VALUES(6,16,'Roman','Ramirez','Quintana',8,10,'RAQR7702201MP','13/03/1982','Casado',200.00,'10/09/2020','09/12/2020','32107777928','RAQR7702201MC33');
Insert into Empleado VALUES(6,17,'Lourdes','Guerra','Garza',7,10,'GEGL9511083M1','01/001/1978','Soltero',200.00,'10/09/2020','09/12/2020','32099595235','GEGL9511083RT1');

Insert into CondicionPago VALUES(5,1,'Contador',0,'Alta');
Insert into CondicionPago VALUES(5,2,'Semanal',8,'Alta');
Insert into CondicionPago VALUES(5,3,'Quincenal',15,'Alta');
Insert into CondicionPago VALUES(5,4,'Mensual',30,'Alta');
Insert into CondicionPago VALUES(5,5,'Bimestral',60,'Alta');
Insert into CondicionPago VALUES(5,6,'Trimestral',90,'Alta');
Insert into CondicionPago VALUES(5,7,'Anual',360,'Alta');

Insert into CondicionPago VALUES(6,1,'Contador',0,'Alta');
Insert into CondicionPago VALUES(6,2,'Semanal',8,'Alta');
Insert into CondicionPago VALUES(6,3,'Quincenal',15,'Alta');
Insert into CondicionPago VALUES(6,4,'Mensual',30,'Alta');
Insert into CondicionPago VALUES(6,5,'Bimestral',60,'Alta');
Insert into CondicionPago VALUES(6,6,'Trimestral',90,'Alta');
Insert into CondicionPago VALUES(6,7,'Anual',360,'Alta');

Insert into TipoUnidad VALUES(5,1,'Pieza','Alta');
Insert into TipoUnidad VALUES(5,2,'Paquete','Alta');
Insert into TipoUnidad VALUES(5,3,'Caja','Alta');
Insert into TipoUnidad VALUES(5,4,'Kilogramo','Alta');
Insert into TipoUnidad VALUES(5,5,'Litro','Alta');
Insert into TipoUnidad VALUES(5,6,'Libra','Alta');
Insert into TipoUnidad VALUES(5,7,'Bolsa','Alta');
Insert into TipoUnidad VALUES(5,8,'Bulto','Alta');

Insert into TipoUnidad VALUES(6,1,'Pieza','Alta');
Insert into TipoUnidad VALUES(6,2,'Paquete','Alta');
Insert into TipoUnidad VALUES(6,3,'Caja','Alta');
Insert into TipoUnidad VALUES(6,4,'Kilogramo','Alta');
Insert into TipoUnidad VALUES(6,5,'Litro','Alta');
Insert into TipoUnidad VALUES(6,6,'Libra','Alta');
Insert into TipoUnidad VALUES(6,7,'Bolsa','Alta');
Insert into TipoUnidad VALUES(6,8,'Bulto','Alta');

-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Empresa; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Depto; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Empleado; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Puesto; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from ClienteTipo; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Cliente; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from CondicionPago; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from TipoUnidad; /*ya*/
-- SQLINES LICENSE FOR EVALUATION USE ONLY
select*from Producto; /*ya*/