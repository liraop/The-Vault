--1a

SELECT D.nome, COUNT(DISTINCT F.id_professor) as QTD_PROF
FROM fat_alocacao F
INNER JOIN dim_disciplina D
ON (F.id_disciplina = D.id_disciplina)
GROUP BY D.nome
ORDER BY QTD_PROF
DESC;

--1b
SELECT DISTINCT nome
FROM fat_alocacao F
INNER JOIN dim_professor
ON (F.id_professor = dim_professor.id_professor)
WHERE NOT EXISTS(SELECT * FROM fat_alocacao WHERE id_curso = 2 AND id_professor = F.id_professor)
ORDER BY nome
ASC;

--1c
SELECT P.nome, AVG(D.carga) as MEDIA_CH
FROM fat_alocacao F
INNER JOIN dim_disciplina D
      ON F.id_disciplina = D.id_disciplina
INNER JOIN dim_professor P
      ON F.id_professor = P.id_professor
GROUP BY P.nome
ORDER BY MEDIA_CH
DESC
FETCH FIRST 5 ROWS ONLY;;

--1d
SELECT DISTINCT nome
FROM fat_alocacao F
INNER JOIN dim_professor
ON (F.id_professor = dim_professor.id_professor)
WHERE ((F.id_curso = 2 OR F.id_curso = 1) AND dim_professor.id_professor = F.id_professor)
ORDER BY nome
ASC;

--1e
SELECT S.codigo, COUNT(*) AS COUNT_SALA
FROM fat_alocacao F
INNER JOIN dim_sala S
      ON F.id_sala = S.id_sala
GROUP BY S.codigo
ORDER BY COUNT_SALA
DESC
FETCH FIRST 5 ROWS ONLY;

--1f
SELECT D.nome, COUNT(*) AS QTD_TURMAS
FROM fat_alocacao F
INNER JOIN dim_disciplina D
      ON F.id_disciplina = D.id_disciplina
GROUP BY D.nome
ORDER BY QTD_TURMAS
DESC
FETCH FIRST 5 ROWS ONLY;

--1g
SELECT P.nome, COUNT(UNIQUE F.id_disciplina) AS DISC_PROF
FROM fat_alocacao F
INNER JOIN dim_professor P
ON F.id_professor = P.id_professor
GROUP BY P.nome
ORDER BY DISC_PROF
DESC
FETCH FIRST 5 ROWS ONLY;
