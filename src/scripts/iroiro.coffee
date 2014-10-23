# Description
#   A Hubot script that returns a iroiro url
#
# Configuration:
#   None
#
# Commands:
#   hubot iroiro <keyword> - returns a iroiro url
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /iroiro (.+)$/i, (res) ->
    keyword = res.match[1]
    url = "http://synthsky.com/iroiro/embed?req=#{encodeURIComponent(keyword)}"
    res.send url
