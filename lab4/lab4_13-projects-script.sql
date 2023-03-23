-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lab4_13-projects
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lab4_13-projects
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lab4_13-projects` DEFAULT CHARACTER SET utf8 ;
USE `lab4_13-projects` ;

-- -----------------------------------------------------
-- Table `lab4_13-projects`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab4_13-projects`.`company` (
  `id_company` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NULL,
  PRIMARY KEY (`id_company`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab4_13-projects`.`employee_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab4_13-projects`.`employee_group` (
  `id_employee_group` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id_company` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `employees_amount` TINYINT(5) NOT NULL,
  `participation_group_id_participation_group` INT NOT NULL,
  PRIMARY KEY (`id_employee_group`),
  INDEX `fk_employee_group_company1_idx` (`company_id_company` ASC) VISIBLE,
  CONSTRAINT `fk_employee_group_company1`
    FOREIGN KEY (`company_id_company`)
    REFERENCES `lab4_13-projects`.`company` (`id_company`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab4_13-projects`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab4_13-projects`.`employee` (
  `id_employee` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_employee_group` INT(11) UNSIGNED NOT NULL,
  `id_company` INT(11) UNSIGNED NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `fk_employee_company_idx` (`id_company` ASC) VISIBLE,
  INDEX `fk_employee_employee_group1_idx` (`id_employee_group` ASC) VISIBLE,
  CONSTRAINT `fk_employee_company`
    FOREIGN KEY (`id_company`)
    REFERENCES `lab4_13-projects`.`company` (`id_company`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_employee_group1`
    FOREIGN KEY (`id_employee_group`)
    REFERENCES `lab4_13-projects`.`employee_group` (`id_employee_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab4_13-projects`.`project_done`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab4_13-projects`.`project_done` (
  `id_project_done` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id_company` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `date_start` DATE NOT NULL,
  `date_finish` DATE NOT NULL,
  PRIMARY KEY (`id_project_done`),
  INDEX `fk_project_done_company1_idx` (`company_id_company` ASC) VISIBLE,
  CONSTRAINT `fk_project_done_company1`
    FOREIGN KEY (`company_id_company`)
    REFERENCES `lab4_13-projects`.`company` (`id_company`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lab4_13-projects`.`participation_in_project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lab4_13-projects`.`participation_in_project` (
  `id_participation_in_project` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_project_done` INT(11) UNSIGNED NOT NULL,
  `id_employee_group` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_participation_in_project`),
  INDEX `fk_participation_in_project_project_done1_idx` (`id_project_done` ASC) VISIBLE,
  INDEX `fk_participation_in_project_employee_group1_idx` (`id_employee_group` ASC) VISIBLE,
  CONSTRAINT `fk_participation_in_project_project_done1`
    FOREIGN KEY (`id_project_done`)
    REFERENCES `lab4_13-projects`.`project_done` (`id_project_done`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_participation_in_project_employee_group1`
    FOREIGN KEY (`id_employee_group`)
    REFERENCES `lab4_13-projects`.`employee_group` (`id_employee_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
