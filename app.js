/*
    SETUP
*/

const express = require('express');
const path = require('path');
const app = express();
// const db = require('./db-connector');
const PORT = 18413;

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));


/*
    ROUTES
*/

// ===========
// NAVIGATION
// ===========

// Home page
app.get(['/', '/home'], function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

// Players page 
app.get('/players', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'players.html'));
});

// API endpoint to get all players as JSON
app.get('/api/players', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_players()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Worlds page
app.get('/worlds', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'worlds.html'));
});

// API endpoint to get all worlds as JSON
app.get('/api/worlds', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_worlds()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Advancements page
app.get('/advancements', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'advancements.html'));
});

// API endpoint to get all advancements as JSON
app.get('/api/advancements', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_Advancements()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Stats page
app.get('/stats', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'stats.html'));
});

// API endpoint to get all statistics as JSON
app.get('/api/statistics', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_Statistics()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// API endpoint to get all farms as JSON
app.get('/api/farms', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_Farms()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// API endpoint to get all storage units as JSON
app.get('/api/storageunits', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_StorageUnits()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
// Farms page
app.get('/farms', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'farms.html'));
});

// FarmItems page
app.get('/farmitems', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'farmitems.html'));
});

// API endpoint to get all farm items as JSON
app.get('/api/farmitems', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_FarmItems()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// StorageUnits page
app.get('/storageunits', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'storageunits.html'));
});

// StoredItems page
app.get('/storeditems', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'storeditems.html'));
});

