/*Ejercicio 01*/
CREATE database IF NOT EXISTS Ejercicio01;
CREATE table Cliente (
  IDCliente int NOT NULL,
  RazonSocial varchar(50) NOT NULL, 
  Domicilio varchar(50) NOT NULL,
  Mail varchar(50) DEFAULT NULL,
  Rubro int DEFAULT NULL, 
  CantEmpleados int NOT NULL 
); 

CREATE table Rubro(
   IDRubro int NOT NULL,
   Descripcion varchar (50) NOT NULL
);

CREATE table ClienteSucursal (
   IDClienteSucursal int NOT NULL,
   CantSucursalesCapital int NOT NULL,
   CantSucursalesInterior int NOT NULL
);

/*Ejercicio 02*/
ALTER TABLE cliente ADD PRIMARY KEY (IDCliente);
ALTER TABLE cliente ADD FOREIGN KEY (Rubro) REFERENCES rubro(IDRubro);

ALTER TABLE Rubro ADD PRIMARY KEY (IDRubro);

ALTER TABLE clientesucursal ADD PRIMARY KEY (IDClienteSucursal);
ALTER TABLE clientesucursal ADD FOREIGN KEY (IDClienteSucursal) REFERENCES cliente(IDCliente);

/*Ejercicio 03*/
ALTER TABLE cliente ADD CP varchar(50) NOT NULL;
ALTER TABLE cliente DROP CP;
ALTER TABLE cliente DROP FOREIGN KEY cliente_ibfk_1; /*supuestamente asi elimina la foreign key*/
/*ALTER TABLE cliente DROP PRIMARY KEY;*/
/*no se puede eliminar la PK de la tabla cliente porque es FK de la tabla clienteSucursal. 
Para eso hay que eliminar primero la tabla clientesSucursal para poder despues eliminar la PK de la tabla cliente*/

/*Ejercicio 04*/

/*DROP table cliente; no puedo eliminar la tabla cliente primero porque está referenciada como FK
de clientesucursal. para eso tengo que eliminar primero la tabla cliente sucursal, aunque tambien puedo
empezar por la tabla rubro*/

DROP table rubro;
DROP table clientesucursal;
DROP table cliente;

/*Ejercicio 05*/

/*En este caso no puedo crear la tabla cliente en primer lugar porque tiene una clave foranea que depende 
de la tabla rubro. Tampoco puedo crear la tabla clientesucursal porque tiene una clave foranea que 
depende de la tabla cliente. 
El orden correcto de creacion de tablas es rubro, cliente y clientesucursal*/

CREATE TABLE rubro(
  IDRubro int NOT NULL,
  Descripcion varchar (50) NOT NULL,
  PRIMARY KEY (IDRubro)
);

CREATE TABLE clientes(
  IDCliente int NOT NULL,
  RazonSocial varchar(50) NOT NULL, 
  Domicilio varchar(50) NOT NULL,
  Mail varchar(50) DEFAULT NULL,
  Rubro int DEFAULT NULL, 
  CantEmpleados int NOT NULL, 
  PRIMARY KEY (IDCliente), 
  CONSTRAINT fk_clientes_rubro FOREIGN KEY (Rubro) REFERENCES rubro(IDRubro)
 );

CREATE TABLE clientesSucursal(
   IDClienteSucursal int NOT NULL,
   CantSucursalesCapital int NOT NULL,
   CantSucursalesInterior int NOT NULL, 
   PRIMARY KEY (IDClienteSucursal), 
   CONSTRAINT fk_clientesSucursal_clientes FOREIGN KEY (IDClienteSucursal) REFERENCES clientes(IDCliente)
  );
  
  /*Ejercicio 06*/
  
INSERT INTO Rubro(IDRubro, Descripcion)
VALUES (1, "Electricidad");
INSERT INTO Rubro(IDRubro, Descripcion)
VALUES (2, "Telecomunicaciones");
INSERT INTO Rubro(IDRubro, Descripcion)
VALUES (3, "Redes");
INSERT INTO Rubro(IDRubro, Descripcion)
VALUES (4, "Telefonia IP");
INSERT INTO Rubro(IDRubro, Descripcion)
VALUES (5, "Seguridad Informatica");
 
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Mail, Rubro, CantEmpleados)
VALUES (2,"ElectroTodo","Virrey del Pino 1434","et@yahoo.com.ar",1,5);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Mail, Rubro, CantEmpleados)
VALUES (3,"Conectar SA","Aguero 37", "conectar@fibertel.com.ar",2,10);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Rubro, CantEmpleados)
VALUES (4, "Metro SRL","Cerrito Esq San Juan", 3,12);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Mail, Rubro, CantEmpleados) 
VALUES (5,"MyIP","Salguero 3421","mip@hotmail.com",2,3);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Mail, CantEmpleados)
VALUES (6,"Router&Switch","Las Heras esq Austria", "rs@gmail.com",4);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, CantEmpleados)
VALUES (7,"Sat","Cabildo esq Juramento",1);
INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Rubro, CantEmpleados)
VALUES(8,"Cableado SRL","Guemes 234",4,7);

