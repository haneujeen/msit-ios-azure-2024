const Sequelize = require('sequelize')

class User extends Sequelize.Model {
    static init(sequelize) {
        return super.init(
            {
                userId: {
                    type: Sequelize.STRING(30),
                    allowNull: false,
                    unique: true
                },
                userName: {
                    type: Sequelize.STRING(30),
                    allowNull: false
                },
                password: {
                    type: Sequelize.STRING(100),
                    allowNull: false
                }
            }, 
            { 
                sequelize, 
                timestamps: true, 
                paranoid: true, 
                modelName: 'User', 
                tableName: 'user' 
            }
        )
    }

    static associate(db) {
        db.User.hasMany(db.Post, { foreignKey: 'userId', sourceKey: 'userId' })
    }
}

module.exports = User