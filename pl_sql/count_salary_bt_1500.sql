DECLARE
 empregados_maior_1500 INTEGER;
BEGIN
 SELECT COUNT(*)
 INTO empregados_maior_1500
 FROM employees
 WHERE salary > 1500;

 IF (empregados_maior_1500 > 0) THEN dbms_output.put_line(empregados_maior_1500);
 ELSE null;
 END IF;

END;
