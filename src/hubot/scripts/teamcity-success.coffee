# Mark Borcherding
#
# team city build success messages
#

success = [
  "http://imgs.xkcd.com/comics/compiling.png"  
]

module.exports = (robot) ->
  robot.hear /Build.*finished with status "success"/i, (msg) ->
    msg.send msg.random success
