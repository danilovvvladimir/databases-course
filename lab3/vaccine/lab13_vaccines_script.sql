-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lab0313
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab0313
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab3_13` DEFAULT CHARACTER SET utf8mb3 ;
USE `lab3_13` ;

-- -----------------------------------------------------
-- Table `lab0313`.`child`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_13`.`child` (
  `id_child` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `birthDate` DATE NOT NULL,
  PRIMARY KEY (`id_child`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab0313`.`hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_13`.`hospital` (
  `id_hospital` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `telephone` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_hospital`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab0313`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_13`.`doctor` (
  `id_doctor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `id_hospital` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_doctor`, `id_hospital`),
  INDEX `fk_doctor_hospital1_idx` (`id_hospital` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_hospital1`
    FOREIGN KEY (`id_hospital`)
    REFERENCES `lab3_13`.`hospital` (`id_hospital`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab0313`.`vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_13`.`vaccines` (
  `id_vaccine` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `shots_amount` TINYINT UNSIGNED NOT NULL,
  `revactination_time` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id_vaccine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab0313`.`vaccine_done`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_13`.`vaccine_done` (
  `id_vaccine_done` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` INT UNSIGNED NOT NULL,
  `id_vaccine` INT UNSIGNED NOT NULL,
  `id_child` INT UNSIGNED NOT NULL,
  `id_doctor` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_vaccine_done`),
  INDEX `fk_vaccine_done_child1_idx` (`id_child` ASC) VISIBLE,
  INDEX `fk_vaccine_done_doctor1_idx` (`id_doctor` ASC) VISIBLE,
  CONSTRAINT `fk_vaccine_done_child1`
    FOREIGN KEY (`id_child`)
    REFERENCES `lab3_13`.`child` (`id_child`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vaccine_done_doctor1`
    FOREIGN KEY (`id_doctor`)
    REFERENCES `lab3_13`.`doctor` (`id_doctor`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vaccine_done_vaccine2`
    FOREIGN KEY (`id_vaccine`)
    REFERENCES `lab3_13`.`vaccines` (`id_vaccine`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
