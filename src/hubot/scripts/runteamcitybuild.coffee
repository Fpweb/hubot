# You need to set the following variables:
# HUBOT_TEAMCITY_USERNAME = <user name>
# HUBOT_TEAMCITY_PASSWORD = <password>
# HUBOT_TEAMCITY_HOSTNAME = <host : port>

# This url format triggers a build on a specific build id.
# https://dev.fpweb.net/TeamCity/action.html?add2Queue=bt19
#
# run me build <build id> - Trigger a build on TeamCity.
module.exports = (robot) ->
  robot.respond /run me build( (.*))?/i, (msg) ->
    # TODO: Parse text after 'run build' into a btid or wildcard text that matches build config names.
    buildQuery = msg.match[2]

    if not buildQuery.match(/^bt[0-9]+/i)
      msg.send "I don't know what build '#{buildQuery}' is"
      msg.send "Try a btId. Like bt28 for Zuora or bt26 for Mercury."
      return

    buildId = buildQuery

    # TODO: Get the full name of the build config for echoing later.
    buildName = buildId # for now...

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
        msg.send "Build #{buildName} has been queued up."

# TODO: Stick a build comment on these hubot triggered builds.  Include the user name as TC uses the sys account.