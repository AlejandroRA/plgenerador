--------------------------------------------------------
-- Archivo creado  - sábado-febrero-09-2019   
--------------------------------------------------------
DROP TRIGGER "TRABAJOTERMINAL"."TRI_CUESTIONARIO";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_GENERO";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_OPCION";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_PREGUNTA";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_RESPUESTA";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_USER";
DROP TRIGGER "TRABAJOTERMINAL"."TRI_USUARIO";
--------------------------------------------------------
--  DDL for Sequence S_CUESTIONARIO
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."S_CUESTIONARIO"  MINVALUE 1 MAXVALUE 100000000000000 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_GENERO
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_GENERO"  MINVALUE 1 MAXVALUE 100000000000000 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_OPCION
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_OPCION"  MINVALUE 1 MAXVALUE 10000000000000 INCREMENT BY 1 START WITH 101 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_PREGUNTA
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_PREGUNTA"  MINVALUE 1 MAXVALUE 10000000000000 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_RESPUESTA
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_RESPUESTA"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 161 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_USER
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_USER"  MINVALUE 1 MAXVALUE 10000 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_USUARIO
--------------------------------------------------------

   CREATE SEQUENCE  "TRABAJOTERMINAL"."SQ_USUARIO"  MINVALUE 1 MAXVALUE 1000000000000000000 INCREMENT BY 1 START WITH 138 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table T_CUESTIONARIO
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_CUESTIONARIO" 
   (	"ID_CUESTIONARIO" NUMBER, 
	"FK_USUARIO" NUMBER, 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"FECHA_CREACION" DATE, 
	"FECHA_MODIFICACION" DATE, 
	"FECHA_FIN" DATE, 
	"ESTADO" NUMBER, 
	"CONTRASENA" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_GENERO
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_GENERO" 
   (	"ID_GENERO" NUMBER, 
	"DESCRIPCION" VARCHAR2(50 BYTE), 
	"ESTADO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_OPCION
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_OPCION" 
   (	"ID_OPCION" NUMBER, 
	"FK_PREGUNTA" NUMBER, 
	"DESCRIPCION" VARCHAR2(100 BYTE), 
	"ORDEN" NUMBER, 
	"ESTADO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_PREGUNTA
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_PREGUNTA" 
   (	"ID_PREGUNTA" NUMBER, 
	"FK_CUESTIONARIO" NUMBER, 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"TIPO" NUMBER, 
	"CLASE" NUMBER, 
	"ESTADO" NUMBER, 
	"ORDEN" NUMBER, 
	"TAMANO" NUMBER, 
	"OBLIGADO" NUMBER, 
	"RANGO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_RESPUESTA
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_RESPUESTA" 
   (	"ID_RESPUESTA" NUMBER, 
	"FK_PREGUNTA" NUMBER, 
	"FK_USER" NUMBER, 
	"RESPUESTA" VARCHAR2(2000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_USER
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_USER" 
   (	"ID_USER" NUMBER, 
	"FECHA" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table T_USUARIO
--------------------------------------------------------

  CREATE TABLE "TRABAJOTERMINAL"."T_USUARIO" 
   (	"PK_USUARIO" NUMBER, 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APATERNO" VARCHAR2(50 BYTE), 
	"AMATERNO" VARCHAR2(50 BYTE), 
	"CORREO" VARCHAR2(50 BYTE), 
	"CONTRASENA" VARCHAR2(50 BYTE), 
	"ESTADO" NUMBER, 
	"GENERO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
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
--  DDL for Trigger TRI_RESPUESTA
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_RESPUESTA" 
   before insert on "TRABAJOTERMINAL"."T_RESPUESTA" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_RESPUESTA" is null then 
         select SQ_RESPUESTA.nextval into :NEW."ID_RESPUESTA" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_RESPUESTA" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRI_USER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "TRABAJOTERMINAL"."TRI_USER" 
   before insert on "TRABAJOTERMINAL"."T_USER" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID_USER" is null then 
         select SQ_USER.nextval into :NEW."ID_USER" from dual; 
      end if; 
   end if; 
end;

/
ALTER TRIGGER "TRABAJOTERMINAL"."TRI_USER" ENABLE;
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
--  DDL for Synonymn DUAL
--------------------------------------------------------

  CREATE OR REPLACE PUBLIC SYNONYM "DUAL" FOR "SYS"."DUAL";
