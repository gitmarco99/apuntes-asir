use tienda_online;

SELECT 
    productos.nombre
FROM
    clientes
        JOIN
    pedidos ON clientes.id_cliente = pedidos.id_cliente
        JOIN
    detalle_pedido ON detalle_pedido.id_pedido = pedidos.id_pedido
        JOIN
    productos ON detalle_pedido.id_producto = productos.id_producto
WHERE
    clientes.nombre = 'Ana Torres';
    
    SELECT 
    productos.categoria,
    COUNT(DISTINCT (detalle_pedido.id_pedido)) AS num_pedidos
FROM
    productos
        JOIN
    detalle_pedido ON detalle_pedido.id_producto = productos.id_producto
GROUP BY productos.categoria;
        
/*CONCLUSIONES/*
En este caso, es posible reducir la consulta y no poner el join productos ya que el numero de productos tambien lo podemos ver en la tabla detalle_pedido.

        
