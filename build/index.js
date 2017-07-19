(function() {
  'use strict';
  var async;

  async = require('async');

  module.exports = function(ndx) {
    return ndx.shortToken = {
      fetch: function(token, cb) {
        return ndx.database.select('shorttoken', {
          short: token
        }, function(tokens) {
          if (tokens && tokens.length) {
            return cb(null, tokens[0].long);
          } else {
            return cb('No token');
          }
        });
      },
      generate: function(longToken, cb) {
        var id;
        id = null;
        return async.whilst(function() {
          return id === null;
        }, function(callback) {
          var testid;
          testid = ndx.generateID(8);
          return ndx.database.select('shorttoken', {
            short: testid
          }, function(tokens) {
            if (tokens && tokens.length) {
              true;
            } else {
              id = testid;
            }
            return callback(null, id);
          });
        }, function(err, id) {
          ndx.database.insert('shorttoken', {
            short: id,
            long: longToken
          });
          return cb(id);
        });
      }
    };
  };

}).call(this);

//# sourceMappingURL=index.js.map
