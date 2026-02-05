-- ============================================
-- Minecraft World Management Database
-- Team DataBlocks
-- Connor Allen, Lucas Feldsein
-- ============================================

CREATE TABLE Players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    world_count INT NOT NULL,
    username VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE Worlds (
    world_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    gamemode VARCHAR(10) NOT NULL,
    version VARCHAR(10) NOT NULL,
    player_id INT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

CREATE TABLE Statistics (
    statistic_id INT AUTO_INCREMENT PRIMARY KEY,
    blocks_mined INT NOT NULL,
    distance_travelled INT NOT NULL,
    mob_slain INT NOT NULL,
    days_elapsed INT NOT NULL,
    world_id INT NOT NULL UNIQUE,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id)
);

CREATE TABLE Advancements (
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL UNIQUE,
    description VARCHAR(255),
    progress INT,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id)
);

CREATE TABLE Farms (
    farm_id INT AUTO_INCREMENT PRIMARY KEY,
    x_coordinate INT NOT NULL,
    y_coordinate INT NOT NULL,
    z_coordinate INT NOT NULL,
    is_loaded BOOLEAN NOT NULL,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id)
);

CREATE TABLE FarmItems (
    farm_item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(64) NOT NULL,
    item_yield_per_hour INT NOT NULL,
    farm_id INT NOT NULL,
    FOREIGN KEY (farm_id) REFERENCES Farms(farm_id)
);

CREATE TABLE StorageUnits (
    storage_id INT AUTO_INCREMENT PRIMARY KEY,
    storage_type VARCHAR(32) NOT NULL,
    storage_slots INT NOT NULL,
    x_coordinate INT NOT NULL,
    y_coordinate INT NOT NULL,
    z_coordinate INT NOT NULL,
    world_id INT NOT NULL,
    FOREIGN KEY (world_id) REFERENCES Worlds(world_id)
);

CREATE TABLE StoredItems (
    stored_item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(64) NOT NULL,
    quantity INT NOT NULL,
    storage_id INT NOT NULL,
    FOREIGN KEY (storage_id) REFERENCES StorageUnits(storage_id)
);
