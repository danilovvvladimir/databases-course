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
CREATE SCHEMA IF NOT EXISTS `lab0313` DEFAULT CHARACTER SET utf8mb3 ;
-- -----------------------------------------------------
-- Schema lab3_14
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab3_14
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab3_14` DEFAULT CHARACTER SET utf8mb3 ;
USE `lab0313` ;

-- -----------------------------------------------------
-- Table `lab0313`.`child`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab0313`.`child` (
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
CREATE TABLE IF NOT EXISTS `lab0313`.`hospital` (
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
CREATE TABLE IF NOT EXISTS `lab0313`.`doctor` (
  `id_doctor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `id_hospital` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_doctor`, `id_hospital`),
  INDEX `fk_doctor_hospital1_idx` (`id_hospital` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_hospital1`
    FOREIGN KEY (`id_hospital`)
    REFERENCES `lab0313`.`hospital` (`id_hospital`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab0313`.`vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab0313`.`vaccines` (
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
CREATE TABLE IF NOT EXISTS `lab0313`.`vaccine_done` (
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
    REFERENCES `lab0313`.`child` (`id_child`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vaccine_done_doctor1`
    FOREIGN KEY (`id_doctor`)
    REFERENCES `lab0313`.`doctor` (`id_doctor`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vaccine_done_vaccine2`
    FOREIGN KEY (`id_vaccine`)
    REFERENCES `lab0313`.`vaccines` (`id_vaccine`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `lab3_14` ;

-- -----------------------------------------------------
-- Table `lab3_14`.`p_e_standart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_14`.`p_e_standart` (
  `id_p_e_standart` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `average_result` VARCHAR(45) NOT NULL,
  `record_result` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_p_e_standart`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab3_14`.`university`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_14`.`university` (
  `id_university` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_university`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab3_14`.`p_e_teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_14`.`p_e_teacher` (
  `id_p_e_teacher` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `university_id_university` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_p_e_teacher`, `university_id_university`),
  INDEX `fk_p_e_teacher_university1_idx` (`university_id_university` ASC) VISIBLE,
  CONSTRAINT `fk_p_e_teacher_university1`
    FOREIGN KEY (`university_id_university`)
    REFERENCES `lab3_14`.`university` (`id_university`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab3_14`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_14`.`student` (
  `id_student` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `group` VARCHAR(45) NOT NULL,
  `id_university` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_student`, `id_university`),
  INDEX `fk_student_university1_idx` (`id_university` ASC) VISIBLE,
  CONSTRAINT `fk_student_university1`
    FOREIGN KEY (`id_university`)
    REFERENCES `lab3_14`.`university` (`id_university`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `lab3_14`.`result`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab3_14`.`result` (
  `id_result` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_p_e_standart` INT UNSIGNED NOT NULL,
  `id_student` INT UNSIGNED NOT NULL,
  `id_p_e_teacher` INT UNSIGNED NOT NULL,
  `grade` TINYINT NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  INDEX `fk_result_p_e_standart1_idx` (`id_p_e_standart` ASC) VISIBLE,
  INDEX `fk_result_student1_idx` (`id_student` ASC) VISIBLE,
  INDEX `fk_result_p_e_teacher1_idx` (`id_p_e_teacher` ASC) VISIBLE,
  PRIMARY KEY (`id_result`),
  CONSTRAINT `fk_result_p_e_standart1`
    FOREIGN KEY (`id_p_e_standart`)
    REFERENCES `lab3_14`.`p_e_standart` (`id_p_e_standart`),
  CONSTRAINT `fk_result_p_e_teacher1`
    FOREIGN KEY (`id_p_e_teacher`)
    REFERENCES `lab3_14`.`p_e_teacher` (`id_p_e_teacher`),
  CONSTRAINT `fk_result_student1`
    FOREIGN KEY (`id_student`)
    REFERENCES `lab3_14`.`student` (`id_student`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
