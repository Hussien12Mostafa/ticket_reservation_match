const express = require('express');
const matchController = require('./../controllers/matchController');
const authController = require('./../controllers/authController');

const router = express.Router();

router
  .route('/')
  .get(matchController.getAllMatches)
  .post(
    authController.protect,
    authController.restrictTo('admin','manager'),
    matchController.fixTime,
    matchController.validateMatch,
    matchController.createMatch
  );

router
  .route('/:id')
  .get(matchController.getMatch);

  router
  .route('/editMatch')
  .post(
    authController.protect,
    authController.restrictTo('admin','manager'),
    matchController.validateMatch,
    matchController.updateMatch
  )

module.exports = router;
