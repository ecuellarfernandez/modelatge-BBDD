-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema 6_optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 6_optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `6_optics` DEFAULT CHARACTER SET utf8 ;
USE `6_optics` ;

-- -----------------------------------------------------
-- Table `6_optics`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `number` VARCHAR(5) NULL,
  `flat` VARCHAR(5) NULL,
  `door` VARCHAR(5) NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(45) NULL,
  `postal_code` VARCHAR(6) NULL,
  `phone` VARCHAR(13) NULL,
  PRIMARY KEY (`id_supplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`brand` (
  `id_brand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `supplier_id_supplier` INT NOT NULL,
  PRIMARY KEY (`id_brand`),
  INDEX `fk_brand_supplier_idx` (`supplier_id_supplier` ASC),
  CONSTRAINT `fk_brand_supplier`
    FOREIGN KEY (`supplier_id_supplier`)
    REFERENCES `6_optics`.`supplier` (`id_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`frame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`frame` (
  `id_frame` INT NOT NULL AUTO_INCREMENT,
  `frame_type` VARCHAR(45) NULL,
  `frame_color` VARCHAR(45) NULL,
  PRIMARY KEY (`id_frame`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`glass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`glass` (
  `id_glass` INT NOT NULL AUTO_INCREMENT,
  `calibration` DOUBLE NULL,
  `color` VARCHAR(45) NULL,
  PRIMARY KEY (`id_glass`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`glasses` (
  `id_glasses` INT NOT NULL AUTO_INCREMENT,
  `price` DOUBLE NULL,
  `brand_id_brand` INT NOT NULL,
  `frame_id_frame` INT NOT NULL,
  `glass_id_right` INT NOT NULL,
  `glass_id_left` INT NOT NULL,
  PRIMARY KEY (`id_glasses`),
  INDEX `fk_glasses_brand1_idx` (`brand_id_brand` ASC),
  INDEX `fk_glasses_frame1_idx` (`frame_id_frame` ASC),
  INDEX `fk_glasses_glass1_idx` (`glass_id_right` ASC),
  INDEX `fk_glasses_glass2_idx` (`glass_id_left` ASC),
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id_brand`)
    REFERENCES `6_optics`.`brand` (`id_brand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_glasses_frame1`
    FOREIGN KEY (`frame_id_frame`)
    REFERENCES `6_optics`.`frame` (`id_frame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_glasses_glass1`
    FOREIGN KEY (`glass_id_right`)
    REFERENCES `6_optics`.`glass` (`id_glass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_glasses_glass2`
    FOREIGN KEY (`glass_id_left`)
    REFERENCES `6_optics`.`glass` (`id_glass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `registration_date` DATE NULL,
  `postal_code` VARCHAR(6) NULL,
  `phone` VARCHAR(13) NULL,
  `referrer_client_id` INT NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_client_client1_idx` (`referrer_client_id` ASC),
  CONSTRAINT `fk_client_client1`
    FOREIGN KEY (`referrer_client_id`)
    REFERENCES `6_optics`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`employee` (
  `id_employee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_employee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `6_optics`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `6_optics`.`factura` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `glasses_id_glasses` INT NOT NULL,
  `client_id_client` INT NOT NULL,
  `employee_id_employee` INT NOT NULL,
  `data` TIMESTAMP NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_order_glasses1_idx` (`glasses_id_glasses` ASC),
  INDEX `fk_order_client1_idx` (`client_id_client` ASC),
  INDEX `fk_order_employee1_idx` (`employee_id_employee` ASC),
  CONSTRAINT `fk_order_glasses1`
    FOREIGN KEY (`glasses_id_glasses`)
    REFERENCES `6_optics`.`glasses` (`id_glasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `6_optics`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_id_employee`)
    REFERENCES `6_optics`.`employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
