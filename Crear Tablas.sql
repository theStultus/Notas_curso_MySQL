#Crear una tabla dentro de la DB
USE test_db;
#Para indicar en que DB se creara la tabla
CREATE TABLE `Log` (
#El nombre de la tabla entre `` porque es igual a un comando
	id INT(10) NOT NULL AUTO_INCREMENT,
	Nick CHAR(15) NULL DEFAULT "Anon",
	`Description` CHAR(40) NULL DEFAULT "Void",
	PRIMARY KEY (`id`) USING BTREE
#Al parecer el primary key se debe colocar al final, USING BTREE es desconocido  
	)
AUTO_INCREMENT=1;
#Indica en que valor comenzara

CREATE TABLE if NOT EXISTS  places (
#Esta esuna manera de prevenir crear tablas ya existentes
	placeid INT(10) PRIMARY KEY AUTO_INCREMENT,
#Al parecer tambien es correcto de este modo
	placename CHAR(20) NOT NULL 
	)
AUTO_INCREMENT=1;

#Eliminar tablas 
DROP TABLE `log`;
DROP TABLE if EXISTS `places`;
#Para asegurarse supongo

#Renombrar una tabla
ALTER TABLE places RENAME place;

#Agregar columnas a la tabla
ALTER TABLE place ADD `status` CHAR(10) NULL DEFAULT "Offline";

#Eliminar columna que se ingreso mal
ALTER TABLE place DROP COLUMN statu;

#Agregar columnas en lugares especificos
ALTER TABLE `log` ADD Class CHAR(15) NULL DEFAULT "Pending" AFTER Nick;
#Despues de la columna especificada
ALTER TABLE `log` ADD Class CHAR(15) NULL DEFAULT "Pending" FIRST;
#Al principio de la tabla

#Cambiar el nombre de una columna
ALTER TABLE place CHANGE COLUMN `placename` `Stage` CHAR(20);

#Cambiar el nombre y el tipo de dato de una columna
ALTER TABLE place MODIFY `status` INT(5);
#Tener cuidado con los cambiosde tipo de dato, puede llevar a perdidas de datos.	

#Para quitar la llave categoria de clave principal a una columna
ALTER TABLE `log` MODIFY `id` INT(8) UNSIGNED;
#Primero eliminar la "Identidad"; el valor predeterminado
ALTER TABLE `log` DROP PRIMARY KEY;
#Esta sentence no se puede ejecutar sin antes eliminar la "identidad" 

#Agregar clave principal
ALTER TABLE `log` ADD PRIMARY KEY (id);
ALTER TABLE `log` MODIFY `id` INT(8) AUTO_INCREMENT; 
#Se pueden ejecutar ambas sentences en la misma query, no se si se pueda ejecutar en una misma sentence

#Insertar datos en las tablas
INSERT INTO place (Stage, `status`) VALUES ("Main hub", "Online");
INSERT INTO place (Stage, `status`) VALUES ("Downtown", "Online");
INSERT INTO place (Stage, `status`) VALUES ("ColRef", "Reparis");
#Se pueden ingresar vasrios registros en una misma query!
#Se deben espacificar siempre las columnas cuando exista una clave principal, para no ingresar datos ahi.
#El orden en el que se ingresan los datos es vital, se debe tener cuidado con ello.
#Respetar los tipos de datos y los valores validos para cada campo (columna), no hacerlo puede causar errores.

#Consultar datos de la tabla `place` usando Aliases para ciertas columnas
SELECT placeid AS "ID", Stage, `status` AS "Status" FROM place;

#Eliminar TODOS los registros de una tabla
TRUNCATE TABLE place;

#Reiniciar el autoincremental de una tabla
ALTER TABLE place AUTO_INCREMENT=1;
#No es necesario especificar en que columna esta asignado el autoincremental  

#Crear una tabla auxiliar para copiar temporalmente los datos de otra tabla
CREATE TABLE aux (
	a1 CHAR(20),
	a2 CHAR(20)
);
#Esta tabla es auxiliar de la tabla `place`
#Las tablas auxiliares se usan cuando la tabla principal necesita modificaciones y queremos proteger los datos
INSERT INTO aux SELECT Stage, `status` FROM place;
#Se ingresan los datos de la tabla principal

#Consultar los datos de una tabla.
#Muchas (o quiza todas) las formas de filtrar consultas requieren de operadores logicos y logica booleana.
#Considerar la manera de funcionar de los operadores logicos y las tablas de verdad.
SELECT * FROM place;
#Consulta todos los datos
SELECT Stage FROM place;
#Consulta columna(s) especificada(s)
SELECT * FROM place WHERE `status` = "Repairs";
#Consulta de acuerdo a una condicion
SELECT * FROM `log` WHERE `Description` LIKE "%Useful%";
#Consulta filtrando datos de acuerdo a valores string
SELECT * FROM `log` WHERE `Exp` BETWEEN 0 AND 3;
#Consulta filtrando a partir de un rango de valores
SELECT * FROM `log` WHERE `Class` IN ("Top", "Dom", "Sub");
#Consulta filtrando registros de a cuerdo a una seleccion de valores
SELECT * FROM place WHERE `status`="Offline" OR `status`="Repairs";
#Consulta filtrando registros que cumplan al menos una condicion
SELECT * FROM `log` WHERE `Class`= "Top" AND `Exp`>5;
#Consulta filtrando registros que cumplan TODAS condiciones
SELECT * FROM place WHERE NOT `status`= "Offline" OR `status`= "Repairs";
#Usar el comando not para excluir los resultados que cumplan las condiciones (operadores logicos)

#Ordenar resultados de la columna
SELECT * FROM `log` ORDER BY "Exp";
#Order by se puede combina con cualquier tipo de consulta, debera escribirse siempre hasta el final

#Mostrar n numero de resultados
SELECT * FROM place LIMIT 5;
#De manera similar a ORDER BY puede combinarse con muchas consultas

#Actualizar los datos de un registro
UPDATE place SET `status`= "Offline" WHERE placeid=2;
#Cuidar el modo en el que opera UPDATE
 
#Eliminar un registro de la tabla
DELETE FROM place WHERE `status`= "Offline";
#Usar el condicional previene borrar la totalidad de la tabla
#Cuidar la manera peculiar en que el comando DELETE funciona

#Darle un nuevo formato a un dato tipo fecha en la consulta
SELECT `name`, DATE_FORMAT(`date`, '%D/%M/%Y') FROM `resource`;
#El segundo parametro en el parentesis modifica el formato de salida, dependiendo de como se escriba

#Agregar tiempo a una fecha en la consulta
SELECT DATE_ADD(`date`, INTERVAL 5 DAY) FROM `resource`;
#Se pueden agregar dias, meses, años, horas, etc.

#Restar tiempo a una fecha en la consulta
SELECT DATE_SUB(`date`, INTERVAL 5 DAY) FROM `resource`;


 
#https://www.sqlshack.com/es/funciones-y-formatos-de-sql-convert-date/ 


 
 

