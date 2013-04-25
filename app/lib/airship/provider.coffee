# Airship.js Provider
#
# This class is the main Airship.js RPC API. It runs in an iframe embedded in the
# consumer app and allows the app to store and retrieve data managed by Airship.js.

DropboxHelper = require 'lib/dropbox_helper'

module.exports = class Provider
  LOGIN_SELECTOR: 'button.login'

  initialize: ->
    console.log('Initialized Provider')
    @initRPC()
    @initDropbox()
    Object.freeze? this
    this

  initRPC: ->
    @remote = new easyXDM.Rpc @getChannel(),
      remote:
        alertMessage: {}
      local:
        addNumbers: (a, b) ->
          a + b
        multiplyNumbers: (a, b, fn) ->
          window.setTimeout (-> fn(a * b)), 5000
        noOp: ->
          alert('Consumer successfully called provider noOp method. Hooray!')
    this

  initDropbox: ->
    @dropbox = (new DropboxHelper)
      .initialize()
      .initPopup(@LOGIN_SELECTOR)
    setTimeout((=> @updateUI()), 10)
    this

  getChannel: ->
    local: '/name.html'
    swf: '/swf/easyxdm.swf'

  # Called by auth.html popup
  popupCallback: (error, client) ->
    debugger
    @dropbox.client.setCredentials(client.credentials())
    @updateUI()

  updateUI: ->
    txt = if @dropbox.isAuthenticated() then 'logout-text' else 'login-text'
    $(@LOGIN_SELECTOR).each ->
      $(@).text($(@).data(txt))
