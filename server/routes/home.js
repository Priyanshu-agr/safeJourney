const express = require('express');
const router = express.Router();
const home = require('../controllers/home');

router.route('/')
    .get(home.getHome);

router.route('/')
    .post(home.displayScams);

module.exports = router;