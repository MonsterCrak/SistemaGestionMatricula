use sys;
drop database if exists BDProyectoLPII;
create database if not exists `BDProyectoLPII` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
use `BDProyectoLPII`;

drop table if exists ReporteMatricula;
drop table if exists Matricula;
drop table if exists DetalleAsistencia;
drop table if exists Horario;
drop table if exists Asistencia;
drop table if exists Curso;
drop table if exists Usuario;
drop table if exists Empleado;
drop table if exists Alumno;
drop table if exists Cargo;
drop table if exists Sesion;

DROP PROCEDURE if exists `bdproyectolpii`.`sp_generar_num_matricula`;


Create table if not exists Cargo(
IdCargo int primary key auto_increment,
descripcion varchar(50)
);


/*------------------------------*/

Create table if not exists Empleado(
IdEmp int primary key auto_increment,
nombre varchar(50),
paterno varchar(50),
materno varchar(50),
dni char(8),
sexo varchar(15),
sueldo decimal(8,2),
telefono char(9),
estCivil varchar(30),
IdCargo int
);



/*------------------------------*/

Create table if not exists Alumno(
IdAlumno int primary key auto_increment,
nombre varchar(50) not null,
apellido varchar(50) not null,
telf char(9) ,
edad int,
dni char(8) not null
);



create table if not exists Menu(
codMen int(11) not null auto_increment,
desMen varchar(30) default null,
urlMen varchar(400) default null,
primary key (`codMen`)
);

/*
------------- DATOS MENU --------------
*/
insert into Menu values 
(1,'Empleado','empleado.jsp'),
(2,'Alumno','ServletAlumno?accion=LISTAR'),
(3,'Curso','Curso.jsp'),
(4,'Matricula','matricula.jsp');

Create table if not exists Usuario(
-- codUsu int(11) not null auto_increment,
codUsu int auto_increment primary key,
logUsu varchar(15) default null,
pasUsu varchar(15) default null,
nomUsu varchar(30) default null,
apeUsu varchar(50) default null,
edaUsu smallint(6) default null,
estUsu char(1) default null,
IdCargo int
);







create table if not exists Acceso(
codMen int(11) not null,
codUsu int(11) not null,
primary key (`codMen`,`codUsu`),
key codUsu (`codUsu`),
constraint `acceso_fk_1` foreign key (`codMen`) references Menu (`codMen`),
constraint `acceso_fk_2` foreign key (`codUsu`) references Usuario (`codUsu`)
);



/*------------------------------*/
Create table if not exists Grado(
IdGrado int primary key,
nomGrado varchar(50)
);

insert into Grado values
(1,"Primer Grado"),
(2,"Segundo Grado"),
(3,"Tercer Grado"),
(4,"Cuarto Grado"),
(5,"Quinto Grado");



/*------------------------------*/
Create table if not exists Curso(
IdCurso int primary key auto_increment,
nomCurso varchar(50),
IdEmp int,
IdGrado int
);


/*------------------------------*/
Create table if not exists Asistencia(
IdAsistencia int primary key auto_increment,
IdCurso int,
fecha datetime
);

/*------------------------------*/
Create table if not exists DetalleAsistencia(
IdDetAsistencia int primary key auto_increment,
IdAlumno int,
Registro bit,
IdAsistencia int
);


Create table if not exists Matricula(
IdMatricula int primary key auto_increment,
numMatri varchar(10) unique,
IdAlumno int,
IdGrado int,
fecMatricula date,
codUsu int,
CONSTRAINT `fk_MatriculaUsuario` FOREIGN KEY (`codUsu`) REFERENCES `Usuario` (`codUsu`)
);


/*------------------------------*/
Create table if not exists ReporteMatricula(
IdReporteMatricula int primary key auto_increment,
IdMatricula int,--
cantMatriculados int,
PeriodoMatricula varchar(20)
);


Create table if not exists DetalleMatricula(
IdMatricula int,
IdCurso int,
Cuota decimal(8,2),
CONSTRAINT `fk_DetalleMatriculaMatricula` FOREIGN KEY (`IdMatricula`) REFERENCES `Matricula` (`IdMatricula`),
CONSTRAINT `fk_DetalleMatriculaCurso` FOREIGN KEY (`IdCurso`) REFERENCES `Curso` (`IdCurso`)
);
/*------------------------------*/

Alter table Curso add constraint fk_CursoGrado foreign key(IdGrado) references
Grado(IdGrado);

Alter table Empleado add constraint fk_EmpleadoCargo foreign key(IdCargo) references
Cargo(IdCargo);

Alter table Usuario add constraint fk_UsuarioCargo foreign key(IdCargo) references
Cargo(IdCargo);


Alter table Curso add constraint fk_CursoEmpleado foreign key(IdEmp) references
Empleado(IdEmp);

Alter table Asistencia add constraint fk_AsistenciaCurso foreign key(IdCurso) references
Curso(IdCurso);


Alter table DetalleAsistencia add constraint fk_DetalleAsistenciaAlumno foreign key(IdAlumno) references
Alumno(IdAlumno);

Alter table DetalleAsistencia add constraint fk_DetalleAsistenciaAsistencia foreign key(IdAsistencia) references
Asistencia(IdAsistencia);

Alter table Matricula add constraint fk_MatriculaAlumno foreign key(IdAlumno) references
Alumno(IdAlumno);


