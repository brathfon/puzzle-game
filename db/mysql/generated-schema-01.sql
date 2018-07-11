-- MySQL Script generated by MySQL Workbench
-- Tue Jul 10 11:30:06 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema puzzle_game
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `puzzle_game` ;

-- -----------------------------------------------------
-- Schema puzzle_game
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `puzzle_game` DEFAULT CHARACTER SET latin1 ;
SHOW WARNINGS;
USE `puzzle_game` ;

-- -----------------------------------------------------
-- Table `puzzle_pieces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `puzzle_pieces` (
  `puzzle_piece_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `price` INT UNSIGNED NOT NULL,
  `is_available` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `last_update` TIMESTAMP NOT NULL,
  `employer_and_occupation` VARCHAR(64) NULL DEFAULT NULL,
  `paypal_payment_id` VARCHAR(32) NULL DEFAULT NULL,
  `first_name` VARCHAR(32) NULL DEFAULT NULL,
  `last_name` VARCHAR(32) NULL DEFAULT NULL,
  `comments` VARCHAR(1024) NULL DEFAULT NULL,
  PRIMARY KEY (`puzzle_piece_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(32) NOT NULL,
  `last_name` VARCHAR(32) NOT NULL,
  `initials` VARCHAR(3) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `email` VARCHAR(64) NOT NULL,
  `phone_number` VARCHAR(32) NULL DEFAULT NULL,
  `salt` CHAR(32) NULL DEFAULT NULL COMMENT 'salt and hash are used to generate and check the password',
  `hash` CHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_idx` (`email` ASC)  COMMENT 'The email is their user id',
  UNIQUE INDEX `initials_idx` (`initials` ASC)  COMMENT 'just in case first and last name match another user.')
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `abrv` VARCHAR(4) NULL COMMENT 'Abbreviation like QA, DE',
  `long_name` VARCHAR(45) NULL COMMENT 'ex: Quality Assurance',
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `roll_name_UNIQUE` (`long_name` ASC),
  UNIQUE INDEX `abrv_UNIQUE` (`abrv` ASC),
  UNIQUE INDEX `rolls` (`role_id` ASC, `abrv` ASC)  COMMENT 'cover the surrogate key and natural key')
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` INT UNSIGNED NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  UNIQUE INDEX `user_roles` (`user_id` ASC, `role_id` ASC),
  CONSTRAINT `user`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `role`
    FOREIGN KEY (`role_id`)
    REFERENCES `roles` (`role_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `logs` (
  `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `when` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user` VARCHAR(65) NOT NULL COMMENT 'who was logged in and using the app, but may have messages before user logs in.',
  `logging_level` VARCHAR(16) NOT NULL COMMENT 'correspond to bootstrap values: primary, secondary, success, info, warning, danger',
  `title` VARCHAR(64) NOT NULL,
  `json_text` VARCHAR(512) NULL COMMENT 'array of strings to further describe the logged information',
  PRIMARY KEY (`log_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
