/* 1FN (Primera Forma Normal)
-1 Eliminar campos repetidos en tablas individuales
-2 Crear una tabla independiente para cada conjunto de datos relacionados
-3 Identificar cada conjunto relacionado con la clave principal*/

--Ejemplo de tabla no normalizada
CREATE TABLE Alumnos(
    id INT (10) NOT NULL AUTO_INCREMENT,
    Nombre CHAR(20) NOT NULL,
    Direccion CHAR(20),
    Telefono INT(15),
    Curso1 CHAR(20),
    Curso2 CHAR(20),
    Carrera CHAR(20),
    PRIMARY KEY (id)
)
AUTO_INCREMENT= 1;

--Rellenar la tabla
INSERT INTO alumnos (Nombre, Direccion, Telefono, Curso1, Curso2, Carrera) VALUES(
    "Cinthia", "Centro", 124563, "Reportes", "Auditoria", "Contabilidad"
); 

--Aplicar la 1FN

--Cambiar el nombre de la tabla no normalizada
ALTER TABLE alumnos RENAME Alum;

--Crear una nueva tabla corregida
*CREATE TABLE Alumnos(
    id INT (10) NOT NULL AUTO_INCREMENT,
    Nombre CHAR(20) NOT NULL,
    Direccion CHAR(20),
    Telefono INT(15),
    Cursos CHAR(20),
--Se cambiaron llas columnas de curso por una sola columna
    Carrera CHAR(20),
    PRIMARY KEY (id)
)
AUTO_INCREMENT= 1;

--Se rellena la nueva tabla con los datos de la tabla anterior
INSERT INTO alumnos (Nombre, Direccion, Telefono, Cursos, Carrera) 
SELECT alum.Nombre, alum.Direccion, alum.Telefono, alum.Curso1, alum.Carrera FROM
alum where alum.id= 3;
/*Cambie manualmente el dato de alum.id
me gustaria usar un autoincremental para barrer la tabla*/

insert INTO alumnos(Nombre, Direccion, Telefono, Cursos, Carrera) 
SELECT alum.Nombre, alum.Direccion, alum.Telefono, alum.Curso2, alum.Carrera FROM
alum where alum.id= 3; 

--La tabla que cumple la 1FN se a completado
/*Esta nueva tabla ya no repite campos, sin embargo tiene registros
duplicados, esto se debera corregir con la Segunda Forma Normal*/
;
    
/*2FN (Segunda Forma Normal)
-1 Crear tablas independientes para los conjuntos de valores que se aplican a varios registros
-2 Relacionar esta tablas con una clave foranea*/

--Se crea la tabla para el nuevo grupo
create TABLE Clases (
    idclas INT(10) not NULL AUTO_INCREMENT,
    nomclas CHAR(15),
    idalumn INT(10),
    PRIMARY KEY (idclas) 
)
AUTO_INCREMENT= 1;

--No termine de comprender los ejemplos en el curso

/* 1FN 2FN y 3FN
Primera, Segunda y Tercera forma Normal
-1 Identificar si existe redundancia en algun campo y separar ese campo en otra tabla.
-2 Identificar relacionar las las tablas generadas anteriormente con tablas secundarias.
-3 Separar los datos con dependencias transitivas siempre que sea pertinente.
https://docs.microsoft.com/es-es/office/troubleshoot/access/database-normalization-description
De acuerdo a lo anterior propongo otro ejemplo para esta seccion*/

--Se crea La tabla de ejemplo

CREATE TABLE Alumnos(
    id INT (10) NOT NULL AUTO_INCREMENT,
    nombre CHAR(30) NOT NULL,
    direccion CHAR(30),
    telefono INT(15),
    clase1 CHAR(20),
    clase2 CHAR(20),
    carrera CHAR(20),
    beca CHAR(20),
    PRIMARY KEY (id)
)
AUTO_INCREMENT= 1;

--Se insertan datos
insert INTO alumnos(nombre, direccion, telefono, clase1, clase2, carrera, beca) VALUES(
    "Abel", "La muralla", 124578, "Python", "C", "Programacion", "Deportiva" 
);

--Se verifican los datos
SELECT * from alumnos;

