
const express = require('express')
const app = express()
const defaults = require('./constant/defaults.js')
const timerRoutes = require('./router/routes.js')
const fs = require('fs')


app.use('/',timerRoutes);

app.listen(defaults.constants.PORT, () => {
  console.log(`Date and Time App listening on port ${defaults.constants.PORT}`)
})