/*******************************************************************************
ENTREGABLE:     Pre-entrega Módulo 5 - Consultas con JOINs
  TÍTULO:         Cruzando tablas para enriquecer el análisis
  PROYECTO:       RetailPro
  ARCHIVO:        m5_consultas_joins.sql
  AUTOR:          Simón Lipshitz
  FECHA:          2026-10-01
  
  DESCRIPCIÓN:
  Este script contiene la consolidación de datos mediante INNER JOINs, LEFT JOINs 
  y UNION ALL sobre el modelo relacional de RetailPro. Proporciona la vista base 
  enriquecida que servirá como fuente de datos principal para el dashboard 
  de Power BI (Módulo 7), e identifica excepciones de negocio (clientes sin 
  compras y productos sin rotación).
*******************************************************************************/

USE Ventas_Tech_DB;


-- =============================================================================
-- VISTA BASE DEL PROYECTO
-- =============================================================================

SELECT 
v.id_cliente,
c.segmento,
p.nombre_producto,
p.descripcion_producto,
ca.nombre_categoria,
g.pais,
g.region,
v.cantidad,
v.precio_unitario,
v.costo_unitario,
v.fecha_venta
FROM ventas v
JOIN clientes c
ON v.id_cliente = c.id_cliente
JOIN productos p 
ON v.id_producto = p.id_producto
JOIN categorias ca
ON p.id_categoria = ca.id_categoria
JOIN geografia g
ON v.id_ubicacion = g.id_ubicacion
;


-- =============================================================================
-- CLIENTES SIN VENTAS
-- =============================================================================

SELECT
c.nombre,
c.email,
c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Se observa de que hay un cliente sin ventas asociadas

-- =============================================================================
-- PRODUCTOS SIN VENTAS
-- =============================================================================

SELECT
p.nombre_producto,
ca.nombre_categoria,
p.precio
FROM productos p
JOIN categorias ca
ON p.id_categoria = ca.id_categoria
LEFT JOIN ventas v
ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL;

-- Se observa que hay un producto sin ventas asociadas

-- =============================================================================
--  CONSOLIDADO POR CANAL
-- =============================================================================

-- El criterio escogido para separar las consultas select es la comparación de 
-- las ventas de clientes Individuales contra las ventas de clientes Empresariales (Pymes o Corporativos)

SELECT tipo_cliente, SUM(total) AS total_canal
FROM (
SELECT 
v.cantidad * v.precio_unitario AS total, 
'Individual' AS tipo_cliente
FROM ventas v
JOIN clientes c
ON v.id_cliente = c.id_cliente
WHERE c.segmento = 'Individual'
UNION ALL
SELECT 
v.cantidad * v.precio_unitario AS total, 
'Empresarial' AS tipo_cliente
FROM ventas v
JOIN clientes c
ON v.id_cliente = c.id_cliente
WHERE c.segmento != 'Individual'
) AS consolidado
GROUP BY tipo_cliente;

-- Se observa que las ventas de clientes Individuales representan aproximadamente un 16%  de la 
-- facturación total, mientras que los clientes Empresariales representan un 86%
