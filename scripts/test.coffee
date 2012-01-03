
module.exports = (robot) ->
  robot.hear /test/, (msg) ->
    msg.reply 'yup'