// API endpoint to get all stored items as JSON
app.get('/api/storeditems', async function (req, res) {
    const db = require('./db-connector');
    try {
        const [rows] = await db.query('CALL pl_get_StoredItems()');
        res.json(rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// ==========
// ADD/DELETE
// ==========


// Add Player (POST)
app.post('/add-player', async function (req, res) {
    const db = require('./db-connector');
    const username = req.body.username_input;
    try {
        await db.query('CALL pl_add_player(username)');
        res.redirect('/players');
    } catch (err) {
        res.status(500).send('Error adding player: ' + err.message);
    }
});

// Delete Player (POST)
app.post('/delete-player', async function (req, res) {
    const db = require('./db-connector');
    const playerId = Number(req.body.player_id);
    if (!Number.isInteger(playerId) || playerId <= 0) {
        return res.status(400).send('Invalid player ID');
    }

    const connection = await db.getConnection();
    try {
        await connection.beginTransaction();
        await connection.query('CALL pl_delete_player(?)', [playerId]);
        await connection.commit();
        res.redirect('/players');
    } catch (err) {
        await connection.rollback();
        res.status(500).send('Error deleting player: ' + err.message);
    } finally {
        connection.release();
    }
});

// Edit Player (POST)
app.post('/edit-player', async function (req, res) {
    const db = require('./db-connector');
    const player_id = req.body.player_id;
    const username = req.body.username_input;
    try {
        await db.query('CALL pl_update_player(?, ?)', [username, player_id]);
        res.redirect('/players');
    } catch (err) {
        res.status(500).send('Error editing player: ' + err.message);
    }
});

// Add World (POST)
app.post('/add-world', async function (req, res) {
    const db = require('./db-connector');
    const name = req.body.name_input;
    const gamemode = req.body.gamemode_input;
    const version = req.body.version_input;
    const player_id = req.body.selected_player_id;
    try {
        await db.query('CALL pl_add_world(?, ?, ?, ?)', [name, gamemode, version, player_id]);
        res.redirect('/worlds');
    } catch (err) {
        res.status(500).send('Error adding world: ' + err.message);
    }
});

// Delete World (POST)
app.post('/delete-world', async function (req, res) {
    const db = require('./db-connector');
    const worldId = req.body.world_id;
    try {
        await db.query('CALL pl_delete_world(?)', [worldId]);
        res.redirect('/worlds');
    } catch (err) {
        res.status(500).send('Error deleting world: ' + err.message);
    }
});

// Edit World (POST)
app.post('/edit-world', async function (req, res) {
    const db = require('./db-connector');
    const world_id = req.body.world_id;
    const name = req.body.name_input;
    const gamemode = req.body.gamemode_input;
    const version = req.body.version_input;
    const player_id = req.body.selected_player_id;
    try {
        await db.query('CALL pl_update_world(?, ?, ?, ?, ?)', [name, gamemode, version, player_id, world_id]);
        res.redirect('/worlds');
    } catch (err) {
        res.status(500).send('Error editing world: ' + err.message);
    }
});

// Add farm items (POST)
app.post('/add-farmItem', async function (req, res) {
    const db = require('./db-connector');
    const itemFarmName = req.body.item_name_input;
    const itemYield = req.body.item_yield_input;
    const FarmIdFk = req.body.item_farm_id_input;
    try {
        await db.query('CALL pl_add_FarmItem(?, ?, ?)', [itemFarmName, itemYield, FarmIdFk]);
        res.redirect('/farmitems');
    } catch (err) {
        res.status(500).send('Error adding FarmItems: ' + err.message);
    }
});

// Delete farm items (POST)
app.post('/delete-farmItem', async function (req, res) {
    const db = require('./db-connector');
    const farmItemId = req.body.farm_item_id;
    try {
        await db.query('CALL pl_delete_FarmItem(farmItemId)');
        res.redirect('/farmitems');
    } catch (err) {
        res.status(500).send('Error deleting FarmItems: ' + err.message);
    }
});

// Edit farm items (POST)
app.post('/edit-farmItem', async function (req, res) {
    const db = require('./db-connector');
    const farm_item_id = req.body.farm_item_id;
    const itemFarmName = req.body.item_name_input;
    const itemYield = req.body.item_yield_input;
    const FarmIdFk = req.body.item_farm_id_input;
    try {
        await db.query('CALL pl_update_FarmItem(itemFarmName, itemYield, FarmIdFk, farm_item_id)');
        res.redirect('/farmitems');
    } catch (err) {
        res.status(500).send('Error editing FarmItems: ' + err.message);
    }
});

// Add StorageUnit (POST)
app.post('/add-StorageUnits', async function (req, res) {
    const db = require('./db-connector');
    const storeType = req.body.type_input;
    const storeSlot = req.body.slot_input;
    const storeX = req.body.store_x_input;
    const storeY = req.body.store_y_input;
    const storeZ = req.body.store_z_input;
    const worldIdFk = req.body.world_id_input;
    try {
        await db.query('CALL pl_add_StorageUnit(storeType, storeSlot, storeX, storeY, storeZ, worldIdFk)');
        res.redirect('/storageunits');
    } catch (err) {
        res.status(500).send('Error adding StorageUnit: ' + err.message);
    }
});

// Delete StorageUnit (POST)
app.post('/delete-StorageUnits', async function (req, res) {
    const db = require('./db-connector');
    const StorageUnitId = req.body.storage_id;
    try {
        await db.query('CALL pl_delete_StorageUnit(StorageUnitId)');
        res.redirect('/storageunits');
    } catch (err) {
        res.status(500).send('Error deleting StorageUnit: ' + err.message);
    }
});

// Edit StorageUnit (POST)
app.post('/edit-StorageUnits', async function (req, res) {
    const db = require('./db-connector');
    const storage_id = req.body.storage_id;
    const storeType = req.body.type_input;
    const storeSlot = req.body.slot_input;
    const storeX = req.body.store_x_input;
    const storeY = req.body.store_y_input;
    const storeZ = req.body.store_z_input;
    const worldIdFk = req.body.world_id_input;
    try {
        await db.query('CALL pl_update_StorageUnit(storeType, storeSlot, storeX, storeY, storeZ, worldIdFk, storage_id)');
        res.redirect('/storageunits');
    } catch (err) {
        res.status(500).send('Error editing StorageUnit: ' + err.message);
    }
});

// Add StoredItems (POST)
app.post('/add-StoredItems', async function (req, res) {
    const db = require('./db-connector');
    const itemName = req.body.item_name_input;
    const itemQuantity = req.body.quantity_input;
    const UnitIdFk = req.body.unit_id_input;
    try {
        await db.query('CALL pl_add_StoredItem(itemName, itemQuantity, UnitIdFk)');
        res.redirect('/storeditems');
    } catch (err) {
        res.status(500).send('Error adding StoredItem: ' + err.message);
    }
});

// Delete StoredItems (POST)
app.post('/delete-StoredItems', async function (req, res) {
    const db = require('./db-connector');
    const storedItemId = req.body.stored_item_id;
    try {
        await db.query('CALL pl_delete_StoredItem(storedItemId)');
        res.redirect('/storeditems');
    } catch (err) {
        res.status(500).send('Error deleting StoredItem: ' + err.message);
    }
});

// Edit StoredItems (POST)
app.post('/edit-StoredItems', async function (req, res) {
    const db = require('./db-connector');
    const stored_item_id = req.body.stored_item_id;
    const itemName = req.body.item_name_input;
    const itemQuantity = req.body.quantity_input;
    const UnitIdFk = req.body.unit_id_input;
    try {
        await db.query('CALL pl_update_StoredItem(itemName, itemQuantity, UnitIdFk, stored_item_id)');
        res.redirect('/storeditems');
    } catch (err) {
        res.status(500).send('Error editing StoredItem: ' + err.message);
    }
});

// Add Advancement (POST)
app.post('/add-advancement', async function (req, res) {
    const db = require('./db-connector');
    const name = req.body.name_input;
    const description = req.body.description_input;
    const progress = req.body.progress_input;
    const world_id = req.body.world_id_input;
    try {
        await db.query('CALL pl_add_Advancement(name, description, progress, world_id)');
        res.redirect('/advancements');
    } catch (err) {
        res.status(500).send('Error adding Advancement: ' + err.message);
    }
});

// Delete Advancement (POST)
app.post('/delete-advancement', async function (req, res) {
    const db = require('./db-connector');
    const advancement_id = req.body.achievement_id;
    try {
        await db.query('CALL pl_delete_Advancement(advancement_id)');
        res.redirect('/advancements');
    } catch (err) {
        res.status(500).send('Error deleting Advancements: ' + err.message);
    }
});

// Edit Advancement (POST)
app.post('/edit-advancement', async function (req, res) {
    const db = require('./db-connector');
    const achievement_id = req.body.achievement_id;
    const name = req.body.name_input;
    const description = req.body.description_input;
    const progress = req.body.progress_input;
    const world_id = req.body.world_id_input;
    try {
        await db.query('CALL pl_update_Advancement(name, description, progress, world_id, achievement_id)');
        res.redirect('/advancements');
    } catch (err) {
        res.status(500).send('Error editing Advancement: ' + err.message);
    }
});

// Add Statistic (POST)
app.post('/add-statistic', async function (req, res) {
    const db = require('./db-connector');
    const blocks_mined = req.body.blocks_mined_input;
    const distance_travelled = req.body.distance_travelled_input;
    const mob_slain = req.body.mob_slain_input;
    const days_elapsed = req.body.days_elapsed_input;
    const world_id = req.body.world_id_input;
    try {
        await db.query('CALL pl_add_Statistic(blocks_mined, distance_travelled, mob_slain, days_elapsed, world_id)');
        res.redirect('/stats');
    } catch (err) {
        res.status(500).send('Error adding statistic: ' + err.message);
    }
});

// edit Statistic (POST)
app.post('/edit-statistic', async function (req, res) {
    const db = require('./db-connector');
    const blocks_mined = req.body.blocks_mined_input;
    const distance_travelled = req.body.distance_travelled_input;
    const mob_slain = req.body.mob_slain_input;
    const days_elapsed = req.body.days_elapsed_input;
    const statistic_id = req.body.statistic_id_input;
    try {
        await db.query('CALL pl_update_Statistic(blocks_mined, distance_travelled, mob_slain, days_elapsed, statistic_id)');
        res.redirect('/stats');
    } catch (err) {
        res.status(500).send('Error editing statistic: ' + err.message);
    }
});

// Delete Statistic (POST)
app.post('/delete-statistic', async function (req, res) {
    const db = require('./db-connector');
    const statistic_id = req.body.statistic_id;
    try {
        await db.query('CALL pl_delete_Statistic(statistic_id)');
        res.redirect('/stats');
    } catch (err) {
        res.status(500).send('Error deleting statistic: ' + err.message);
    }
});

// Add Farm (POST)
app.post('/add-farm', async function (req, res) {
    const db = require('./db-connector');
    const x = req.body.x_coordinate_input;
    const y = req.body.y_coordinate_input;
    const z = req.body.z_coordinate_input;
    const is_loaded = req.body.is_loaded_input;
    const world_id = req.body.world_id_input;
    try {
        await db.query('CALL pl_add_Farm(x, y, z, is_loaded, world_id)');
        res.redirect('/farms');
    } catch (err) {
        res.status(500).send('Error adding farm: ' + err.message);
    }
});

// Delete Farm (POST)
app.post('/delete-farm', async function (req, res) {
    const db = require('./db-connector');
    const farm_id = req.body.farm_id;
    try {
        await db.query('CALL pl_delete_Farm(farm_id)');
        res.redirect('/farms');
    } catch (err) {
        res.status(500).send('Error deleting farm: ' + err.message);
    }
});

// Edit Farm (POST)
app.post('/edit-farm', async function (req, res) {
    const db = require('./db-connector');
    const farm_id = req.body.farm_id;
    const x = req.body.x_coordinate_input;
    const y = req.body.y_coordinate_input;
    const z = req.body.z_coordinate_input;
    const is_loaded = req.body.is_loaded_input;
    const world_id = req.body.world_id_input;
    try {
        await db.query('CALL pl_update_Farm(x, y, z, is_loaded, world_id, farm_id)');
        res.redirect('/farms');
    } catch (err) {
        res.status(500).send('Error editing farm: ' + err.message);
    }
});

// RESET SCHEMA
app.get('/reset', async function (req, res) {
    const db = require('./db-connector');
    try {
        await db.query('CALL sp_reset_schema();');
        res.send('<h2>Database reset successful!</h2><a href="/home">Return Home</a>');
    } catch (err) {
        res.status(500).send('Error resetting database: ' + err.message);
    }
});

/*
    LISTENER
*/

app.listen(PORT, function () {
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.');
});
