module.exports = (robot) ->
  robot.hear /forever\s{0,1}alone/i, (msg) ->
    msg.send "http://s3.amazonaws.com/kym-assets/entries/icons/original/000/003/619/Untitled-1.jpg?1288903617?bot=.jpg"