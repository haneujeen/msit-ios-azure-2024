const { timeStamp } = require("console")
const Sequelize = require("sequelize")

class Student extends Sequelize.Model {
    static init(sequelize) {
        super.init({
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                primaryKey: true,
                unique: true
            },
            name: {
                type: Sequelize.STRING(50),
                allowNull: false
            },
            gender: {
                type: Sequelize.CHAR(1)
            }, 
            major: {
                type: Sequelize.STRING(30)
            }, 
            grade: {
                type: Sequelize.INTEGER
            }
        },
        {
            sequelize,
            timeStamp: true,
            paranoid: true,
            underscored: false,
            modelName: "Student",
            tableName: "student"
        })
    }
    static associate(db) {
        db.Student.hasMany(db.Car, { foreignKey: "studentId", sourceKey: "id" })
        db.Student.belongsToMany(db.Book, { through: "rental" })
    }
}

module.exports = Student