# Airship.js provider class
#
# This class is the main Airship.js RPC API. It runs in an iframe embedded in the
# consumer app and allows the app to store and retrieve data managed by Airship.js.

module.exports = class Provider
  DROPBOX_KEY: 'JPV0lpf0g5A=|rXZdMsbZbCGpGK8utNJDrTF8bY5OHxRBgSSMzxqOrg=='

  initialize: ->
    console.log('initialized')
    @initRPC()
    @initDropbox()
    @initUI()
    # Prevent changes to app instance
    Object.freeze? this

  initRPC: ->
    channel =
      local: '/name.html'
      swf: '/easyxdm.swf'
      remote: 'dummy' # needed to prevent url error?
    @remote = new easyXDM.Rpc channel,
      remote:
        alertMessage: {}
      local:
        addNumbers: (a, b) ->
          a + b
        multiplyNumbers: (a, b, fn) ->
          window.setTimeout (-> fn(a * b)), 5000
        noOp: ->
          alert("Method not returning any data")

  initDropbox: ->
    @dbclient = new Dropbox.Client
      key: @DROPBOX_KEY
      sandbox: true
    @dbclient.onError.addListener @onDropboxError
    # Use redirect driver with custom popup to get around popup blockers
    # https://github.com/dropbox/dropbox-js/issues/60
    @dbclient.authDriver new Dropbox.Drivers.Redirect
      userQuery: true
      rememberUser: true
    # Check if user is already logged in to Dropbox
    @dbclient.authenticate
      interactive: false
      @authCallback

  initUI: ->
    $('button.login').popupWindow
      centerBrowser: true

  isAuthenticated: ->
    @dbclient.isAuthenticated()

  onDropboxError: (error) ->
    console.log(error)

  authCallback: (error, client) =>
    return onDropboxError(error) if error
    return if @isAuthenticated()

  auth: (evt) =>
    evt.preventDefault()
    #@dbclient.authenticate @authCallback
