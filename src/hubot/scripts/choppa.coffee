
module.exports = (robot) ->
  robot.hear /get to the choppa/i, (msg) ->
    msg.send "http://i531.photobucket.com/albums/dd352/sbkittrell/get-to-the-choppa.jpg"
