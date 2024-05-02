const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];
const db = {};

let sequelize = new Sequelize (
  config.database,
  config.username,
  config.password,
  config
)

db.sequelize = sequelize;
db.Sequelize = Sequelize;

const Student = require("./student")
const Book = require("./book")
const Car = require("./car")
Student.init(sequelize)
Book.init(sequelize)
Car.init(sequelize)
db.Student = Student
db.Book = Book
db.Car = Car

Car.associate(db)
Student.associate(db)
Book.associate(db)

module.exports = db;
