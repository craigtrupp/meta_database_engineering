-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GlobalSuperStore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GlobalSuperStore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GlobalSuperStore` DEFAULT CHARACTER SET utf8 ;
USE `GlobalSuperStore` ;

-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(100) NOT NULL,
  `ContactEmail` VARCHAR(100) NOT NULL,
  `ContactPhone` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Categories` (
  `CategoryID` INT NOT NULL,
  `CategoryName` VARCHAR(155) NOT NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Subcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Subcategories` (
  `SubCategoryID` INT NOT NULL,
  `SubCategoryName` VARCHAR(155) NOT NULL,
  PRIMARY KEY (`SubCategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Products` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(100) NOT NULL,
  `Quantity` INT NOT NULL,
  `ProductSubCategoryID` INT NOT NULL,
  `ProductCategoryID` INT NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `CategoryID_idx` (`ProductCategoryID` ASC) VISIBLE,
  INDEX `SubCategoryID_idx` (`ProductSubCategoryID` ASC) VISIBLE,
  CONSTRAINT `prdcts_CategoryID`
    FOREIGN KEY (`ProductCategoryID`)
    REFERENCES `GlobalSuperStore`.`Categories` (`CategoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `prdcts_SubCategoryID`
    FOREIGN KEY (`ProductSubCategoryID`)
    REFERENCES `GlobalSuperStore`.`Subcategories` (`SubCategoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Discount` DECIMAL(3,2) NULL,
  `OrderPriority` VARCHAR(150) NULL,
  `TotalCost` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `ProductID_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `ords_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `GlobalSuperStore`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ords_ProductID`
    FOREIGN KEY (`ProductID`)
    REFERENCES `GlobalSuperStore`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`CustomerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`CustomerAddress` (
  `CustomerAddressID` INT NOT NULL,
  `CustomerAddress` VARCHAR(255) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(25) NOT NULL,
  `ZipCode` VARCHAR(25) NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`CustomerAddressID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `ca_customer_id`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `GlobalSuperStore`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Shipments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Shipments` (
  `ShipmentID` INT NOT NULL,
  `ShipmentDate` DATE NOT NULL,
  `ShipmentMode` VARCHAR(100) NOT NULL,
  `ShipmentCost` DECIMAL(5,2) NOT NULL,
  `CustomerAddressID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  PRIMARY KEY (`ShipmentID`),
  INDEX `customerAddressID_idx` (`CustomerAddressID` ASC) VISIBLE,
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `shp_customerAddressID`
    FOREIGN KEY (`CustomerAddressID`)
    REFERENCES `GlobalSuperStore`.`CustomerAddress` (`CustomerAddressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `shp_OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `GlobalSuperStore`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Sales` (
  `SaleID` INT NOT NULL,
  `TotalSalePrice` DECIMAL(7,2) NOT NULL,
  `TotalProductPrice` DECIMAL(7,2) NOT NULL,
  `ShipmentCost` DECIMAL(5,2) NULL,
  `Quantity` INT NOT NULL,
  `OrderID` INT NOT NULL,
  `CustomerAddressShipmentID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `SaleProfit` DECIMAL(5,2) NULL,
  PRIMARY KEY (`SaleID`),
  INDEX `sl_productID_idx` (`ProductID` ASC) VISIBLE,
  INDEX `sl_orderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `sl_customerAddressID_idx` (`CustomerAddressShipmentID` ASC) VISIBLE,
  CONSTRAINT `sl_productID`
    FOREIGN KEY (`ProductID`)
    REFERENCES `GlobalSuperStore`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sl_orderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `GlobalSuperStore`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sl_customerAddressID`
    FOREIGN KEY (`CustomerAddressShipmentID`)
    REFERENCES `GlobalSuperStore`.`CustomerAddress` (`CustomerAddressID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
