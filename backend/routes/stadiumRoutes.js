const express = require('express');
const stadiumController = require('./../controllers/stadiumController');
const authController = require('./../controllers/authController');

const router = express.Router({ mergeParams: true });

router
  .route('/')
  .get(
    stadiumController.getAllStadiums)
  .post(
    authController.protect,
    authController.restrictTo('admin','manager'),
    stadiumController.createStadium
  );

module.exports = router;
