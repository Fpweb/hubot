last_twss = null
twss = require 'twss'
twss.algo = 'knn'

# without the redis brain we lose the classifier everytime it restarts
# this makes training it very annoying
#module.exports = (robot) ->
  
  robot.hear /(.*)/i, (msg) ->
    text = msg.message.text
    if twss.is msg.message.text
      last_twss = msg.message.text
      msg.reply "That's what she said."

  robot.respond /that (?:was|is)(?:n't| not) funny\.?/i, (msg) ->
      twss.trainingData.neg.push last_twss if last_twss
