CREATE DATABASE IF NOT EXISTS consecionarios_db;
USE consecionarios_db;
CREATE TABLE consecionarios(
	nit_concesionario int primary key not null,
    nombre_consecionario varchar(50) unique key not null
);

CREATE TABLE aseguradoras(
	nit_aseguradora int primary key not null, 
    nombre_aseguradora varchar(50) unique key not null
);

CREATE TABLE departamentos(
	id_dpto int auto_increment primary key not null,
    nombre_dpto varchar(30) unique key not null
);

CREATE TABLE ciudades(
	id_ciudad int auto_increment primary key not null,
    nombre_ciudad varchar(30) unique key not null,
    FK_dpto int not null,	
    foreign key(FK_dpto) references departamentos(id_dpto)    
);

CREATE TABLE direcciones(
	id_direccion int auto_increment primary key not null,
    tipo_calle varchar(40) not null,
    num1 int not null,
    num2 int not null,
    num3 int not null,
    barrio varchar(30) not null,
    FK_ciudad int not null,
    foreign key (FK_ciudad) references ciudades(id_ciudad)    
);

CREATE TABLE sucursales(
	nit_sucursal int primary key not null,
    nombre_sucursal varchar(50) unique key not null,
    FK_concesionario int not null,
    FK_direccion int not null,
    foreign key(FK_concesionario) references consecionarios(nit_concesionario),
    foreign key(FK_direccion) references direcciones(id_direccion)
);

CREATE TABLE empleados(
	cedula_empleado int primary key not null,
    tipo_documento enum("Cedula","Pasaporte"),
    nombre_empleado varchar(30) not null,
    apellido_empleado varchar(30) not null,
    telefono_empleado varchar(10) unique key not null,
    email_empleado varchar(30) unique key not null,
    FK_empleado_jefe int,
    FK_sucursal int not null,
    foreign key(FK_empleado_jefe) references empleados(cedula_empleado),
    foreign key(FK_sucursal) references sucursales(nit_sucursal)
);

CREATE TABLE clientes(
	cedula_cliente int primary key not null,
    tipo_documento enum("Cedula","Pasaporte"),
    nombre_cliente varchar(30) not null,
    apellido_cliente varchar(30) not null,
    telefono_cliente varchar(10) unique key not null,
    email_cliente varchar(30) unique key not null,
    FK_direccion int not null,
    foreign key(FK_direccion) references direcciones(id_direccion)
);

CREATE TABLE marcas(
	id_marca int auto_increment primary key not null,
    nombre varchar(30) not null,
    linea varchar(30) not null,
    FK_sucursal int not null,
    foreign key (FK_sucursal) references sucursales(nit_sucursal)
);

CREATE TABLE colores(
	id_color int auto_increment primary key not null,
    nombre varchar(30) not null
);

CREATE TABLE vehiculos(
	id_vehiculo int auto_increment primary key not null,
    modelo int not null,
    FK_marca int not null,
    FK_color int not null,
    foreign key(FK_marca) references marcas(id_marca),
    foreign key(FK_color) references colores(id_color)
);

CREATE TABLE facturas(
	id_factura int auto_increment primary key not null,
    chasis varchar(50) not null,
    placa varchar(6) unique key not null,
    fecha date,
    FK_empleado int not null,
    FK_cliente int not null,
    FK_vehiculo int not null,
    foreign key(FK_empleado) references empleados(cedula_empleado),
    foreign key(FK_cliente) references clientes(cedula_cliente),
    foreign key(FK_vehiculo) references vehiculos(id_vehiculo)
);

CREATE TABLE compras_seguro(
	id_compra int auto_increment primary key not null,
    fecha date,
    costo float not null,
    FK_aseguradora int not null,
    FK_consecionario int not null,
    FK_vehiculo int not null,
    FK_cliente int not null,
    foreign key(FK_aseguradora) references aseguradoras(nit_aseguradora),
    foreign key(FK_consecionario) references consecionarios(nit_concesionario),
    foreign key(FK_vehiculo) references vehiculos(id_vehiculo),
    foreign key(FK_cliente) references clientes(cedula_cliente)    
);

