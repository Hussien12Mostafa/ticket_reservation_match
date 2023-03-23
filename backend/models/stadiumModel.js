const mongoose = require('mongoose');

const stadiumSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Name is required!'],
        unique: true,
      },
    rows: {
        type: Number,
        required: [true, 'Rows Number is required!'],
        min: 1,
      },
    columns: {
        type: Number,
        required: [true, 'Columns Number is required!'],
        min: 1,
    }
  },
  {
      timestamps: true
    });


const Stadium = mongoose.model('Stadium', stadiumSchema,'stadiums');

module.exports = Stadium;
