-- ==============================================================================
-- SUMATIVA 1 CONSULTA DE BASE DE DATOS 
-- Caso de Estudio: ASOCIADOS Corredora de Propiedades
-- ==============================================================================

/* ---- SELECCIONES DE TABLAS ---- */
SELECT * FROM cliente;
SELECT * FROM propietario;
SELECT * FROM propiedad;
SELECT * FROM empleado; 
SELECT * FROM sucursal;
SELECT * FROM arriendo_propiedad;
SELECT * FROM tipo_propiedad;
SELECT * FROM comision;
SELECT * from categoria_empleado; 
SELECT * FROM haberes;
SELECT * FROM haberes;
SELECT * FROM detalle_prop_arrendadas;
SELECT * FROM resumen_prop_arrendadas;
SELECT * FROM empleados_por_sucursal;
SELECT * FROM descuentos;
SELECT * FROM comuna;
SELECT * FROM resumen_pagos_por_sucursal; --Sin contenido aún


-- ==============================================================================
-- CASO 1: Listado de Clientes con Rango de Renta
-- Variables de Sustitución Requeridas: &RENTA_MINIMA, &RENTA_MAXIMA
-- ==============================================================================
--
-- Requerimientos:
-- 
-- Mostrar solo los clientes listados entre un rango de renta definido por el operario 
-- que interactúe con el informe, es decir, el desarrollo debe ser capaz de pedir 
-- el monto mínimo y máximo de renta a filtrar por pantalla.
-- 
-- El reporte debe mostrar el RUT de los clientes con puntos y guion, 
-- y considerar solo a los clientes que tienen registrado un número de celular.
--
-- El objetivo del informe es medir por tramos la rentabilidad de cada uno de los clientes, considerando la siguiente escala: 
-- Renta mayor de 500.000 clasifica como 'TRAMO 1'.
-- Renta entre 400.000 y 500.000 clasifica como 'TRAMO 2'.
-- Renta entre 200.000 y 399.999 clasifica como 'TRAMO 3'.
-- Renta menor de 200.000 clasifica como 'TRAMO 4'.
-- ==============================================================================

SELECT
    -- RUT CLIENTE: numrut_cli y dvrut_cli con formato de puntos y guion
    REPLACE(TO_CHAR(c.numrut_cli, 'FM99G999G999', 'NLS_NUMERIC_CHARACTERS = ''.,'''), ',', '.') || '-' || c.dvrut_cli AS "RUT Cliente",
    
    -- NOMBRE_CLIENTE: Nombre, Apellido Paterno, Apellido Materno, formato Capitalizado (función INITCAP)
    INITCAP(c.nombre_cli || ' ' || c.appaterno_cli || ' ' || c.apmaterno_cli) AS "Nombre Completo Cliente",

    -- DIRECCION_CLIENTE: formato Capitalizado (función INITCAP)
    INITCAP(c.direccion_cli) AS "Direccion Cliente",
    
    -- RENTA: Formato monetario con signo $ y separador de miles con PUNTO (Se utiliza la coma como separador de grupo, y luego se fuerza la coma a ser un punto)
    REPLACE(
        TO_CHAR(c.renta_cli, 'FM$9G999G999', 'NLS_NUMERIC_CHARACTERS = ''.,'''),
    ',', '.') AS "Renta Cliente",

    -- CELULAR: formato '00-000-0000' (Rellenar con ceros a la izquierda y aplicar formato de guiones)
    SUBSTR(LPAD(c.celular_cli, 9, '0'), 1, 2) || '-' ||   -- primeros 2 dígitos
    SUBSTR(LPAD(c.celular_cli, 9, '0'), 3, 3) || '-' ||  --  siguientes 3 digitos
    SUBSTR(LPAD(c.celular_cli, 9, '0'), 6, 4) AS "Celular Cliente",  -- ultimos 4 digitos

    -- CLASIFICACION: Tramo según renta (función condicional CASE)
    CASE
        WHEN c.renta_cli > 500000 THEN 'TRAMO 1'
        WHEN c.renta_cli BETWEEN 400000 AND 500000 THEN 'TRAMO 2'
        WHEN c.renta_cli BETWEEN 200000 AND 399999 THEN 'TRAMO 3'
        ELSE 'TRAMO 4'
    END AS "Trama Renta Cliente"
