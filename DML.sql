-- ============================================
-- Minecraft World Management Database
-- Team DataBlocks
-- Connor Allen, Lucas Feldsein
-- ============================================


-- Players


-- Get show every player
SELECT player_id, username, world_count
FROM Players
ORDER BY player_id;

-- create a new player
INSERT INTO Players (username, world_count)
VALUES (username_input, 0);

-- Worlds


-- Get all the worlds from every player
SELECT Players.username, name, version, gamemode
FROM worlds
INNER JOIN Players ON Worlds.player_id = Players.player_id
ORDER BY world_id;

-- Add a new world
INSERT INTO World (name, gamemode, version, player_id)
VALUES (name_input, gamemode_input, version_input, selected_player_id);

-- remove a world
DELETE FROM World
WHERE world_id = selected_world_id;


-- Statistics


-- Get all statistics from selected world
SELECT blocks_mined, distance_travelled, mob_slain, days_elapsed
FROM Statistics
WHERE world_id = selected_world_id;

-- Update statistics
UPDATE Statistics
SET blocks_mined = input_blocks_mined,
    distance_travelled = descriptionInput,
    mob_slain = conditionInput,
    days_elapsed = categoryInput
WHERE world_id = selected_world_id;

-- delete statistics table
DELETE FROM Statistics
WHERE world_id = selected_world_id;


-- Advancements


-- Get all transactions with item and borrower info
SELECT name, description, progress
FROM Advancements
ORDER BY world_id;

-- Add a new advancement
INSERT INTO Advancements (name, description, progress, world_id)
VALUES (name_input, description_input, progress_input, selected_world_id);

-- Update an advancement
UPDATE Advancements
SET progress = progress_input,
WHERE world_id = selected_world_id;


-- Farms/FarmItems


SELECT FarmItems.item_name, FarmItems.ote,_yield_per_hour, x_coordinate, y_coordinate, z_coordinate, is_loaded
FROM Farms
INNER JOIN FarmItems ON FarmItems.farm_id = Farms.farm_id
WHERE world_id = selected_world_id
ORDER BY farm_id;

-- Add a new farm
INSERT INTO Farms (x_coordinate, y_coordinate, z_coordinate, is_loaded, world_id)
VALUES (x_coordinate_input, y_coordinate_input, z_coordinate_input, is_loaded_input, selected_world_id);

-- remove a farm
DELETE FROM Farms
WHERE world_id = selected_world_id
AND farm_id = selected_farm_id;


--StorageUnits/StoredItems
--(storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id)
--(item_name, quantity, storage_id)

SELECT storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate,
FROM StorageUnits
WHERE world_id = selected_world_id
ORDER BY storage_id;


--StoredItems


SELECT item_name, quantity
FROM StoredItems
WHERE world_id = selected_world_id
ORDER BY storage_id;