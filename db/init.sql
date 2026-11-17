-- ============================================================
--  Script de inicialización de la base de datos "inventario"
--  MySQL lo ejecuta automáticamente SOLO la primera vez,
--  cuando el volumen datos_mysql está vacío.
-- ============================================================

SET NAMES utf8mb4;
USE inventario;

CREATE TABLE IF NOT EXISTS equipos (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    tipo ENUM('Cama de hospitalización', 'Terminal de admisiones', 'Estación de enfermería', 'Equipo de soporte vital', 'Dispositivo de monitoreo', 'Otro') NOT NULL,
    marca           VARCHAR(50)  NOT NULL,
    numero_serie    VARCHAR(50)  NOT NULL UNIQUE,
    ubicacion       VARCHAR(100) NOT NULL,
    estado ENUM('Disponible', 'Ocupado - En estancia', 'En proceso de sanitización', 'Fuera de servicio') NOT NULL DEFAULT 'Disponible',
    fecha_registro  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Registros de ejemplo (datos ficticios)
INSERT INTO equipos (nombre, tipo, marca, numero_serie, ubicacion, estado) VALUES
('Cama 104 - Medicina Interna', 'Cama de hospitalización', 'Hill-Rom', 'CAM-0104', 'Módulo Medicina Interna', 'Ocupado - En estancia'),
('Terminal Urgencias T-02', 'Terminal de admisiones', 'Dell', 'TRM-0002', 'Recepción Urgencias', 'Disponible'),
('Cama UCI 02', 'Cama de hospitalización', 'Stryker', 'UCI-0002', 'Módulo UCI', 'En proceso de sanitización'),
('Estación Piso 2', 'Estación de enfermería', 'HP', 'EST-0201', 'Hospitalización Piso 2', 'Disponible'),
('Monitor Multiparámetro 05', 'Dispositivo de monitoreo', 'Mindray', 'MON-0005', 'Urgencias', 'Fuera de servicio');
