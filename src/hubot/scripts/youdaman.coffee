# You Da Man
#

images = [
  "http://images.cheezburger.com/completestore/2011/4/12/cb4a0c0c-d1e9-4478-b56f-0031c6791985.jpg"
  ]

module.exports = (robot) ->
  robot.hear /you da man/i, (msg) ->
    msg.send msg.random images