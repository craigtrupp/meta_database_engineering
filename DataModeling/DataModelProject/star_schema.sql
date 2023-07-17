-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Table Star Schema -- 

-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Location` (
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(25) NOT NULL,
  `ZipCode` VARCHAR(25) NOT NULL,
  `LocaleID` INT NOT NULL,
  PRIMARY KEY (`LocaleID`),
  INDEX `city_state` (`City` ASC, `State` ASC) VISIBLE,
  INDEX `city_zip` (`City` ASC, `ZipCode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `OrderPriority` VARCHAR(150) NULL,
  `TotalCost` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`OrderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`Products` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(100) NOT NULL,
  `ProductCategoryID` INT NULL,
  `ProductSubCategoryID` INT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `cat_subcat_idx` (`ProductCategoryID` ASC, `ProductSubCategoryID` ASC) VISIBLE)
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
  `LocationID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `SaleProfit` DECIMAL(5,2) NOT NULL,
  `Sales` VARCHAR(45) NULL,
  `Orders_OrderID` INT NOT NULL,
  `Products_ProductID` INT NOT NULL,
  PRIMARY KEY (`SaleID`),
  INDEX `sales_location_idx` (`LocationID` ASC) VISIBLE,
  INDEX `sales_orders_id_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_Sales_Orders1_idx` (`Orders_OrderID` ASC) VISIBLE,
  INDEX `fk_Sales_Products1_idx` (`Products_ProductID` ASC) VISIBLE,
  CONSTRAINT `sales_location`
    FOREIGN KEY (`LocationID`)
    REFERENCES `GlobalSuperStore`.`Location` (`LocaleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sales_orders_id`
    FOREIGN KEY (`OrderID`)
    REFERENCES `GlobalSuperStore`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sales_Orders1`
    FOREIGN KEY (`Orders_OrderID`)
    REFERENCES `GlobalSuperStore`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Products1`
    FOREIGN KEY (`Products_ProductID`)
    REFERENCES `GlobalSuperStore`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
