
twss = require 'twss'
#twss.algo = 'knn'
module.exports = (robot) ->
  # The classifier is not accurate enough yet. 
  #  robot.hear /(.*)/i, (msg) ->
  #  msg.reply "That's what she said." if twss.is msg.message.text
