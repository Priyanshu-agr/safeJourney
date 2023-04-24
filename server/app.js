const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();
const dbURL = process.env.DB_URL;

const Scam = require('./models/scam');

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
app.use(express.urlencoded({ extended: true }));


app.get('/', (req, res) => {
    res.send("Hello from the server");
})

app.post('/scam', (req,res) => {
    const scam = new Scam(req.body);
    console.log(req.body);
    console.log(scam.title);
    res.send("Received");
})

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})