const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const scamSchema = new Schema({
    title: String,
    body: String,
    author: String,
    date: Date
})

module.exports = mongoose.model('Scam', scamSchema);