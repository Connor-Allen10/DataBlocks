-- ============================================
-- Minecraft World Management Database
-- Team DataBlocks
-- Connor Allen, Lucas Feldsein
-- ============================================

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS Players;
CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    world_count INT NOT NULL,
    username VARCHAR(16) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Worlds;
CREATE TABLE Worlds (
    world_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    gamemode VARCHAR(10) NOT NULL,
    version VARCHAR(10) NOT NULL,
    player_id INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

DROP TABLE IF EXISTS Statistics;
CREATE TABLE Statistics (
    statistic_id INT AUTO_INCREMENT PRIMARY KEY,
    blocks_mined INT NOT NULL,
    distance_travelled INT NOT NULL,
    mob_slain INT NOT NULL,
    days_elapsed INT NOT NULL,
    world_id INT NOT NULL UNIQUE,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Advancements;
CREATE TABLE Advancements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE,
    description VARCHAR(255),
    progress INT,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Farms;
CREATE TABLE Farms (
    farm_id INT AUTO_INCREMENT PRIMARY KEY,
    x_coordinate INT NOT NULL,
    y_coordinate INT NOT NULL,
    z_coordinate INT NOT NULL,
    is_loaded TINYINT(1) NOT NULL,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS FarmItems;
CREATE TABLE FarmItems (
    farm_item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(64) NOT NULL,
    item_yield_per_hour INT NOT NULL,
    farm_id INT NOT NULL,
    FOREIGN KEY (farm_id) REFERENCES Farms(farm_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS StorageUnits;
CREATE TABLE StorageUnits (
    storage_id INT AUTO_INCREMENT PRIMARY KEY,
    storage_type VARCHAR(32) NOT NULL,
    storage_slots INT NOT NULL,
    x_coordinate INT NOT NULL,
    y_coordinate INT NOT NULL,
    z_coordinate INT NOT NULL,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS StoredItems;
CREATE TABLE StoredItems (
    stored_item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(64) NOT NULL,
    quantity INT NOT NULL,
    storage_id INT NOT NULL,
    FOREIGN KEY (storage_id) REFERENCES StorageUnits(storage_id) ON DELETE CASCADE
);

INSERT INTO Players
(world_count, username)
VALUES
(1, 'Herobrine'),
(2, 'Jeb_'),
(2, 'Steve');

INSERT INTO Worlds
(name, gamemode, version, player_id)
VALUES
('horror gameplay', 'survival', '1.8.1', 1),
('parkour civilization', 'creative', '1.7.2', 2),
('skyblock', 'survival', '1.15.5', 2),
('underwater temple', 'creative', '1.21.1', 3),
('WIP', 'creative', '1.12.3', 3);

INSERT INTO Statistics
(blocks_mined, distance_travelled, mob_slain, days_elapsed, world_id)
VALUES
(9983, 100023, 14389, 183, 1),
(1382674, 38427, 4, 9, 2),
(1332, 302, 168, 497, 3),
(142, 5357, 183, 10, 4),
(16, 2537, 0, 2, 5);

INSERT INTO Advancements
(name, description, progress, world_id)
VALUES
('Subspace Bubble', 'Use the Nether to travel 7 km in the Overworld', 0, 1),
('Hidden in the Depths', 'Obtain Ancient Debris', 100, 1),
('The End?', 'Enter the End Portal', 100, 1),
('Acquire Hardware', 'Smelt an Iron Ingot', 100, 1),
('Stone Age', 'Mine Stone with your new Pickaxe', 100, 3),
('We Need to Go Deeper', 'Build, light and enter a Nether Portal', 0, 3),
('Cover Me with Diamonds', 'Diamond armor saves lives', 50, 3),
('Enchanter', 'Enchant an item at an Enchanting Table', 0, 3);

INSERT INTO Farms
(x_coordinate, y_coordinate, z_coordinate, is_loaded, world_id)
VALUES
(-146, 73, 2573, 1, 1),
(-3955, 51, 4, 0, 1),
(-293, 92, -30, 0, 3),
(246, 83, -93, 0, 3),
(16, 125, -34, 1, 5);

INSERT INTO FarmItems
(item_name, item_yield_per_hour, farm_id)
VALUES
('Rotten Flesh', 723, 1),
('iron ingot', 39, 1),
('gunpowder', 84, 2),
('spider eye', 7, 3),
('raw chicken', 19, 4),
('bow', 2, 5);

INSERT INTO StorageUnits
(storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id)
VALUES
('double chest', 54, -147, 73, 2574, 1),
('chest', 27, -3956, 51, 5, 1),
('trapped double chest', 54, -290, 92, -30, 3),
('chest', 27, 243, 80, -80, 3),
('barrel', 27, 20, 118, -34, 5);

INSERT INTO StoredItems
(item_name, quantity, storage_id)
VALUES
('Rotten Flesh', 64, 1),
('iron ingot', 32, 1),
('gunpowder', 16, 2),
('spider eye', 2, 3),
('raw chicken', 64, 4),
('egg', 16, 4),
('bow', 1, 5);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;