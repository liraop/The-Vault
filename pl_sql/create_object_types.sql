--2

CREATE OR REPLACE TYPE professor_type AS OBJECT (
  id_professor INTEGER,
  nome VARCHAR2(20)
);

CREATE OR REPLACE TYPE sala_type AS OBJECT (
  id_sala INTEGER,
  codigo VARCHAR2(10),
  capacidade INTEGER
);

CREATE OR REPLACE TYPE disciplina_type AS OBJECT (
  id_disciplina INTEGER,
  nome VARCHAR2(20),
  sigla VARCHAR(10),
  area VARCHAR2(20),
  cargaHoraria INTEGER,
  creditos INTEGER
);

CREATE OR REPLACE TYPE curso_type AS OBJECT (
  id_curso INTEGER,
  nome VARCHAR2(20)
);

CREATE OR REPLACE TYPE turma_type AS OBJECT (
  id_disciplina REF disciplina_type NOT NULL,
  id_professor REF professor_type NOT NULL,
  id_curso REF curso_type NOT NULL,
  id_sala REF sala_type NOT NULL,
  periodo VARCHAR2(10),
  quantidadeAlunos INTEGER,
  mediaTurma DOUBLE PRECISION,
  cogTurma INTEGER
);
