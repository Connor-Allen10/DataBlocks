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


-- select procedure for player
DROP PROCEDURE IF EXISTS pl_get_players;
DELIMITER //
CREATE PROCEDURE pl_get_players()
BEGIN
    SELECT * FROM Players;
END //
DELIMITER ;

-- add procedure for a player
DROP PROCEDURE IF EXISTS pl_add_player;
DELIMITER //
CREATE PROCEDURE pl_add_player(
    IN username_input VARCHAR(16)
)
BEGIN
    INSERT INTO Players (world_count, username) VALUES (0, username_input);
END //
DELIMITER ;

-- update procedure for a player
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

-- delete procedure for a player
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
    DELETE FROM FarmItems WHERE farmItem_id = FarmItem_id_input;
END //
DELIMITER ;


-- StorageUnit


-- select procedure for StorageUnits
DROP PROCEDURE IF EXISTS pl_get_StorageUnits;
DELIMITER //
CREATE PROCEDURE pl_get_StorageUnits()
BEGIN
    SELECT * FROM StorageUnits;
END //
DELIMITER ;

-- add procedure for a StorageUnit
DROP PROCEDURE IF EXISTS pl_add_StorageUnit;
DELIMITER //
CREATE PROCEDURE pl_add_StorageUnit(
    IN storeType VARCHAR(32),
    IN storeSlot INT,
    IN storeX INT,
    IN storeY INT,
    IN storeZ INT,
    IN worldIdFk INT
)
BEGIN
    INSERT INTO StorageUnits (storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id) VALUES (storeType, storeSlot, storeX, storeY, storeZ, worldIdFk);
END //
DELIMITER ;

-- update procedure for a StorageUnit
DROP PROCEDURE IF EXISTS pl_update_StorageUnit;
DELIMITER //
CREATE PROCEDURE pl_update_StorageUnit(
    IN storeType VARCHAR(32),
    IN storeSlot INT,
    IN storeX INT,
    IN storeY INT,
    IN storeZ INT,
    IN worldIdFk INT,
    IN storageId INT
)
BEGIN
    UPDATE StorageUnits
    SET storage_type = storeType, storage_slots = storeSlot, x_coordinate = storeX, y_coordinate = storeY, z_coordinate = storeZ, world_id = worldIdFk
    WHERE storage_id = storageId;
END //
DELIMITER ;

-- delete procedure for a StorageUnit
DROP PROCEDURE IF EXISTS pl_delete_StorageUnit;
DELIMITER //
CREATE PROCEDURE pl_delete_StorageUnit(
    IN StorageUnit_id_input INT
)
BEGIN
    DELETE FROM StorageUnits WHERE storage_id = StorageUnit_id_input;
END //
DELIMITER ;


-- Stored Items


-- select procedure for StoredItems
DROP PROCEDURE IF EXISTS pl_get_StoredItems;
DELIMITER //
CREATE PROCEDURE pl_get_StoredItems()
BEGIN
    SELECT * FROM StoredItems;
END //
DELIMITER ;

-- add procedure for a StoredItem
DROP PROCEDURE IF EXISTS pl_add_StoredItem;
DELIMITER //
CREATE PROCEDURE pl_add_StoredItem(
    IN itemName VARCHAR(64),
    IN itemQuantity INT,
    IN UnitIdFk INT
)
BEGIN
    INSERT INTO StoredItems (item_name, quantity, storage_id) VALUES (itemName, itemQuantity, UnitIdFk);
END //
DELIMITER ;

-- update procedure for a StoredItem
DROP PROCEDURE IF EXISTS pl_update_StoredItem;
DELIMITER //
CREATE PROCEDURE pl_update_StoredItem(
    IN itemName VARCHAR(64),
    IN itemQuantity INT,
    IN UnitIdFk INT,
    IN stored_item_id_input INT
)
BEGIN
    UPDATE StoredItems
    SET item_name = itemName, quantity = itemQuantity, storage_id = UnitIdFk
    WHERE stored_item_id = stored_item_id_input;
END //
DELIMITER ;

-- delete procedure for a StoredItem
DROP PROCEDURE IF EXISTS pl_delete_StoredItem;
DELIMITER //
CREATE PROCEDURE pl_delete_StoredItem(
    IN StoredItem_id_input INT
)
BEGIN
    DELETE FROM StoredItems WHERE stored_item_id = StoredItem_id_input;
END //
DELIMITER ;


-- advancements


-- select procedure for Advancements
DROP PROCEDURE IF EXISTS pl_get_Advancements;
DELIMITER //
CREATE PROCEDURE pl_get_Advancements()
BEGIN
    SELECT * FROM Advancements;
END //
DELIMITER ;

