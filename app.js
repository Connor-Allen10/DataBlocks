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
        const [rows] = await db.query('SELECT * FROM Players');
        res.json(rows);
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
        const [rows] = await db.query('SELECT * FROM Worlds');
        res.json(rows);
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
        const [rows] = await db.query('SELECT * FROM Advancements');
        res.json(rows);
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
        const [rows] = await db.query('SELECT * FROM Statistics');
        res.json(rows);
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
        const [rows] = await db.query('SELECT * FROM FarmItems');
        res.json(rows);
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
        const [rows] = await db.query('SELECT * FROM StoredItems');
        res.json(rows);
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
        await db.query('INSERT INTO Players (world_count, username) VALUES (?, ?)', [0, username]);
        res.redirect('/players');
    } catch (err) {
        res.status(500).send('Error adding player: ' + err.message);
    }
});

// Delete Player (POST)
app.post('/delete-player', async function (req, res) {
    const db = require('./db-connector');
    const playerId = req.body.player_id;
    try {
        await db.query('DELETE FROM Players WHERE player_id = ?', [playerId]);
        res.redirect('/players');
    } catch (err) {
        res.status(500).send('Error deleting player: ' + err.message);
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
        await db.query('INSERT INTO Worlds (name, gamemode, version, player_id) VALUES (?, ?, ?, ?)', [name, gamemode, version, player_id]);
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
        await db.query('DELETE FROM Worlds WHERE world_id = ?', [worldId]);
        res.redirect('/worlds');
    } catch (err) {
        res.status(500).send('Error deleting world: ' + err.message);
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
        await db.query('INSERT INTO StorageUnits (storage_type , storage_slots, x_coordinate, y_coordinate, z_coordinate, world_id) VALUES (?, ?)', [storeType, storeSlot, storeX, storeY, storeZ, worldIdFk]);
        res.redirect('/storageunits');
    } catch (err) {
        res.status(500).send('Error adding Storage Unit: ' + err.message);
    }
});

// Delete StorageUnit (POST)
app.post('/delete-StorageUnits', async function (req, res) {
    const db = require('./db-connector');
    const StorageUnitId = req.body.storage_id;
    try {
        await db.query('DELETE FROM StorageUnits WHERE storage_id = ?', [StorageUnitId]);
        res.redirect('/storageunits');
    } catch (err) {
        res.status(500).send('Error deleting Storage Unit: ' + err.message);
    }
});

// Add StoredItems (POST)
app.post('/add-StoredItems', async function (req, res) {
    const db = require('./db-connector');
    const itemName = req.body.item_name_input;
    const itemQuantity = req.body.quantity_input;
    const UnitIdFk = req.body.unit_id_input;
    try {
        await db.query('INSERT INTO StoredItems (item_name, quantity, storage_id) VALUES (?, ?)', [itemName, itemQuantity, UnitIdFk]);
        res.redirect('/storeditems');
    } catch (err) {
        res.status(500).send('Error adding Storage Unit: ' + err.message);
    }
});

// Delete StoredItems (POST)
app.post('/delete-StoredItems', async function (req, res) {
    const db = require('./db-connector');
    const storedItemId = req.body.stored_item_id;
    try {
        await db.query('DELETE FROM StoredItems WHERE stored_item_id = ?', [storedItemId]);
        res.redirect('/storeditems');
    } catch (err) {
        res.status(500).send('Error deleting Stored Item: ' + err.message);
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
        await db.query('INSERT INTO Advancements (name, description, progress, world_id) VALUES (?, ?, ?, ?)', [name, description, progress, world_id]);
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
        await db.query('DELETE FROM Advancements WHERE achievement_id = ?', [advancement_id]);
        res.redirect('/advancements');
    } catch (err) {
        res.status(500).send('Error deleting Advancements: ' + err.message);
    }
});

/*
    LISTENER
*/

app.listen(PORT, function () {
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.');
});
