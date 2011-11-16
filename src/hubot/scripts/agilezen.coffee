# listen for agilezen card numbers

AgileZen = require 'node-agilezen'

BOARD   = process.env.HUBOT_AGILEZEN_BOARD
API_KEY = process.env.HUBOT_AGILEZEN_APIKEY

module.exports = (robot) ->
  robot.hear /(?:card|story) #?(\d+)/i, (msg) ->
    agilezen = new AgileZen(API_KEY)
    story = msg.match[1]
    agilezen.showStory BOARD, story, (data,err) ->
      msg.send "[#{story}] #{data.text} https://agilezen.com/project/#{BOARD}/story/#{story}"
