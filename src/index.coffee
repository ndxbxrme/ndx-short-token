'use strict'
async = require 'async'

module.exports = (ndx) ->
  generateID = (num) ->
    chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    output = ''
    i = 0
    while i++ < num
      output += chars[Math.floor(Math.random() * chars.length)]
    output
  ndx.shortToken =
    fetch: (token, cb) ->
      ndx.database.select 'shorttoken',
        short: token
      , (tokens) ->
        if tokens and tokens.length
          cb null, tokens[0].long
        else
          cb 'No token'
    remove: (token) ->
      ndx.database.delete 'shorttoken',
        short: token
    generate: (longToken, cb) ->
      id = null
      async.whilst ->
        return id is null
      , (callback) ->
        testid = generateID 8
        ndx.database.select 'shorttoken',
          short: testid
        , (tokens) ->
          if tokens and tokens.length
            true
          else
            id = testid
          callback null, id
      , (err, id) ->
        ndx.database.insert 'shorttoken',
          short: id
          long: longToken
        cb id