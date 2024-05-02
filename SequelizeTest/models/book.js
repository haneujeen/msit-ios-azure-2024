const { timeStamp } = require("console")
const Sequelize = require("sequelize")

class Book extends Sequelize.Model {
    static init(sequelize) {
        super.init({
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                primaryKey: true,
                unique: true
            },
            title: {
                type: Sequelize.STRING(50),
                allowNull: false
            },
            author: {
                type: Sequelize.STRING(50)
            },
            // studentId: {
            //     type: Sequelize.INTEGER,
            //     references: {
            //         model: 'student',
            //         key: 'id',
            //     }
            // },
        },
        {
            sequelize,
            timeStamp: true,
            paranoid: true,
            underscored: false,
            modelName: "Book",
            tableName: "book"
        })
    }
    static associate(db) {
        db.Book.belongsToMany(db.Student, { through: "rental" })
    }
}

module.exports = Book