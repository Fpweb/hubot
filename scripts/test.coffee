
module.exports = (robot) ->
  robot.hear /test/, (msg) ->
    msg.reply robot.name

  robot.respond /foo/, (msg) ->
    msg.reply 'yup'
