-- MySQL Script generated by MySQL Workbench
-- Tue Jul 18 13:26:42 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema papema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema papema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `papema` DEFAULT CHARACTER SET utf8 ;
USE `papema` ;

-- -----------------------------------------------------
-- Table `papema`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`categorias` (
  `id_categorias` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`id_categorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`provedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`provedores` (
  `id_provedores` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `a_paterno` VARCHAR(45) NULL,
  `a_materno` VARCHAR(45) NULL,
  `agencia` VARCHAR(45) NULL,
  `calle` VARCHAR(45) NULL,
  `colonia` VARCHAR(45) NULL,
  `telefono` VARCHAR(15) NULL,
  `correo` VARCHAR(35) NULL,
  PRIMARY KEY (`id_provedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`articulos` (
  `id_articulos` INT NOT NULL AUTO_INCREMENT,
  `nombre_articulo` VARCHAR(45) NULL,
  `precio_compra_mayoreo` FLOAT NULL,
  `precio_compra_menudeo` FLOAT NULL,
  `descripcion` VARCHAR(60) NULL,
  `precio_venta` FLOAT NULL,
  `iva` FLOAT NULL,
  `existencia` INT NULL,
  `stock_maximo` INT NULL,
  `stock_minimo` INT NULL,
  `categorias_id_categorias` INT NOT NULL,
  `provedores_id_provedores` INT NOT NULL,
  PRIMARY KEY (`id_articulos`),
  INDEX `fk_articulos_categorias1_idx` (`categorias_id_categorias` ASC),
  INDEX `fk_articulos_provedores1_idx` (`provedores_id_provedores` ASC),
  CONSTRAINT `fk_articulos_categorias1`
    FOREIGN KEY (`categorias_id_categorias`)
    REFERENCES `papema`.`categorias` (`id_categorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulos_provedores1`
    FOREIGN KEY (`provedores_id_provedores`)
    REFERENCES `papema`.`provedores` (`id_provedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`clientes` (
  `id_clientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `a_paterno` VARCHAR(45) NULL,
  `a_materno` VARCHAR(45) NULL,
  `telefono` VARCHAR(15) NULL,
  `calle` VARCHAR(45) NULL,
  `colonia` VARCHAR(35) NULL,
  `num_casa` INT NULL,
  `estado` VARCHAR(4) NULL,
  `municipio` VARCHAR(4) NULL,
  `correo` VARCHAR(35) NULL,
  PRIMARY KEY (`id_clientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`compras` (
  `id_compras` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `total_compra` FLOAT NULL,
  `fecha_compra` DATETIME NULL,
  PRIMARY KEY (`id_compras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`ventas` (
  `id_ventas` INT NOT NULL AUTO_INCREMENT,
  `total_venta` FLOAT NULL,
  `fecha_venta` FLOAT NULL,
  `clientes_id_clientes` INT NOT NULL,
  PRIMARY KEY (`id_ventas`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_id_clientes` ASC),
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `papema`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`usuarios` (
  `id_usuarios` INT NOT NULL,
  `usuario` VARCHAR(10) NOT NULL,
  `contrasenia` VARCHAR(8) NOT NULL,
  `tipo_registro` VARCHAR(15) NULL,
  `nombre` VARCHAR(45) NULL,
  `a_paterno` VARCHAR(45) NULL,
  `a_materno` VARCHAR(45) NULL,
  `telefono` VARCHAR(15) NULL,
  `ciudad` VARCHAR(20) NULL,
  `calle` VARCHAR(30) NULL,
  `colonia` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`compras_articulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`compras_articulos` (
  `compras_id_compras` INT NOT NULL,
  `articulos_id_articulos` INT NOT NULL,
  PRIMARY KEY (`compras_id_compras`, `articulos_id_articulos`),
  INDEX `fk_compras_has_articulos_articulos1_idx` (`articulos_id_articulos` ASC),
  INDEX `fk_compras_has_articulos_compras_idx` (`compras_id_compras` ASC),
  CONSTRAINT `fk_compras_has_articulos_compras`
    FOREIGN KEY (`compras_id_compras`)
    REFERENCES `papema`.`compras` (`id_compras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_has_articulos_articulos1`
    FOREIGN KEY (`articulos_id_articulos`)
    REFERENCES `papema`.`articulos` (`id_articulos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `papema`.`articulos_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `papema`.`articulos_ventas` (
  `articulos_id_articulos` INT NOT NULL,
  `ventas_id_ventas` INT NOT NULL,
  PRIMARY KEY (`articulos_id_articulos`, `ventas_id_ventas`),
  INDEX `fk_articulos_has_ventas_ventas1_idx` (`ventas_id_ventas` ASC),
  INDEX `fk_articulos_has_ventas_articulos1_idx` (`articulos_id_articulos` ASC),
  CONSTRAINT `fk_articulos_has_ventas_articulos1`
    FOREIGN KEY (`articulos_id_articulos`)
    REFERENCES `papema`.`articulos` (`id_articulos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulos_has_ventas_ventas1`
    FOREIGN KEY (`ventas_id_ventas`)
    REFERENCES `papema`.`ventas` (`id_ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
