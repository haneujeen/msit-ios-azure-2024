const { sequelize } = require('./index')

const sync = () => {
    sequelize
    .sync({ force: true, alter: true })
    .then((result) => { console.log('Created') })
    .catch((err) => { console.log(err) });
}

module.exports = sync