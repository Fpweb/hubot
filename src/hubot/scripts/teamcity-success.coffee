# Mark Borcherding
#
# team city build success messages
#

success = [
  "http://imgs.xkcd.com/comics/compiling.png",
  "http://troll.me/images/the-most-interesting-man-in-the-world/i-dont-always-test-my-code-but-when-i-do-i-do-it-in-production.jpg"
]

module.exports = (robot) ->
  robot.hear /Build.*finished with status "success"/i, (msg) ->
    msg.send msg.random success
