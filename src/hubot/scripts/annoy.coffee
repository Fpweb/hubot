# Ask hubot to annoy people
#
# hubot annoy mark
#
module.exports = (robot) ->

  delay = (ms, func) -> setTimeout func, ms

  robot.respond /annoy ([\w .-]+)$/i, (msg) ->
    name = msg.match[1]

    if name is "Josh"
      msg.send "I will not risk offending JRawk."
    else if name is robot.name
      msg.send "I am so annoying I annoy myself already. I am certainly not going to do it on purpose."
    else if user = robot.userForName name
      annoy = (seconds) ->
        msg.send "Hey #{name}, are you annoyed yet?"
        delay seconds*2, ->
          annoy seconds*2
          if seconds >= 128
            msg.send "I'm done annoying you."
            return

      annoy 1
    else
      msg.send "I can't annoy #{name}. I don't know who they are."