#Ingresar los valores
insert into consecionarios(nit_concesionario,nombre_consecionario)
	values(815432,"Mazda"),(9876543,"Ford");
select * from consecionarios;
insert into aseguradoras(nit_aseguradora,nombre_aseguradora)
	values(98765,"Seguros SOAT"),(12345,"Allianz seguros"),(76543,"Mapfre seguros"),
    (19087,"Seguros del estado"),(20567,"Positiva"),(40987,"Seguros Alfa");
select * from aseguradoras;
insert into departamentos(nombre_dpto)
	values("Caldas"),("Cundinamarca"),("Antioquia");
select * from departamentos;
insert into ciudades(nombre_ciudad,FK_dpto)
	values("Manizales",1),("Bogota",2),("Medellin",3),
    ("Pereira",1),("Soacha",2),("Santa fe",3);
select * from ciudades;
insert into ciudades(nombre_ciudad,FK_dpto)
	values("La dorada",1);
insert into direcciones(tipo_calle,num1,num2,num3,barrio,FK_ciudad)
	values("Aveida",23,36,65,"Santander",1),("Autopista",134,45,95,"Norte",2),("Avenida",48,10,168,"Las vegas",3),
    ("Sector",22,10,50,"Parque Olaya",1),("Avenida",127,71,33,".",2),("Calle",31,43,03,".",3);
insert into direcciones(tipo_calle,num1,num2,num3,barrio,FK_ciudad)
	values("Avenida",23,54,12,"Enea",7);
insert into direcciones (tipo_calle, num1, num2, num3, barrio,FK_ciudad) 
	values ('Junction', '93498', '181', '607', 'Forest',1),
	('Crossing', '6', '560', '98', 'Prairieview',2),
	('Plaza', '662', '2', '8', 'Hudson',3),
	('Trail', '73', '25', '90', 'Waubesa',4),
	('Way', '01', '6752', '713', 'Rowland',5),
	('Junction', '41', '39645', '6', 'Nova',6);
insert into direcciones (tipo_calle, num1, num2, num3, barrio,FK_ciudad) 
values("Avenida",12,32,6,"Bosque",4);
select * from direcciones;
insert into sucursales(nit_sucursal,nombre_sucursal,FK_concesionario,FK_direccion)
	values(1982,"Colautos",815432,1),(234561,"Alciautos",815432,2),(10928,"Somerauto",815432,3),
    (73434,"El roble motor",9876543,4),(32893,"Los coches",9876543,5),(6734243,"Corautos andino",9876543,6);
insert into sucursales(nit_sucursal,nombre_sucursal,FK_concesionario,FK_direccion)
	values(2345667,"Los cochecitos",9876543,13);
select * from sucursales;
insert into empleados(cedula_empleado,tipo_documento,nombre_empleado,apellido_empleado,telefono_empleado,email_empleado,FK_sucursal)
	values("75033","Cedula","Jacinto","Florez",310486,"jacinto@gmail.com",1982),
    ("30358","Cedula","Marcelo","Perez",321456,"marcelo@gmail.com",234561),
    ("1053764","Cedula","Marcela","Alzate",313325,"marcela@gmail.com",10928),
    ("1056421","Cedula","Esteban","Rivera",320476,"esteban@gmail.com",73434),
    ("1002656","Cedula","Oscar","Loaiza",311342,"oscar@gmail.com",32893),
    ("10765","Cedula","Cecilia","Ortiz",323363,"cecilia@gmail.com",6734243);
