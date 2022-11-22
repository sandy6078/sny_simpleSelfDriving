CREATE TABLE IF NOT EXISTS `self_driving_vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plate` varchar(50) NOT NULL,
  `owned` tinyint NOT NULL,
  `favourite` longtext NOT NULL,
  `history` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;