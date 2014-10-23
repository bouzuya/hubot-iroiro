// Description
//   A Hubot script that returns a iroiro url
//
// Configuration:
//   None
//
// Commands:
//   hubot iroiro <keyword> - returns a iroiro url
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  return robot.respond(/iroiro (.+)$/i, function(res) {
    var keyword, url;
    keyword = res.match[1];
    url = "http://synthsky.com/iroiro/embed?req=" + (encodeURIComponent(keyword));
    return res.send(url);
  });
};
