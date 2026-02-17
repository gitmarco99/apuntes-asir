use tienda_online;
-- 1) Listar cada id del pedido con el nombre del cliente que lo realizó.
--    Orden: cliente ASC, y a igualdad de cliente por pedido ASC.
SELECT 
    pedidos.id_pedido as pedido, clientes.nombre as nombre
FROM
    clientes
        JOIN
    pedidos ON clientes.id_cliente = pedidos.id_cliente
ORDER BY pedido asc , nombre asc;
-- 2) Listar cada línea de detalle con el nombre del producto y el id del pedido.
--    Columnas EXACTAS y alias:
--      - producto (pr.nombre)
--      - pedido   (dp.id_pedido)
--    Orden: producto ASC, y a igualdad de producto por pedido ASC.
SELECT 
    productos.nombre AS producto,
    detalle_pedido.id_pedido AS pedido
FROM
    productos
        JOIN
    detalle_pedido ON productos.id_producto = detalle_pedido.id_producto
ORDER BY producto ASC , pedido ASC;  
-- 3) Listar cada pedido con el nombre del cliente y su coste total.
--    Columnas EXACTAS y alias:
--      - cliente      (c.nombre)
--      - pedido       (p.id_pedido)
--      - coste_total  (p.coste_total)
--    Orden: coste_total DESC y, en empates, pedido ASC.
SELECT 
    clientes.nombre AS cliente,
    pedidos.id_pedido AS pedido,
    pedidos.coste_total AS coste_total
FROM
    clientes
        JOIN
    pedidos ON pedidos.id_cliente = clientes.id_cliente
ORDER BY coste_total DESC , pedido ASC;
-- 4) Listar pedidos realizados a partir del 1 de enero de 2024 (incluido), con nombre del cliente y fecha.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - cliente       (c.nombre)
--      - fecha_pedido  (p.fecha_pedido)
--    Orden: fecha_pedido ASC; en empate, pedido ASC.
SELECT 
    pedidos.id_pedido AS pedido,
    clientes.nombre AS cliente,
    pedidos.fecha_pedido AS fecha_pedido
FROM
    clientes
        JOIN
    pedidos ON pedidos.id_cliente = clientes.id_cliente
WHERE
    DATE(fecha_pedido) >= '2024-01-01 00:00:00:00'
ORDER BY fecha_pedido ASC , pedido ASC;
-- 5) Listar pedidos cuyo estado sea 'cancelado' o 'pendiente', con cliente y coste_total.
--    Columnas y alias:
--      - pedido       (p.id_pedido)
--      - cliente      (c.nombre)
--      - estado       (p.estado)
--      - coste_total  (p.coste_total)
--    Orden: estado ASC (ojo: no es orden alfabético. Ordena con otro criterio por el tipo de dato. Te lo contaré en clase), y dentro de cada estado coste_total DESC.
SELECT 
    pedidos.id_pedido AS pedido,
    clientes.nombre AS cliente,
    pedidos.estado AS estado,
    pedidos.coste_total AS coste_total
FROM
    pedidos
        JOIN
   clientes ON pedidos.id_cliente = clientes.id_cliente
WHERE
    estado IN ('cancelado' , 'pendiente')
ORDER BY estado ASC , coste_total DESC;
-- 6) Listar pagos con su pedido y cliente, mostrando el método de pago.
--    Columnas y alias:
--      - pedido       (p.id_pedido)
--      - cliente      (c.nombre)
--      - metodo_pago  (pa.metodo_pago)
--    Orden: pedido ASC.
SELECT 
    pedidos.id_pedido AS pedido,
    clientes.nombre AS cliente,
    pagos.metodo_pago
FROM
    clientes
        JOIN
    pedidos ON pedidos.id_cliente = clientes.id_cliente
        JOIN
    pagos ON pagos.id_pedido = pedidos.id_pedido
ORDER BY pedido ASC;
-- 7) Listar las líneas del pedido con id 10, incluyendo nombre del producto, cantidad y precio unitario.
--    Columnas y alias:
--      - producto         (pr.nombre)
--      - cantidad         (dp.cantidad)
--      - precio_unitario  (dp.precio_unitario)
--    Orden: producto ASC.
SELECT 
    productos.nombre AS producto,
    detalle_pedido.cantidad,
    detalle_pedido.precio_unitario
FROM
    productos
        JOIN
    detalle_pedido ON detalle_pedido.id_producto = productos.id_producto
WHERE
    detalle_pedido.id_pedido = '10'
