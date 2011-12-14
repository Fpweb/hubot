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
API_KEY = process.env.HUBOT_AGILEZEN_APIKEY
agilezen = new AgileZen API_KEY

IGNORE_USERS = ['AgileZen','The Fpwebot']
ECHOABLE_MESSAGE = [ /commented on/ , /reassigned/ ]

module.exports = (robot) ->

  reply = (msg, text) ->
    hipchat.postMessage
      room: /\d+_(.*)@conf.hipchat.com/.exec(msg.message.user.reply_to)[1].replace "_", " "
      message: text
      from: robot.name
      color: 'green'


  robot.hear /#(\d+)/i, (msg) ->
    text = msg.message.text
    if msg.message.user.name == "AgileZen" and _.any ECHOABLE_MESSAGE, ((r) -> r.test text)
      hipchat.postMessage
        room: "Fpweb.net"
        message: text
        from: robot.name
        color: 'green'

  robot.hear /(?:card #?|story #?|task #?|#)(\d+)/i, (msg) ->
    agilezen = new AgileZen(API_KEY)
    story = msg.match[1]

    return if _.include IGNORE_USERS, msg.message.user.name

    agilezen.showStory BOARD, story, (err,data) ->
      if data
        reply msg, "<a href='https://agilezen.com/project/#{BOARD}/story/#{story}'>##{story}</a> #{data.text} "
      else
        msg.send "Card #{story} cannot be found."

  robot.hear /^@(?:card|story|task)(\d+) (.*)/i, (msg) ->
      story = msg.match[1]
      comment = msg.match[2]
      agilezen.commentOnStory BOARD,story, comment, (err, data) ->
        msg.send err if err



