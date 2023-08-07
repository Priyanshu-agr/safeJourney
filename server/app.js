const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const scamRoutes = require('./routes/scam');
const homeRoutes = require('./routes/home');
const db = mongoose.connection;
require('dotenv').config();

const app = express();
app.use(cors({ origin: true, credentials: true }));
app.use(express.urlencoded({ extended: true }));

mongoose.connect(process.env.DB_URL);
db.on('error', console.error.bind(console, "connection error:"));
db.once('open', () => {
    console.log("Database connected");
});

const BING_KEY = process.env.BING_MAP_KEY;
const port = process.env.PORT || 3000;

app.use('/', homeRoutes);
app.use('/scam', scamRoutes);

app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})