const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();
const dbURL = process.env.DB_URL;

const MongoDBStore = require("connect-mongo");

main().catch(err => {
    console.log("Database not connected");
    console.log(err);
})

async function main() {
    mongoose.set('strictQuery', true);
    await mongoose.connect(dbURL);
    console.log("Database connected");
}

const app = express();

app.get('/', (req, res) => {
    res.send("Hello from the server");
})

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})