-- add procedure for a Advancement
DROP PROCEDURE IF EXISTS pl_add_Advancement;
DELIMITER //
CREATE PROCEDURE pl_add_Advancement(
    IN name_input VARCHAR(32),
    IN description_input VARCHAR(255),
    IN progress_input INT,
    IN world_id_input INT
)
BEGIN
    INSERT INTO Advancements (name, description, progress, world_id) VALUES (name_input, description_input, progress_input, world_id_input);
END //
DELIMITER ;

-- update procedure for a Advancement
DROP PROCEDURE IF EXISTS pl_update_Advancement;
DELIMITER //
CREATE PROCEDURE pl_update_Advancement(
    IN name_input VARCHAR(32),
    IN description_input VARCHAR(255),
    IN progress_input INT,
    IN world_id_input INT,
    IN achievement_id_input INT
)
BEGIN
    UPDATE Advancements
    SET name = name_input, description = description_input, progress = progress_input, world_id = world_id_input
    WHERE achievement_id = achievement_id_input;
END //
DELIMITER ;

-- delete procedure for a Advancement
DROP PROCEDURE IF EXISTS pl_delete_Advancement;
DELIMITER //
CREATE PROCEDURE pl_delete_Advancement(
    IN Advancement_id_input INT
)
BEGIN
    DELETE FROM Advancements WHERE achievement_id = Advancement_id_input;
END //
DELIMITER ;


-- Statistics


-- select procedure for Statistics
DROP PROCEDURE IF EXISTS pl_get_Statistics;
DELIMITER //
CREATE PROCEDURE pl_get_Statistics()
BEGIN
    SELECT * FROM Statistics;
END //
DELIMITER ;

-- add procedure for a Statistic
DROP PROCEDURE IF EXISTS pl_add_Statistic;
DELIMITER //
CREATE PROCEDURE pl_add_Statistic(
    IN blocks_mined_input INT,
    IN distance_travelled_input INT,
    IN mob_slain_input INT,
    IN days_elapsed_input INT,
    IN world_id_input INT
)
BEGIN
    INSERT INTO Statistics (blocks_mined, distance_travelled, mob_slain, days_elapsed, world_id) VALUES (blocks_mined_input, distance_travelled_input, mob_slain_input, days_elapsed_input, world_id_input);
END //
DELIMITER ;

-- update procedure for a Statistic
DROP PROCEDURE IF EXISTS pl_update_Statistic;
DELIMITER //
CREATE PROCEDURE pl_update_Statistic(
    IN blocks_mined_input INT,
    IN distance_travelled_input INT,
    IN mob_slain_input INT,
    IN days_elapsed_input INT,
    IN statistic_id_input INT
)
BEGIN
    UPDATE Statistics
    SET blocks_mined = blocks_mined_input, distance_travelled = distance_travelled_input, mob_slain = mob_slain_input, days_elapsed = days_elapsed_input
    WHERE statistic_id = statistic_id_input;
END //
DELIMITER ;

-- delete procedure for a Statistic
DROP PROCEDURE IF EXISTS pl_delete_Statistic;
DELIMITER //
CREATE PROCEDURE pl_delete_Statistic(
    IN Statistic_id_input INT
)
BEGIN
    DELETE FROM Statistics WHERE statistic_id = Statistic_id_input;
END //
DELIMITER ;


-- Farms


-- select procedure for Farms
DROP PROCEDURE IF EXISTS pl_get_Farms;
DELIMITER //
CREATE PROCEDURE pl_get_Farms()
BEGIN
    SELECT * FROM Farms;
END //
DELIMITER ;

-- add procedure for a Farm
DROP PROCEDURE IF EXISTS pl_add_Farm;
DELIMITER //
CREATE PROCEDURE pl_add_Farm(
    IN x INT,
    IN y INT,
    IN z INT,
    IN is_loaded_input TINYINT(1),
    IN world_id_input INT
)
BEGIN
    INSERT INTO Farms (x_coordinate, y_coordinate, z_coordinate, is_loaded, world_id) VALUES (x, y, z, is_loaded_input, world_id_input);
END //
DELIMITER ;

-- update procedure for a Farm
DROP PROCEDURE IF EXISTS pl_update_Farm;
DELIMITER //
CREATE PROCEDURE pl_update_Farm(
    IN x INT,
    IN y INT,
    IN z INT,
    IN is_loaded_input TINYINT(1),
    IN world_id_input INT,
    IN farm_id_input INT
)
BEGIN
    UPDATE Farms
    SET x_coordinate = x, y_coordinate = y, z_coordinate = z, is_loaded = is_loaded_input, world_id = world_id_input
    WHERE farm_id = farm_id_input;
END //
DELIMITER ;

-- delete procedure for a Farm
DROP PROCEDURE IF EXISTS pl_delete_Farm;
DELIMITER //
CREATE PROCEDURE pl_delete_Farm(
    IN Farm_id_input INT
)
BEGIN
    DELETE FROM Farms WHERE farm_id = Farm_id_input;
END //
DELIMITER ;