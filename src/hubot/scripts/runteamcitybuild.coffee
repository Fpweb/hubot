# You need to set the following variables:
# HUBOT_TEAMCITY_USERNAME = <user name>
# HUBOT_TEAMCITY_PASSWORD = <password>
# HUBOT_TEAMCITY_HOSTNAME = <host : port>

# This url format triggers a build on a specific build id.
# https://dev.fpweb.net/TeamCity/action.html?add2Queue=bt19

module.exports = (robot) ->
  robot.respond /run build( (.*))?/i, (msg) ->
    # TODO: Parse text after 'run build' into a btid or wildcard text that matches build config names.
    buildId = msg.match[2] || "bt29"

    username = process.env.HUBOT_TEAMCITY_USERNAME
    password = process.env.HUBOT_TEAMCITY_PASSWORD
    hostname = process.env.HUBOT_TEAMCITY_HOSTNAME
    msg.http("https://#{hostname}/action.html?add2Queue=#{buildId}")
      .query(locator: ["running:any", "count:3"].join(","))
      .headers(Authorization: "Basic #{new Buffer("#{username}:#{password}").toString("base64")}", Accept: "application/json")
      .get() (err, res, body) ->
        if err
          msg.send "Team city says: #{err}"
          return
        msg.send "Your build has been triggered."