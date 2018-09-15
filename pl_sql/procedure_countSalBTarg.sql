CREATE OR REPLACE PROCEDURE CountSalBTarg(s_arg NUMBER)
IS
 count_sals INTEGER;
BEGIN
 SELECT COUNT(*)
 INTO count_sals
 FROM employees
 WHERE salary > s_arg;

 DBMS_OUTPUT.PUT_LINE(count_sals);
END;
