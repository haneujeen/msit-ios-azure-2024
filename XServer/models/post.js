const Sequelize = require('sequelize')

class Post extends Sequelize.Model {
    static init(sequelize) {
        return super.init(
            {
                userId: {
                    type: Sequelize.STRING(30),
                    allowNull: false
                },
                content: {
                    type: Sequelize.TEXT,
                    allowNull: false
                }
            }, 
            { 
                sequelize, 
                timestamps: true, 
                paranoid: true, 
                modelName: 'Post', 
                tableName: 'post' 
            }
        )
    }

    static associate(db) {
        db.Post.belongsTo(db.User, { foreignKey: 'userId', targetKey: 'userId' })
    }
}

module.exports = Post