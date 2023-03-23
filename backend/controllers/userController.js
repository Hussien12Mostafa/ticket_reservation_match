const User = require('./../models/userModel');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');
const factory = require('./handlerFactory');
const Booking = require('../models/bookingModel');


const filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach(el => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

exports.getMe = (req, res, next) => {
  req.params.id = req.user.id;
  next();
};

exports.getAllReservations =  catchAsync(async (req, res, next) => {

  const reservations = await Booking.find({ user: req.user._id,canceled:false });
  const data=new Array();
  for(const reservation of reservations)
  {
    const bookings=await Booking.find({canceled:false,match:reservation.match._id})
    const reserved = new Array();
    const seats = Array.from({ length: reservation.match.stadium.rows*reservation.match.stadium.columns  }, (value, index) => (index+1).toString());
    for(const booking of bookings)
          reserved.push(booking.seatID);
    data.push({ticket:reservation,match:{match: reservation.match,reservedSeats:reserved,allSeats:seats}})
  }

  return res.status(200).json({
    status: 'success',
    data: data
  });
});


exports.getAllPendingUsers =  catchAsync(async (req, res, next) => {

  const pendingUsers = await User.find({ active: false });

  return res.status(200).json({
    status: 'success',
    users: pendingUsers
  });
});

exports.updateMe = catchAsync(async (req, res, next) => {
  if (req.body.password || req.body.passwordConfirm) {
    return next(
      new AppError(
        'This route is not for password updates. Please use /updateMyPassword.',
        400
      )
    );
  }

  const filteredBody = filterObj(req.body, 'name', 'email');
  const updatedUser = await User.findByIdAndUpdate(req.user.id, filteredBody, {
    new: true,
    runValidators: true
  });

  res.status(200).json({
    status: 'success',
    data: {
      user: updatedUser
    }
  });
});

exports.deleteMe = catchAsync(async (req, res, next) => {
  await User.findByIdAndUpdate(req.user.id, { active: false });

  res.status(204).json({
    status: 'success',
    data: null
  });
});

exports.updatePending = catchAsync(async (req, res, next) => {
  await User.findByIdAndUpdate(req.body.id, { active: req.body.active });

  res.status(200).json({
    status: 'success',
    data: null
  });
});

exports.updateAllPending = catchAsync(async (req, res, next) => {
  await User.updateMany({ active: req.body.accepted });

  res.status(200).json({
    status: 'success',
    data: null
  });
});


exports.deleteUser = catchAsync(async (req, res, next) => {
  await User.findByIdAndDelete(req.body.id);

  res.status(200).json({
    status: 'success',
    data: null
  });
});

exports.createUser = (req, res) => {
  res.status(500).json({
    status: 'error',
    message: 'This route is not defined! Please use /signup instead'
  });
};

exports.getUser = factory.getOne(User);
exports.getAllUsers = factory.getAll(User);
exports.updateUser = factory.updateOne(User);
