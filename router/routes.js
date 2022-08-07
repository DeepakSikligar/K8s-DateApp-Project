const express = require('express');
const crudControl = require("../controllers/dateFromFile.js");
const router = express.Router();

router.get('/date' ,async function (req, res) {
    // this api was used by ICAM team to submit changes in any service.
    let result = await crudControl.getDateAndTime(req);
    res.send(result);
})

module.exports = router;