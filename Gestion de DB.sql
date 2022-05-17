--Crear nueva base de datos
CREATE DATABASE test_DB;

--El nombre se coloca entre `` cuando es igual a un comando
CREATE DATABASE `LOG`;
--Se usa punto y coma al finalizar la Query

--Verificar si la DB ya existe
SHOW DATABASES LIKE 'test_db'
--Usar simbolos correctos, en este caso '', aqui no se uso ; 

--Eliminar la DB
DROP DATABASE test_DB;

--Collate 
COLLATE= 
--Define la manera de interpretar una cadena de caracteres, el idioma en el que se escribe un texto


--Crear nuevo usuario para la DB
CREATE USER 'nuevo'@'localhost'IDENTIFIED BY 'password';

--Eliminar usuario de la DB
DROP USER 'nuevo'@'localhost';

--Otorgar todos los rpivilegios a usuario
GRANT ALL PRIVILEGES ON *.* TO 'nuevo'@'localhost';

--Retirar los privilegios a usuario
REVOKE ALL PRIVILEGES on *.* FROM 'nuevo'@'localhost';

--Otorgar ciertos privilegios a usuario
/*Se pueden enlistar mas o menos comandos en funcion de que privilegios queremos otorgar*/
GRANT SELECT, INSERT, DELETE, UPDATE, CREATE, DROP ON *.* TO 'nuevo'@'localhost';

--Retirar algunos privilegios a usuario
REVOKE DROP ON *.* TO 'nuevo'@'localhost';

--Mostrar privilegios del usuario
SHOW GRANTS;
SHOW GRANTS FOR CURRENT_USER();

--Crear un rol de usuario para la DB
CREATE ROLE IF NOT EXISTS "nuevorol";
GRANT SELECT, INSERT, UPDATE ON *.* TO 'nuevorol';
--Eliminar rol de DB
DROP ROLE IF EXISTS "nuevorol";

--Asignar/eliminar rol
GRANT 'nuevorol' TO 'nuevo';
REVOKE 'nuevorol' FROM 'nuevo';




  