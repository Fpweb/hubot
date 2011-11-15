# taking a screenshot of the www
#
Crypto = require('ezcrypto').Crypto
https = require 'https'

API_KEY = process.env.HUBOT_URL2PNG_API_KEY
PRIVATE_KEY = process.env.HUBOT_URL2PNG_PRIVATE_KEY
HIPCHAT_API_KEY = process.env.HUBOT_HIPCHAT_API_KEY

screenshot = (msg) -> 
  md5 = Crypto.MD5 PRIVATE_KEY + 'www.fpweb.net'
  url = "http://api.url2png.com/v3/#{API_KEY}/#{md5}/300x300/www.fpweb.net"
  thumbnail =  "<img src='#{url}' />"
  msg.send thumbnail


  body = 'room_id=fpweb.net&from=Fpwebot&message=something'

  options = 
    host:   'api.hipchat.com'
    path:   "v1/rooms/message?format=json&auth_token=#{HIPCHAT_API_KEY}"
    port:   443
    method: 'POST'
    headers: 
      'Content-Type':'application/x-www-form-urlencoded'
      'Content-Lenght':body.length

  req = https.request options, (res) ->
      msg.send res.statusCode
  req.write body
  req.end()


module.exports = (robot) ->
  #URL2PNG_API_KEY = process.env.HUBOT_TEAMCITY_PASSWORD
  robot.hear /(WWW).*production.*success/i, screenshot
