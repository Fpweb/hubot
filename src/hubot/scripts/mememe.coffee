# meme me <meme> when you hear <the text> - Responds with a meme when you some catch phrase
module.exports = (robot) ->

  memes = {}

  robot.respond /meme me (.*) when you hear (.*)/i, (msg) ->  
    [meme, text] =[ msg.match[1], msg.match[2]]

    msg.send "I need another meme like a need a hole in my head....but OK"

    if memes.hasOwnProperty(text)
      memes[text].push meme
    else
      memes[text] = [meme]
      robot.hear new RegExp(text) , (m) ->
        m.send m.random memes[text]



