'use strict'
async = require 'async'

module.exports = (ndx) ->
  ndx.shortToken =
    fetch: (token, cb) ->
      ndx.database.select 'shorttoken',
        short: token
      , (tokens) ->
        if tokens and tokens.length
          cb null, tokens[0].long
        else
          cb 'No token'
    generate: (longToken, cb) ->
      id = null
      async.whilst ->
        return id is null
      , (callback) ->
        testid = ndx.generateID 8
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