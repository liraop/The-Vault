ALTER TABLE dim_obj_tab_sala
  DROP CONSTRAINT pk_sala;
/
ALTER TABLE dim_obj_tab_professor
  DROP CONSTRAINT pk_professor;
/
ALTER TABLE dim_obj_tab_disciplina
  DROP CONSTRAINT pk_disciplina;
/
ALTER TABLE dim_obj_tab_curso
  DROP CONSTRAINT pk_curso;
/
ALTER TABLE  fat_obj_tab_alocacao
 DROP CONSTRAINT tab_disciplina_fk;
/
ALTER TABLE  fat_obj_tab_alocacao
 DROP CONSTRAINT tab_professor_fk;
/
ALTER TABLE  fat_obj_tab_alocacao
 DROP CONSTRAINT tab_curso_fk;
/
ALTER TABLE  fat_obj_tab_alocacao
 DROP CONSTRAINT tab_sala_fk;
 /
