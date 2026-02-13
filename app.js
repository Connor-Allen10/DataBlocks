/*
    SETUP
*/

const express = require('express');
const path = require('path');
const app = express();
const PORT = 18413;

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));


/*
    ROUTES
*/

// Home page
app.get(['/', '/home'], function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

// Players page 
app.get('/Worlds', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'player.html'));
});

// Stats page
app.get('/stats', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'stats.html'));
});

//Farms page
app.get('/farms', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'farms.html'));
});

/*
    LISTENER
*/

app.listen(PORT, function () {
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.');
});
