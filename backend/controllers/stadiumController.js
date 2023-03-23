const Stadium = require('./../models/stadiumModel');
const factory = require('./handlerFactory');

exports.getAllStadiums = factory.getAll(Stadium);
exports.createStadium = factory.createOne(Stadium);
