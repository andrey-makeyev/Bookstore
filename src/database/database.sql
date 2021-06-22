DROP DATABASE IF EXISTS `bookstore`;
CREATE DATABASE IF NOT EXISTS `bookstore`/*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `bookstore`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `books`;
DROP TABLE IF EXISTS `accounts`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `cart_items`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE `books` (
                         `id` INT(11) NOT NULL,
                         `isbn` VARCHAR(20) NOT NULL,
                         `title` VARCHAR(128) NOT NULL,
                         `author` VARCHAR(50) NOT NULL,
                         `publisher` VARCHAR(128) NOT NULL,
                         `year` SMALLINT NOT NULL,
                         `description` VARCHAR(255) NOT NULL,
                         `price` DOUBLE PRECISION NOT NULL,
                         `image` MEDIUMBLOB
);

ALTER TABLE `books`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `books`
    ADD CONSTRAINT `books_isbn_uk` UNIQUE (`isbn`);

CREATE TABLE `accounts` (
                            `id` INT(11) NOT NULL,
                            `user_name` VARCHAR(20) NOT NULL,
                            `is_active` BIT NOT NULL,
                            `password_hash` VARCHAR(128) NOT NULL,
                            `user_role` VARCHAR(20) NOT NULL
);

ALTER TABLE `accounts`
    ADD PRIMARY KEY (`id`);

CREATE TABLE `orders` (
                          `id` INT(11) NOT NULL,
                          `amount` DOUBLE PRECISION NOT NULL,
                          `customer_address` VARCHAR(255) NOT NULL,
                          `customer_email` VARCHAR(128) NOT NULL,
                          `customer_name` VARCHAR(255) NOT NULL,
                          `customer_phone` VARCHAR(128) NOT NULL,
                          `order_date` DATETIME NOT NULL,
                          `order_number` INTEGER NOT NULL
);

ALTER TABLE `orders`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `orders`
    ADD CONSTRAINT `orders_uk` UNIQUE (`order_number`);

CREATE TABLE `cart_items` (
                              `id` INT(11) NOT NULL,
                              `amount` DOUBLE PRECISION NOT NULL,
                              `price` DOUBLE PRECISION NOT NULL,
                              `quantity` INTEGER NOT NULL,
                              `order_id` INT(11) NOT NULL,
                              `book_id` INT(11) NOT NULL
);

ALTER TABLE `cart_items`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `cart_items`
    ADD CONSTRAINT `cart_items_orders_fk` FOREIGN KEY (`order_id`)
        REFERENCES `orders` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;

ALTER TABLE `cart_items`
    ADD CONSTRAINT `cart_items_books_fk` FOREIGN KEY (`book_id`)
        REFERENCES `books` (`id`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION;

ALTER TABLE `cart_items`
    ADD INDEX `cart_items_orders_fk_index` (`order_id` ASC);

ALTER TABLE `cart_items`
    ADD INDEX `cart_items_books_fk_index` (`book_id` ASC);

CREATE TABLE `hibernate_sequence` (
    `sequence_name` VARCHAR(255) NOT NULL,
    `next_val` INT(11) NOT NULL
);

INSERT INTO `hibernate_sequence` (`sequence_name`, `next_val`) VALUES ('default', 1000);

INSERT INTO accounts (`id`, `user_name`, `is_active`, `password_hash`, `user_role`)
VALUES (1, 'admin', 1,
        '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'ROLE_ADMIN');

INSERT INTO accounts (`id`, `user_name`, `is_active`, `password_hash`, `user_role`)
VALUES (2, 'op', 1,
        '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'ROLE_OP');

INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (1, '978-5-699-12014-1', 'Jaskaran Cullen', 'Tales of the Heart', 1999, 'Grand Encore Multimedia', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 55.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (2, '978-5-699-12014-2', 'Georgiana Wormald', 'The Search For Bella', 2018, 'I Wear Sunglasses', 'Est ea labore eripuit, impedit torquatos cu duo, audiam fabellas te qui. Maiorum hendrerit ea duo, ubique sententiae ius ex. Vix ea probo liber adolescens. Vix illud patrioque ad, vim et quem recteque. Et omnium dissentiunt qui, ne assum novum cum. Eu lorem congue partem quo, eum saepe congue cu. Nec cu affert ullamcorper.', 12.12);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (3, '978-5-699-12014-3', 'Brendon May', 'One Shot', 2000, 'Bloomberg Lp', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 60.84);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (4, '978-5-699-12014-4', 'Nancy North', 'Monster Strike', 2021, 'Allegheny Music Works', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 54.34);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (5, '978-5-699-12014-5', 'Soren Luna', 'Snow This Christmas', 2014, 'Lane Guide', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 56.93);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (6, '978-5-699-12014-6', 'Aalia Martins', 'Burning The Breeze', 2015, 'Daverci Solutions Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 10.67);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (7, '978-5-699-12014-7', 'Kaydan Daniels', 'Warrior Princess', 2016, 'Lrp Publications Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 110.50);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (8, '978-5-699-12014-8', 'Emmie Shah', 'The Lost Soul', 2017, 'Ares Publishers; Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 174.85);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (9, '978-5-699-12014-9', 'Tonicha Kelly', 'The Blue Knight', 1998, 'Minnesota Political Press', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 09.64);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (10, '978-5-699-12014-10', 'Joshua Simon', 'Watch Out', 2017, 'Bond Internet Services', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 08.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (11, '978-5-699-12014-11', 'T-Jay Charles', 'Bad Surprise', 2010, 'Baker And Associates Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 84.94);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (12, '978-5-699-12014-12', 'Aqsa Bird', 'Back In TIme', 2015, 'Sozo Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 10.48);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (13, '978-5-699-12014-13', 'Rayhaan John', 'Once Upon A Rat', 2001, 'Media Promotion', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 93.78);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (14, '978-5-699-12014-14', 'Dillan Heath', 'The One After Mars', 1990, 'Windsor Peak Press', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 199.44);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (15, '978-5-699-12014-15', 'Evie-Mae Brock', 'Burning Poem', 1995, 'Intec Telecom Systems Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 104.65);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (16, '978-5-699-12014-16', 'Alfie-Jay England', 'Mysterious Cyborg', 1993, 'Golden Opportunities', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 129.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (17, '978-5-699-12014-17', 'Jason Wilkins', 'The Perfect Thief', 1999, 'Dolphin Technology Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 99.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (18, '978-5-699-12014-18', 'Byron Neville', 'We Are Powerful', 2018, 'Media Expressions', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 75.89);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (19, '978-5-699-12014-19', 'Acacia Yoder', 'Eternal Soul', 2004, 'Youth Activism Project', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 45.90);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (20, '978-5-699-12014-20', 'Olivia-Rose Bryan', 'The Angel And The Star', 2019, 'Stressmarket.com', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 33.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (21, '978-5-699-12014-21', 'Jillian Bain', 'Earth To Unknown', 2009, 'Food And Drug Administration', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 34.86);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (22, '978-5-699-12014-22', 'Saqlain Marshall', 'Imaginary Gravity', 2015, 'Inside Track', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 185.35);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (23, '978-5-699-12014-23', 'Stefania Potter', 'Ninja Cats Rescue Mission', 2016, 'AB Gobal Consultants', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 67.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (24, '978-5-699-12014-24', 'Kirsty Lam', 'One Way Ride', 2010, 'Shirley Pta', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 12.65);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (25, '978-5-699-12014-25', 'Ifan Avalos', 'Love of Tomorrow', 1999, 'Burgiss Group Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 12.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (26, '978-5-699-12014-26', 'Margie Begum', 'Monster Strike', 1992, 'Intermedia Usa', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 09.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (27, '978-5-699-12014-27', 'Blanka Morgan', 'Cupcake Kitty', 1996, 'Globus', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 13.13);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (28, '978-5-699-12014-28', 'Safah Franks', 'Get Away And Run Away', 2019, 'Scientific Media Services', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 16.01);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (29, '978-5-699-12014-29', 'Sulaiman Haynes', 'Dead Man’s WIsh', 2020, 'I P Data Corp', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 73.22);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (30, '978-5-699-12014-30', 'Zeshan Tomlinson', 'Ridin’ To Roscoe', 2015, 'Cloudburst Multimedia', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 24.66);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (31, '978-5-699-12014-31', 'Jordan-Lee Ashley', 'The Enchanted Ones', 2011, 'Media Outpost', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 85.35);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (32, '978-5-699-12014-32', 'Ameer Bell', 'Tales of the Heart', 1990, 'Reed Group Ltd', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 98.69);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (33, '978-5-699-12014-33', 'Indigo Needham', 'Call of the Forest', 1999, 'Advanced Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 45.29);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (34, '978-5-699-12014-34', 'Caleb Simpson', 'Dragon Invasion', 2013, 'Nando Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 185.39);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (35, '978-5-699-12014-35', 'Floyd Ray', 'Time To Go', 2012, 'Internet-Biz-Guide', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 145.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (36, '978-5-699-12014-36', 'Ann-Marie Burt', 'Who Stole My Homework?', 2017, 'Recordable Media Corp', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 20.01);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (37, '978-5-699-12014-37', 'Alesha Preston', 'Trapped Like A Bug', 2014, 'Hypix Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 05.33);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (38, '978-5-699-12014-38', 'Ameera Chang', 'Cats, Dogs And Other Pets', 2008, 'Electrografix New Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 50.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (39, '978-5-699-12014-39', 'Liam Broughton', 'A Potion For The Wise', 2002, 'Exit Zero Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 23.86);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (40, '978-5-699-12014-40', 'Courtnie Mackenzie', 'We Still Exist', 2015, 'Ideum', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 12.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (41, '978-5-699-12014-41', 'Kajal Cabrera', 'Time Ticks', 1997, 'M.s.d. Enterprises', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 18.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (42, '978-5-699-12014-42', 'Breanna Shields', 'Signs of the Past', 1995, 'Rapid Graphix', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 100.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (43, '978-5-699-12014-43', 'Charles Bateman', 'The Amazing Adventures of Ice Boy', 2021, 'Alpha Media Systems', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 16.20);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (44, '978-5-699-12014-44', 'Eira Dyer', 'The Two-Cent Men', 2009, 'Onlinepublishers', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 79.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (45, '978-5-699-12014-45', 'Josh Holden', 'Point A to Z', 2014, 'Lemar Publishers', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 197.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (46, '978-5-699-12014-46', 'Vanesa Gray', 'New Planet', 2018, 'Spanish Broadcasting Syst Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 50.10);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (47, '978-5-699-12014-47', 'Randall Ewing', 'Season For Revenge', 2006, 'Imprimatur Press', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 56.66);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (48, '978-5-699-12014-48', 'Mujtaba Cunningham', 'The Amazing Adventures of Ice Boy', 2000, 'Patriot & Free Press', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 19.93);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (49, '978-5-699-12014-49', 'Taylan Connelly', 'Bad Surprise', 1999, 'Fma', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 74.38);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (50, '978-5-699-12014-50', 'Lennon Novak', 'Don’t Go There', 2013, 'Consolidated Comms Directories', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 93.50);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (51, '978-5-699-12014-51', 'Avi Mata', 'We Still Exist', 1994, 'Clark Machine Corporation', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 40.09);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (52, '978-5-699-12014-52', 'Britney Gregory', 'A Boring Day', 2021, 'Hyson Internatinal Corp.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 88.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (53, '978-5-699-12014-53', 'Asher Humphries', 'Signs of Life on Jupiter', 2002, 'Brewco', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 99.92);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (54, '978-5-699-12014-54', 'Freya Lyon', 'The Number', 2015, 'Village Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 150.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (55, '978-5-699-12014-55', 'Shelley Ball', 'Wizards of Ice', 2000, 'Slackananda Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 47.98);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (56, '978-5-699-12014-56', 'Saqib Wolf', 'Nice Try John', 2008, 'Chartwell Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 12.12);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (57, '978-5-699-12014-57', 'Chase Mcdougall', 'Dangerous Moon', 1991, 'Papillon Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 06.77);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (58, '978-5-699-12014-58', 'Ayrton Thomson', 'The Secret Witness', 2017, 'National Publishers Group', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 95.59);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (59, '978-5-699-12014-59', 'Casper Naylor', 'Bizarre Robot', 2012, 'Visualpublishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 20.29);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (60, '978-5-699-12014-60', 'Elysia Leach', 'Martian Boy', 2003, 'A Cappella Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 28.30);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (61, '978-5-699-12014-61', 'Kirsten Perez', 'The Amazing Adventures of Ice Boy', 2014, 'Paradigm Publications Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 27.77);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (62, '978-5-699-12014-62', 'Sasha Tran', 'World of Tomorrow', 1998, 'Trader Publishing Co', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 04.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (63, '978-5-699-12014-63', 'Osama Dawe', 'Lonesome Shadow', 2016, 'Futurus', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 07.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (64, '978-5-699-12014-64', 'Ariel Blair', 'The Meaning of Z', 1999, 'Tuttle Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 13.77);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (65, '978-5-699-12014-65', 'Jonathan Jones', 'The Perfect Thief', 2004, 'Addicus Books', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 70.22);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (66, '978-5-699-12014-66', 'Helen Reed', 'The Secrets Of Mr. Miller', 2018, 'Dino Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 56.91);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (67, '978-5-699-12014-67', 'Layla-Rose Kim', 'The New Kind', 2010, 'Alan C Hood & CO', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 89.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (68, '978-5-699-12014-68', 'Lilly Barber', 'Burning Poem', 2019, 'Love Lane Sweet Shoppe', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 10.10);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (69, '978-5-699-12014-69', 'Lilliana Duponts', 'Nice Try John', 2014, 'Automated Media Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 185.79);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (70, '978-5-699-12014-70', 'Angelica Sharpe', 'Quest Of The West', 1997, 'Dutch Sheets Ministries', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 100.99);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (71, '978-5-699-12014-71', 'Aadil Marks', 'Get Away And Run Away', 2021, 'Whole Person Assoc Inc', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 06.44);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (72, '978-5-699-12014-72', 'Leroy Benson', 'Who Is Mary Walker?', 2000, 'Anti-Profit Media', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 30.30);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (73, '978-5-699-12014-73', 'Fabian Chan', 'Invaders of the Earth', 1999, 'Poreda Publishing', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 70.23);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (74, '978-5-699-12014-74', 'Tasnim Reilly', 'Unofficial Crimes', 2020, 'Cadent', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 120.00);
INSERT INTO books (id, isbn, author, title, year, publisher, description, price)
VALUES (75, '978-5-699-12014-75', 'Tommy-Lee Villalobos', 'We Are Powerful', 2001, 'Markus Wiener Publishers', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 81.90);

INSERT INTO orders (id, amount, customer_address, customer_email, customer_name, customer_phone, order_date, order_number)
VALUES (1, '99', 'New York streets', 'johndoe@johndoe.com', 'John Doe', 12345678, NOW(), 1);