select * from empleados;
insert into empleados(cedula_empleado,tipo_documento,nombre_empleado,apellido_empleado,telefono_empleado,email_empleado,FK_empleado_jefe,FK_sucursal)
	values("1054765","Cedula","Manuel","Velez",312824,"manuel@gmail.com",75033,1982),("1002987","Pasaporte","Manuela","Zapata",311456,"manuela@gmail.com",75033,1982),
    ("1002498","Pasaporte","Jean","Arias",3002765,"jean@gmail.com",30358,234561),("1056789","Cedula","Geraldine","Urrea",320123,"geral@gmail.com",30358,234561),
    ("1052437","Cedula","Juan","Quintero",305643,"juan@gmail.com",1053764,10928),("1052734","Pasaporte","Felipe","Morales",320934,"felipe@gmail.com",1053764,10928),
    ("108543","Pasaporte","Yaneth","Mejia",302123,"yaneth@gmail.com",1056421,73434),("109876","Cedula","Felipe","Buitrago",312501,"felipeb@gmail.com",1056421,73434),
    ("112233","Cedula","Estefania","Giraldo",301123,"fabian@gmail.com",1002656,32893),("198754","Pasaporte","Ricardo","Rodriguez",3028765,"ricardo@gmail.com",1002656,32893),
    ("10983524","Pasaporte","Salome","Hernandez",3124567,"salome@gmail.com",10765,6734243),("1053927","Cedula","Alisson","Giraldo",312016,"alisson@gmail.com",10765,6734243);
insert into clientes(cedula_cliente,tipo_documento,nombre_cliente,apellido_cliente,telefono_cliente,email_cliente,FK_direccion)
	values(1096543,"Pasaporte", 'Therese', 'Leehane', "3202293285", 'tleehane0@yellowpages.com',7),
	(4364534, "Cedula",'Blanca', 'Litel',"2774736885", 'blitel1@nps.gov', 8),
	(146535,"Pasaporte", 'Delbert', 'Clive',"4072653881", 'dclive2@princeton.edu', 9),
	(263545,"Cedula", 'Siana', 'Anderl',"4027824488", 'sanderl3@typepad.com', 10),
	(237434,"Pasaporte", 'Carrie', 'McKnish',"3059306584", 'cmcknish4@behance.net', 11),
	(293843,"Cedula", 'Elianore', 'Pease', "3913574747", 'epease5@cloudflare.com', 12);
insert into clientes(cedula_cliente,tipo_documento,nombre_cliente,apellido_cliente,telefono_cliente,email_cliente,FK_direccion)
values(1027654321,"Pasaporte","Helen","Chufe",310987654,"helen@gmail.com",14);
SELECT * FROM clientes;
insert into marcas(nombre,linea,FK_sucursal)
	values("Mazda","MX-5 Miata RF",1982),("Mazda","CX-30",1982),("Mazda","CX-5",234561),("Mazda","CX-50",234561),
    ("Mazda","MX-5 Miata",10928),("Mazda","CX-9",10928),("Ford","EcoSport",73434),("Ford","Explorer",73434),
    ("Ford","Focus",32893),("Ford","Galaxy",32893),("Ford","Kuga",6734243),("Ford","Mondeo",6734243);
insert into marcas(nombre,linea,FK_sucursal)
values("Ford","Bronco Sport 4x4",6734243);
select * from marcas;
insert into colores(nombre)
	values('Goldenrod'),('Blue'),('Violet'),('Green'),('Mauv'),('Pink'),
	('black'),('white'),('Turquoise'),('purple'),('Indigo'),('Aquamarine');
select * from colores;
insert into vehiculos(modelo,FK_marca,FK_color)
	values(2018,1,1),(2019,1,2),(2018,2,3),(2020,2,4),(2021,3,5),(2022,3,6),(2015,4,7),(2016,4,8),(2017,5,9),(2013,5,10),
    (2014,6,11),(2022,6,12),(2022,7,1),(2021,7,2),(2020,8,3),(2019,8,4),(2018,9,5),(2017,9,6),(2020,10,7),(2022,10,8),
    (2021,11,9),(2015,11,10),(2014,12,11),(2016,12,12);
insert into vehiculos(modelo,FK_marca,FK_color)
values (2020,1,1),(2019,2,1);
select * from vehiculos;
insert into facturas(chasis,placa,fecha,FK_empleado,FK_cliente,FK_vehiculo)
	values("32435RT44545","VRE654","2022-02-13",75033,1096543,1),("YTR65454H877","HHW464","2022-02-20",75033,237434,2),
    ("EERT456TYT65767","VUW831","2020-12-18",112233,293843,6),("UYETWR09284376","SPX873","2021-06-27",1052437,4364534,7);    
    
