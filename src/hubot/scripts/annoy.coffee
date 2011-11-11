# Ask hubot to annoy people
#
# hubot annoy mark
#
module.exports = (robot) ->

  delay = (ms, func) -> setTimeout func, ms

  robot.respond /annoy ([\w .-]+)$/i, (msg) ->
    name = msg.match[1]

    if name is "josh buedel"
      msg.send "I will not risk offending JRawk."

    # TODO: This does not ever find user names....
    else if user = robot.userForName name
      if name is "fpwebot bot" # TODO: try robot.name instead
        msg.send "I am so annoying I annoy myself already. I am certainly not going to do it on purpose."
        return

      msg.send "sure.  }:)"

      delay 5000, ->
        annoy = (seconds) ->
          if seconds >= 12800 # millis
            msg.send "I'm done annoying you @#{name}."
            return

          msg.send "Hey @#{name}, are you annoyed yet?"
          delay seconds, ->
            annoy seconds*2

        annoy 1000
    else
      msg.send "I can't annoy #{name}. I don't know who that is."