FROM
    CLIENTE c
WHERE
    -- Restricción de datos: Renta en el rango definido por las variables de sustitución
    c.renta_cli BETWEEN &RENTA_MINIMA AND &RENTA_MAXIMA
    -- Restricción de datos: Solo clientes con celular registrado (manejo de nulos)
    AND c.celular_cli IS NOT NULL
ORDER BY
    -- Cláusula de ordenamiento: Por nombre completo ascendente
    "Nombre Completo Cliente" ASC;


-- ==============================================================================
-- CASO 2: Sueldo Promedio por Categoría de Empleado
-- Variables de Sustitución Requeridas: &SUELDO_PROMEDIO_MINIMO
-- ==============================================================================
--
-- Requerimientos:
-- 
-- Recursos Humanos ha solicitado un informe que les permita identificar grupos de empleados por categoría:
-- Las categorías se clasifican por el siguiente código:
--  1 corresponde Gerente
--  2 corresponde Supervisor
--  3 corresponde Ejecutivo de Arriendo
--  4 corresponde Auxiliar
--
-- Al igual que el código de sucursal:
--  10 corresponde Sucursal Las Condes
--  20 corresponde Sucursal Santiago Centro
--  30 corresponde Sucursal Providencia
--  40 corresponde Sucursal Vitacura
--
-- De la cantidad de empleados por sucursal se debe calcular el promedio de sueldo 
-- y formatear con signo pesos separando miles.
--
-- El usuario podrá ingresar por pantalla el valor del sueldo promedio mínimo a considerar en el reporte.
-- --> Variables de Sustitución: SUELDO_PROMEDIO_MINIMO
--
-- La información debe ordenarse por sueldo promedio de forma descendente. 
-- ==============================================================================

SELECT
    -- ID CATEGORIA EMPLEADO: 
    e.id_categoria_emp AS "CODIGO_CATEGORIA",

    -- CATEGORIA_EMPLEADO: Descripción de la categoría
    ce.desc_categoria_emp AS "DESCRIPCION_CATEGORIA",

    -- CANTIDAD_EMPLEADOS: Conteo de empleados por grupo (función de grupo COUNT)
    COUNT(e.numrut_emp) AS "CANTIDAD_EMPLEADOS",
    
    -- SUCURSAL: Descripción de la sucursal
    s.desc_sucursal AS "SUCURSAL",

    -- SUELDO_PROMEDIO: Promedio de sueldo redondeado a entero y formateado con '$' (función de grupo AVG y conversión)
    -- Nota: Uso de REPLACE para forzar el punto como separador de miles.
    REPLACE(
        TO_CHAR(ROUND(AVG(e.sueldo_emp)), 'FM$9G999G999', 'NLS_NUMERIC_CHARACTERS = ''.,'''),
    ',',
    '.') AS "SUELDO_PROMEDIO"

FROM
    EMPLEADO e
    JOIN CATEGORIA_EMPLEADO ce ON e.id_categoria_emp = ce.id_categoria_emp
    JOIN SUCURSAL s ON e.id_sucursal = s.id_sucursal
GROUP BY
    -- Grupo de datos: Agrupación por categoría, id categoria y sucursal
    e.id_categoria_emp,
    ce.desc_categoria_emp,
    s.desc_sucursal
HAVING
    -- Restricción de grupos de datos: Sueldo promedio mayor a la variable de sustitución
    AVG(e.sueldo_emp) > &SUELDO_PROMEDIO_MINIMO
ORDER BY
    -- Cláusula de ordenamiento: Por sueldo promedio descendente (usando el valor sin formatear para la ordenación)
    ROUND(AVG(e.sueldo_emp)) DESC;
    
    
