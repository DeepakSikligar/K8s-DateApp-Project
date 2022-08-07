const defaults = require('../constant/defaults.js')
const readLastLines = require('read-last-lines');

async function getDateAndTime(req) {
    try {
        console.log(defaults.constants.PATH)
        let results={}, last5lines;
        last5lines = await readLastLines.read(defaults.constants.PATH, 5)
        if(last5lines){
            last5lines = last5lines.trim().split("\n")
            for(let singleJobOutput in last5lines) {
                results[parseInt(singleJobOutput)+1]=last5lines[singleJobOutput]
            }           
        }
        else{
            results={
                "message" : "NO DATA FOUND"
            }
        }

        return results;

    } catch (err) {
        console.error(err);
        let message= {"Error": "Unable to fetch data from the server, please check logs"}
        return message;
    }
}

module.exports = { getDateAndTime };