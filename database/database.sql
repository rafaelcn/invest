CREATE SCHEMA IF NOT EXISTS `INVEST_DATABASE` DEFAULT CHARACTER SET utf8 ;
USE `INVEST_DATABASE` ;


CREATE TABLE IF NOT EXISTS `INVEST_DATABASE`.`TB_COMPANY` (
  `COMPANY_PK` INT(11) NOT NULL,
  `COMPANY_NAME` VARCHAR(100) NOT NULL,
  `COMPANY_INFO` VARCHAR(1000) NOT NULL,
  `COMPANY_SYMBOL` CHAR(10) NOT NULL,
  PRIMARY KEY (`COMPANY_PK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `INVEST_DATABASE`.`TB_COMPANY_HISTORY` (
  `COMPANY_HISTORY_PK` INT(11) NOT NULL,
  `COMPANY_HISTORY_MINIMIUM` DOUBLE NOT NULL,
  `COMPANY_HISTORY_MAXIMIUM` DOUBLE NOT NULL,
  `COMPANY_PK` INT(11) NOT NULL,
  `COMPANY_HISTORY_DATE` DATE NOT NULL,
  `COMPANY_HISTORY_OPENING_VALUE` DOUBLE NOT NULL,
  `COMPANY_HISTORY_CLOSE_VALUE` DOUBLE NOT NULL,
  PRIMARY KEY (`COMPANY_HISTORY_PK`, `COMPANY_PK`),
  INDEX `fk_TB_COMPANY_HISTORIC_TB_COMPANY1` (`COMPANY_PK` ASC) VISIBLE,
  CONSTRAINT `fk_TB_COMPANY_HISTORIC_TB_COMPANY1`
    FOREIGN KEY (`COMPANY_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_COMPANY` (`COMPANY_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `INVEST_DATABASE`.`TB_STOCK` (
  `STOCK_MINIMIUM` DOUBLE NOT NULL,
  `STOCK_MAXIMUN` DOUBLE NOT NULL,
  `STOCK_OPENING` DOUBLE NOT NULL,
  `STOCK_PK` INT(11) NOT NULL,
  `TB_COMPANY_COMPANY_PK` INT(11) NOT NULL,
  `STOCK_VALUE` DOUBLE NOT NULL,
  `STOCK_CLOSE_VALUE` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`STOCK_PK`),
  INDEX `fk_TB_STOCK_TB_COMPANY1` (`TB_COMPANY_COMPANY_PK` ASC) VISIBLE,
  CONSTRAINT `fk_TB_STOCK_TB_COMPANY1`
    FOREIGN KEY (`TB_COMPANY_COMPANY_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_COMPANY` (`COMPANY_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `INVEST_DATABASE`.`TB_USER` (
  `USER_PK` INT(11) NOT NULL,
  `USER_NAME` VARCHAR(100) NOT NULL,
  `USER_WALLET` DOUBLE NOT NULL,
  `USER_PASSWORD` VARCHAR(255) NOT NULL,
  `USER_LOGIN` VARCHAR(20) NOT NULL,
  `USER_CPF` VARCHAR(20) NOT NULL,
  `USER_EMAIL` VARCHAR(50) NOT NULL,
  `USER_DATE_OF_BIRTH` DATE NOT NULL,
  `USER_CELL_PHONE` VARCHAR(20) NOT NULL,
  `USER_ADM` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`USER_PK`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `INVEST_DATABASE`.`TB_TRANSACTION` (
  `USER_USER_PK_CODE` INT(11) NOT NULL,
  `STOCK_PK` INT(11) NOT NULL,
  `TRANSACTION_DATE` DATE NOT NULL,
  `TRANSACTION_TYPE` VARCHAR(45) NOT NULL,
  `TRANSACTION_QUANTITY` INT(11) NOT NULL,
  `TRANSACTION_TOTAL` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`USER_USER_PK_CODE`, `STOCK_PK`),
  INDEX `fk_TB_USER_has_TB_STOCK_TB_STOCK1` (`STOCK_PK` ASC) VISIBLE,
  CONSTRAINT `fk_TB_USER_has_TB_STOCK_TB_STOCK1`
    FOREIGN KEY (`STOCK_PK`)
    REFERENCES `INVEST_DATABASE`.`TB_STOCK` (`STOCK_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TB_USER_has_TB_STOCK_TB_USER1`
    FOREIGN KEY (`USER_USER_PK_CODE`)
    REFERENCES `INVEST_DATABASE`.`TB_USER` (`USER_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


DELIMITER //
CREATE  PROCEDURE P_DELETE_USER (IN PK_CODE INT)
BEGIN
    IF EXISTS (SELECT USER_PK FROM TB_USER WHERE USER_PK = PK_CODE)
    THEN
        DELETE FROM TB_USER WHERE USER_PK = PK_CODE;
    END IF;
END
//


DELIMITER //
CREATE  PROCEDURE P_DELETE_USER_NAME (IN LOGIN VARCHAR(20))
BEGIN
    IF EXISTS (SELECT USER_LOGIN FROM TB_USER WHERE USER_LOGIN = LOGIN)
    THEN
        DELETE FROM TB_USER WHERE USER_LOGIN = LOGIN;
    END IF;
END
//


DELIMITER //
CREATE  PROCEDURE P_INSERT_USER (PK_CODE INT, WALLET DOUBLE, LOGIN VARCHAR(20),
                               CPF VARCHAR(20), EMAIL VARCHAR(50), PASSWORD VARCHAR(255),
                               PHONE VARCHAR(20), NASC DATE, NOME VARCHAR(100))
BEGIN
    INSERT INTO TB_USER (USER_PK, USER_NAME, USER_WALLET, USER_PASSWORD, USER_LOGIN,
                         USER_CPF, USER_EMAIL, USER_DATE_OF_BIRTH, USER_CELL_PHONE, USER_ADM)
    VALUES (PK_CODE, NOME, WALLET, PASSWORD, LOGIN, CPF, EMAIL, NASC, PHONE, 0);
END
//

DELIMITER //
CREATE  PROCEDURE P_INSERT_ADM (PK_CODE INT, WALLET DOUBLE, LOGIN VARCHAR(20),
                              CPF VARCHAR(20), EMAIL VARCHAR(50), PASSWORD VARCHAR(255),
                              PHONE VARCHAR(20), NASC DATE, NOME VARCHAR(100))
BEGIN
    INSERT INTO TB_USER (USER_PK, USER_NAME, USER_WALLET, USER_PASSWORD, USER_LOGIN,
                         USER_CPF, USER_EMAIL, USER_DATE_OF_BIRTH, USER_CELL_PHONE, USER_ADM)
    VALUES (PK_CODE, NOME, WALLET, PASSWORD, LOGIN , CPF, EMAIL, NASC, PHONE , 1);
END
//


DELIMITER //
CREATE  PROCEDURE P_SELECT_ADM (IN PK_CODE INT)
BEGIN
  SELECT * FROM TB_USER WHERE USER_ADM = PK_CODE;
END
//


DELIMITER //
CREATE  PROCEDURE P_UPDATE_EMAIL (PK_CODE INT, EMAIL VARCHAR(50))
BEGIN
    IF EXISTS (SELECT USER_EMAIL FROM TB_USER WHERE USER_EMAIL = EMAIL AND
               USER_PK = PK_CODE)
    THEN
        UPDATE TB_USER SET USER_EMAIL = EMAIL WHERE USER_PK = PK_CODE;
    END IF;
END
//


DELIMITER //
CREATE PROCEDURE P_UPDATE_PASS (PK_CODE INT, LOGIN VARCHAR(20), PASSWORD VARCHAR(255),
                               NEW_PASSWORD VARCHAR(255))
BEGIN
    IF EXISTS (SELECT USER_PASSWORD FROM TB_USER WHERE USER_PASSWORD = PASSWORD AND
               USER_LOGIN = LOGIN)
    THEN
        UPDATE TB_USER SET USER_PASSWORD = NEW_PASSWORD WHERE USER_PK = PK_CODE;
    END IF;
END
//


DELIMITER //
CREATE PROCEDURE P_UPDATE_PHONE (PK_CODE INT, PHONE VARCHAR(20))
BEGIN
    IF EXISTS (SELECT USER_PK FROM TB_USER WHERE USER_PK = PK_CODE)
    THEN
        UPDATE TB_USER SET USER_CELL_PHONE = PHONE WHERE USER_PK = PK_CODE;
    END IF;
END
//


DELIMITER //
CREATE  PROCEDURE P_UPDATE_WALLET (PK_CODE INT, VALUE DOUBLE)
BEGIN
    IF EXISTS (SELECT USER_PK FROM TB_USER WHERE USER_PK = PK_CODE)
    THEN
        UPDATE TB_USER SET USER_WALLET = VALUE WHERE USER_PK = PK_CODE;
    END IF;
END
//
