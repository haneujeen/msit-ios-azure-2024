const Sequelize = require('sequelize');
const process = require('process');
const env = process.env.NODE_ENV || 'development';
const config = require('/../config/config.json')[env];
const db = {};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
