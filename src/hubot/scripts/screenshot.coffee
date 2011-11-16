# taking a screenshot of the www
#
Crypto = require('ezcrypto').Crypto
HipChat = require('node-hipchat')


API_KEY = process.env.HUBOT_URL2PNG_API_KEY
PRIVATE_KEY = process.env.HUBOT_URL2PNG_PRIVATE_KEY

HIPCHAT_API_KEY = process.env.HUBOT_HIPCHAT_API_KEY
HIPCHAT_ROOM_NAME = process.env.HUBOT_HIPCHAT_ROOM_NAME

HUBOT_NAME = process.env.HUBOT_NAME

hipchat = new HipChat HIPCHAT_API_KEY

screenshot = (msg) -> 
  cacheBuster = Crypto.MD5 new Date()
  imgUrl =  "www.fpweb.net?nocache=#{cacheBuster}"
  md5 = Crypto.MD5 "#{PRIVATE_KEY}+#{imgUrl}"
  url = "http://api.url2png.com/v3/#{API_KEY}/#{md5}/400x400/#{imgUrl}"
  thumbnail =  "<img src='#{url}' /><br/><small><a href='#{url}'>url</a></small>"
  options =
    message: thumbnail
    room: HIPCHAT_ROOM_NAME
    from: HUBOT_NAME 
  hipchat.postMessage options
    



module.exports = (robot) ->
  #URL2PNG_API_KEY = process.env.HUBOT_TEAMCITY_PASSWORD
  robot.hear /(WWW).*production.*success/i, screenshot
