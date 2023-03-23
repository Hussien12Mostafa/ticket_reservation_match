const mongoose = require('mongoose');
const Booking = require('./../models/bookingModel');

const matchSchema = new mongoose.Schema({
    firstTeam: {
        type: mongoose.Schema.ObjectId,
        ref: 'Team',
        required: [true, 'First Team is required!'],
    },
    secondTeam: {
        type: mongoose.Schema.ObjectId,
        ref: 'Team',
        required: [true, 'Second Team is required!'],
    },
    stadium: {
        type: mongoose.Schema.ObjectId,
        ref: 'Stadium',
        required: [true, 'Stadium is required!'],
    },
    mainReferee: {
        type: String,
        required: [true, 'Main Referee is required!'],
      },

    firstLineman: {
        type: String,
        required: [true, 'First Line Man is required!'],
      },
    secondLineman: {
        type: String,
        required: [true, 'Second Line Man is required!'],
    },
    startDate: { type: Date,required: [true, 'Start Date is required!'],},
},
{
    timestamps: true
  });

matchSchema.pre('find', function(next) {
    this.populate('firstTeam').populate('secondTeam').populate('stadium');
    next();
});


const Match = mongoose.model('Match', matchSchema);

module.exports = Match;
