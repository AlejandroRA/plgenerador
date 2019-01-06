--------------------------------------------------------
-- Archivo creado  - domingo-enero-06-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRI_USUARIO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_USUARIO" 
   before insert on "TRABAJOTERMINAL"."T_USUARIO" 
   for each row 
begin  
   if inserting then 
      if :NEW."PK_USUARIO" is null then 
         select SQ_USUARIO.nextval into :NEW."PK_USUARIO" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_USUARIO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRI_PREGUNTA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_PREGUNTA" 
   before insert on "TRABAJOTERMINAL"."T_PREGUNTA" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_PREGUNTA" is null then 
         select SQ_PREGUNTA.nextval into :NEW."ID_PREGUNTA" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_PREGUNTA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRI_OPCION
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_OPCION" 
   before insert on "TRABAJOTERMINAL"."T_OPCION" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_OPCION" is null then 
         select SQ_OPCION.nextval into :NEW."ID_OPCION" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_OPCION" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRI_GENERO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_GENERO" 
   before insert on "TRABAJOTERMINAL"."T_GENERO" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_GENERO" is null then 
         select SQ_GENERO.nextval into :NEW."ID_GENERO" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_GENERO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRI_CUESTIONARIO
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_CUESTIONARIO" 
   before insert on "TRABAJOTERMINAL"."T_CUESTIONARIO" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_CUESTIONARIO" is null then 
         select S_CUESTIONARIO.nextval into :NEW."ID_CUESTIONARIO" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_CUESTIONARIO" ENABLE;
