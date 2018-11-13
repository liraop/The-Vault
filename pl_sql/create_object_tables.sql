CREATE OR REPLACE TABLE dim_obj_tab_sala OF sala_type (
  CONSTRAINT pk_sala PRIMARY KEY (id_sala)
);

CREATE OR REPLACE TABLE dim_obj_tab_professor OF professor_type (
  CONSTRAINT pk_professor PRIMARY KEY (id_professor)
);

CREATE OR REPLACE TABLE dim_obj_tab_disciplina OF disciplina_type (
  CONSTRAINT pk_disciplina PRIMARY KEY (id_disciplina)
);

CREATE OR REPLACE TABLE dim_obj_tab_curso OF curso_type (
  CONSTRAINT pk_curso PRIMARY KEY (id_curso)
);

CREATE OR REPLACE TABLE fat_obj_tab_alocacao OF turma_type (
  CONSTRAINT tab_disciplina_fk FOREIGN KEY (id_disciplina) REFERENCES dim_obj_tab_disciplina,
  CONSTRAINT tab_professor_fk FOREIGN KEY (id_professor) REFERENCES dim_obj_tab_professor,
  CONSTRAINT tab_curso_fk FOREIGN KEY (id_curso) REFERENCES dim_obj_tab_curso,
  CONSTRAINT tab_sala_fk FOREIGN KEY (id_sala) REFERENCES dim_obj_tab_sala
);
