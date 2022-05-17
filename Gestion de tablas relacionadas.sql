--Comando IGNORE y REPLACE
/*El uso de estos comandos es muy situacional, pues requiere de conocer de ante mano los valores que existen
para no duplicarlos?. se supone que ayuda en INSERT muy largos y automatizados*/
INSERT IGNORE INTO tabla (PK, column) VALUES (n, "data");

REPLACE INTO tabla (PK, column) VALUES (n, "data");  

--???
SET @curso= "java";
INSERT INTO cursos(curso) SELECT (@curso) FROM DUAL WHERE
NOT EXISTS(SELECT curso FROM cursos WHERE curso= @curso LIMIT 1);
SELECT FROM cursos;

--Ingresar regsitro en 3 tablas simultaneamente
SET @id= 0;
SET @curso= "java";
SET @idcurso= 0;

INSERT INTO estudiantes (nombre, telefono, direccion) VALUES(
    "Yadhira", 555512346, "zona 1");
SET @id= last_insert_id();

INSERT INTO cursos(curso) SELECT (@curso) FROM
DUAL WHERE NOT EXISTS (SELECT curso FROM cursos WHERE curso= @curso LIMIT 1);

SELECT @idcurso:= idcurso FROM cursos WHERE curso= @curso;

INSERT INTO student_curso (idcurso, idstudent) VALUES (@idcurso, @id);

--Consulta de 3 tablas relacionadas 
SELECT * FROM rolclase JOIN alumnos ON 
rolclase.idalumn= alumnos.id INNER JOIN materias ON
rolclase.idmat= materias.idmateria;

--Crear nuevo usuario para la DB
CREATE USER 'nuevo'@'localhost'IDENTIFIED BY 'password';

--Eliminar usuario de la DB
DROP USER 'nuevo'@'localhost';