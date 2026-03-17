-- ============================================
-- Minecraft World Management Database
-- Team DataBlocks
-- Connor Allen, Lucas Feldsein
-- ============================================


-- Players


-- Get show every player
SELECT * FROM Players;

-- create a new player
INSERT INTO Players (world_count, username) VALUES (0, username);

-- edit a player
UPDATE Players SET username = ? WHERE player_id = ?, [username, player_id]

-- delete a new player
DELETE FROM Players WHERE player_id = playerId;


-- Worlds


-- Get all the worlds from every player
SELECT * FROM Worlds;

-- Add a new world
INSERT INTO Worlds (name, gamemode, version, player_id) VALUES (name, gamemode, version, player_id);

-- Edit a world
UPDATE Worlds SET name = ?, gamemode = ?, version = ?, player_id = ? WHERE world_id = ?, [name, gamemode, version, player_id, world_id]

-- remove a world
DELETE FROM Worlds WHERE world_id = worldId;


-- Statistics


-- Get all statistics from selected world
SELECT * FROM Statistics;

-- Update statistics
INSERT INTO Statistics (blocks_mined, distance_travelled, mob_slain, days_elapsed, world_id) VALUES (blocks_mined, distance_travelled, mob_slain, days_elapsed, world_id);

-- Update a statistic
UPDATE Statistics SET blocks_mined = ?, distance_travelled = ?, mob_slain = ?, days_elapsed = ? WHERE statistic_id = ?, [blocks_mined, distance_travelled, mob_slain, days_elapsed, statistic_id]

-- delete statistics table
DELETE FROM Statistics WHERE statistic_id = statistic_id;


-- Advancements


-- Get all advancements from selected world
SELECT * FROM Advancements;

-- Add a new advancement
INSERT INTO Advancements (name, description, progress, world_id) VALUES (name, description, progress, world_id);

-- Edit an advancement
UPDATE Advancements SET name = ?, description = ?, progress = ?, world_id = ? WHERE achievement_id = ?, [name, description, progress, world_id, achievement_id]

-- Update an advancement
DELETE FROM Advancements WHERE achievement_id = advancement_id;


-- Farms


-- Get all farms from selected world
SELECT * FROM Farms;

-- Add a new farm
INSERT INTO Farms (x_coordinate, y_coordinate, z_coordinate, is_loaded, world_id) VALUES (x, y, z, is_loaded, world_id);

-- Edit a farm
UPDATE Farms SET x_coordinate = ?, y_coordinate = ?, z_coordinate = ?, is_loaded = ?, world_id = ? WHERE farm_id = ?, [x, y, z, is_loaded, world_id, farm_id]

-- remove a farm
DELETE FROM Farms WHERE farm_id = farm_id;


-- Farm items


-- Get all farm items from selected world
SELECT * FROM FarmItems;

-- Add a new farm item
INSERT INTO FarmItems (item_name, item_yield_per_hour, farm_id) VALUES (itemFarmName, itemYield, FarmIdFk);

-- Edit a farm item
UPDATE FarmItems SET item_name = ?, item_yield_per_hour = ?, farm_id = ? WHERE farm_item_id = ?, [itemFarmName, itemYield, FarmIdFk, farm_item_id]

-- remove a farm item
DELETE FROM FarmItems WHERE farm_item_id = farmItemId;


--StorageUnits


-- Get all farm items from selected world
SELECT * FROM StorageUnits;

-- Add a new Storage unit
INSERT INTO StorageUnits (storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id) VALUES (storeType, storeSlot, storeX, storeY, storeZ, worldIdFk);

-- Edit a Storage unit
UPDATE StorageUnits SET storage_type = ?, storage_slots = ?, x_coordinate = ?, y_coordinate = ?, z_coordinate = ?, world_id = ? WHERE storage_id = ?, [storeType, storeSlot, storeX, storeY, storeZ, worldIdFk, storage_id]

-- delete a Storage unit
DELETE FROM StorageUnits WHERE storage_id = StorageUnitId;


--StoredItems


-- Get all Stored items from selected world
SELECT * FROM StoredItems;

-- Add a new Stored item
INSERT INTO StoredItems (item_name, quantity, storage_id) VALUES (itemName, itemQuantity, UnitIdFk);

-- Edit a new Stored item
UPDATE StoredItems SET item_name = ?, quantity = ?, storage_id = ? WHERE stored_item_id = ?, [itemName, itemQuantity, UnitIdFk, stored_item_id]

-- delete a new Stored item
DELETE FROM StoredItems WHERE stored_item_id = storedItemId;