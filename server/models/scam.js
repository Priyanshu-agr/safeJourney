const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const scamSchema = new Schema({
    title: String,
    body: String,
    author: String,
    date: Date,
    location: String,
    coordinatex: Number,
    coordinatey: Number, 
    votes: {type: Number, default: 0}
})

module.exports = mongoose.model('Scam', scamSchema);