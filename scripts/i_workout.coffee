
module.exports = (robot) ->
  #obsceneImagesOfLmfao = []
  sighCount = 0
  robot.hear /\*?sigh\*?/i, (msg) ->
    sighCount = ++sighCount % 4
    msg.reply 'Girl look at that body.' 
    msg.reply 'I...I.I.I work out' if sighCount == 3
    # populate and uncomment this at your own risk
    #msg.reply msg.random obsceneImagesOfLmfao
