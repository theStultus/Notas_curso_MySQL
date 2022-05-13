CREATE DATABASE testdb;

USE testdb;
--Crea una tabla principal
CREATE TABLE IF NOT EXISTS `log`(
    itemid INT NOT NULL AUTO_INCREMENT,
    itemname CHAR(15) NULL DEFAULT "Freshmeat",
    class CHAR(15) NULL DEFAULT "Pending",
    `description` CHAR (50) DEFAULT "Pending",
    PRIMARY KEY (itemid) 
-- Asigna el valor de clave principal, se coloca en esta area para limpieza de codigo
);

-- Crea una tabla secundaria, subordinada a la tabla principal mediante el la columna useditem
CREATE TABLE IF NOT EXISTS assigments(
    deedid INT NOT NULL AUTO_INCREMENT,
    deedname CHAR(20) NULL DEFAULT "Outing",
    deedon DATE NOT NULL,
    useditem INT NOT NULL,
    `status` CHAR(15) NULL DEFAULT "Pending",
    PRIMARY KEY (deedid),
--Se define la clave principal de esta tabla, se usa coma
    INDEX fk_assigments_log_idx (useditem ASC),
--NO entiendo muy bien que hace este comando
    CONSTRAINT Fk_assigments_log
    FOREIGN KEY (useditem) REFERENCES testdb.log (itemid)
    ON DELETE NO ACTION 
--Creacion de la clave foranea y su referencia
);

--Eliminar clave foranea
ALTER TABLE assigments DROP FOREIGN KEY fk_assigments_log;

--Crear clave foranea
ALTER TABLE assigments ADD CONSTRAINT fk_assigments_log 
    FOREIGN KEY (useditem) REFERENCES testdb.log(itemid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
;

--Crear clave foranea con eliminacion en cascada
/*Al eliminar un registro en la tabla principal
los registros subordinados en la tabla secundaria tambien se eliminan*/
ALTER TABLE assigments ADD CONSTRAINT fk_assigments_log 
    FOREIGN KEY (useditem) REFERENCES testdb.log(itemid)
    ON DELETE CASCADE
;

--Creal clave foranea con sustitucion de registro referenciado
/*Al eliminar un registro de la tabla principal, el dato subordinado en la tabla secundaria
es sustituido por el valor NULL, conservando el resto del registro.
Es necesario habilitar a la columna para aceptar valores NULL*/   
ALTER TABLE assigments ADD CONSTRAINT fk_asssigments_log
    FOREIGN KEY (useditem) REFERENCES testdb.log(itemid)
    ON DELETE SET NULL
;

--Insertar datos usando una variable
INSERT INTO `log` (itemname, class, `description`) 
VALUES ("a", "b", "c")
;

SET @itemid= last_insert_id()
;
--Se crea la variable y se le asigna el valor del ultimo registro de identidad (autoincrement)

INSERT INTO assigments (deedname, deedon, useditem, `status`)
VALUES ("x", DATE(), @itemid, "void")

/*En este ejemplo este tipo de insercion no tiene sentido porque, aunque las tablas estan relacionadas, 
los registro son independientes unos de otros y no necesitan acerse al mismo tiempo. 
Este tipo de registro sera util cuando se tengan que ingresar datos al mismo tiempo en 2 tablas*/
;

--Consulta de 2 tablas usando JOIN, no se requiere que las tablas esten relacionadas por KEYS
SELECT * FROM assigments JOIN `log` ON aasigments.useditem= log.itemid;

--Consulta de 2 tablas usando JOIN conespecificaciones ligeramente mas complejas
SELECT assigments.deedname, assigments.status, log.itemname FROM
assigments JOIN `log` ON assigments.useditem= log.itemid WHERE
assigments.deeon= 12/25/1990;

--Sintaxis del comando CAST convierte un dato de acuerdo a un tipo de dato proporcionado
SELECT CAST(momento AS TIME) FROM reportes;

--Sintaxis del comando CONVERT
SELECT CONVERT(momento, TIME) from reportes;

--Comandos SIGNED y UNSIGNED cambian las propiedades del signo
