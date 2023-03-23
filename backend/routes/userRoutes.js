const express = require('express');
const userController = require('./../controllers/userController');
const authController = require('./../controllers/authController');

const router = express.Router();

router.post('/signup', authController.signup);
router.post('/login', authController.login);

router.use(authController.protect);
router.post('/logout',authController.logout);
router.post('/updateMyPassword', authController.updatePassword);
router.get('/me', userController.getMe, userController.getUser);
router.get('/myReservations', userController.getAllReservations);
router.post('/updateMe',userController.updateMe);

router.use(authController.restrictTo('admin'));
router.route('/').get(userController.getAllUsers).post(userController.createUser);
router.route('/pendingUsers').get(userController.getAllPendingUsers)

router.route('/updatePending').post(userController.updatePending)

router.route('/updateAllPending').post(userController.updateAllPending)

router.route('/deleteUser').post(userController.deleteUser)

module.exports = router;
