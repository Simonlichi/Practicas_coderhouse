-- EXTRAYENDO MÉTRICAS CLAVE CON SQL

USE Ventas_Tech_DB;


-- == RESUMEN EJECUTIVO MENSUAL ==

SELECT EXTRACT(MONTH FROM fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_facturado, ROUND(AVG(precio_unitario), 2) AS ticket_promedio
FROM ventas
GROUP BY mes
;


-- == RANKING DE PRODUCTOS ==

SELECT id_producto, SUM(cantidad * precio_unitario) AS total_generado, SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;


-- == CLIENTES RECURRENTES ==

SELECT id_cliente, COUNT(*) AS cantidad_pedidos
FROM ventas
GROUP BY id_cliente HAVING cantidad_pedidos > 1
;


-- == MESES POR ENCIMA O POR DEBAJO DEL PROMEDIO ==

SELECT EXTRACT(MONTH FROM fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_facturado,
CASE 
WHEN SUM(cantidad * precio_unitario) >= AVG(precio_unitario) THEN 'Por encima'
ELSE 'Por debajo'
END AS estado_vs_promedio
FROM ventas
GROUP BY mes
;


-- A partir de este analisis preliminar, se observó lo siguiente:
-- 1. El producto 1 es el de mayor recaudación ya que concentra el 55,9% de la facturación del mes (3)
-- 2. Todos los clientes registrados en el mes mostraron un comportamiento recurrente
-- 3. El producto 2 es el de mayor rotación,concentrando el 50% del total de unidades físicas vendidas dentro del Top 5 de productos con mayor facturación