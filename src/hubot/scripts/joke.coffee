module.exports = (robot) ->
  joke_state = 'none'

  robot.respond /tell me a joke/i, (msg) ->
    if joke_state is 'none'
      msg.send "ok"
      msg.send "Knock knock"
      joke_state = 'expectwho'
    else
      msg.send "I'm already telling a joke.  Shut it."

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
