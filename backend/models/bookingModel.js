const mongoose = require('mongoose');

const bookingSchema = new mongoose.Schema({

    match: {
        type: mongoose.Schema.ObjectId,
        ref: 'Match',
        required: [true, 'Match is required!'],
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
        required: [true, 'User is required!'],
    },
    seatID:{
      type: String,
      required: [true, 'Seat Number is required!'],
    },
    canceled: { type: Boolean, default:false},
},
{
    timestamps: true
  });

  bookingSchema.pre(/^find/, function(next) {
    this.populate('match');
    next();
  });

const Booking = mongoose.model('Booking', bookingSchema);

module.exports = Booking;
