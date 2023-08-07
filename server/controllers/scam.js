const Scam = require('../models/scam');
const axios = require('axios');
require('dotenv').config();

const BING_KEY = process.env.BING_MAP_KEY;

async function newScam(req, res) {
    try {
        const scam = new Scam(req.body);
        const query = req.body.location;
        const key = BING_KEY;
        const url = `http://dev.virtualearth.net/REST/v1/Locations/${query}?&maxResults=${1}&key=${key}`;

        let lat1;
        let lng1;
        await axios.get(url)
            .then((res) => {
                lat1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[0];
                lng1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[1];
            })
            .catch((e) => {
                console.error(e);
            });

        scam.coordinatex = lat1;
        scam.coordinatey = lng1;

        console.log(scam);
        await scam.save();
        res.send("New scam reveived");
    }
    catch (e) {
        console.log(e.message);
        res.send("Error in receiving scam");
    }
}

// Data retrieval from database in sorted order (descending of votes)
async function getScam(req, res) {
    try{
    const scams = await Scam.find({}).sort({ votes: -1 });
    res.json(scams);
    }
    catch(e)
    {
        console.log(e.message);
        res.send('Failed to fetch all scams');
    }
}

async function upvote(req, res) {
    try{
    const scam = await Scam.findById(req.body.id);
    scam.votes++;
    await scam.save();   
    res.send("Upvoted");
    }
    catch(e){
        res.send(e.message);
        console.log('Failed to upvote');
    }
}

async function downvote(req, res) {
    try{
    const scam = await Scam.findById(req.body.id);
    scam.votes--;
    await scam.save();
    res.send("Downvoted");
    }
    catch(e)
    {
        res.send(e.message);
        console.log('Failed to downvote');
    }
}

module.exports = { newScam, getScam, upvote, downvote };