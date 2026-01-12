CREATE TABLE hechos_ventas (
    id_venta INTEGER PRIMARY KEY,
    id_tiempo INTEGER REFERENCES dim_tiempo(id),
    id_cliente INTEGER REFERENCES dim_cliente(id),
    id_producto INTEGER REFERENCES dim_producto(id),
    id_canal INTEGER REFERENCES dim_canal_adquisicion(id),
    id_geografia INTEGER REFERENCES dim_geografia(id),

    cantidad INTEGER,
    precio_unitario NUMERIC(10,2),
    descuento_aplicado NUMERIC(10,2),
    costo_envio NUMERIC(10,2),
    impuestos NUMERIC(10,2),

    total_bruto NUMERIC(10,2)
      GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    total_neto NUMERIC(10,2)
      GENERATED ALWAYS AS ((cantidad * precio_unitario) - descuento_aplicado + costo_envio + impuestos) STORED,

    margen_contribucion NUMERIC(10,2)
      GENERATED ALWAYS AS (((cantidad * precio_unitario) - descuento_aplicado - costo_envio) * 0.3) STORED,

    primera_compra BOOLEAN,
    compra_recurrente BOOLEAN,
    cliente_vip BOOLEAN
);

-- 2. Dimensión Tiempo: Jerarquía temporal completa
CREATE TABLE dim_tiempo (
    id INTEGER PRIMARY KEY,
    fecha DATE UNIQUE,
    dia INTEGER,
    mes INTEGER,
    nombre_mes VARCHAR(20),
    trimestre INTEGER,
    año INTEGER,
    dia_semana VARCHAR(10),
    numero_semana INTEGER,
    festivo BOOLEAN,
    temporada VARCHAR(20),  -- Primavera, Verano, etc.
    fin_semana BOOLEAN,
    dia_habil BOOLEAN
);

-- 3. Dimensión Cliente: Segmentación completa
CREATE TABLE dim_cliente (
    id INTEGER PRIMARY KEY,
    id_cliente_natural INTEGER,  -- Para SCD Tipo 2
    nombre VARCHAR(100),
    email VARCHAR(100),
    fecha_registro DATE,
    segmento_valor VARCHAR(20),  -- Bronce, Plata, Oro, Platino
    segmento_comportamiento VARCHAR(30),  -- Nuevo, Recurrente, VIP, Inactivo
    edad INTEGER,
    genero VARCHAR(10),
    ciudad VARCHAR(50),
    region VARCHAR(50),
    pais VARCHAR(50),
    frecuencia_compras_mensual DECIMAL(4,1),
    valor_promedio_compra DECIMAL(10,2),
    ultima_compra DATE,
    activo BOOLEAN
);

-- 4. Dimensión Producto: Jerarquía de catálogo
CREATE TABLE dim_producto (
    id INTEGER PRIMARY KEY,
    sku VARCHAR(20) UNIQUE,
    nombre VARCHAR(100),
    descripcion TEXT,
    id_categoria INTEGER REFERENCES dim_categoria(id),
    id_marca INTEGER REFERENCES dim_marca(id),
    precio_lista DECIMAL(10,2),
    costo DECIMAL(10,2),
    margen DECIMAL(5,2),
    stock_actual INTEGER,
    stock_minimo INTEGER,
    disponible BOOLEAN,
    fecha_lanzamiento DATE,
    temporada VARCHAR(20)
);

-- 5. Dimensión Geografía: Ubicación jerárquica
CREATE TABLE dim_geografia (
    id INTEGER PRIMARY KEY,
    codigo_postal VARCHAR(10),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    region VARCHAR(50),
    pais VARCHAR(50),
    zona_horaria VARCHAR(10),
    densidad_poblacional VARCHAR(20)
);

-- 6. Dimensión Canal: Marketing y adquisición
CREATE TABLE dim_canal_adquisicion (
    id INTEGER PRIMARY KEY,
    nombre_canal VARCHAR(50),
    tipo_canal VARCHAR(20),  -- Pago, Orgánico, Social, Email, etc.
    costo_adquisicion DECIMAL(8,2),
    roi_promedio DECIMAL(5,2),
    tasa_conversion DECIMAL(5,2),
    activo BOOLEAN
);

-- 7. Tablas de soporte para jerarquías
CREATE TABLE dim_categoria (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    categoria_padre INTEGER REFERENCES dim_categoria(id),  -- Para jerarquía
    nivel INTEGER,  -- 1=Principal, 2=Subcategoria, etc.
    descripcion TEXT
);

CREATE TABLE dim_marca (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    pais_origen VARCHAR(50),
    segmento VARCHAR(20),  -- Premium, Medio, Económico
    reputacion DECIMAL(3,1)  -- Puntuación 1-10
);