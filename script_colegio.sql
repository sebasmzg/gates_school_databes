SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema bx6crrqekkqo9qroeyb0
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bx6crrqekkqo9qroeyb0` DEFAULT CHARACTER SET utf8mb4 ;
USE `bx6crrqekkqo9qroeyb0` ;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`grados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`grados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`tipo_documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`tipo_documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_documento` VARCHAR(25) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`sede` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`jornada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`jornada` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `hora_salida` TIME NOT NULL,
  `sede_id` INT NOT NULL,
  PRIMARY KEY (`id`, `sede_id`),
  INDEX `fk_jornada_sede1_idx` (`sede_id` ASC) VISIBLE,
  CONSTRAINT `fk_jornada_sede1`
    FOREIGN KEY (`sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`bloque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`bloque` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `sede_id` INT NOT NULL,
  PRIMARY KEY (`id`, `sede_id`),
  INDEX `fk_bloque_sede1_idx` (`sede_id` ASC) VISIBLE,
  CONSTRAINT `fk_bloque_sede1`
    FOREIGN KEY (`sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`aulas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`aulas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  `bloque_id` INT NOT NULL,
  `bloque_sede_id` INT NOT NULL,
  PRIMARY KEY (`id`, `bloque_id`, `bloque_sede_id`),
  INDEX `fk_aulas_bloque1_idx` (`bloque_id` ASC, `bloque_sede_id` ASC) VISIBLE,
  CONSTRAINT `fk_aulas_bloque1`
    FOREIGN KEY (`bloque_id` , `bloque_sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`bloque` (`id` , `sede_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Adding necessary index to `aulas` table for foreign key constraint
ALTER TABLE `bx6crrqekkqo9qroeyb0`.`aulas`
ADD INDEX `idx_bloque_sede_id` (`bloque_sede_id`);

-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`coordinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`coordinador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `sede_id` INT NOT NULL,
  `jornada_id` INT NOT NULL,
  `jornada_sede_id` INT NOT NULL,
  `tipo_documento_id` INT NOT NULL,
  PRIMARY KEY (`id`, `sede_id`, `jornada_id`, `jornada_sede_id`, `tipo_documento_id`),
  INDEX `fk_coordinador_sede1_idx` (`sede_id` ASC) VISIBLE,
  INDEX `fk_coordinador_jornada1_idx` (`jornada_id` ASC, `jornada_sede_id` ASC) VISIBLE,
  INDEX `fk_coordinador_tipo_documento1_idx` (`tipo_documento_id` ASC) VISIBLE,
  CONSTRAINT `fk_coordinador_sede1`
    FOREIGN KEY (`sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coordinador_jornada1`
    FOREIGN KEY (`jornada_id` , `jornada_sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`jornada` (`id` , `sede_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coordinador_tipo_documento1`
    FOREIGN KEY (`tipo_documento_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`tipo_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`profesores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  `apellido` CHAR(25) NOT NULL,
  `sede_id` INT NOT NULL,
  `coordinador_id` INT NOT NULL,
  `tipo_documento_id` INT NOT NULL,
  PRIMARY KEY (`id`, `sede_id`, `coordinador_id`, `tipo_documento_id`),
  INDEX `fk_profesores_sede1_idx` (`sede_id` ASC) VISIBLE,
  INDEX `fk_profesores_coordinador1_idx` (`coordinador_id` ASC) VISIBLE,
  INDEX `fk_profesores_tipo_documento1_idx` (`tipo_documento_id` ASC) VISIBLE,
  CONSTRAINT `fk_profesores_sede1`
    FOREIGN KEY (`sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`sede` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesores_coordinador1`
    FOREIGN KEY (`coordinador_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`coordinador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesores_tipo_documento1`
    FOREIGN KEY (`tipo_documento_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`tipo_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`materias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  `profesores_id` INT NOT NULL,
  PRIMARY KEY (`id`, `profesores_id`),
  INDEX `fk_materias_profesores1_idx` (`profesores_id` ASC) VISIBLE,
  CONSTRAINT `fk_materias_profesores1`
    FOREIGN KEY (`profesores_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`profesores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`horarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hora_inicio_materia` TIME NOT NULL,
  `hora_fin_materia` TIME NOT NULL,
  `dia` VARCHAR(10) NULL,
  `jornada_sede_id` INT NOT NULL,
  `aulas_bloque_sede_id` INT NOT NULL,
  `materias_profesores_id` INT NOT NULL,
  PRIMARY KEY (`id`, `jornada_sede_id`, `aulas_bloque_sede_id`, `materias_profesores_id`),
  INDEX `fk_horarios_jornada1_idx` (`jornada_sede_id` ASC) VISIBLE,
  INDEX `fk_horarios_aulas1_idx` (`aulas_bloque_sede_id` ASC) VISIBLE,
  INDEX `fk_horarios_materias1_idx` (`materias_profesores_id` ASC) VISIBLE,
  CONSTRAINT `fk_horarios_jornada1`
    FOREIGN KEY (`jornada_sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`jornada` (`sede_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horarios_aulas1`
    FOREIGN KEY (`aulas_bloque_sede_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`aulas` (`bloque_sede_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horarios_materias1`
    FOREIGN KEY (`materias_profesores_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`materias` (`profesores_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`grupos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(25) NOT NULL,
  `grados_id` INT NOT NULL,
  `horarios_id` INT NOT NULL,
  PRIMARY KEY (`id`, `grados_id`, `horarios_id`),
  INDEX `fk_grupos_grados1_idx` (`grados_id` ASC) VISIBLE,
  INDEX `fk_grupos_horarios1_idx` (`horarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_grupos_grados1`
    FOREIGN KEY (`grados_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`grados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_horarios1`
    FOREIGN KEY (`horarios_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`horarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bx6crrqekkqo9qroeyb0`.`estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bx6crrqekkqo9qroeyb0`.`estudiantes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(30) NOT NULL,
  `apellido` CHAR(30) NOT NULL,
  `grados_id` INT NOT NULL,
  `tipo_documento_id` INT NOT NULL,
  `grupos_id` INT NOT NULL,
  PRIMARY KEY (`id`, `grados_id`, `tipo_documento_id`, `grupos_id`),
  INDEX `fk_estudiantes_grados1_idx` (`grados_id` ASC) VISIBLE,
  INDEX `fk_estudiantes_tipo_documento1_idx` (`tipo_documento_id` ASC) VISIBLE,
  INDEX `fk_estudiantes_grupos1_idx` (`grupos_id` ASC) VISIBLE,
  CONSTRAINT `fk_estudiantes_grados1`
    FOREIGN KEY (`grados_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`grados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiantes_tipo_documento1`
    FOREIGN KEY (`tipo_documento_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`tipo_documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiantes_grupos1`
    FOREIGN KEY (`grupos_id`)
    REFERENCES `bx6crrqekkqo9qroeyb0`.`grupos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
