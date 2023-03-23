const multer = require('multer');
const sharp = require('sharp');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');
const factory = require('./handlerFactory');
const Team = require('../models/teamModel');

exports.getAllTeams = factory.getAll(Team);
exports.getTeam = factory.getOne(Team);
exports.createTeam = factory.createOne(Team);
exports.updateTeam= factory.updateOne(Team);
exports.deleteTeam = factory.deleteOne(Team);
