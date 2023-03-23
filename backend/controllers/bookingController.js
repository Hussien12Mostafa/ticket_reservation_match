const Booking = require('./../models/bookingModel');
const User = require('./../models/userModel');
const Match = require('./../models/matchModel');
const factory = require('./handlerFactory');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');

exports.cancelBooking = catchAsync(async (req, res, next) => {
    const booking = await Booking.findById(req.body.reservationId);
    if (!booking.user.equals(req.user._id)) {
        return next(new AppError('Unauthorized to view booking', 403));
    }
    if (!booking) {
        return next(new AppError('Booking Not Found', 404));
    }
    if (booking.canceled) {
        return next(new AppError('Booking Already Cancelled', 400));
    }
    const updatedBooking = await Booking.findByIdAndUpdate(req.params.id, { canceled: true });
    return res.status(200).json({
        status: 'success',
        data: updatedBooking
      });
  });

exports.validateAccess = catchAsync(async (req, res, next) => {
    if (!booking) {
        return next(new AppError('Booking Not Found', 404));
    }
    const booking = await Booking.findById(req.params.id);
    if (booking.user.id != req.user.id) {
        return next(new AppError('Unauthorized to view booking', 403));
    }
    next();
  });
  

exports.validateSeat = catchAsync(async (req, res, next) => {
    const user = await User.findById(req.user._id);
    if (user.role!="fan") {
        return next(new AppError('Invalid Access', 403));
    }
    const match = await Match.findById(req.body.match);
    seats=req.body.seats;
    for (const seat of seats) {
        const booking = await Booking.findOne({seatID:seat,match:req.body.match,canceled:false});
        if (booking) {
            return next(new AppError('Seat Already Taken', 400));
        }
      }
    next();
  });

  exports.createBooking = catchAsync(async (req, res, next) => {
    seats=req.body.seats;
    const match = await Match.findById(req.body.match);
    for (const seat of seats) {
        const booking = await Booking.create({user:req.user._id,seatID:seat,match:req.body.match,canceled:false});
      }
      return res.status(200).json({
        status: 'success',
        data: []
      });
  });

  exports.getMatchReservedSeats = async function(data)
  {
    if(data.matchId)
    {
        const bookings=await Booking.find({canceled:false,match:data.matchId})
        const reserved = new Array();
        for(const booking of bookings)
            reserved.push(booking.seatID);
        return {reservedSeats:reserved,matchId:data.matchId};
    }
    else return {reservedSeats:[],matchId:null}
  }

  
