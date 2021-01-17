IF NOT EXISTS (SELECT * FROM Sysdatabases WHERE (name = 'MultiVentas'))
	BEGIN
		CREATE DATABASE MultiVentas
	END
go
USE MultiVentas
go
/*Crear tabla definiendo su llave primaria,
definiendo su columna UNIQUE, CHECK*/

/*Creaci�n de Tabla Compania*/ 
create table Empresa
(Cla_Empresa Int PRIMARY KEY not null,
Nombre_Empresa varchar(80) not null,
Direccion_Empresa varchar(100) not null,
RFC_Empresa varchar(20) not null,
Estatus_Empresa varchar(4))
go
/*Creaci�n de Tabla Departamento*/ 
create table Depto
(Cla_Empresa Int not null,
Id_Depto Int  not null,
Nombre_Depto varchar(20) not null,
Fecha_Creacion Date not null,
Primary Key (Cla_Empresa,Id_Depto))
go
/*Creaci�n de Tabla Empleado*/
Create Table Puesto
(Cla_Empresa Int not null,
Id_Puesto int not null,
Nombre_Puesto varchar(20) not null,
Fecha_Creacion Date not null,
Primary Key (Cla_Empresa,Id_Puesto))
go
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
Estado_Civil varchar(10) CHECK(Estado_Civil IN('SOLTERO','CASADO','VIUDO','DIVORCIADO'))  not null,
Sueldo_Diario decimal(10,2)not null,
Fecha_Ingreso date not null,
Fecha_Baja date not null,
No_Seguro_Social varchar(20) not null,
CURP char(15) UNIQUE not null,
Primary Key (Cla_Empresa,Id_Empleado))
go
CREATE TABLE ClienteTipo
(Cla_Empresa Int not null,
Id_TipoCliente int not null,
Descp_TipoCliente varchar(30) not null,
Status_TipoCliente varchar(4),
Primary Key (Cla_Empresa,Id_TipoCliente))
go
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
Primary Key (Cla_Empresa,Id_Cliente))
go
CREATE TABLE CondicionPago
(Cla_Empresa Int not null,
Id_CondPago Int not null,
Descp_CondPago varchar(50) not null,
Dias_CondPago int, 
Status_CondPago varchar(4),
Primary Key (Cla_Empresa,Id_CondPago))
go
CREATE TABLE TipoUnidad
(Cla_Empresa Int not null,
Id_TipoUnidad varchar(6) not null,
Descp_TipoUnidad varchar(50) not null,
Status_TipoUnidad varchar(4),
Primary Key (Cla_Empresa,Id_TipoUnidad))
go
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
Primary Key (Cla_Empresa,Id_Producto))
go
CREATE TABLE OrdenVenta
(Cla_Empresa Int not null,
Id_OrdenVenta int not null identity(1,1),
Id_Cliente varchar(12) not null,
Id_CondPago Int not null,
Id_Empleado int not null,
Fecha_Creacion Date not null,
Status_OrdenVenta bit not null,
Primary Key (Cla_Empresa,Id_OrdenVenta))
go
CREATE TABLE DetalleOrdenVenta
(Cla_Empresa Int not null,
Id_OrdenVenta int not null,
Id_PartidaDetOV int not null identity(1,1),
Id_Producto varchar(12) not null,
Descp_Producto varchar(50) not null,
Id_TipoUnidad varchar(6) not null,
Cantidad_Producto decimal (10,2) not null,
Precio_Producto decimal (10,2) not null,
Iva_Producto decimal (10,2) not null,
Descuento_Producto decimal (10,2) not null,
Total_Producto decimal (10,2) not null,
Status_OrdenVenta bit not null,
Comentarios varchar(90),
PRIMARY KEY(Cla_Empresa,Id_OrdenVenta,Id_PartidaDetOV))
go
/*Definir Indices*/
CREATE INDEX IX_Depto ON Depto (Cla_Empresa,Id_Depto)
CREATE INDEX IX_Puesto ON Puesto (Cla_Empresa,Id_Puesto)
CREATE INDEX IX_Empleado ON Empleado (Cla_Empresa,Id_Empleado)
CREATE INDEX IX_ClienteTipo ON ClienteTipo (Cla_Empresa,Id_TipoCliente)
CREATE INDEX IX_Cliente ON Cliente (Cla_Empresa,Id_Cliente)
CREATE INDEX IX_CondicionPago ON CondicionPago(Cla_Empresa,Id_CondPago)
CREATE INDEX IX_TipoUnidad ON TipoUnidad (Cla_Empresa,Id_TipoUnidad)
CREATE INDEX IX_Producto ON Producto (Cla_Empresa,Id_Producto)
CREATE INDEX IX_OrdenVenta ON OrdenVenta (Cla_Empresa,Id_OrdenVenta)
CREATE INDEX IX_DetalleOrdenVenta ON DetalleOrdenVenta (Cla_Empresa,Id_OrdenVenta,Id_PartidaDetOV)

