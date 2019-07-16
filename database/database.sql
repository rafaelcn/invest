CREATE SCHEMA IF NOT EXISTS `INVEST_DATABASE`;
USE `INVEST_DATABASE`;


CREATE TABLE IF NOT EXISTS TB_COMPANY (
  `COMPANY_PK` INT(11) NOT NULL AUTO_INCREMENT,
  `COMPANY_NAME` VARCHAR(100) NOT NULL,
  `COMPANY_INFO` VARCHAR(1000) NOT NULL,
  `COMPANY_SYMBOL` CHAR(5) NOT NULL UNIQUE KEY,
  PRIMARY KEY (`COMPANY_PK`));

CREATE TABLE IF NOT EXISTS TB_COMPANY_HISTORY (
  `COMPANY_HISTORY_PK` INT(11) NOT NULL AUTO_INCREMENT,
  `COMPANY_HISTORY_MINIMIUM` DOUBLE NOT NULL,
  `COMPANY_HISTORY_MAXIMIUM` DOUBLE NOT NULL,
  `COMPANY_HISTORY_DATE` DATE NOT NULL,
  `COMPANY_HISTORY_OPENING_VALUE` DOUBLE NOT NULL,
  `COMPANY_HISTORY_CLOSE_VALUE` DOUBLE NOT NULL,
  `COMPANY_PK` INT(11) NOT NULL,
  PRIMARY KEY (`COMPANY_HISTORY_PK`, `COMPANY_PK`),
  CONSTRAINT `fk_TB_COMPANY_HISTORY_TB_COMPANY_PK`
    FOREIGN KEY (`COMPANY_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_COMPANY` (`COMPANY_PK`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS TB_STOCK (
  `STOCK_PK` INT(11) NOT NULL AUTO_INCREMENT,
  `STOCK_MINIMIUM` DOUBLE NOT NULL,
  `STOCK_MAXIMUN` DOUBLE NOT NULL,
  `STOCK_OPEN_VALUE` DOUBLE NOT NULL,
  `STOCK_CLOSE_VALUE` DOUBLE NOT NULL,
  `STOCK_VALUE` DOUBLE NOT NULL,
  `TB_COMPANY_COMPANY_PK` INT(11) NOT NULL,
  PRIMARY KEY (`STOCK_PK`),
  CONSTRAINT `fk_TB_STOCK_TB_COMPANY1`
    FOREIGN KEY (`TB_COMPANY_COMPANY_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_COMPANY` (`COMPANY_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS TB_USER (
  `USER_PK` INT(11) NOT NULL AUTO_INCREMENT,
  `USER_LOGIN` VARCHAR(20) NOT NULL UNIQUE KEY,
  `USER_PASSWORD` VARCHAR(255) NOT NULL,
  `USER_NAME` VARCHAR(100) NOT NULL,
  `USER_CPF` VARCHAR(20) NOT NULL,
  `USER_EMAIL` VARCHAR(50) NOT NULL,
  `USER_BIRTH` DATE NOT NULL,
  `USER_PHONE` VARCHAR(20) NOT NULL,
  `USER_WALLET` DOUBLE NOT NULL,
  `USER_ADM` INT(1) NOT NULL,
  PRIMARY KEY (`USER_PK`));


CREATE TABLE IF NOT EXISTS TB_TRANSACTION (
  `TRANSACTION_PK` INT(11) NOT NULL AUTO_INCREMENT,
  `USER_PK` INT(11) NOT NULL,
  `STOCK_PK` INT(11) NOT NULL,
  `TRANSACTION_DATE` DATE NOT NULL,
  `TRANSACTION_TYPE` VARCHAR(45) NOT NULL,
  `TRANSACTION_QUANTITY` INT(11) NOT NULL,
  `TRANSACTION_TOTAL` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`TRANSACTION_PK`),
  CONSTRAINT `fk_TB_USER_has_TB_STOCK_TB_STOCK1`
    FOREIGN KEY (`STOCK_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_STOCK` (`STOCK_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_USER_has_TB_STOCK_TB_USER1`
    FOREIGN KEY (`USER_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_USER` (`USER_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);