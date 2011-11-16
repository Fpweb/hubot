# Ask hubot to sing you a song.
#
# sing me a song - Hubot will start singing the only song it knows.  It's an
#                         oldie but a goldie!  You can ask it to stop too.  Just remember
#                         to say please.
module.exports = (robot) ->

  time_to_stop = true

  robot.respond /sing me a song.*/i, (msg) ->
    msg.send "ok"

    time_to_stop = false

    delay = (ms, func) -> setTimeout func, ms

    sing = (n) ->
      if n > 1 and not time_to_stop
        msg.send "♪ #{n} bottles of beer on the wall ♩"
        msg.send "♬ #{n} bottles of beer ♪"
        msg.send "take one down ♫"
        msg.send "pass it around ♫"
        msg.send "♩ that's #{n-1} bottles of beer on the wall! ♬"

        delay 1000, -> sing(n-1)
      else
        time_to_stop = true
    sing 99

  robot.respond /please.*stop.*/i, (msg) ->
    if time_to_stop is false
      msg.send "What, dont you like my song?"
      msg.send "Fine. I'll stop."
      time_to_stop = true

