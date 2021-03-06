# listen for agilezen card numbers
#
# card <number> - Get the details for a card of a given number. You can call it a card or
#                 a story. You can also choose to use the # in front of the digits or not.

_ = require 'underscore'

HipChat = require 'node-hipchat'
HIPCHAT_API_KEY = process.env.HUBOT_HIPCHAT_API_KEY
hipchat = new HipChat HIPCHAT_API_KEY

AgileZen = require 'node-agilezen'
BOARD   = process.env.HUBOT_AGILEZEN_BOARD
PLANNING_BOARD = process.env.HUBOT_AGILEZEN_PLANNING_BOARD
API_KEY = process.env.HUBOT_AGILEZEN_APIKEY
agilezen = new AgileZen API_KEY

IGNORE_USERS = ['AgileZen','The Fpwebot', 'TeamCity', 'Fpwebot bot']
ECHOABLE_MESSAGE = [ /commented on/ , /reassigned/ ]
ECHO_TARGET_ROOM = process.env.HUBOT_AGILEZEN_ECHO_TARGET_ROOM

# card #xxx or just #xxx - see a summary of the card
# pb#xxx - see a summary the planning board card
module.exports = (robot) ->

  reply = (msg, text) ->
    hipchat.postMessage
      # This works for now, but will fail if the room contains a _
      room: /\d+_(.*)@conf.hipchat.com/.exec(msg.message.user.reply_to)[1].replace "_", " "
      message: text
      from: robot.name
      color: 'green'


  # echo the AgileZen board messages to our main room
  robot.hear /#(\d+)/i, (msg) ->
    text = msg.message.text
    return unless msg.message.user.name == "AgileZen"    
    return unless _.any ECHOABLE_MESSAGE, ((r) -> r.test text)
    return if /\[[a-f0-9]{7}\]/.test text  
    
    hipchat.postMessage
      room: ECHO_TARGET_ROOM
      message: text
      from: robot.name
      color: 'blue'

  robot.hear /(pl|pb|bl|p)?\s?(?:card #?|story #?|task #?|#)(\d+)/i, (msg) ->
    
    return if _.include IGNORE_USERS, msg.message.user.name

    agilezen = new AgileZen(API_KEY)
    story = msg.match[2]
    board = if msg.match[1] then PLANNING_BOARD else BOARD 

    agilezen.showStory board, story, (err,data) ->
      if data
        reply msg, "<a href='https://agilezen.com/project/#{board}/story/#{story}'>##{story}</a> #{data.text} "
      else
        msg.send "Card #{story} cannot be found."

  robot.hear /^@(?:card|story|task)(\d+) (.*)/i, (msg) ->
      story = msg.match[1]
      comment = msg.match[2]
      agilezen.commentOnStory BOARD,story, comment, (err, data) ->
        msg.send err if err