ORDER BY producto ASC; 
-- 8) Listar pedidos con estado 'entregado' con nombre del cliente y fecha del pedido.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - cliente       (c.nombre)
--      - fecha_pedido  (p.fecha_pedido)
--    Orden: fecha_pedido ASC; en empate, pedido ASC.
SELECT 
    pedidos.id_pedido AS pedido,
    clientes.nombre AS cliente,
    pedidos.fecha_pedido
FROM
    clientes
        JOIN
    pedidos ON pedidos.id_cliente = clientes.id_cliente
WHERE
    pedidos.estado = 'entregado'
ORDER BY fecha_pedido ASC , pedido ASC;
-- 9) Calcular la suma total pagada por cada pedido que tenga al menos un pago.
--    Columnas y alias:
--      - pedido        (p.id_pedido)
--      - total_pagado  (SUM(pa.total_pagado))
--    Agrupación: por p.id_pedido exclusivamente.
--    Orden: total_pagado DESC; en empate, pedido ASC.
SELECT 
    pedidos.id_pedido AS pedido,
    SUM(pagos.total_pagado) AS total_pagado
FROM
    pedidos
        JOIN
    pagos ON pagos.id_pedido = pedidos.id_pedido
GROUP BY pedido
ORDER BY total_pagado DESC , pedido ASC;
-- 10) Contar el número de pedidos realizados por cada cliente.
--     Columnas y alias:
--       - cliente        (c.nombre)
--       - total_pedidos  (COUNT(p.id_pedido))
--     Agrupación: por c.id_cliente y c.nombre (ambos campos, para evitar ambigüedad).
--     Orden: total_pedidos DESC; en empate, cliente ASC.
SELECT 
    clientes.nombre AS cliente,
    COUNT(pedidos.id_pedido) AS total_pedidos
FROM
    clientes
        JOIN
    pedidos ON pedidos.id_cliente = clientes.id_cliente
GROUP BY clientes.id_cliente , clientes.nombre
ORDER BY total_pedidos desc , cliente ASC;
-- 11) Listar los clientes que poseen MÁS DE 3 pedidos (estrictamente > 3).
--     Columnas y alias:
--       - cliente        (c.nombre)
--       - total_pedidos  (COUNT(p.id_pedido))
--     Agrupación: por c.id_cliente y c.nombre.
--     Orden: total_pedidos DESC; en empate, cliente ASC.
-- 12) Calcular los ingresos totales por cada producto (cantidad * precio_unitario)
--     Columnas y alias:
--       - producto  (pr.nombre)
--       - ingresos  (SUM(dp.cantidad * dp.precio_unitario))
--     Agrupación: por pr.id_producto y pr.nombre.
--     Orden: ingresos DESC; en empate, producto ASC.
-- 13) Listar los productos cuyo ingreso total (cantidad * precio_unitario) sea superior a 10.000,00 euros.
--     Columnas y alias:
--       - producto  (pr.nombre)
--       - ingresos  (SUM(dp.cantidad * dp.precio_unitario))
--     Agrupación: por pr.id_producto y pr.nombre.
--     Orden: ingresos DESC; en empate, producto ASC.
-- 14) Listar los pedidos cuyo estado sea 'entregado' O 'enviado' y cuyo cliente tenga país 'España' O 'México'.
--     Columnas y alias:
--       - pedido   (p.id_pedido)
--       - cliente  (c.nombre)
--       - pais     (c.pais)
--       - estado   (p.estado)
--     Orden: pais ASC, luego estado ASC y finalmente pedido ASC.
-- 15) Listar productos con precio_unitario > 200 en líneas pertenecientes a pedidos CANCELADOS.
--     Columnas y alias (sin duplicados en misma consulta):
--       - producto        (pr.nombre)
--       - precio_unitario (dp.precio_unitario)
--       - estado          (p.estado)
--     Selección DISTINCT para evitar filas repetidas por combinaciones idénticas.
--     Orden: precio_unitario DESC; en empate, producto ASC.
-- 16) Listar clientes registrados en 2024 que tengan al menos un pedido en estado 'pendiente' O 'enviado' (no entregado ni cancelado).
--     Columnas y alias (sin duplicados por cliente-estado):
--       - cliente        (c.nombre)
--       - fecha_registro (c.fecha_registro)
--       - estado         (p.estado)
--     DISTINCT para evitar múltiples filas idénticas por mismo cliente y estado.
--     Orden: cliente ASC, y en empate por estado ASC.