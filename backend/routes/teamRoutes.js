const express = require('express');
const teamController = require('../controllers/teamController');
const authController = require('../controllers/authController');
const router = express.Router({ mergeParams: true });
router.route('/').get(teamController.getAllTeams);
module.exports = router;