insert into facturas(chasis,placa,fecha,FK_empleado,FK_cliente,FK_vehiculo)
values("6735264EDF","MJX835","2021-12-24",109876,4364534,25),("2534DFFHDSVB","POR587","2021-01-04",198754,4364534,26);
insert into facturas(chasis,placa,fecha,FK_empleado,FK_cliente,FK_vehiculo)
values("34324M4MN432","TRE344","2021-10-23",75033,146535,15),("374326YUGYWE76235","MNQ801","2021-09-06",75033,293843,12),
("34RERWWEED34242","VFD145","2021-11-10",75033,237434,17),("BFD657DFS","FGV834","2021-09-09",1002498,146535,9);
#-----------------------------------------Aqui voy con las capturas-------------------------------------------------------

insert into facturas(chasis,placa,fecha,FK_empleado,FK_cliente,FK_vehiculo)
values("43545RTWETT","MER654","2021-10-22",75033,146535,15);
SELECT * FROM facturas;
insert into compras_seguro(fecha,costo,FK_aseguradora,FK_consecionario,FK_vehiculo,FK_cliente)
values("2021-04-12",34.9876,98765,815432,1,1096543),("2022-08-12",98.765,12345,9876543,2,4364534),("2022-11-24",103.765,20567,9876543,3,293843);
insert into compras_seguro(fecha,costo,FK_aseguradora,FK_consecionario,FK_vehiculo,FK_cliente)
values("2022-01-12",34.9876,20567,815432,12,1096543),("2022-02-12",98.765,12345,815432,15,4364534),("2022-11-24",103.765,76543,815432,18,293843);
insert into compras_seguro(fecha,costo,FK_aseguradora,FK_consecionario,FK_vehiculo,FK_cliente)
values("");
select * from compras_seguro;
#CONSULTAS
#1. Consultar los nombres completos y la dirección de vivienda, de los clientes atendidos por el empleado Jacinto durante el mes de febrero del año 2022.
select concat(c.nombre_cliente," ",c.apellido_cliente) as Nombre_completo, concat(d.tipo_calle," ",d.num1,"N°",d.num2,"-",num3," ",barrio,". ",ciu.nombre_ciudad,"-",dpto.nombre_dpto) as Direccion
from clientes as c
inner join empleados as e
inner join facturas as f
inner join direcciones as d
inner join ciudades as ciu
inner join departamentos as dpto
on f.FK_empleado=e.cedula_empleado and f.FK_cliente=c.cedula_cliente and d.id_direccion=c.FK_direccion and d.FK_ciudad=ciu.id_ciudad and ciu.FK_dpto=dpto.id_dpto
where month(f.fecha)=02 and year(f.fecha)=2022 and e.nombre_empleado="Jacinto";
#2. ¿En qué ciudades hay sucursales de la concesionaria Mazda?
select ciu.nombre_ciudad 
from  consecionarios as c
inner join sucursales as s
inner join ciudades as ciu
inner join direcciones as dir
on s.FK_concesionario=c.nit_concesionario and s.FK_direccion=dir.id_direccion and dir.FK_ciudad=ciu.id_ciudad
where c.nombre_consecionario="Mazda";
#3. ¿Cuáles son las aseguradoras que tienen convenio con Ford?
select ase.nombre_aseguradora
from consecionarios as con
inner join compras_seguro as c
inner join aseguradoras as ase
on c.FK_consecionario=con.nit_concesionario and c.FK_aseguradora=ase.nit_aseguradora
where con.nombre_consecionario="Ford";
#4. ¿Cuáles son los clientes que atiende Jacinto, asesor de la concesionaria de Mazda de la sucursal Colautos ubicada en la ciudad de Manizales?
select concat(cli.nombre_cliente,"",cli.apellido_cliente) as Clientes
from clientes as cli
inner join empleados as emp
inner join consecionarios as con
inner join facturas as fac
inner join sucursales as suc
inner join direcciones as dir
inner join ciudades as ciu
on suc.FK_concesionario=con.nit_concesionario and suc.FK_direccion=dir.id_direccion and dir.FK_ciudad=ciu.id_ciudad and fac.FK_empleado=emp.cedula_empleado and fac.FK_cliente=cli.cedula_cliente
where emp.nombre_empleado="Jacinto" and con.nombre_consecionario="Mazda" and suc.nombre_sucursal="Colautos" and ciu.nombre_ciudad="Manizales";
#5. Consultar el color de carro más vendido de la marca Mazda durante el año 2021
drop procedure color_mas_vendido;
delimiter //
create procedure color_mas_vendido()
begin
	select c.nombre as color, count(c.id_color) as Cant
	from colores as c
	inner join facturas as f
	inner join vehiculos as v
	inner join marcas as m
	on f.FK_vehiculo=v.id_vehiculo and v.FK_marca=m.id_marca and v.FK_color=c.id_color
	where year(f.fecha)=2021 and m.nombre="Mazda"
	group by color
	having Cant>1;
