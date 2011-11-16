# Ask hubot to tell you a joke.
#
# tell me a joke - Hubot will tell a knock knock joke. It only knows one.
#                         You can tell it the joke is lame if you want.  It'll stop.
module.exports = (robot) ->
  joke_state = 'none'

  robot.respond /tell me a joke/i, (msg) ->
    if joke_state is 'none'
      msg.send "ok"
      msg.send "Knock knock"
      joke_state = 'expectwho'
    else
      msg.send "I'm already telling a joke.  Wait your turn."

  robot.respond /who.*there/i, (msg) ->
    if joke_state is 'expectwho'
      msg.send "Boo"
      joke_state = 'expectwhowho'
    else
      msg.send "just me, ole Fpwebot"

  robot.respond /boo.*who/i, (msg) ->
    if joke_state is 'expectwhowho'
      msg.send "Don't cry.  It's just a joke."
      joke_state = 'none'

  robot.respond /.*joke.*(stupid|lame|dumb|suck|bad).*/i, (msg) ->
    if joke_state is 'none'
      msg.send "What joke?  I'm not telling one."
    else
      msg.send "Whatever.  Your face is #{msg.match[1]}."
      joke_state = 'none'
