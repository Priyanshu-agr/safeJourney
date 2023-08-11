const express = require('express');
const router = express.Router();
const scam = require('../controllers/scam');

router.route('/')
    .post(scam.newScam);

router.route('/')
    .get(scam.getScams);

router.route('/upvote')
    .post(scam.upvote);

router.route('/downvote')
    .post(scam.downvote);

module.exports = router;