end //
delimiter ;
call color_mas_vendido;
#6. Consultar la cantidad de vehículos que vendió Mazda en la sucursal situada en la ciudad de Manizales durante el año 2021.
drop procedure cant_vehiculos;
delimiter //
create procedure cant_vehiculos()
begin
		select count(v.id_vehiculo) as cantidad
        from vehiculos as v
		inner join facturas as fac
		inner join consecionarios as c
		inner join sucursales as s
		inner join direcciones as dir
		inner join ciudades as ciu
		on dir.FK_ciudad=ciu.id_ciudad and s.FK_direccion=dir.id_direccion and s.FK_concesionario=c.nit_concesionario and fac.FK_vehiculo=v.id_vehiculo
		where year(fac.fecha)=2021 and c.nombre_consecionario="Mazda" and ciu.nombre_ciudad="Manizales";
end //
delimiter ;
call cant_vehiculos;
#7. Consultar cuál fue el mes en el que Jacinto vendió más vehículos durante el segundo semestre del año 2021.
drop procedure mes_jacinto;
delimiter //
create procedure mes_jacinto()
begin
	select month(f.fecha) as Mes, count(f.id_factura) as Cant, emp.cedula_empleado as Empleado
    from facturas as f
    inner join empleados as emp
    on f.FK_empleado=emp.cedula_empleado
    where f.fecha between "2021-06-01" and "2021-12-31" and emp.nombre_empleado="Jacinto"    
    group by month(f.fecha) 
    having Cant>1;
end //
delimiter ;
call mes_jacinto;
#8. Cuál aseguradora de las que tiene convenio con la concesionaria Mazda, ofreció el seguro más
	#costoso durante el primer trimestre del año 2022. La consulta debe mostrar el nombre de la
	#aseguradora, el costo del seguro contra todo riesgo, la placa del vehículo y el nombre del cliente que
	#adquirió el seguro.
drop procedure seguro_costoso;
delimiter //
create procedure seguro_costoso()
begin
	select ase.nombre_aseguradora as Aseguradora, com.costo as Costo, com.FK_vehiculo as Vehiculo, cli.nombre_cliente as Cliente
    from compras_seguro as com
    inner join aseguradoras as ase
    inner join vehiculos as v
    inner join clientes as cli
    inner join consecionarios as con
    on com.FK_consecionario=con.nit_concesionario and com.FK_cliente=cli.cedula_cliente and com.FK_vehiculo=v.id_vehiculo
    and com.FK_aseguradora=ase.nit_aseguradora
    where con.nombre_consecionario="Mazda" and com.fecha between "2022-01-01" and "2022-03-31" 
    and com.costo=(select max(com.costo) from compras_seguro);
end //
delimiter ;
call seguro_costoso;
select * from compras_seguro;
select * from aseguradoras;
select * from consecionarios;
#9. Consulta cual de las tres aseguradoras que tienen convenio con Ford para vehículos de uso particular,
#ofrece un menor precio para el Bronco Sport 4x4 que adquirió Helen Chufe y cual de las tres
#aseguradoras ofrece un mayor precio.
