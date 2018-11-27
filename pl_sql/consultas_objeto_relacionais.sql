--1a
SELECT ((DEREF (a.id_disciplina)).nome), COUNT(DISTINCT DEREF(a.id_professor).nome) as QTD_PROF
FROM fat_obj_tab_alocacao a
GROUP BY ((DEREF (a.id_disciplina)).nome)
ORDER BY QTD_PROF
DESC;
/
--1b
SELECT DISTINCT DEREF(A.id_professor).nome AS NOME
FROM fat_obj_tab_alocacao A
WHERE NOT EXISTS(SELECT DEREF(B.id_professor).nome FROM fat_obj_tab_alocacao B WHERE DEREF(B.id_curso).id_curso = 2 AND DEREF(B.id_professor).nome = DEREF(A.id_professor).nome)
ORDER BY NOME
ASC;
/
--1c

SELECT * FROM(
SELECT DEREF(A.id_professor).nome, AVG(DEREF(A.id_disciplina).cargaHoraria) AS MEDIA_CH
FROM fat_obj_tab_alocacao A
GROUP BY DEREF(A.id_professor).nome
ORDER BY MEDIA_CH
DESC)
WHERE ROWNUM <= 5;
/
--1d
SELECT DISTINCT DEREF(A.id_professor).nome as NOME
FROM fat_obj_tab_alocacao A
WHERE (DEREF(A.id_curso).id_curso = 2)
AND (DEREF(A.id_professor).nome IN (SELECT DEREF(B.id_professor).nome FROM fat_obj_tab_alocacao B WHERE DEREF(B.id_curso).id_curso = 1))
ORDER BY NOME
ASC;

--1e
SELECT *
FROM ( SELECT S.codigo, COUNT(*) AS COUNT_SALA
FROM fat_alocacao F
INNER JOIN dim_sala S
      ON F.id_sala = S.id_sala
GROUP BY S.codigo
ORDER BY COUNT_SALA
DESC)
WHERE ROWNUM <= 5;
/
--1f
SELECT *
FROM (SELECT D.nome, COUNT(*) AS QTD_TURMAS
FROM fat_alocacao F
INNER JOIN dim_disciplina D
      ON F.id_disciplina = D.id_disciplina
GROUP BY D.nome
ORDER BY QTD_TURMAS
DESC)
WHERE ROWNUM <= 5;
/
--1g
SELECT *
FROM (SELECT P.nome, COUNT(UNIQUE F.id_disciplina) AS DISC_PROF
FROM fat_alocacao F
INNER JOIN dim_professor P
ON F.id_professor = P.id_professor
GROUP BY P.nome
ORDER BY DISC_PROF
DESC)
WHERE ROWNUM <= 5;
/
