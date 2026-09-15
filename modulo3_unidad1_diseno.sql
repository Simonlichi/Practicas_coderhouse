CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY, -- INT porque el identificador sera un numero entero
  nombre VARCHAR(100) NOT NULL, -- VARCHAR porque permite almacenar texto de hasta la cantidad de caracteres indicada (100)
  perfil_bio TEXT, --TEXT porque permite almacenar una cantidad extensa de texto
  fecha_registro DATE -- DATE porque almacena unicamente una fecha
  );

CREATE TABLE productos (
  id_producto INT PRIMARY KEY, -- INT porque el identificador sera un numero entero
  descripcion VARCHAR(255) NOT NULL, -- VARCHAR porque permite almacenar texto de hasta la cantidad de caracteres indicada (255)
  precio DECIMAL(10, 2) NOT NULL, -- DECIMAL porque permite indicar la cantidad de digitos y decimales deseada (10 y 2 respectivamente)
                                  -- y es apropiado para almacenar valores monetarios
  esta_activo BOOLEAN NOT NULL -- BOOLEAN porque permite representar si el producto está activo o no
  );
