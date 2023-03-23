const express = require('express');
const bookingController = require('./../controllers/bookingController');
const authController = require('./../controllers/authController');

const router = express.Router();

router
  .route('/')
  .post(
    authController.protect,
    authController.restrictTo('fan'),
    bookingController.validateSeat,
    bookingController.createBooking
  );

  router
  .route('/cancelBooking')
  .post(
    authController.protect,
    authController.restrictTo('fan'),
    bookingController.cancelBooking
  );

module.exports = router;