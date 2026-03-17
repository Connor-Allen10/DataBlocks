-- ============================================
-- Minecraft World Management Database
-- Team DataBlocks
-- Connor Allen, Lucas Feldsein
-- ============================================

-- reset procedure
DELIMITER //
DROP PROCEDURE IF EXISTS sp_reset_schema//
CREATE PROCEDURE sp_reset_schema()
BEGIN
    SET FOREIGN_KEY_CHECKS=0;

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
        FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE
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
END //
DELIMITER ;


-- Players


hh


-- Worlds


-- select procedure for world
DROP PROCEDURE IF EXISTS pl_get_worlds;
DELIMITER //
CREATE PROCEDURE pl_get_worlds()
BEGIN
    SELECT * FROM Worlds;
END //
DELIMITER ;

-- add procedure for a world
DROP PROCEDURE IF EXISTS pl_add_world;
DELIMITER //
CREATE PROCEDURE pl_add_world(
    IN name_input VARCHAR(32), 
    IN gamemode_input VARCHAR(10),
    IN version_input VARCHAR(10),
    IN player_id_input INT
)
BEGIN
    INSERT INTO Worlds (name, gamemode, version, player_id) VALUES (name_input, gamemode_input, version_input, player_id_input);
END //
DELIMITER ;

-- update procedure for a world
DROP PROCEDURE IF EXISTS pl_update_world;
DELIMITER //
CREATE PROCEDURE pl_update_world(
    IN name_input VARCHAR(32), 
    IN gamemode_input VARCHAR(10),
    IN version_input VARCHAR(10),
    IN player_id_input INT,
    IN world_id_input INT
)
BEGIN
    UPDATE Worlds
    SET name = name_input, gamemode = gamemode_input, version = version_input, player_id = player_id_input
    WHERE world_id = world_id_input;
END //
DELIMITER ;

-- delete procedure for a world
DROP PROCEDURE IF EXISTS pl_delete_world;
DELIMITER //
CREATE PROCEDURE pl_delete_world(
    IN world_id_input INT
)
BEGIN
    DELETE FROM Worlds WHERE world_id = world_id_input;
END //
DELIMITER ;


-- Farm Items


-- select procedure for Farm Items
DROP PROCEDURE IF EXISTS pl_get_players;
DELIMITER //
CREATE PROCEDURE pl_get_players()
BEGIN
    SELECT * FROM Players;
END //
DELIMITER ;

-- add procedure for a Farm Item
DROP PROCEDURE IF EXISTS pl_add_player;
DELIMITER //
CREATE PROCEDURE pl_add_player(
    IN username_input VARCHAR(16)
)
BEGIN
    INSERT INTO Players (world_count, username) VALUES (0, username_input);
END //
DELIMITER ;

-- update procedure for a Farm Item
DROP PROCEDURE IF EXISTS pl_update_player;
DELIMITER //
CREATE PROCEDURE pl_update_player(
    IN username_input VARCHAR(16),
    IN player_id_input INT
)
BEGIN
    UPDATE Players
    SET username = username_input
    WHERE player_id = player_id_input;
END //
DELIMITER ;

-- delete procedure for a Farm Item
DROP PROCEDURE IF EXISTS pl_delete_player;
DELIMITER //
CREATE PROCEDURE pl_delete_player(
    IN player_id_input INT
)
BEGIN
    DELETE FROM Worlds WHERE player_id = player_id_input;
    DELETE FROM Players WHERE player_id = player_id_input;
END //
DELIMITER ;


-- Farm Items


-- select procedure for farm Items
DROP PROCEDURE IF EXISTS pl_get_FarmItems;
DELIMITER //
CREATE PROCEDURE pl_get_FarmItems()
BEGIN
    SELECT * FROM FarmItems;
END //
DELIMITER ;

-- add procedure for a farm Items
DROP PROCEDURE IF EXISTS pl_add_FarmItem;
DELIMITER //
CREATE PROCEDURE pl_add_FarmItem(
    IN itemFarmName_input VARCHAR(64),
    IN itemYield_input INT,
    IN FarmIdFk_input INT
)
BEGIN
    INSERT INTO FarmItems (item_name, item_yield_per_hour, farm_id) VALUES (itemFarmName_input, itemYield_input, FarmIdFk_input);
END //
DELIMITER ;

-- update procedure for a farm Items
DROP PROCEDURE IF EXISTS pl_update_FarmItem;
DELIMITER //
CREATE PROCEDURE pl_update_FarmItem(
    IN itemFarmName_input VARCHAR(64),
    IN itemYield_input INT,
    IN FarmIdFk_input INT,
    IN farm_item_id_input INT
)
BEGIN
    UPDATE FarmItems
    SET item_name = itemFarmName_input, item_yield_per_hour = itemYield_input, farm_id = FarmIdFk_input
    WHERE farm_item_id = farm_item_id_input;
END //
DELIMITER ;

-- delete procedure for a farm Items
DROP PROCEDURE IF EXISTS pl_delete_FarmItem;
DELIMITER //
CREATE PROCEDURE pl_delete_FarmItem(
    IN FarmItem_id_input INT
)
BEGIN
    DELETE FROM FarmItems WHERE FarmItem_id = FarmItem_id_input;
END //
DELIMITER ;


-- StorageUnit


