url               = require 'url'
MeshbluAuth       = require 'express-meshblu-auth'
MessageController = require './controllers/message-controller'
DeviceController  = require './controllers/device-controller'

class Router
  constructor: ({deviceType, imageUrl, @meshbluConfig, serviceUrl}) ->
    @messageController = new MessageController
    @deviceController = new DeviceController {@meshbluConfig, deviceType, serviceUrl, imageUrl}

  route: (app) =>
    meshbluAuth = new MeshbluAuth @meshbluConfig
    app.get '/schemas/v1/configure.json', @deviceController.getConfigureSchema
    app.use meshbluAuth.auth()

    app.post   '/messages',       @messageController.message
    app.post   '/devices',        @deviceController.create

module.exports = Router
