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

// [x] Insert
// [x] Retrieve
// [ ] Upvote Downvote
// [ ] Location based search

//Post request to add a new scam schema in ./models/scam.js
app.post('/scam', async (req,res) => {
    const scam = new Scam(req.body);
    console.log(req.body);
    console.log(scam.title);
    await scam.save();
    res.send("Received");
})

// Data retrieval from database
app.get('/scam', async (req,res) => {
    const scams = await Scam.find({});
    res.send(scams);
})

app.post('/scam/upvote', async (req,res) => {
    const scam = await Scam.findById(req.body.id);
    scam.votes++;
    await scam.save();
    res.send("Upvoted");
})

app.post('/scam/downvote', async(req,res) => {
    const scam = await Scam.findById(req.body.id);
    scam.votes--;
    await scam.save();
    res.send("Downvoted");
})

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})