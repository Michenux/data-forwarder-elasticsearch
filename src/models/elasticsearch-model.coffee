request = require 'request'
logerror = require('debug')('elasticsearch:error');

class Elasticsearch
  onMessage: ({message, forwarderConfig}, callback) =>
    {url, username, password} = forwarderConfig
    options =
      url: url
      json: message

    options.auth = {username, password} if username?.length && password?.length
    request.post options, (error, response, body) ->
      return callback error if error?
      unless response.statusCode >= 200 && response.statusCode < 399
        logerror 'Failed to insert data inside ES'
        logerror 'response.statusCode: ' + response.statusCode
        logerror 'response.statusMessage: ' + response.statusMessage
        logerror 'response.body: ' + JSON.stringify(body)
        return callback 'Failed to insert data inside ElasticSearch. Check server logs.'
      callback()

module.exports = Elasticsearch