/*Creaci�n de Relaciones*/ 
ALTER TABLE Cliente
ADD FOREIGN KEY (Cla_Empresa,Id_TipoCliente)REFERENCES ClienteTipo(Cla_Empresa,Id_TipoCliente)
ALTER TABLE Empleado
ADD FOREIGN KEY (Cla_Empresa,Id_Depto)REFERENCES Depto(Cla_Empresa,Id_Depto),
	FOREIGN KEY (Cla_Empresa,Id_Puesto)REFERENCES Puesto(Cla_Empresa,Id_Puesto)
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_Cliente)REFERENCES Cliente(Cla_Empresa,Id_Cliente),
	FOREIGN KEY (Cla_Empresa,Id_CondPago)REFERENCES CondicionPago(Cla_Empresa,Id_CondPago),
    FOREIGN KEY (Cla_Empresa,Id_Empleado)REFERENCES Empleado(Cla_Empresa,Id_Empleado)
ALTER TABLE DetalleOrdenVenta
ADD FOREIGN KEY (Cla_Empresa,Id_OrdenVenta) REFERENCES OrdenVenta(Cla_Empresa,Id_OrdenVenta),
	FOREIGN KEY (Cla_Empresa,Id_Producto)REFERENCES Producto(Cla_Empresa,Id_Producto),
	FOREIGN KEY (Cla_Empresa,Id_TipoUnidad)REFERENCES TipoUnidad(Cla_Empresa,Id_TipoUnidad)
ALTER TABLE OrdenVenta
ADD FOREIGN KEY (Cla_Empresa)REFERENCES Empresa(Cla_Empresa)
go

/*Empresa*/
Insert Into Empresa	Values (1, 'The Home Depot', 'Entre Kennedy y Santana, Blvd Harold R. Pape s/n, Del Prado, 25718 Monclova, Coah.', 'HDM001017AS1', 'ACT')
Insert Into Empresa	Values (2, 'Elektra', 'Miguel blanco Pte. 202, Centro, 25700 Monclova' ,'GEL9112136Z2', 'ACT')

