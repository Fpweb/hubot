# your FACE
#

images = [
  "http://www.mikeweber.info/misc/farva.jpg"
  ]

module.exports = (robot) ->
  robot.hear /your FACE/i, (msg) ->
    msg.send msg.random images