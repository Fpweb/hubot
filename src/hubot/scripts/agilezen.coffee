# listen for agilezen card numbers
#
# card <number> - Get the details for a card of a given number. You can call it a card or
#                 a story. You can also choose to use the # in front of the digits or not.

AgileZen = require 'node-agilezen'

BOARD   = process.env.HUBOT_AGILEZEN_BOARD
API_KEY = process.env.HUBOT_AGILEZEN_APIKEY

module.exports = (robot) ->
  robot.hear /(?:card|story|task) #?(\d+)/i, (msg) ->
    agilezen = new AgileZen(API_KEY)
    story = msg.match[1]
    agilezen.showStory BOARD, story, (data,err) ->
      if data
        msg.send "[Card #{story}] #{data.text} https://agilezen.com/project/#{BOARD}/story/#{story}" 
      else
        msg.send "Card #{story} cannot be found."

  robot.hear /^@(?:card|story|task)(\d+) (.*)/i, (msg) ->
  	msg.send "#{msg.match[1]} #{msg.match[2]}"
      
