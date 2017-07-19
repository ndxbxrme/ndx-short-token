(function() {
  'use strict';
  var count, ndx;

  count = 0;

  ndx = {
    generateID: function(num) {
      var chars, i, output;
      chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
      output = '';
      i = 0;
      while (i++ < num) {
        output += chars[Math.floor(Math.random() * chars.length)];
      }
      return output;
    },
    database: {
      select: function(table, obj, cb) {
        if (table === 'shorttoken' && obj && obj.short === 'boom') {
          return cb([
            {
              short: 'boom',
              long: 'g934hgjig34gh34ggkjhgiughwegjkhag'
            }
          ]);
        } else {
          if (count++ < 5) {
            return cb([
              {
                something: 3
              }
            ]);
          } else {
            return cb([]);
          }
        }
      },
      insert: function(table, obj, cb) {
        return console.log("inserting " + (JSON.stringify(obj)) + " into " + table);
      }
    }
  };

  require('../index.js')(ndx);

  ndx.shortToken.generate('boom', function(shortToken) {
    return console.log('generate short token, result: ' + shortToken);
  });

  ndx.shortToken.fetch('boom', function(err, longToken) {
    return console.log('fetch short token, result: ' + longToken);
  });

}).call(this);

//# sourceMappingURL=test.js.map
