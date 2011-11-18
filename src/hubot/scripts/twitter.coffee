# twitter me <username> - Get the last tweet from <user>

module.exports = (robot) ->
  robot.respond /(twitter|lasttweet) me (.+)$/, (msg) ->
   username = msg.match[2]      
   msg.http("http://api.twitter.com/1/statuses/user_timeline/#{escape(username)}.json?count=1")
    .get() (err, res, body) ->
      response = JSON.parse body
      if response[0]
       msg.send response[0]["text"]
      else
       msg.send "Error"