--Se crea una tabla para el campo carrera que genera redundancias
create TABLE carreras (
    idcarrera INT NOT NULL AUTO_INCREMENT,
    nomcarrera CHAR(20),
    PRIMARY KEY (idcarrera)
)
--El autoincremental comienza en 2001, como una clave para distinguir la carrera, 
--me gustaria usar letra y numero
AUTO_INCREMENT= 2001;

--Se insertan las carreras que existen en la tabla alumnos
INSERT INTO carreras (nomcarrera) SELECT DISTINCT carrera FROM alumnos;

--Se agraga una nueva columna a la tabla alumnos
ALTER TABLE alumnos ADD major INT;

--La columna anterior se vuelve clave foranea
ALTER TABLE alumnos ADD CONSTRAINT fk_carreras_alumnos
FOREIGN KEY (major) REFERENCES testdb.carreras(idcarrera)
/* alguna parte del codigo anterior me envia un error de definicion de variable
no se porque, pero aun asi se ejecuta y funciona como queria*/
;
--Se ingresan las clave de las carreras a la tabla alumnos
UPDATE alumnos SET major= 2001 WHERE carrera= "Programacion";
UPDATE alumnos SET major= 2002 WHERE carrera= "Mecatronica"; 

--Se elimina la columna noralizada
ALTER  TABLE alumnos drop carrera;

--Cambiar el nombre de la columna agregada al normalizar
ALTER  TABLE alumnos RENAME COLUMN major TO carrera;

--Se crea una tabla para la columna becas que genera redundancias 
CREATE TABLE becados (
    statbeca INT AUTO_INCREMENT,
    becas CHAR(20),
    PRIMARY KEY(statbeca)
)
AUTO_INCREMENT= 3000;

-- Se insertan los tipo de beca existentes en la tabla
INSERT INTO becados (becas) SELECT DISTINCT beca FROM alumnos;

--Se crea un nuevo campo en la tabla alumnos
ALTER TABLE alumnos ADD statusbeca INT NULL DEFAULT 3002;

--Se actualiza el campo recien creado con el valor statbeca
UPDATE alumnos SET statusbeca= 3000 WHERE beca= "Deportiva";
UPDATE alumnos SET statusbeca= 3001 WHERE beca= "Academica";

--Se crea la clave foranea para las becas
ALTER TABLE alumnos ADD CONSTRAINT fk_becados_alumnos
FOREIGN KEY (statusbeca) REFERENCES testdb.becados(statbeca);

--Se elimina la tabla becas que generaba conflicto
ALTER TABLE alumnos DROP COLUMN beca;

--Se crea una tabla materias para las columnas clase que generan redundancias
create TABLE materias(
    idmateria INT NOT NULL AUTO_INCREMENT,
    materia CHAR(20) UNIQUE,
    PRIMARY KEY(idmateria)   
)
AUTO_INCREMENT= 4000;

--Se crea una tabla auxiliar
CREATE TABLE aux (
    aux1 INT(50),
    aux2 CHAR(50),
    aux3 VARCHAR(50)
);

--Se ingresan los datos de los campos clase a la tabla auxiliar
INSERT into aux(aux2) SELECT clase1 FROM alumnos; 
INSERT into aux(aux2) SELECT clase2 FROM alumnos; 

--Se ingresan los datos la tabla materias
INSERT INTO materias (materia) SELECT DISTINCT aux2 FROM aux;

--Se crea una tabla secundaria para relacionar materias con alumnos
CREATE TABLE rolclase(
    idrol INT,
    idalumn INT,
    idmat INT
);

--Se ingresa la relacion alumno-materia a dicha tabla
insert into rolclase (idalumn, idmat) Select alumnos.id, materias.idmateria from alumnos JOIN materias WHERE (
alumnos.clase1= materias.materia OR alumnos.clase2= materias.materia);

--Se crean las claves foraneas referenciando materias y alumnos
ALTER TABLE rolclase ADD CONSTRAINT fk_alumnos_rolclase
FOREIGN KEY (idalumn) REFERENCES testdb.alumnos(id);
ALTER TABLE rolclase ADD CONSTRAINT fk_materias_rolclase
FOREIGN KEY (idmat) REFERENCES testdb.materias(idmateria);
