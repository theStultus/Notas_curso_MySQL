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

--Se insertan los cursosque existen y los junto con los alumnos que los cursan

INSERT INTO clases (nomclas, idalumn) VALUES (

)


/*3FN (tercera Forma Normal )
-1 Comprueba sependencias transitivas 
- Los campos que no tienen una dependencia funcional con la tabla se separan

Los ejemplos de su uso en el curso me parecieron absurdo e inimplementable en tablas con
mas de un dato.
Voy a investigar como resolver la normalizacion de manera mas eficiente*/

