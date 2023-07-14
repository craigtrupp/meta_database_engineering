-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mangata_gallo_jewelery
-- -----------------------------------------------------
-- coursera db engineering course
-- 

-- -----------------------------------------------------
-- Schema mangata_gallo_jewelery
--
-- coursera db engineering course
-- 
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mangata_gallo_jewelery` DEFAULT CHARACTER SET utf8 ;
USE `mangata_gallo_jewelery` ;

-- -----------------------------------------------------
-- Table `mangata_gallo_jewelery`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mangata_gallo_jewelery`.`Clients` (
  `ClientID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ClientID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mangata_gallo_jewelery`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mangata_gallo_jewelery`.`Products` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(255) NOT NULL,
  `BuyPrice` DECIMAL(10,2) NOT NULL,
  `SellPrice` DECIMAL(10,2) NOT NULL,
  `AmountInStock` INT NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mangata_gallo_jewelery`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mangata_gallo_jewelery`.`Orders` (
  `OrderID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalPrice` DECIMAL(10,2) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `ClientID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `client_id_fk_idx` (`ClientID` ASC) VISIBLE,
  INDEX `product_id_fk_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `client_id_fk`
    FOREIGN KEY (`ClientID`)
    REFERENCES `mangata_gallo_jewelery`.`Clients` (`ClientID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id_fk`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mangata_gallo_jewelery`.`Products` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mangata_gallo_jewelery`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mangata_gallo_jewelery`.`Address` (
  `AddressID` INT NOT NULL,
  `Street` VARCHAR(255) NOT NULL,
  `ZipCode` VARCHAR(15) NULL,
  `State` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mangata_gallo_jewelery`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mangata_gallo_jewelery`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATE NULL,
  `DeliveryStatus` VARCHAR(255) NOT NULL,
  `Comment` VARCHAR(255) NULL,
  `OrderID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `order_id_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `address_id_fk_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `order_id_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mangata_gallo_jewelery`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `address_id_fk`
    FOREIGN KEY (`AddressID`)
    REFERENCES `mangata_gallo_jewelery`.`Address` (`AddressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
