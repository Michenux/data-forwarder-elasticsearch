debug       = require('debug')('data-forwarder:data-forwarder-elasticsearch')
_           = require 'lodash'
MeshbluHttp = require 'meshblu-http'
Elasticsearch  = require '../models/elasticsearch-model'

class MessageController

  message: (req, res) =>
    message = req.body
    meshblu = new MeshbluHttp req.meshbluAuth

    @whoami meshblu, (error, device) =>
      return res.sendError(error) if error?
      {forwarderConfig} = device
      return res.sendStatus 422 unless forwarderConfig?
      
      {devices} = req.body
      @getDeviceConfig meshblu, devices, (error, receiverConfig) =>
        return res.sendError(error) if error?

        message.receiverName = receiverConfig.name

        receivedDate = new Date
        message.date = receivedDate

        elasticsearch = new Elasticsearch
        elasticsearch.onMessage {message, forwarderConfig}, (error) =>
          return res.sendError error if error?
          res.sendStatus 201

  whoami: (meshblu, callback) =>
    meshblu.whoami (error, device) =>
      return callback error if error?
      callback null, device

  getDeviceConfig: (meshblu, devices, callback) =>
      meshblu.device devices, {}, (error, device) =>
        return callback error if error?
        callback null, device

module.exports = MessageController
