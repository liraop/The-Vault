CREATE OR REPLACE TYPE professor_type AS OBJECT (
  id_professor INTEGER,
  nome VARCHAR2(15)
);

CREATE OR REPLACE TYPE sala_type AS OBJECT (
  id_sala INTEGER,
  codigo VARCHAR2(8),
  capacidade INTEGER
);

CREATE OR REPLACE TYPE disciplina_type AS OBJECT (
  id_disciplina INTEGER,
  nome VARCHAR2(60),
  sigla VARCHAR(10),
  area VARCHAR2(20),
  cargaHoraria INTEGER,
  creditos INTEGER
);

CREATE OR REPLACE TYPE curso_type AS OBJECT (
  id_curso INTEGER,
  nome VARCHAR2(45)
);

CREATE OR REPLACE TYPE turma_type AS OBJECT (
  id_disciplina REF disciplina_type ,
  id_professor REF professor_type ,
  id_curso REF curso_type ,
  id_sala REF sala_type,
  periodo VARCHAR2(10),
  quantidadeAlunos INTEGER,
  mediaTurma DOUBLE PRECISION,
  cogTurma INTEGER
);
