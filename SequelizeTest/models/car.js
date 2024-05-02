const { timeStamp } = require("console")
const Sequelize = require("sequelize")

class Car extends Sequelize.Model {
    static init(sequelize) {
        super.init({
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                primaryKey: true,
                unique: true
            },
            model: {
                type: Sequelize.STRING(50),
                allowNull: false
            },
            // studentId: {
            //     type: Sequelize.INTEGER,
            //     references: {
            //         model: 'student',
            //         key: 'id',
            //     }
            // }
        },
        {
            sequelize,
            timeStamp: true,
            paranoid: true,
            underscored: false,
            modelName: "Car",
            tableName: "car"
        })
    }
    static associate(db) {
        db.Car.belongsTo(db.Student, { foreignKey: "studentId", targetKey: "id" })
    }
}

module.exports = Car