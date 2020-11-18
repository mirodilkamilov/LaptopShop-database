CREATE TABLE IF NOT EXISTS `laptopshop`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(45) NOT NULL,
  `series` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `sale` DOUBLE ZEROFILL NULL,
  `photos` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
);
-- -----------------------------------------------------
-- Table `laptopshop`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laptopshop`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `region` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `street_address` VARCHAR(45) NULL,
  `zip_code` VARCHAR(45) NULL,
  `gender` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC)
);
-- -----------------------------------------------------
-- Table `laptopshop`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laptopshop`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `total_cost` DOUBLE NOT NULL,
  `order_date` DATETIME NOT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `user_id`),
  INDEX `fk_order_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_order_user1` FOREIGN KEY (`user_id`) REFERENCES `laptopshop`.`user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table `laptopshop`.`order_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laptopshop`.`order_product` (
  `order_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `user_id`, `product_id`),
  INDEX `fk_order_has_product_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_order_product_order1` FOREIGN KEY (`order_id`, `user_id`) REFERENCES `laptopshop`.`order` (`order_id`, `user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_product_product1` FOREIGN KEY (`product_id`) REFERENCES `laptopshop`.`product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);
-- -----------------------------------------------------
-- Table `laptopshop`.`shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laptopshop`.`shipment` (
  `shipment_id` INT NOT NULL AUTO_INCREMENT,
  `shipment_tracking_id` VARCHAR(45) NOT NULL,
  `shipment_status` VARCHAR(45) NOT NULL,
  `shipment_date` DATETIME NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  `street_address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shipment_id`),
  UNIQUE INDEX (`shipment_tracking_id`)
);
-- -----------------------------------------------------
-- Table `laptopshop`.`order_shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `laptopshop`.`order_shipment` (
  `order_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `shipment_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `user_id`, `shipment_id`),
  INDEX `fk_order_has_shipment_shipment1_idx` (`shipment_id` ASC),
  INDEX `fk_order_has_shipment_order1_idx` (`order_id` ASC, `user_id` ASC),
  CONSTRAINT `fk_order_has_shipment_order1` FOREIGN KEY (`order_id`, `user_id`) REFERENCES `laptopshop`.`order` (`order_id`, `user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_shipment_shipment1` FOREIGN KEY (`shipment_id`) REFERENCES `laptopshop`.`shipment` (`shipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);