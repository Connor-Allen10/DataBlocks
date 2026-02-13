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
INNER JOIN PLayers ON Worlds.player_id = Players.player_id
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
FROM World
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


-- Farms
--(x_coordinate, y_coordinate, z_coordinate, is_loaded, world_id)
--FarmItems
--(item_name, item_yield_per_hour, farm_id)
--StorageUnits
--(storage_type, storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id)
--StoredItems
--(item_name, quantity, storage_id)
