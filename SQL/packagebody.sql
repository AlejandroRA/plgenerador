--------------------------------------------------------
-- Archivo creado  - domingo-enero-06-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body PKG_USUARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "TRABAJOTERMINAL"."PKG_USUARIO" AS

    PROCEDURE ins_usuario (
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        INSERT INTO t_usuario (
            t_usuario.nombre,
            t_usuario.apaterno,
            t_usuario.amaterno,
            t_usuario.correo,
            t_usuario.contrasena,
            t_usuario.genero,
            t_usuario.estado
        ) VALUES (
            p_nombre,
            p_apaterno,
            p_amaterno,
            upper(p_correo),
            p_contrasena,
            p_genero,
            c_uno
        );

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
            ROLLBACK;
    END;
  /*******************************************************************/

    PROCEDURE sel_usuario (
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_cursor       OUT SYS_REFCURSOR,
        p_bandera      OUT NUMBER
    ) AS
    BEGIN
        p_bandera := c_uno;
        OPEN p_cursor FOR SELECT
                              t_usuario.pk_usuario id,
                              t_usuario.nombre     nombre,
                              t_usuario.apaterno   apaterno,
                              t_usuario.amaterno   amaterno,
                              t_usuario.correo,
                              t_usuario.nombre     nombre,
                              t_usuario.apaterno   apaterno,
                              t_usuario.amaterno   amaterno,
                              t_usuario.correo,
                              t_usuario.contrasena    pass,
                              DECODE (t_usuario.genero, 1, 'MASCULINO', 
                             2, 'FEMENINO') genero,
                             t_usuario.estado estado
                          FROM
                              t_usuario
                          WHERE
                              t_usuario.correo = UPPER(p_correo)
                              AND t_usuario.contrasena = p_contrasena;
                              

        dbms_output.put_line(p_cursor%rowcount);
    EXCEPTION
        WHEN no_data_found THEN
            p_bandera := c_cero;
    END;
  /*******************************************************************/

    PROCEDURE del_usuario (
        p_usuario   IN VARCHAR2,
        p_bandera   OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        UPDATE t_usuario
        SET
            t_usuario.estado = c_cero
        WHERE
            t_usuario.pk_usuario = p_usuario;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;
/*********************************************************************/
    PROCEDURE act_usuario (
        p_usuario   IN VARCHAR2,
        p_bandera   OUT NUMBER
    )IS
    BEGIN
        p_bandera := c_uno;
        UPDATE t_usuario
        SET
            t_usuario.estado = c_uno
        WHERE
            t_usuario.pk_usuario = p_usuario;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;
  /*********************************************************************/

    PROCEDURE upd_usuario (
        p_usuario      IN VARCHAR2,
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo       IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        UPDATE t_usuario
        SET
            t_usuario.nombre = nvl(p_nombre,t_usuario.nombre),
            t_usuario.apaterno = nvl(p_apaterno,t_usuario.apaterno),
            t_usuario.amaterno = nvl(p_amaterno,t_usuario.amaterno),
            t_usuario.correo = nvl(p_correo,upper(t_usuario.correo)),
            t_usuario.contrasena = nvl(p_contrasena,t_usuario.contrasena),
            t_usuario.genero = nvl(p_genero,t_usuario.genero)
            
        WHERE
            t_usuario.pk_usuario = p_usuario;
 
    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;
  /****************************************************************/

    FUNCTION validar_correo (
        p_correo VARCHAR2
    ) RETURN NUMBER IS

        CURSOR us (
            p_correo VARCHAR2
        ) IS SELECT
                 t_usuario.correo,
                 t_usuario.estado
             FROM
                 t_usuario
             WHERE
                 t_usuario.correo = UPPER(p_correo);

        v_correo    t_usuario.correo%TYPE;
        v_estado    t_usuario.estado%TYPE;
        v_test   NUMBER := c_uno;
    BEGIN
        OPEN us(p_correo);
        LOOP
            FETCH us INTO
                v_correo,
                v_estado;
            EXIT WHEN us%notfound;
            IF v_estado = c_cero THEN
                v_test := c_tres;
            END IF;
        END LOOP;
        IF us%rowcount > c_cero AND v_test != c_tres THEN
            v_test := c_dos;
        END IF;
        CLOSE us;
        RETURN v_test;
    END;
    /***************************************************************************/

    PROCEDURE nuevo_usuario (
        p_nombre       IN VARCHAR2,
        p_apaterno     IN VARCHAR,
        p_amaterno     IN VARCHAR2,
        p_correo2      IN VARCHAR2,
        p_contrasena   IN VARCHAR,
        p_genero       IN NUMBER,
        p_bandera      OUT NUMBER
    ) IS
    BEGIN
    /*validar el correo a ingresar*/
        p_bandera := validar_correo(p_correo2);
        DBMS_OUTPUT.PUT_LINE('Resultado: '||P_BANDERA);
        IF p_bandera = c_uno THEN
            ins_usuario(p_nombre => p_nombre,p_apaterno => p_apaterno,p_amaterno => p_amaterno,p_correo => p_correo2,p_contrasena
            => p_contrasena,p_genero => p_genero,p_bandera => p_bandera);

        END IF;

    END;
    
    /*******************************************************************/

    PROCEDURE sel_usuario_correo (
        p_correo       IN VARCHAR2,
        p_cursor       OUT SYS_REFCURSOR,
        p_bandera      OUT NUMBER
    ) AS
    BEGIN
        p_bandera := c_uno;
        OPEN p_cursor FOR SELECT
                              t_usuario.nombre     nombre,
                              t_usuario.apaterno   apaterno,
                              t_usuario.amaterno   amaterno,
                              t_usuario.correo,
                              t_usuario.contrasena    pass,
                              DECODE (t_usuario.genero, 1, 'MASCULINO', 
                             2, 'FEMENINO') genero
                          FROM
                              t_usuario
                          WHERE
                              t_usuario.correo = UPPER(p_correo)
                              AND t_usuario.estado > c_cero;

        dbms_output.put_line(p_cursor%rowcount);
    EXCEPTION
        WHEN no_data_found THEN
            p_bandera := c_cero;
    END;

END pkg_usuario;

/
--------------------------------------------------------
--  DDL for Package Body PKG_PREGUNTA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "TRABAJOTERMINAL"."PKG_PREGUNTA" IS

    PROCEDURE ins_pregunta (
        p_cuestionario   IN NUMBER,
        p_descripcion    IN VARCHAR2,
        p_tipo           IN NUMBER,
        p_clase          IN NUMBER,
        p_orden          IN NUMBER,
        p_obligado       IN NUMBER,
        p_resultado      OUT NUMBER
    ) IS
    BEGIN
        p_resultado := c_uno;
        INSERT INTO t_pregunta (
            t_pregunta.fk_cuestionario,
            t_pregunta.descripcion,
            t_pregunta.tipo,
            t_pregunta.clase,
            t_pregunta.orden,
            t_pregunta.obligado,
            t_pregunta.estado,
            t_pregunta.tamano,
            t_pregunta.rango
        ) VALUES (
            p_cuestionario,
            p_descripcion,
            p_tipo,
            p_clase,
            p_orden,
            p_obligado,
            c_uno,
            c_cincuenta,
            c_rango_ini
        );

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
            ROLLBACK;
    END;

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
    ) IS
    BEGIN
        p_resultado := c_uno;
        UPDATE t_pregunta
        SET
            t_pregunta.descripcion = nvl(p_descripcion,t_pregunta.descripcion),
            t_pregunta.tipo = nvl(p_tipo,t_pregunta.tipo),
            t_pregunta.clase = nvl(p_clase,t_pregunta.clase),
            t_pregunta.orden = nvl(p_orden,t_pregunta.orden),
            t_pregunta.obligado = nvl(p_obligado,t_pregunta.obligado),
            t_pregunta.tamano = nvl(p_tamano,t_pregunta.tamano),
            t_pregunta.estado = nvl(p_estado,t_pregunta.estado),
            t_pregunta.rango = nvl(p_rango,t_pregunta.rango)
        WHERE
            t_pregunta.id_pregunta = p_pregunta
            AND t_pregunta.fk_cuestionario = nvl(p_cuestionario,t_pregunta.fk_cuestionario);

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
            ROLLBACK;
    END;

    PROCEDURE sel_preguntas (
        p_pregunta       IN NUMBER,
        p_cuestionario   IN NUMBER,
        p_clase          IN NUMBER,
        p_resultado      OUT SYS_REFCURSOR,
        p_bandera        OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        OPEN p_resultado FOR SELECT
                                 t_pregunta.id_pregunta,
                                 t_pregunta.fk_cuestionario,
                                 t_pregunta.descripcion,
                                 t_pregunta.tipo       tipo_p,
                                 t_pregunta.clase      clase_p,
                                 t_pregunta.orden,
                                 t_pregunta.obligado,
                                 t_pregunta.estado,
                                 t_pregunta.tamano,
                                 c_tipo.descripcion    tipo,
                                 c_clase.descripcion   clase,
                                 t_pregunta.rango
                             FROM
                                 t_pregunta,
                                 c_clase,
                                 c_tipo
                             WHERE
                                 t_pregunta.id_pregunta = nvl(p_pregunta,t_pregunta.id_pregunta)
                                 AND t_pregunta.fk_cuestionario = nvl(p_cuestionario,t_pregunta.fk_cuestionario)
                                 AND t_pregunta.clase = nvl(p_clase,t_pregunta.clase)
                                 AND t_pregunta.tipo = c_tipo.id_tipo
                                 AND t_pregunta.clase = c_clase.id_clase
                                 AND t_pregunta.estado > c_cero
                             ORDER BY
                                 orden ASC,
                                 t_pregunta.descripcion DESC;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;

    PROCEDURE sel_tipos (
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        OPEN p_resultado FOR SELECT
                                 *
                             FROM
                                 c_tipo;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;

    PROCEDURE sel_u_pregunta (
        p_pregunta    IN NUMBER,
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        OPEN p_resultado FOR SELECT
                                 t_pregunta.id_pregunta,
                                 t_pregunta.fk_cuestionario,
                                 t_pregunta.descripcion,
                                 t_pregunta.tipo       tipo_p,
                                 t_pregunta.clase      clase_p,
                                 t_pregunta.orden,
                                 t_pregunta.obligado,
                                 t_pregunta.estado,
                                 t_pregunta.tamano,
                                 c_tipo.descripcion    tipo,
                                 c_clase.descripcion   clase,
                                 t_pregunta.rango
                             FROM
                                 t_pregunta,
                                 c_clase,
                                 c_tipo
                             WHERE
                                 t_pregunta.id_pregunta = nvl(p_pregunta,t_pregunta.id_pregunta)
                             --    AND t_pregunta.fk_cuestionario = nvl(p_cuestionario,t_pregunta.fk_cuestionario)
                                -- AND t_pregunta.clase = nvl(p_clase,t_pregunta.clase)
                                 AND t_pregunta.tipo = c_tipo.id_tipo
                                 AND t_pregunta.clase = c_clase.id_clase
                                 AND t_pregunta.estado > c_cero
                             ORDER BY
                                 orden ASC,
                                 t_pregunta.descripcion DESC;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;

END;

/
--------------------------------------------------------
--  DDL for Package Body PKG_OPCION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "TRABAJOTERMINAL"."PKG_OPCION" IS

    PROCEDURE ins_opcion (
        p_pregunta      IN NUMBER,
        p_descripcion   IN VARCHAR2,
        p_orden         IN NUMBER,
        p_resultado     OUT NUMBER
    ) IS
    BEGIN
        p_resultado := c_uno;
        INSERT INTO t_opcion (
            t_opcion.fk_pregunta,
            t_opcion.descripcion,
            t_opcion.orden,
            t_opcion.estado
        ) VALUES (
            p_pregunta,
            p_descripcion,
            p_orden,
            c_uno
        );

    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
    END;

    PROCEDURE upd_opcion (
        p_opcion        IN NUMBER,
        p_descripcion   IN VARCHAR2,
        p_orden         IN NUMBER,
        p_estado        IN NUMBER,
        p_resultado     OUT NUMBER
    ) IS
    BEGIN
        p_resultado := c_uno;
        UPDATE t_opcion
        SET
            t_opcion.descripcion = nvl(p_descripcion,t_opcion.descripcion),
            t_opcion.orden = nvl(p_orden,t_opcion.orden),
            t_opcion.estado = nvl(p_estado,t_opcion.estado)
        WHERE
            t_opcion.id_opcion = nvl(p_opcion,t_opcion.id_opcion);

    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
    END;

    PROCEDURE sel_opcion (
        p_opcion      IN NUMBER,
        p_pregunta    IN NUMBER,
        p_resultado   OUT SYS_REFCURSOR,
        p_bandera     OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        OPEN p_resultado FOR SELECT
                                 t_opcion.id_opcion,
                                 t_opcion.descripcion,
                                 t_opcion.orden,
                                 t_opcion.fk_pregunta
                             FROM
                                 t_opcion
                             WHERE
                                 t_opcion.id_opcion = nvl(p_opcion,t_opcion.id_opcion)
                                 AND t_opcion.fk_pregunta = nvl(p_pregunta,t_opcion.fk_pregunta)
                                 AND t_opcion.estado > c_cero
                             ORDER BY
                                 t_opcion.orden ASC;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;

END;

/
--------------------------------------------------------
--  DDL for Package Body PKG_CUESTIONARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "TRABAJOTERMINAL"."PKG_CUESTIONARIO" IS

    PROCEDURE ins_cuestionario (
        p_usuario       IN NUMBER,
        p_nombre        IN VARCHAR2,
        p_descripcion   IN VARCHAR2,
        p_fecha_fin     IN DATE DEFAULT NULL,
        p_contrasena    IN VARCHAR2 DEFAULT NULL,
        p_resultado     OUT NUMBER
    ) IS
        v   NUMBER;
    BEGIN
        p_resultado := c_uno;
        INSERT INTO t_cuestionario (
            t_cuestionario.fk_usuario,
            t_cuestionario.nombre,
            t_cuestionario.descripcion,
            t_cuestionario.fecha_creacion,
            t_cuestionario.fecha_modificacion,
            t_cuestionario.fecha_fin,
            t_cuestionario.estado,
            t_cuestionario.contrasena
        ) VALUES (
            p_usuario,
            p_nombre,
            p_descripcion,
            SYSDATE,
            SYSDATE,
            p_fecha_fin,
            c_uno,
            p_contrasena
        );

        p_resultado := s_cuestionario.currval;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
            ROLLBACK;
    END;

    PROCEDURE sel_cuestionario (
        p_cuestionario   IN NUMBER,
        p_usuario        IN NUMBER,
        p_cursor         OUT SYS_REFCURSOR,
        p_bandera        OUT NUMBER
    ) IS
    BEGIN
        p_bandera := c_uno;
        OPEN p_cursor FOR SELECT
                              t_cuestionario.id_cuestionario   id,
                              t_cuestionario.fk_usuario        usuario,
                              t_cuestionario.nombre,
                              t_cuestionario.descripcion,
                              TO_CHAR(t_cuestionario.fecha_creacion,'DD-MM-YYYY') fecha_creacion,
                              TO_CHAR(t_cuestionario.fecha_modificacion,'DD-MM-YYYY') fecha_modificacion,
                              --t_cuestionario.fecha_fin,
                              TO_CHAR(t_cuestionario.fecha_fin,'DD-MM-YYYY') fecha_fin,
                              t_cuestionario.estado,
                              t_cuestionario.contrasena
                          FROM
                              t_cuestionario
                          WHERE
                              fk_usuario = p_usuario
                              AND id_cuestionario = nvl(p_cuestionario,id_cuestionario)
                              AND t_cuestionario.estado > c_cero
                          ORDER BY
                              t_cuestionario.fecha_modificacion DESC;

    EXCEPTION
        WHEN OTHERS THEN
            p_bandera := c_cero;
    END;

    PROCEDURE upd_cuestionario (
        p_cuestionario   IN NUMBER,
        p_usuario        IN NUMBER,
        p_nombre         IN VARCHAR2,
        p_descripcion    IN VARCHAR2,
        p_fecha_fin      IN DATE DEFAULT NULL,
        p_estado         IN NUMBER,
        p_contrasena     IN VARCHAR2 DEFAULT NULL,
        p_resultado      OUT NUMBER
    ) IS
    BEGIN
        p_resultado := c_uno;
        UPDATE t_cuestionario
        SET
            t_cuestionario.nombre = nvl(p_nombre,t_cuestionario.nombre),
            t_cuestionario.descripcion = nvl(p_descripcion,t_cuestionario.descripcion),
            t_cuestionario.fecha_modificacion = SYSDATE,
            t_cuestionario.fecha_fin = nvl(p_fecha_fin,t_cuestionario.fecha_fin),
            t_cuestionario.estado = nvl(p_estado,t_cuestionario.estado),
            t_cuestionario.contrasena = nvl(p_contrasena,t_cuestionario.contrasena)
        WHERE
            t_cuestionario.id_cuestionario = p_cuestionario
            AND t_cuestionario.fk_usuario = p_usuario;

    EXCEPTION
        WHEN OTHERS THEN
            p_resultado := c_cero;
    END;

    
END pkg_cuestionario;

/
--------------------------------------------------------
--  DDL for Package Body PKG_CONSULTAS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "TRABAJOTERMINAL"."PKG_CONSULTAS" IS

    PROCEDURE gen_cuestionario (
        p_usuario        IN NUMBER,
        p_cuestionario   IN NUMBER,
        p_clase          IN NUMBER,
        p_respuesta      OUT SYS_REFCURSOR,
        p_res            OUT NUMBER
    ) IS
    BEGIN
        p_res := c_uno;
        OPEN p_respuesta FOR SELECT
                                 id_pregunta,
                                 t_pregunta.descripcion,
                                 t_pregunta.tamano,
                                 t_pregunta.rango,
                                 t_pregunta.orden,
                                 t_pregunta.tipo,
                                 t_pregunta.obligado,
                                 LISTAGG(t_opcion.id_opcion ||':'|| t_opcion.descripcion,'$') WITHIN GROUP(
                                         ORDER BY
                                             t_opcion.orden ASC
                                     ) opciones
                             FROM
                                 t_cuestionario,
                                 t_pregunta,
                                 (
                                     SELECT
                                         *
                                     FROM
                                         t_opcion
                                     WHERE
                                         estado > c_cero
                                 ) t_opcion
                             WHERE
                                 t_cuestionario.id_cuestionario = t_pregunta.fk_cuestionario
                                 AND t_pregunta.id_pregunta = t_opcion.fk_pregunta (+)
                                 AND t_pregunta.fk_cuestionario = p_cuestionario
                                 AND t_pregunta.clase = p_clase
                                 AND t_pregunta.estado > c_cero
                                 AND t_cuestionario.fk_usuario = p_usuario
                             GROUP BY
                                 id_pregunta,
                                 t_pregunta.descripcion,
                                 t_pregunta.tamano,
                                 t_pregunta.rango,
                                 t_pregunta.orden,
                                 t_pregunta.tipo,
                                 t_pregunta.obligado
                             ORDER BY
                                 t_pregunta.orden ASC;

    EXCEPTION
        WHEN OTHERS THEN
            p_res := c_cero;
    END gen_cuestionario;

END pkg_consultas;

/
