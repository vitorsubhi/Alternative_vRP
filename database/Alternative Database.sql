-- phpMyAdmin SQL Dump
-- version 5.1.1
--
-- versão do PHP: 8.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `alternative`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_accounts`
--

CREATE TABLE `summerz_accounts` (
  `whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `chars` int(1) NOT NULL DEFAULT 1,
  `gems` int(11) NOT NULL DEFAULT 0,
  `premium` int(11) NOT NULL DEFAULT 0,
  `predays` int(11) NOT NULL DEFAULT 0,
  `priority` int(3) NOT NULL DEFAULT 0,
  `login` varchar(25) NOT NULL DEFAULT '00/00/0000',
  `discord` varchar(50) NOT NULL DEFAULT '0',
  `steam` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_banneds`
--

CREATE TABLE `summerz_banneds` (
  `id` int(11) NOT NULL,
  `steam` varchar(100) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `days` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_characters`
--

CREATE TABLE `summerz_characters` (
  `id` int(11) NOT NULL,
  `steam` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `serial` varchar(6) DEFAULT NULL,
  `name` varchar(50) DEFAULT 'Individuo',
  `name2` varchar(50) DEFAULT 'Indigente',
  `bank` int(11) NOT NULL DEFAULT 1500,
  `fines` int(11) NOT NULL DEFAULT 0,
  `garage` int(3) NOT NULL DEFAULT 1,
  `homes` int(3) NOT NULL DEFAULT 1,
  `prison` int(11) NOT NULL DEFAULT 0,
  `port` int(1) NOT NULL DEFAULT 0,
  `penal` int(1) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `age` int(11) NOT NULL DEFAULT 20,
  `paypal` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_chests`
--

CREATE TABLE `summerz_chests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(100) NOT NULL,
  `logs` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_entitydata`
--

CREATE TABLE `summerz_entitydata` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_playerdata`
--

CREATE TABLE `summerz_playerdata` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_prison`
--

CREATE TABLE `summerz_prison` (
  `id` int(11) NOT NULL,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(11) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_propertys`
--

CREATE TABLE `summerz_propertys` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT 'Homes0001',
  `interior` varchar(255) NOT NULL DEFAULT 'Middle',
  `tax` int(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `residents` int(11) NOT NULL DEFAULT 1,
  `vault` int(11) NOT NULL DEFAULT 1,
  `fridge` int(11) NOT NULL DEFAULT 1,
  `owner` int(1) NOT NULL DEFAULT 0,
  `contract` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_races`
--

CREATE TABLE `summerz_races` (
  `id` int(11) NOT NULL,
  `raceid` int(11) NOT NULL DEFAULT 0,
  `user_id` int(9) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `vehicle` varchar(100) NOT NULL DEFAULT '0',
  `points` int(20) NOT NULL DEFAULT 0,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `summerz_vehicles`
--

CREATE TABLE `summerz_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `tax` int(20) NOT NULL DEFAULT 0,
  `plate` varchar(20) DEFAULT NULL,
  `hardness` int(1) NOT NULL DEFAULT 0,
  `rental` int(11) NOT NULL DEFAULT 0,
  `rendays` int(11) NOT NULL DEFAULT 0,
  `arrest` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0,
  `engine` int(11) NOT NULL DEFAULT 1000,
  `body` int(11) NOT NULL DEFAULT 1000,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `work` varchar(10) NOT NULL DEFAULT 'false',
  `doors` varchar(254) NOT NULL,
  `windows` varchar(254) NOT NULL,
  `tyres` varchar(254) NOT NULL,
  `brakes` varchar(254) NOT NULL,
  `estado` text DEFAULT NULL,
  `ipva` varchar(255) DEFAULT '1630912803',
  `garage` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tabela `summerz_accounts`
--
ALTER TABLE `summerz_accounts`
  ADD PRIMARY KEY (`steam`) USING BTREE,
  ADD KEY `steam` (`steam`) USING BTREE;

--
-- Índices para tabela `summerz_banneds`
--
ALTER TABLE `summerz_banneds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `fk_accounts_banned` (`steam`);

--
-- Índices para tabela `summerz_characters`
--
ALTER TABLE `summerz_characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `fk_accounts_characters` (`steam`);

--
-- Índices para tabela `summerz_chests`
--
ALTER TABLE `summerz_chests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Índices para tabela `summerz_entitydata`
--
ALTER TABLE `summerz_entitydata`
  ADD PRIMARY KEY (`dkey`),
  ADD KEY `dkey` (`dkey`);

--
-- Índices para tabela `summerz_playerdata`
--
ALTER TABLE `summerz_playerdata`
  ADD PRIMARY KEY (`user_id`,`dkey`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dkey` (`dkey`);

--
-- Índices para tabela `summerz_prison`
--
ALTER TABLE `summerz_prison`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Índices para tabela `summerz_propertys`
--
ALTER TABLE `summerz_propertys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `fk_character_property` (`user_id`);

--
-- Índices para tabela `summerz_races`
--
ALTER TABLE `summerz_races`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `fk_character_races` (`user_id`);

--
-- Índices para tabela `summerz_vehicles`
--
ALTER TABLE `summerz_vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vehicle` (`vehicle`);

--
-- AUTO_INCREMENT de tabela `summerz_banneds`
--
ALTER TABLE `summerz_banneds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `summerz_characters`
--
ALTER TABLE `summerz_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `summerz_chests`
--
ALTER TABLE `summerz_chests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `summerz_prison`
--
ALTER TABLE `summerz_prison`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `summerz_propertys`
--
ALTER TABLE `summerz_propertys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `summerz_races`
--
ALTER TABLE `summerz_races`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `summerz_banneds`
--
ALTER TABLE `summerz_banneds`
  ADD CONSTRAINT `fk_accounts_banned` FOREIGN KEY (`steam`) REFERENCES `summerz_accounts` (`steam`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `summerz_characters`
--
ALTER TABLE `summerz_characters`
  ADD CONSTRAINT `fk_accounts_characters` FOREIGN KEY (`steam`) REFERENCES `summerz_accounts` (`steam`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `summerz_playerdata`
--
ALTER TABLE `summerz_playerdata`
  ADD CONSTRAINT `fk_character_playerdata` FOREIGN KEY (`user_id`) REFERENCES `summerz_characters` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `summerz_propertys`
--
ALTER TABLE `summerz_propertys`
  ADD CONSTRAINT `fk_character_property` FOREIGN KEY (`user_id`) REFERENCES `summerz_characters` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `summerz_races`
--
ALTER TABLE `summerz_races`
  ADD CONSTRAINT `fk_character_races` FOREIGN KEY (`user_id`) REFERENCES `summerz_characters` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `summerz_vehicles`
--
ALTER TABLE `summerz_vehicles`
  ADD CONSTRAINT `fk_character_vehicles` FOREIGN KEY (`user_id`) REFERENCES `summerz_characters` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
