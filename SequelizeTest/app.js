const { sequelize } = require("./models/index")
sequelize.sync({ force: true, alter: true }).then((result) => {
    console.log("Synced")
}).catch((err) => {
    console.log(err)
});