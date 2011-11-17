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

screenshot = (msg,url) -> 
  cacheBuster = Crypto.MD5(new Date().toString())
  imgUrl =  "#{url}?nocache=#{cacheBuster}"
  md5 = Crypto.MD5 "#{PRIVATE_KEY}+#{imgUrl}"
  url2png = "http://api.url2png.com/v3/#{API_KEY}/#{md5}/300x300/#{imgUrl}"
  thumbnail =  "<a href='http://#{url}'><img src='#{url2png}' /></a>"
  options =
    message: thumbnail
    room: HIPCHAT_ROOM_NAME
    from: HUBOT_NAME 
  hipchat.postMessage options

module.exports = (robot) ->

  robot.hear /Build.*WWW.*production.*success/i, (msg) -> 
    screenshot msg, "www.fpweb.net"

  robot.hear /Build.*Mercury.*production.*success/i, (msg) -> 
    screenshot msg, "mercury.fpweb.net"

  robot.hear /Build.*Amp360.*production.*success/i, (msg) -> 
    screenshot msg, "amp360.fpweb.net"    
