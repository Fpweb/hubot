# listen for agilezen card numbers
#
#
#
module.exports = (robot) ->
  robot.hear /(?:card|story) #?(\d+)/i, (msg) ->
    msg.send msg.match[2]
