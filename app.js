/*
    SETUP
*/

const express = require('express');
const path = require('path');
const app = express();
const PORT = 18413;

// Middleware to read form data
app.use(express.urlencoded({ extended: true }));

// Serve static files (HTML, CSS, etc.)
app.use(express.static(path.join(__dirname, 'public')));


/*
    ROUTES
*/

// Home page
app.get(['/', '/home'], function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'home.html'));
});

// Players page (Worlds page in nav)
app.get('/Worlds', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'player.html'));
});

// Stats page
app.get('/stats', function (req, res) {
    res.sendFile(path.join(__dirname, 'public', 'stats.html'));
});

/*
app.get('/farms', function (req, res) {
    res.send("<h1>Farms Page Coming Soon</h1>");
});
*/

/*
    LISTENER
*/

app.listen(PORT, function () {
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.');
});
