const mongoose = require('mongoose');

const teamSchema = new mongoose.Schema({

    name: {
        type: String,
        required: [true, 'Name is required!'],
        unique: true,
      },
    },
    {
        timestamps: true
      });


const Team = mongoose.model('Team', teamSchema);

module.exports = Team;
