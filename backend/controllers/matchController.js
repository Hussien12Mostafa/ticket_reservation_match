const Match = require('./../models/matchModel');
const Team = require('./../models/teamModel');
const Booking = require('./../models/bookingModel');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');

exports.getAllMatches = catchAsync(async (req, res, next) => {
  const doc = await Match.find();
  const matches=new Array();
  for(const match of doc) {
    const bookings=await Booking.find({canceled:false,match:match._id})
    const reserved = new Array();
    const seats = Array.from({ length: match.stadium.rows*match.stadium.columns  }, (value, index) => (index+1).toString());
    for(const booking of bookings)
          reserved.push(booking.seatID);
    matches.push({match:match,reservedSeats:reserved,allSeats:seats});
  }
  return res.status(200).json({
    status: 'success',
    data: {
      data: matches
    }
  });
});

exports.getMatch =catchAsync(async (req, res, next) => {
  const match = (await Match.find({_id:req.params.id}))[0];
  const bookings=await Booking.find({canceled:false,match:match._id})
  const reserved = new Array();
  const seats = Array.from({ length: match.stadium.rows*match.stadium.columns  }, (value, index) => (index+1).toString());
  for(const booking of bookings)
        reserved.push(booking.seatID);
  return res.status(200).json({
    status: 'success',
    data: {
      match: match,
      reservedSeats:reserved,
      allSeats:seats
    }
  });
});

exports.createMatch = catchAsync(async (req, res, next) => {
  let doc = await Match.create(req.body);
  const match = (await Match.find({_id:doc._id}))[0];
  const bookings=await Booking.find({canceled:false,match:match._id})
  const reserved = new Array();
  const seats = Array.from({ length: match.stadium.rows*match.stadium.columns  }, (value, index) => (index+1).toString());
  for(const booking of bookings)
        reserved.push(booking.seatID);
  return res.status(200).json({
    status: 'success',
    data: {
      match: match,
      reservedSeats:reserved,
      allSeats:seats
    }
  });
});

exports.updateMatch = catchAsync(async (req, res, next) => {
  let doc = await Match.findByIdAndUpdate(req.body._id,{
    stadium:req.body.stadium,
    firstLineman:req.body.firstLineman,
    secondLineman:req.body.secondLineman,
    startDate:req.body.startDate
  });
  const match = (await Match.find({_id:doc._id}))[0];
  const bookings=await Booking.find({canceled:false,match:match._id})
  const reserved = new Array();
  const seats = Array.from({ length: match.stadium.rows*match.stadium.columns  }, (value, index) => (index+1).toString());
  for(const booking of bookings)
        reserved.push(booking.seatID);
  return res.status(200).json({
    status: 'success',
    data: {
      match: match,
      reservedSeats:reserved,
      allSeats:seats
    }
  });
});

exports.fixTime = catchAsync(async (req, res, next) => {
   let when=(req.body.startTime).split(' ')[1];
   let time=(req.body.startTime).split(' ')[0];
   let hours=parseInt(time.split(":")[0]);
   let minutes=time.split(":")[1];
   if(when=="AM")
    hours+=12
  if(hours<12)
  hours="0"+hours
  req.body.startDate=req.body.startDate+"T"+hours+":"+minutes+":00";
    next();
});

exports.validateMatch = catchAsync(async (req, res, next) => {
  if(req.body._id)
  {
    const match = await Match.findById(req.body._id);
    req.body.firstTeam=match.firstTeam;
    req.body.secondTeam=match.secondTeam;
  }
    const firstTeam = await Team.findById(req.body.firstTeam);
    const secondTeam = await Team.findById(req.body.secondTeam);
    if (!firstTeam || !secondTeam) {
        return next(new AppError('Teams Not Found', 404));
    }
    const firstTeamMatches = await Match.find({ firstTeam: req.body.firstTeam });
    const secondTeamMatches = await Match.find({ secondTeam: req.body.secondTeam });
    firstTeamMatches.forEach(element => {
        const date=(req.body.startDate).split('T')[0];
        if((element.startDate).toISOString().split('T')[0]== date && element.id!=req.body._id)
            return next(new AppError('A team cant have two matches at the same day', 404));
      });
    secondTeamMatches.forEach(element => {
        const date=(req.body.startDate).split('T')[0];
        if((element.startDate).toISOString().split('T')[0]== date && element.id!=req.body._id)
            return next(new AppError('A team cant have two matches at the same day', 404));
      });
      next();
  });
  
  