/*Producto*/
INSERT INTO Producto VALUES(01,1,'Escritorio',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(01,2,'Librero',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(01,3,'Archivero',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(01,4,'Laptop',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(01,5,'Silla Ejecutiva',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(01,6,'Cortador de papel',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,7,'Banco',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,8,'Gillotina',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,9,'Grapadora',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,10,'Mesa',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,11,'Tablet',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,12,'Sofa',1,500,200,1500,1,1000,1)
INSERT INTO Producto VALUES(02,13,'Sillon',1,500,200,1500,1,1000,1)

/*Departamento*/
INSERT INTO DEPTO	VALUES (01,1,'	Recursos Humanos','	09/09/2020')
INSERT INTO DEPTO	VALUES (01,2,'	Informatica','	09/09/2020')
INSERT INTO DEPTO	VALUES (01,3,'	Compras','	09/09/2020')
INSERT INTO DEPTO	VALUES (01,4,'	Ventas','	09/09/2020')
INSERT INTO DEPTO	VALUES (01,5,'	Inventario','	09/09/2020')
INSERT INTO DEPTO	VALUES (02,6,'	Contabilidad','	09/09/2020')
INSERT INTO DEPTO	VALUES (02,7,'	Cuentas Por Pagar','	09/09/2020')
INSERT INTO DEPTO	VALUES (02,8,'	Cuentas Por Cobrar','	09/09/2020')
INSERT INTO DEPTO	VALUES (02,9,'	Produccion','	09/09/2020')

/*ClienteTipo*/
INSERT INTO ClienteTipo VALUES(01,1,'AlContado','Alta')
INSERT INTO ClienteTipo VALUES(01,2,'TarjetaDebito','Alta')
INSERT INTO ClienteTipo VALUES(01,3,'TarjetaCredito','Alta')
INSERT INTO ClienteTipo VALUES(01,4,'CreditoDeLaEmpresa','Alta')
INSERT INTO ClienteTipo VALUES(01,5,'MesesSinIntereses','Alta')

INSERT INTO ClienteTipo VALUES(02,1,'AlContado','Alta')
INSERT INTO ClienteTipo VALUES(02,2,'TarjetaDebito','Alta')
INSERT INTO ClienteTipo VALUES(02,3,'TarjetaCredito','Alta')
INSERT INTO ClienteTipo VALUES(02,4,'CreditoDeLaEmpresa','Alta')
INSERT INTO ClienteTipo VALUES(02,5,'MesesSinIntereses','Alta')

/*Clientes*/
INSERT INTO Cliente VALUES (01,'1','Lara Tobias',		'Ivan',			'LATI9208245E5',2,'12/09/2020','Venustiano Carranza 120,Zona Centro, 25700 Monclova','1')
INSERT INTO Cliente VALUES (01,'2','Sanchez Gomez',	'Juan Ramon',	'SAGJ910520H55',4,'12/09/2020','Jalapa,Guadalupe,25750 Monclova','1')
INSERT INTO Cliente VALUES (01,'3','Lopez Suarez',		'Abigail',		'LOSA951207K34',1,'12/09/2020','Guadalupe,25750 Monclova','1')
INSERT INTO Cliente VALUES (01,'4','Hernandez Perez',	'Jose Maria',	'HEPJ0001091P3',2,'12/09/2020','Obrera Sur,25790 Monclova','1')
INSERT INTO Cliente VALUES (01,'5','Gonzalez Rodriguez','Francisco',	'GORF960527E57',2,'12/09/2020','Calle 8,Otilio Monta�o,25796','1')
INSERT INTO Cliente VALUES (02,'6','Ramirez Flores',	'Alma Monserrat','RAFA9808305H5',3,'12/09/2020','Villa Florida 517-539,Praderas Casas Nuevas','1')
INSERT INTO Cliente VALUES (02,'7','Gomez Cruz',		'Juan Pablo',	'GOCJ870318L12',4,'12/09/2020','Rogelio Montemayor,25790','1')
INSERT INTO Cliente VALUES (02,'8','Lopez Martinez',	'Ramiro',		'LOMR851103R85',3,'12/09/2020','Adolfo Fisher 1222-1200,Obrera Sur 3ER. Sector,25790','1')
INSERT INTO Cliente VALUES (02,'9','Garcia Gonzalez',	'Susana ',		'GAGS980620K55',4,'12/09/2020','La Ca�ada 1427-1401,Colinas de Santiago','1')
INSERT INTO Cliente VALUES (02,'10','Perez Suarez',	'Raul Alejandro','PESR9911206R6',2,'12/09/2020','Francisco de Luna 696-727,10 de Mayo,25668','1')
INSERT INTO Cliente VALUES (02,'11','Jimenez Valdez',	'Victor Manuel','JIVV8705107A8',1,'12/09/2020','Internacional 14-6,Americana','1')
/*Puesto*/
INSERT INTO PUESTO VALUES(01,1,'Gerente','09/09/2020')
INSERT INTO PUESTO VALUES(01,2,'Gerente Financiero','09/09/2020')
INSERT INTO PUESTO VALUES(01,3,'Jefe de RH','09/09/2020')
INSERT INTO PUESTO VALUES(01,4,'Director de Calidad','09/09/2020')
INSERT INTO PUESTO VALUES(01,5,'Director Tecnico','09/09/2020')
INSERT INTO PUESTO VALUES(01,6,'Jefe de �rea ','09/09/2020')
INSERT INTO PUESTO VALUES(02,7,'Promotor de Ventas','09/09/2020')
INSERT INTO PUESTO VALUES(02,8,'Ing. Informatico','09/09/2020')
INSERT INTO PUESTO VALUES(02,9,'Operador','09/09/2020')
INSERT INTO PUESTO VALUES(02,10,'Recepcionista','09/09/2020')
INSERT INTO PUESTO VALUES(02,11,'Tecnico de reparacion','09/09/2020')
INSERT INTO PUESTO VALUES(02,12,'Encargado de bodega','09/09/2020')
INSERT INTO PUESTO VALUES(02,13,'Contador','09/09/2021')

/*Empleado*/
Insert into Empleado VALUES(01,1,'Esteban','Guajardo','Lopez',4,1,'GULE8003121MC','12/03/1980','Casado',500.00,'10/09/2020','12/09/2020','32988080011','GULE8003121MC03')
Insert into Empleado VALUES(01,3,'Miguel','Rodriguez','Martinez',2,5,'ROMM8504152PR','12/04/1980','Casado',400.00,'10/09/2020','12/09/2020','32988585012','ROMM8504152ML04')
Insert into Empleado VALUES(01,4,'Arturo','Diaz','Meraz',2,5,'DIMA8910251Z1','02/10/1989','Casado',400.00,'10/09/2020','12/09/2020','32928986013','DIMA8910251MC05')
Insert into Empleado VALUES(01,5,'Maria','Amaya','Gutierrez',3,6,'AMGM900505MC','05/05/1990','Soltero',300.00,'10/09/2020','12/09/2020','32929090012','AMGM900505MC01')
Insert into Empleado VALUES(01,6,'Luis','Sepulveda','Perez',4,6,'SEPL8603128MC','12/03/1986','Casado',300.00,'10/09/2020','12/09/2020','32128686161','SEPL860312MCN1')
Insert into Empleado VALUES(01,7,'Carlos','Cortez','Rios',2,5,'CORC8511046MC','04/11/1985','Soltero',400.00,'10/09/2020','12/09/2020','32118585041','CORC8511046MC')
Insert into Empleado VALUES(01,8,'Anahi','Miranda','Espinoza',1,1,'MREA8903127MC','06/03/1989','Soltero',500.00,'10/09/2020','12/09/2020','32108989131','MREA8903127MCR1')
Insert into Empleado VALUES(01,9,'Laura','Perez	','Montiel',4,2,'PEML910415MC','10/22/1991','Soltero',400.00,'10/09/2020','12/09/2020','32129191011','PEML910415MC33')
Insert into Empleado VALUES(02,10,'Martin','Ramos','Galindo',9,7,'RAGM8201058MC','05/01/1982','Casado',500.00,'10/09/2020','12/09/2020','32328282112','RAGM8201058MC')
Insert into Empleado VALUES(02,11,'Myrna','Tovar','Casas',6,13,'TOCM9203319TY','03/31/1992','Casado',200.00,'10/09/2020','12/09/2020','32259292131','TOCM9203319MC1')
Insert into Empleado VALUES(02,12,'Martha','Pe�a','Alvarado',7,10,'PEAM9710106RI','10/10/1997','Casado',200.00,'10/09/2020','12/09/2020','32219797568','PEAM9710106MC80')
Insert into Empleado VALUES(02,13,'Roberto','Garcia','Martinez',7,12,'GAMR9612124MC','12/12/1996','Casado',500.00,'10/09/2020','12/09/2020','31189696125','GAMR9612124MC')
Insert into Empleado VALUES(02,14,'Pamela','Estrada','Mijares',6,13,'ESMP8810097MC','09/10/1988','Casado',300.00,'10/09/2020','12/09/2020','32158888912','ESMP8810097MC2')
Insert into Empleado VALUES(02,15,'Carmen','Gonzalez','Casta�eda',9,9,'GOCC7915200WQ','05/20/1979','Divorciado',150.00,'10/09/2020','12/09/2020','32117979891','GOCC7915200MC12')
Insert into Empleado VALUES(02,16,'Roman','Ramirez','Quintana',8,10,'RAQR7702201MP','02/20/1977','Casado',200.00,'10/09/2020','12/09/2020','32107777928','RAQR7702201MC33')
Insert into Empleado VALUES(02,17,'Lourdes','Guerra','Garza',7,10,'GEGL9511083M1','08/11/1995','Soltero',200.00,'10/09/2020','12/09/2020','32099595235','GEGL9511083RT1')

/*Condiciones de Pago*/
Insert into CondicionPago VALUES(01,1,'Contador',0,'Alta')
Insert into CondicionPago VALUES(01,2,'Semanal',8,'Alta')
Insert into CondicionPago VALUES(01,3,'Quincenal',15,'Alta')
Insert into CondicionPago VALUES(01,4,'Mensual',30,'Alta')
Insert into CondicionPago VALUES(01,5,'Bimestral',60,'Alta')
Insert into CondicionPago VALUES(01,6,'Trimestral',90,'Alta')
Insert into CondicionPago VALUES(01,7,'Anual',360,'Alta')

Insert into CondicionPago VALUES(02,1,'Contador',0,'Alta')
Insert into CondicionPago VALUES(02,2,'Semanal',8,'Alta')
Insert into CondicionPago VALUES(02,3,'Quincenal',15,'Alta')
Insert into CondicionPago VALUES(02,4,'Mensual',30,'Alta')
Insert into CondicionPago VALUES(02,5,'Bimestral',60,'Alta')
Insert into CondicionPago VALUES(02,6,'Trimestral',90,'Alta')
Insert into CondicionPago VALUES(02,7,'Anual',360,'Alta')

/*Tipo de Unidad*/
Insert into TipoUnidad VALUES(01,1,'Pieza','Alta')
Insert into TipoUnidad VALUES(01,2,'Paquete','Alta')
Insert into TipoUnidad VALUES(01,3,'Caja','Alta')
Insert into TipoUnidad VALUES(01,4,'Kilogramo','Alta')
Insert into TipoUnidad VALUES(01,5,'Litro','Alta')
Insert into TipoUnidad VALUES(01,6,'Libra','Alta')
Insert into TipoUnidad VALUES(01,7,'Bolsa','Alta')
Insert into TipoUnidad VALUES(01,8,'Bulto','Alta')

Insert into TipoUnidad VALUES(02,1,'Pieza','Alta')
Insert into TipoUnidad VALUES(02,2,'Paquete','Alta')
Insert into TipoUnidad VALUES(02,3,'Caja','Alta')
Insert into TipoUnidad VALUES(02,4,'Kilogramo','Alta')
Insert into TipoUnidad VALUES(02,5,'Litro','Alta')
Insert into TipoUnidad VALUES(02,6,'Libra','Alta')
Insert into TipoUnidad VALUES(02,7,'Bolsa','Alta')
Insert into TipoUnidad VALUES(02,8,'Bulto','Alta')

select*from Empresa /*ya*/
select*from Depto /*ya*/
select*from Empleado /*ya*/
select*from Puesto /*ya*/
select*from ClienteTipo /*ya*/
select*from Cliente /*ya*/
select*from CondicionPago /*ya*/
select*from TipoUnidad /*ya*/
select*from Producto /*ya*/
