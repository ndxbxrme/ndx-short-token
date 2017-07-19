'use strict'

count = 0
ndx = 
  generateID: (num) ->
    chars = 'abcdefghijklmnopqrstuvwxyz0123456789'
    output = ''
    i = 0
    while i++ < num
      output += chars[Math.floor(Math.random() * chars.length)]
    output
  database:
    select: (table, obj, cb) ->
      if table is 'shorttoken' and obj and obj.short is 'boom'
        cb [{
          short: 'boom'
          long: 'g934hgjig34gh34ggkjhgiughwegjkhag'
        }]
      else
        if count++ < 5
          cb [{
            something: 3
          }]
        else
          cb []
    insert: (table, obj, cb) ->
      console.log "inserting #{JSON.stringify(obj)} into #{table}"
require('../index.js') ndx
ndx.shortToken.generate 'boom', (shortToken) ->
  console.log 'generate short token, result: ' + shortToken
ndx.shortToken.fetch 'boom', (err, longToken) ->
  console.log 'fetch short token, result: ' + longToken