-- ==============================================================================
-- CASO 3: Arriendo Promedio por Tipo de Propiedad
-- Restricción de Grupo Fija: Promedio de arriendo por m2 superior a 1.000
-- ==============================================================================
--
-- Requerimientos:
-- 
-- Agrupar los registros por tipo de propiedad que ellos tienen en sus registros. 
-- Calcular indicadores clave, tales como el total de propiedades registradas, 
-- el promedio del valor de arriendo, de superficie y la razón de arriendo por metro cuadrado.  
-- Se espera que se transforme el código del tipo de propiedad en una descripción legible:
--
-- A  -> CASA
-- B  -> DEPARTAMENTO
-- C  -> LOCAL
-- D  -> PARCELA SIN CASA
-- E  -> PARCELA CON CASA
--
-- El reporte final deberá incluir, además de los indicadores anteriores, una clasificación 
-- de las propiedades basada en el valor de arriendo por metro cuadrado, asignando categorías como 
-- menor de 5.000 m2 es "Económico", 
-- entre 5.000 y 10.000 m2 "Medio" 
-- o superior a todos los anteriores "Alto", 
-- según los umbrales establecidos.
--
-- El reporte solo mostrará los registros cuyo promedio del valor de arriendo por m2 sea superior a 1.000.
-- La información debe ordenarse por valor de arriendo por m2 de forma descendente. 
-- ==============================================================================


SELECT
    -- Código Tipo de Propiedad (id_tipo_propiedad)
    tp.id_tipo_propiedad AS "CODIGO_TIPO",

    -- DESCRIPCION_TIPO 
    tp.desc_tipo_propiedad AS "DESCRIPCION_TIPO",

    -- TOTAL_PROPIEDADES: Conteo de propiedades por grupo (función de grupo COUNT)
    COUNT(p.nro_propiedad) AS "TOTAL_PROPIEDADES",

    -- PROMEDIO_VALOR_ARRIENDO: Promedio de arriendo con separador de miles PUNTO
    REPLACE(
        TO_CHAR(ROUND(AVG(P.VALOR_ARRIENDO)), 'FM$9G999G999', 'NLS_NUMERIC_CHARACTERS = ''.,'''),
    ',',
    '.') AS "PROMEDIO_VALOR_ARRIENDO",

    -- PROMEDIO_SUPERFICIE_M2 con formato 00,00 (Decimal con dos posiciones)
    -- Se usa el caracter decimal 'D' (la coma en este contexto) y se rellena con ceros (0).
    TO_CHAR(AVG(p.superficie), 'FM00D00') AS "PROMEDIO_SUPERFICIE_M2",

    -- VALOR_ARRIENDO_M2: Promedio del valor de arriendo por m2 con separador de miles PUNTO
    REPLACE(
        TO_CHAR(ROUND(AVG(P.VALOR_ARRIENDO / p.superficie)), 'FM$9G999G999G999', 'NLS_NUMERIC_CHARACTERS = ''.,'''),
    ',',
    '.') AS "VALOR_ARRIENDO_M2",

    -- Clasificación condicional según VALOR_ARRIENDO_M2
    CASE
        WHEN ROUND(AVG(P.VALOR_ARRIENDO / p.superficie)) > 10000 THEN 'Alto'
        WHEN ROUND(AVG(P.VALOR_ARRIENDO / p.superficie)) BETWEEN 5000 AND 10000 THEN 'Medio'
        ELSE 'Económico'
    END AS "CLASIFICACION"
FROM
    PROPIEDAD p
    JOIN TIPO_PROPIEDAD tp ON p.id_tipo_propiedad = tp.id_tipo_propiedad
    INNER JOIN ARRIENDO_PROPIEDAD ap ON p.nro_propiedad = ap.nro_propiedad
GROUP BY
    -- Se incluye el ID en el GROUP BY para que se pueda seleccionar
    tp.id_tipo_propiedad,
    tp.desc_tipo_propiedad
HAVING
  ROUND(AVG(P.VALOR_ARRIENDO / p.superficie)) > 1000
ORDER BY ROUND(AVG(P.VALOR_ARRIENDO / p.superficie)) DESC;

-- ==============================================================================
-- ANDREA ROSERO
-- ANALISTA PROGRAMADOR 
-- ==============================================================================
