const Scams = require('../models/scam');
const utils = require('../utils/scam');
const axios = require('axios');

require('dotenv').config();

const BING_KEY = process.env.BING_MAP_KEY;

async function getHome(req, res) {
    res.send("HEHEHE");
}

async function displayScams(req, res) {
    try {
        //user location user allow us to fetch
        const query = req.body.location;
        // const userLati = query.latitudeUser;
        // const userLng = query.longitudeUser;

        const key = BING_KEY;
        const url = "https://dev.virtualearth.net/REST/v1/Locations?q=" + query + "&output=json&key=" + key;

        let scams = await Scams.find({});
        let resScams = [];
        let lat1;
        let lng1;

        await axios.get(url)
            .then((res) => {
                lat1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[0];
                lng1 = res.data.resourceSets[0].resources[0].geocodePoints[0].coordinates[1];
            })
            .catch((e) => {
                console.error(e);
            })

        scams.forEach((scam) => {
            let dist = utils.getDistance(lat1, lng1, scam.coordinatex, scam.coordinatey);
            dist = dist / 1000;
            dist = Math.floor(dist);
            if (dist <= 6) {
                resScams.push(scam);
            }
        })
        console.log('Scam fetched successfully');
        res.send(resScams);
    }
    catch (e) {
        console.log('Scam fetch unsuccessful');
        console.log(e.message);
    }
}

module.exports = { getHome, displayScams };