Alter table ReporteMatricula add constraint fk_ReporteMatriculaMatricula foreign key(IdMatricula) references
Matricula(IdMatricula);

Alter table Matricula add constraint fk_MatriculaGrado foreign key(IdGrado) references
Grado(IdGrado);

select * from Cargo;
select * from Empleado;
select * from Alumno;

select * from Usuario;

insert into Cargo values
(null,"Administrador"),
(null,"Docente"),
(null,"Director"),
(null,"Secretaria");


insert into Empleado values
(null,"Juan", "Antonio", "Perez", 88888888, "Masculino", 200.00, 933352723, "Soltero",1),
(null,"Pedro", "Soto", "Mayor", 77777777, "Masculino", 500.00, 986777444, "Casado",2),
(null,"Ricardo", "Lopez", "Cruz", 12566978, "Masculino", 350.00, 986977044, "Soltero",3),
(null,"Jorge", "Luna", "Villa", 79658423, "Masculino", 650.00, 986799440, "Casado",4);





Select * from Curso;
Insert into Curso(nomCurso, IdEmp, IdGrado) values("ALGEBRA",1,1);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("INGLES",2,1);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("RV-TEXTOS",3, 2);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("TRIGONOMETRIA",4,3);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("RAZ. MATEMATICO",2,4);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("ARITMETICA",2,5);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("QUIMICA",3,3);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("RAZ. VERBAL",2,2);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("FÍSICA",1,3);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("CIENCIAS SOCIALES",2,4);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("GEOGRAFÍA",3,5);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("ARTE",4,2);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("INGLÉS",3,3);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("RELIGIÓN",4,5);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("EDUCACIÓN FÍSICA",1,1);
Insert into Curso(nomCurso, IdEmp, IdGrado) values("FILOSOFÍA",2,5);



/*
------------- DATOS USUARIO --------------
*/
insert into Usuario values 
(null,'fabi','fabi','Fabian','Soraluz',30,'1','1'),
(null,'jeff','jeff','Jeffri','Soto',28,'1','1'),
(null,'dav','dav','David','Hernandez',35,'1','2'),
(null,'jhoset','1234','Jhoset','Llacchua',21,'1','1'),
(null,'admin','admin','Admin','Admin',20,'1','1');


/*
------------- DATOS ACCESO --------------
*/
insert into Acceso values
(1,1),
(2,1),
(3,1),
(4,1),
(1,2),
(2,2),
(3,2),
(2,3),
(4,3),
(1,4),
(2,4),
(3,4),
(4,4),
(1,5),
(2,5),
(3,5),
(4,5);




-- PROCEDURES
DELIMITER $$
USE `bdproyectolpii`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_BuscarMatriculaById`(NOMBRE VARCHAR(100))
BEGIN
 SELECT 
 M.numMatri, 
 CONCAT(A.nombre, ' ', A.apellido) as Nombre, 
 G.nomGrado,
 fecMatricula 
 from Matricula M 
 inner join Alumno A on M.IdAlumno = A.IdAlumno 
 inner join Grado G on M.IdGrado = G.IdGrado
 where A.Nombre like concat("%",NOMBRE,"%") or A.Apellido like concat("%",NOMBRE,"%");
END$$
DELIMITER ;




Delimiter $$
CREATE PROCEDURE `sp_generar_num_matricula`()
BEGIN
	declare num int;
    set num=(select count(numMatri) from Matricula);
    if(num=0) then
		select 'MA-0001';
	else
		select concat('MA-',right(concat('0000',cast(right(max(numMatri),4)as signed)+1),4)) as numMatri
        from Matricula;
	end if;
END $$
Delimiter ;


call sp_generar_num_matricula();




insert into Alumno values(null,'Antonio','Soliz','999999999', 14,'82738218');
insert into Alumno values(null,'Juan','Perez','972836273', 13,'90283023');
insert into Alumno values(null,'Pepe','Morales','983745627', 15,'20871232');
insert into Alumno values(null,'Edson','Timoteo','923782876', 15,'12038083');
insert into Alumno values(null,'Enrique','Vivar','901293782', 15,'12973921');
insert into Alumno values(null,'Maria','Ponce','900123872', 13,'84739238');
insert into Alumno values(null,'Alan','Garcia','945612378', 11,'84739238');
insert into Alumno values(null,'Andy','Perez','978456321', 12,'84739238');
insert into Alumno values(null,'Lucy','Rios','978456120', 14,'84739238');
insert into Alumno values(null,'Rocio','La Torre','941785623', 11,'84739238');



insert into Matricula values (null,'MA-0001',1,3,curdate(),1);
insert into DetalleMatricula values(1,3,250);
insert into DetalleMatricula values(1,4,250);
insert into DetalleMatricula values(1,5,250);

insert into Matricula values (null,'MA-0002',2,1,'2022/10/27',1);
insert into DetalleMatricula values(2,1,250);
insert into DetalleMatricula values(2,2,250);
insert into DetalleMatricula values(2,3,250);

insert into Matricula values (null,'MA-0003',3,3,'2022/09/28',1);
insert into DetalleMatricula values(3,3,250);
insert into DetalleMatricula values(3,4,250);

insert into Matricula values (null,'MA-0004',4,3,'2022/09/28',1);
insert into DetalleMatricula values(4,3,250);
insert into DetalleMatricula values(4,4,250);
insert into DetalleMatricula values(4,6,250);
insert into DetalleMatricula values(4,7,250);




