# MEAT SAUCE
#

images = [
  "http://www.mikeweber.info/misc/Jack%20Daniels%20Meat%20Sauce.jpg",
  ]

module.exports = (robot) ->
  robot.hear /jack daniels meat sauce/i, (msg) ->
    msg.send msg.random images