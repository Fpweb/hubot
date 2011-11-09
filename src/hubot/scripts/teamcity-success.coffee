# Mark Borcherding
#
# team city build success messages
#

success = [
  "http://imgs.xkcd.com/comics/compiling.png",
  "http://troll.me/images/the-most-interesting-man-in-the-world/i-dont-always-test-my-code-but-when-i-do-i-do-it-in-production.jpg",
  "http://troll.me/images/the-most-interesting-man-in-the-world/hell-it-compiled-thumb.jpg",
  "http://troll.me/images/x-all-the-things/compile-all-the-things-thumb.jpg",
  "http://troll.me/images/family-tech-support-guy/just-compile-it-from-source-oh-by-the-way-they-have-a-virtual-appliance-thumb.jpg"

]

module.exports = (robot) ->
  robot.hear /Build.*finished with status "success"/i, (msg) ->
    msg.send msg.random success
