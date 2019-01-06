--------------------------------------------------------
-- Archivo creado  - domingo-enero-06-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package PKG_USUARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "TRABAJOTERMINAL"."PKG_USUARIO" AS
    c_uno NUMBER := 1;
    c_cero NUMBER := 0;
    c_nuno NUMBER :=-1;
    c_dos NUMBER := 2;
    c_tres NUMBER := 3;
    
    
/*insertar un nuevo usuario*/
    PROCEDURE ins_usuario (
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    );
/*obtener usuario por usuario contraseña*/

    PROCEDURE sel_usuario (
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_cursor       OUT SYS_REFCURSOR,
        p_bandera      OUT NUMBER
    );
  /*Este procedimiento se encarga de eliminar un usuario en caso de ser requerido*/

    PROCEDURE del_usuario (
        p_usuario   IN VARCHAR2,
        p_bandera   OUT NUMBER
    );
    /*Este procedimiento se encarga de activar un usuario en caso de ser requerido*/

    PROCEDURE act_usuario (
        p_usuario   IN VARCHAR2,
        p_bandera   OUT NUMBER
    );
  /*Este procedimiento se encarga de actualizar alguno de los campos de la tabla de usuario*/

    PROCEDURE upd_usuario (
        p_usuario      IN VARCHAR2,
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    );
  /*Funcion para validar el correo electronico en busca de coincidencias*/

    FUNCTION validar_correo (
        p_correo VARCHAR2
    ) RETURN NUMBER;
    
    /*Procedimiento para agregar un nuevo usuario al sistema*/

    PROCEDURE nuevo_usuario (
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo2       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    );
    
    /*Procedimientos para obtener los datos generales del usuario sin necesidad de tener un unicio de sesion*/
    PROCEDURE sel_usuario_correo (
        p_correo       IN VARCHAR2,
        p_cursor       OUT SYS_REFCURSOR,
        p_bandera      OUT NUMBER
    );

END pkg_usuario;

/
--------------------------------------------------------
--  DDL for Package PKG_PREGUNTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "TRABAJOTERMINAL"."PKG_PREGUNTA" IS
    c_uno NUMBER := 1;
    c_cero NUMBER := 0;
    c_nuno NUMBER :=-1;
    c_dos NUMBER := 2;
    c_tres NUMBER := 3;
    c_cincuenta NUMBER := 50;
    c_rango_ini VARCHAR2(50) := '1,10';
    PROCEDURE ins_pregunta (
        p_cuestionario   IN NUMBER,
        p_descripcion    IN VARCHAR2,
        p_tipo           IN NUMBER,
        p_clase          IN NUMBER,
        p_orden          IN NUMBER,
        p_obligado       IN NUMBER,
        p_resultado      OUT NUMBER
    );

    PROCEDURE upd_pregunta (
        p_pregunta       IN NUMBER,
        p_cuestionario   IN NUMBER,
        p_descripcion    IN VARCHAR2,
        p_tipo           IN NUMBER,
        p_clase          IN NUMBER,
        p_orden          IN NUMBER,
        p_obligado       IN NUMBER,
        p_tamano         IN NUMBER,
        p_estado         IN NUMBER,
        p_rango          IN VARCHAR2,
        p_resultado      OUT NUMBER
    );

    PROCEDURE sel_preguntas (
        p_pregunta       IN NUMBER,
        p_cuestionario   IN NUMBER,
        p_clase          IN NUMBER,
        p_resultado      OUT SYS_REFCURSOR,
        p_bandera        OUT NUMBER
    );

    PROCEDURE sel_tipos (
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    );

    PROCEDURE sel_u_pregunta (
        p_pregunta    IN NUMBER,
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    );

END;

/
--------------------------------------------------------
--  DDL for Package PKG_OPCION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "TRABAJOTERMINAL"."PKG_OPCION" IS
    c_uno NUMBER := 1;
    c_cero NUMBER := 0;
    c_nuno NUMBER :=-1;
    c_dos NUMBER := 2;
    c_tres NUMBER := 3;
    c_cincuenta NUMBER := 50;
    PROCEDURE ins_opcion (
        p_pregunta      IN NUMBER,
        p_descripcion   IN VARCHAR2,
        p_orden         IN NUMBER,
        p_resultado     OUT NUMBER
    );

    PROCEDURE upd_opcion (
        p_opcion        IN NUMBER,
        p_descripcion   IN VARCHAR2,
        p_orden         IN NUMBER,
        p_estado        IN NUMBER,
        p_resultado     OUT NUMBER
    );

    PROCEDURE sel_opcion (
        p_opcion      IN NUMBER,
        p_pregunta    IN NUMBER,
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    );

END;

/
--------------------------------------------------------
--  DDL for Package PKG_CUESTIONARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "TRABAJOTERMINAL"."PKG_CUESTIONARIO" IS
    c_uno NUMBER := 1;
    c_cero NUMBER := 0;
    c_nuno NUMBER :=-1;
    c_dos NUMBER := 2;
    c_tres NUMBER := 3;
    PROCEDURE ins_cuestionario (
        p_usuario       IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_fecha_fin     IN DATE DEFAULT NULL,
        p_contrasena    IN VARCHAR2 DEFAULT NULL,
        p_resultado     OUT NUMBER
    );

    PROCEDURE sel_cuestionario (
        p_cuestionario   IN NUMBER,
        p_usuario        IN NUMBER,
        p_cursor         OUT SYS_REFCURSOR,
        p_bandera        OUT NUMBER
    );

    PROCEDURE upd_cuestionario (
        p_cuestionario   IN NUMBER,
        p_usuario        IN NUMBER,
        p_nombre         IN VARCHAR2,
        p_descripcion    IN VARCHAR2,
        p_fecha_fin      IN DATE DEFAULT NULL,
        p_estado         IN NUMBER,
        p_contrasena     IN VARCHAR2 DEFAULT NULL,
        p_resultado      OUT NUMBER
    );
    
     
     

END pkg_cuestionario;

/
--------------------------------------------------------
--  DDL for Package PKG_CONSULTAS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "TRABAJOTERMINAL"."PKG_CONSULTAS" IS
    c_cero NUMBER := 0;
    c_uno NUMBER := 1;
    /*Esta cadena se encarga de obtener las opciones de cierta pregunta*/
    PROCEDURE gen_cuestionario (
        p_usuario        IN NUMBER,
        p_cuestionario   IN NUMBER,
        p_clase          IN NUMBER,
        p_respuesta      OUT SYS_REFCURSOR,
        p_res            OUT NUMBER
    );

END pkg_consultas;

/
