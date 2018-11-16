ALTER TABLE dim_obj_tab_sala
  ADD CONSTRAINT pk_sala PRIMARY KEY (id_sala);
/
ALTER TABLE dim_obj_tab_professor
  ADD CONSTRAINT pk_professor PRIMARY KEY (id_professor);
/
ALTER TABLE dim_obj_tab_disciplina
  ADD CONSTRAINT pk_disciplina PRIMARY KEY (id_disciplina);
/
ALTER TABLE dim_obj_tab_curso
  ADD CONSTRAINT pk_curso PRIMARY KEY (id_curso);
/
ALTER TABLE  fat_obj_tab_alocacao
 ADD CONSTRAINT tab_disciplina_fk FOREIGN KEY (id_disciplina) REFERENCES dim_obj_tab_disciplina;
/
ALTER TABLE  fat_obj_tab_alocacao
 ADD CONSTRAINT tab_professor_fk FOREIGN KEY (id_professor) REFERENCES dim_obj_tab_professor;
/
ALTER TABLE  fat_obj_tab_alocacao
 ADD CONSTRAINT tab_curso_fk FOREIGN KEY (id_curso) REFERENCES dim_obj_tab_curso;
 /
ALTER TABLE  fat_obj_tab_alocacao
    ADD CONSTRAINT tab_sala_fk FOREIGN KEY (id_sala) REFERENCES dim_obj_tab_sala;
/
