const express = require('express');
const mongoose = require('mongoose');
require('dotenv').config();
const bodyParser = require('body-parser');
const https = require("https");
const dbURL = process.env.DB_URL;
const cors = require('cors');

const Scam = require('./models/scam');

const MongoDBStore = require("connect-mongo");

const axios = require('axios');

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
app.use(cors({ origin: true, credentials: true }));
app.use(express.urlencoded({ extended: true }));


var rad = function (x) {
    return x * Math.PI / 180;
};

var getDistance = function (latitude1, longitude1, latitude2, longitude2) {

    var R = 6378137; // Earth’s mean radius in meter
    var dLat = rad(latitude2 - latitude1);
    var dLong = rad(longitude2 - longitude1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(rad(latitude1)) * Math.cos(rad(latitude2)) *
        Math.sin(dLong / 2) * Math.sin(dLong / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    return d; // returns the distance in meter
};

const BING_KEY = process.env.BING_MAP_KEY;

app.get('/', (req, res) => {
    res.send("HEHEHE");
    // res.sendFile("/home/kinitic013/Desktop/vihaan/safeJourney/safeJourney/client/index.html");
});
app.post("/", async (req, res) => {
    //user location user allow us to fetch
    let query = req.body.location;
    console.log(query);
    let userLati = query.latitudeUser;
    let userLng = query.longitudeUser;
    //   console.log(userLati); 
    //   console.log(userLng);
    

    //distance between address searched 
    let key = BING_KEY;
    let url = `http://dev.virtualearth.net/REST/v1/Locations/${query}?&maxResults=${1}&key=${key}`
    // let url="https://dev.virtualearth.net/REST/v1/Locations/IN/"+query+"1%20Microsoft%20Way?o=JSON&key="+key;

    const scams = await Scam.find({});
    const resScams = [];
    let lat1;
    let lng1;

    await axios.get(url)
        .then((res) => {
            // console.log(res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates);
            // const position=res.resourceSets;
            // console.log(res.resourceSets);
            lat1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[0];
            lng1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[1];
        })
        .catch((e) => {
            console.error(e);
        })

    console.log(lat1);
    console.log(lng1);

    scams.forEach(function (scam) {
        let dist = getDistance(lat1, lng1, scam.coordinatex, scam.coordinatey);
        dist = dist / 1000;
        dist = Math.floor(dist);
        if (dist <= 5) {
            resScams.push(scam);
        }
    })

    res.send(resScams);
})
// [x] Insert
// [x] Retrieve
// [x] Upvote Downvote
// [ ] Location based search

//Post request to add a new scam schema in ./models/scam.js
app.post('/scam', async (req, res) => {
    const scam = new Scam(req.body);
    // console.log(req.body);
    // console.log(scam.title);

    let query = req.body.location;
    // console.log(query);
    //   console.log(userLati); 
    //   console.log(userLng);

    //distance between address searched 
    let key = BING_KEY;
    let url = `http://dev.virtualearth.net/REST/v1/Locations/${query}?&maxResults=${1}&key=${key}`
    // let url="https://dev.virtualearth.net/REST/v1/Locations/IN/"+query+"1%20Microsoft%20Way?o=JSON&key="+key;

    const scams = await Scam.find({});
    const resScams = [];
    let lat1;
    let lng1;

    await axios.get(url)
        .then((res) => {
            // console.log(res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates);
            // const position=res.resourceSets;
            // console.log(res.resourceSets);
            lat1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[0];
            lng1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[1];
        })
        .catch((e) => {
            console.error(e);
        })

    scam.coordinatex = lat1;
    scam.coordinatey = lng1;
    
    console.log(scam);
    await scam.save();
    res.send("Received");
})

// Data retrieval from database in sorted order (descending of votes)
app.get('/scam', async (req, res) => {
    const scams = await Scam.find({}).sort({ votes: -1 });
    res.json(scams);
})

app.post('/scam/upvote', async (req, res) => {
    const scam = await Scam.findById(req.body.id);
    scam.votes++;
    await scam.save();
    res.send("Upvoted");
})

app.post('/scam/downvote', async (req, res) => {
    const scam = await Scam.findById(req.body.id);
    scam.votes--;
    await scam.save();
    res.send("Downvoted");
})

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})