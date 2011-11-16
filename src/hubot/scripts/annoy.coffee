# Ask hubot to annoy people
#
# @hubot annoy mark - hubot will send annoying messages if it recognizes the user.
#
module.exports = (robot) ->

  delay = (ms, func) -> setTimeout func, ms

  robot.respond /annoy ([\w .-]+)$/i, (msg) ->
    name = msg.match[1]

    if name.match /mark/i
      msg.send "I will not risk offending Mark."

    else if user = robot.userForName name
      if name.match /fpwebot/i # TODO: try robot.name instead
        msg.send "I am so annoying I annoy myself already. I am certainly not going to do it on purpose."
        return

      if name.match /josh/i
        msg.send "I love annoying JRawk most of all."
      else
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