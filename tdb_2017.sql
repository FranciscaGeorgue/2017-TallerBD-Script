SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema asociacion_deportes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema asociacion_deportes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `asociacion_deportes` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `asociacion_deportes` ;

-- -----------------------------------------------------
-- Table `asociacion_deportes`.`directiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`directiva` (
  `rut` VARCHAR(20) NOT NULL COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  `fecha_termino` DATE NOT NULL COMMENT '',
  `fecha_inicio` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`rut`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`personal` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(70) NULL COMMENT '',
  `area` ENUM('Futbol', 'Tenis', 'Basquetbol', 'Gimnasia Artistica') NOT NULL COMMENT '',
  `directiva_rut` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `cons_per_dir`
    FOREIGN KEY (`directiva_rut`)
    REFERENCES `asociacion_deportes`.`directiva` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `asociacion_deportes`.`arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`arbitro` (
  `personal_id` INT(10) NOT NULL COMMENT '',
  `rango` VARCHAR(30) NOT NULL COMMENT '',
  PRIMARY KEY (`personal_id`)  COMMENT '',
  CONSTRAINT `fk_arbitro_personal1`
    FOREIGN KEY (`personal_id`)
    REFERENCES `asociacion_deportes`.`personal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`juez`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`juez` (
  `personal_id` INT(10) NOT NULL COMMENT '',
  `clasificacion` INT(2) NULL COMMENT '',
  PRIMARY KEY (`personal_id`)  COMMENT '',
  CONSTRAINT `fk_juez_personal1`
    FOREIGN KEY (`personal_id`)
    REFERENCES `asociacion_deportes`.`personal` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`premio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`premio` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(30) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`evento` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `fecha_inicio` DATE NOT NULL COMMENT '',
  `fecha_termino` DATE NOT NULL COMMENT '',
  `nombre` VARCHAR(30) NOT NULL COMMENT '',
  `premio_id` INT(10) NOT NULL COMMENT '',
  `directiva_rut` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `fk_evento_premio3`
    FOREIGN KEY (`premio_id`)
    REFERENCES `asociacion_deportes`.`premio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_directiva4`
    FOREIGN KEY (`directiva_rut`)
    REFERENCES `asociacion_deportes`.`directiva` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`torneo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`torneo` (
  `evento_id` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`evento_id`)  COMMENT '',
  CONSTRAINT `fk_torneo_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `asociacion_deportes`.`evento` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`ronda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`ronda` (
  `torneo_evento_id` INT(10) NOT NULL COMMENT '',
  `final` TINYINT(1) NOT NULL COMMENT '',
  `numero_rondas` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`torneo_evento_id`)  COMMENT '',
  CONSTRAINT `fk_ronda_torneo1`
    FOREIGN KEY (`torneo_evento_id`)
    REFERENCES `asociacion_deportes`.`torneo` (`evento_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`campeonato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`campeonato` (
  `evento_id` INT(10) NOT NULL COMMENT '',
  `numero_campeonato` INT(20) UNSIGNED NOT NULL COMMENT '',
  `numero_fechas` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`evento_id`)  COMMENT '',
  CONSTRAINT `fk_campeonato_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `asociacion_deportes`.`evento` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`encuentro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`encuentro` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `puntaje1` VARCHAR(10) NULL COMMENT '',
  `puntaje2` VARCHAR(10) NULL COMMENT '',
  `fecha` DATE NOT NULL COMMENT '',
  `numero_encuentros` INT(10) NOT NULL COMMENT '',
  `ciudad` ENUM('Arica', 'Iquique', 'Alto Hospicio', 'Pozo Almonte', 'Antofagasta', 'Calama', 'Copiapó', 'Caldera', 'Tierra Amarilla', 'La Serena', 'Coquimbo', 'Punitaqui', 'Andacollo', 'Vicuña', 'Valparaíso', 'Concón', 'Viña del Mar', 'Villa Alemana', 'Quilpue', 'Placilla de Peñuelas', 'San Antonio', 'Santo Domingo', 'Cartagena', 'Quillota', 'Hijuelas', 'La Caldera', 'La Cruz', 'San Felipe', 'Casablanca', 'Las Ventanas', 'Quintero', 'Los Andes', 'Calle Larga', 'Rancagua', 'Machalí', 'Gultro', 'Codegua', 'Doñihue', 'Lo Miranda', 'Graneros', 'Las Cabras', 'San Francisco de Mostazal', 'Talca', 'Curicó', 'Linares', 'Constitución', 'San Clemente', 'Concepción', 'Talcahuano', 'Chiguayante', 'Coronel', 'Hualqui', 'Lota', 'Penco', 'Tomé', 'Hualpén', 'San Pedro de la Paz', 'Chillán', 'Chillán Viejo', 'Los Ángeles', 'Santa Juana', 'Lebu', 'Arauco', 'Cañete', 'Curanilahue', 'Temuco', 'Padre Las Casas', 'Labranza', 'Carahue', 'Cunco', 'Freire', 'Gorbea', 'Lautaro', 'Valdivia', 'Futrono', 'La Unión', 'Puerto Montt', 'Puerto Varas', 'Calbuco', 'Fresia', 'Frutillar', 'Coyhaique', 'Puerto Aysén', 'Punta Arenas', 'Puerto Natales', 'Santiago', 'San José de Maipo', 'Colina', 'Lampa', 'Batuco', 'Tiltil', 'Buin') NOT NULL DEFAULT 'Valparaíso' COMMENT '',
  `region` ENUM('Region de Arica y Parinacota', 'Región de Tarapacá', 'Región de Antofagasta', 'Región de Atacama', 'Región de Coquimbo', 'Región de Valparaíso', 'Región del Libertador General Bernardo OHiggins', 'Región del Maule', 'Región del Biobío', 'Región de la Araucanía', 'Región de Los Ríos', 'Región de Los Lagos', 'Región de Aysén del General Carlos Ibáñez del Campo', ' Región de Magallanes y de la Antártica Chilena', ' Región Metropolitana de Santiago') NOT NULL DEFAULT 'Región de Valparaíso' COMMENT '',
  `establecimiento` VARCHAR(50) NOT NULL COMMENT '',
  `ronda_torneo_evento_id` INT(10) NOT NULL COMMENT '',
  `campeonato_evento_id` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `fk_encuentro_ronda1`
    FOREIGN KEY (`ronda_torneo_evento_id`)
    REFERENCES `asociacion_deportes`.`ronda` (`torneo_evento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_encuentro_campeonato1`
    FOREIGN KEY (`campeonato_evento_id`)
    REFERENCES `asociacion_deportes`.`campeonato` (`evento_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `asociacion_deportes`.`personal_encuentro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`personal_encuentro` (
  `personal_id` INT(10) NOT NULL COMMENT '',
  `encuentro_id` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`personal_id`, `encuentro_id`)  COMMENT '',
  CONSTRAINT `fk_personal_encuentro_personal1`
    FOREIGN KEY (`personal_id`)
    REFERENCES `asociacion_deportes`.`personal` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_encuentro_encuentro1`
    FOREIGN KEY (`encuentro_id`)
    REFERENCES `asociacion_deportes`.`encuentro` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`auspiciador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`auspiciador` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(50) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`institucion` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` VARCHAR(20) NOT NULL COMMENT '',
  `tipo` ENUM('Universidad', 'Colegio') NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`equipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`equipo` (
  `institucion_id` INT(10) NOT NULL COMMENT '',
  `numero_integrantes` INT(2) NOT NULL COMMENT '',
  `premio_id` INT(10) NULL COMMENT '',
  PRIMARY KEY (`institucion_id`)  COMMENT '',
  CONSTRAINT `fk_equipo_institucion1`
    FOREIGN KEY (`institucion_id`)
    REFERENCES `asociacion_deportes`.`institucion` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_premio1`
    FOREIGN KEY (`premio_id`)
    REFERENCES `asociacion_deportes`.`premio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`integrante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`integrante` (
  `rut` VARCHAR(20) NOT NULL COMMENT '',
  `nombre` VARCHAR(70) NOT NULL COMMENT '',
  `equipo_institucion_id` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`rut`)  COMMENT '',
  CONSTRAINT `fk_integrante_equipo1`
    FOREIGN KEY (`equipo_institucion_id`)
    REFERENCES `asociacion_deportes`.`equipo` (`institucion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `asociacion_deportes`.`entrenador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`entrenador` (
  `integrante_rut` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`integrante_rut`)  COMMENT '',
  CONSTRAINT `fk_entrenador_integrante1`
    FOREIGN KEY (`integrante_rut`)
    REFERENCES `asociacion_deportes`.`integrante` (`rut`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`jugador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`jugador` (
  `premio_id` INT(10) NULL COMMENT '',
  `integrante_rut` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`integrante_rut`)  COMMENT '',
  CONSTRAINT `fk_jugador_premio1`
    FOREIGN KEY (`premio_id`)
    REFERENCES `asociacion_deportes`.`premio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_jugador_integrante1`
    FOREIGN KEY (`integrante_rut`)
    REFERENCES `asociacion_deportes`.`integrante` (`rut`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `asociacion_deportes`.`equipo_evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`equipo_evento` (
  `equipo_institucion_id` INT(10) NOT NULL COMMENT '',
  `evento_id` INT(10) NOT NULL COMMENT '',
  `fecha` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`equipo_institucion_id`)  COMMENT '',
  CONSTRAINT `fk_equipo_evento_equipo1`
    FOREIGN KEY (`equipo_institucion_id`)
    REFERENCES `asociacion_deportes`.`equipo` (`institucion_id`)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipo_evento_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `asociacion_deportes`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`evento_auspiciador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`evento_auspiciador` (
  `auspiciador_id` INT(10) NOT NULL COMMENT '',
  `evento_id` INT(10) NOT NULL COMMENT '',
  PRIMARY KEY (`auspiciador_id`, `evento_id`)  COMMENT '',
  CONSTRAINT `fk_evento_auspiciador_auspiciador1`
    FOREIGN KEY (`auspiciador_id`)
    REFERENCES `asociacion_deportes`.`auspiciador` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_auspiciador_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `asociacion_deportes`.`evento` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `asociacion_deportes`.`juez_premio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`juez_premio` (
  `juez_personal_id` INT(10) NOT NULL COMMENT '',
  `premio_id` INT(10) NOT NULL COMMENT '',
  `fecha` DATE NULL COMMENT '',
  PRIMARY KEY (`juez_personal_id`, `premio_id`)  COMMENT '',
  CONSTRAINT `fk_juez_premio_juez1`
    FOREIGN KEY (`juez_personal_id`)
    REFERENCES `asociacion_deportes`.`juez` (`personal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_juez_premio_premio1`
    FOREIGN KEY (`premio_id`)
    REFERENCES `asociacion_deportes`.`premio` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `asociacion_deportes`.`sancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`sancion` (
  `id` INT(10) NOT NULL AUTO_INCREMENT COMMENT '',
  `fecha_inicio` DATE NOT NULL COMMENT '',
  `fecha_termino` DATE NOT NULL COMMENT '',
  `tipo` ENUM('Amonestación', 'expulsión') NOT NULL DEFAULT 'Amonestación' COMMENT '',
  `descripcion` TEXT NULL COMMENT '',
  `integrante_rut` VARCHAR(20) NOT NULL COMMENT '',
  `arbitro_personal_id` INT(10) NOT NULL COMMENT '',
  `directiva_rut` VARCHAR(20) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  CONSTRAINT `fk_sancion_integrante1`
    FOREIGN KEY (`integrante_rut`)
    REFERENCES `asociacion_deportes`.`integrante` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sancion_arbitro1`
    FOREIGN KEY (`arbitro_personal_id`)
    REFERENCES `asociacion_deportes`.`arbitro` (`personal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sancion_directiva1`
    FOREIGN KEY (`directiva_rut`)
    REFERENCES `asociacion_deportes`.`directiva` (`rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `asociacion_deportes`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`area` (
  `id` INT(4) NOT NULL AUTO_INCREMENT COMMENT '',
  `nombre` ENUM('Futbol', 'Tenis', 'Basquetbol', 'Gimnasia Artistica') NOT NULL COMMENT '',
  `genero` ENUM('Femenino', 'Masculino', 'Mixto') NOT NULL COMMENT '',
  `tipo` ENUM('Individual', 'Grupal') NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asociacion_deportes`.`evento_area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `asociacion_deportes`.`evento_area` (
  `evento_id` INT(10) NOT NULL COMMENT '',
  `area_id` INT(4) NOT NULL COMMENT '',
  `fecha` DATE NULL COMMENT '',
  PRIMARY KEY (`evento_id`, `area_id`)  COMMENT '',
  CONSTRAINT `fk_evento_area_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `asociacion_deportes`.`evento` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_area_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `asociacion_deportes`.`area` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;