INSERT INTO clientessucursal(IDClienteSucursal,CantSucursalesCapital,CantSucursalesInterior)
VALUES (2,30,4);
INSERT INTO clientessucursal(IDClienteSucursal,CantSucursalesCapital,CantSucursalesInterior)
VALUES (3,0,12);
INSERT INTO clientessucursal(IDClienteSucursal,CantSucursalesCapital,CantSucursalesInterior) 
VALUES (5,9,0);
INSERT INTO clientessucursal(IDClienteSucursal,CantSucursalesCapital,CantSucursalesInterior)
VALUES (6,25,0);
INSERT INTO clientessucursal(IDClienteSucursal,CantSucursalesCapital,CantSucursalesInterior)
VALUES (7,0,2);

SELECT * FROM clientessucursal;
/*Ejercicio 07*/

INSERT INTO clientes(IDCliente, RazonSocial, Domicilio, Mail, CantEmpleados)
VALUES (9,"Tecno Group SA", "Rivadavia 7654","info@tecnogroup.com.ar", 22);

UPDATE clientes 
SET Mail="info@tecnogroup.com", Rubro = 3
WHERE IDCliente = 9;

DELETE FROM clientes WHERE IDCliente=9;

/*Ejercicio 08*/

/*DELETE FROM rubro WHERE IDRubro=2;*/
/*No puedo eliminar la tupla referida a IDRubro=2 ya que esta es utilizada como clave foranea y tiene la 
palabra clave constraint, usada como restriccion*/

/*Ejercicio 09*/

SELECT * FROM clientes; /*A*/

SELECT IDClienteSucursal, CantSucursalesCapital FROM clientessucursal
WHERE CantSucursalesCapital<25; /*B*/

SELECT IDClienteSucursal, CantSucursalesCapital FROM clientessucursal
WHERE CantSucursalesCapital<=25; /*C*/

/*D*/
SELECT IDClienteSucursal, CantSucursalesInterior FROM clientessucursal
WHERE CantSucursalesInterior>=2 AND CantSucursalesInterior<=4;

SELECT IDClienteSucursal, CantSucursalesInterior FROM clientessucursal
WHERE CantSucursalesInterior BETWEEN 2 AND 4;

/*E*/
SELECT IDClienteSucursal, CantSucursalesInterior FROM clientessucursal
WHERE CantSucursalesInterior<2 or CantSucursalesInterior>4;

SELECT IDClienteSucursal, CantSucursalesInterior FROM clientessucursal
WHERE CantSucursalesInterior NOT BETWEEN 2 AND 4;

/*F*/
SELECT IDCliente, RazonSocial, Domicilio FROM clientes
WHERE Domicilio LIKE 'C%';

/*G*/
SELECT IDCliente, RazonSocial, Domicilio FROM clientes
WHERE Domicilio LIKE '%A%';

/*H*/
SELECT IDCliente, RazonSocial, Domicilio FROM clientes
WHERE DOMICILIO LIKE '_A%';

/*I*/
SELECT * FROM clientes
WHERE Rubro BETWEEN 1 AND 3;

SELECT * FROM clientes
WHERE Rubro>=1 AND Rubro<=3;

/*J*/
SELECT * FROM clientes
WHERE Rubro IS NULL;

/*K*/
SELECT * FROM clientes
WHERE (Rubro IS NULL OR Rubro=2) AND CantEmpleados>3; 

/*L*/
SELECT * FROM clientes ORDER BY IDCliente ASC;

SELECT * FROM clientes ORDER BY RazonSocial DESC;

/*M*/
SELECT DISTINCT Rubro FROM clientes WHERE Rubro IS NOT NULL;

/*N*/
SELECT * from clientes as cli inner join rubro as r on cli.Rubro = r.IDRubro;
SELECT * from clientes as cli inner join rubro as r on cli.Rubro = r.IDRubro group by rubro;

/*O*/
SELECT RazonSocial, Rubro, Descripcion from clientes as cli cross join rubro as r on cli.Rubro = r.IDRubro where RazonSocial like 'M%';

/*P y q*/
SELECT * from clientes as cli inner join rubro as r group by rubro;

/*R*/

SELECT RazonSocial, Rubro, Descripcion from clientes as cli inner join rubro as r on cli.Rubro = r.IDRubro where IDRubro=1 or IDRubro=2 or IDRubro=4;