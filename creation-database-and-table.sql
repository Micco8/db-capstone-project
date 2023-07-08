-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`State`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`State` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`City` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `StateId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_City_State_idx` (`StateId` ASC) VISIBLE,
  CONSTRAINT `fk_City_State`
    FOREIGN KEY (`StateId`)
    REFERENCES `LittleLemonDB`.`State` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Type` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Cuisine` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Category_Id` INT NOT NULL,
  `Price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_MenuItems_Category1_idx` (`Category_Id` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItems_Category1`
    FOREIGN KEY (`Category_Id`)
    REFERENCES `LittleLemonDB`.`Type` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems_has_Cuisine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems_has_Cuisine` (
  `MenuItems_Id` INT NOT NULL,
  `Cuisine_Id` INT NOT NULL,
  PRIMARY KEY (`MenuItems_Id`, `Cuisine_Id`),
  INDEX `fk_MenuItems_has_Cuisine_Cuisine1_idx` (`Cuisine_Id` ASC) VISIBLE,
  INDEX `fk_MenuItems_has_Cuisine_MenuItems1_idx` (`MenuItems_Id` ASC) VISIBLE,
  CONSTRAINT `fk_MenuItems_has_Cuisine_MenuItems1`
    FOREIGN KEY (`MenuItems_Id`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenuItems_has_Cuisine_Cuisine1`
    FOREIGN KEY (`Cuisine_Id`)
    REFERENCES `LittleLemonDB`.`Cuisine` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_has_MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_has_MenuItems` (
  `Menu_Id` INT NOT NULL,
  `MenuItems_Id` INT NOT NULL,
  `Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Menu_has_MenuItems_MenuItems1_idx` (`MenuItems_Id` ASC) VISIBLE,
  INDEX `fk_Menu_has_MenuItems_Menu1_idx` (`Menu_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_has_MenuItems_Menu1`
    FOREIGN KEY (`Menu_Id`)
    REFERENCES `LittleLemonDB`.`Menu` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_MenuItems_MenuItems1`
    FOREIGN KEY (`MenuItems_Id`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `Id` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Roles` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `Id` INT NOT NULL,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Salary` DECIMAL(8,6) NOT NULL,
  `Role` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Staff_Roles1_idx` (`Role` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Roles1`
    FOREIGN KEY (`Role`)
    REFERENCES `LittleLemonDB`.`Roles` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `Id` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `BookingSlot` DATETIME NOT NULL,
  `Customer` INT NOT NULL,
  `Employee` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Bookings_Customers1_idx` (`Customer` ASC) VISIBLE,
  INDEX `fk_Bookings_Staff1_idx` (`Employee` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customers1`
    FOREIGN KEY (`Customer`)
    REFERENCES `LittleLemonDB`.`Customers` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Staff1`
    FOREIGN KEY (`Employee`)
    REFERENCES `LittleLemonDB`.`Staff` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderStatus` (
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `Id` INT NOT NULL,
  `Booking` INT NOT NULL,
  `Status` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Orders_Bookings1_idx` (`Booking` ASC) VISIBLE,
  INDEX `fk_Orders_OrderStatus1_idx` (`Status` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Bookings1`
    FOREIGN KEY (`Booking`)
    REFERENCES `LittleLemonDB`.`Bookings` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_OrderStatus1`
    FOREIGN KEY (`Status`)
    REFERENCES `LittleLemonDB`.`OrderStatus` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItemsOrdered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItemsOrdered` (
  `Menu_has_MenuItems_Id` INT NOT NULL,
  `Orders_Id` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`Menu_has_MenuItems_Id`, `Orders_Id`),
  INDEX `fk_Menu_has_MenuItems_has_Orders_Orders1_idx` (`Orders_Id` ASC) VISIBLE,
  INDEX `fk_Menu_has_MenuItems_has_Orders_Menu_has_MenuItems1_idx` (`Menu_has_MenuItems_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_has_MenuItems_has_Orders_Menu_has_MenuItems1`
    FOREIGN KEY (`Menu_has_MenuItems_Id`)
    REFERENCES `LittleLemonDB`.`Menu_has_MenuItems` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_MenuItems_has_Orders_Orders1`
    FOREIGN KEY (`Orders_Id`)
    REFERENCES `LittleLemonDB`.`Orders` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
