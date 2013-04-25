module.exports = class DropboxHelper
  KEY: 'JPV0lpf0g5A=|rXZdMsbZbCGpGK8utNJDrTF8bY5OHxRBgSSMzxqOrg=='
  SANDBOX: true

  initialize: ->
    console.log('Initialized Dropbox Lib')
    @initDropbox()
    Object.freeze? this
    this

  initDropbox: ->
    @client = new Dropbox.Client
      key: @KEY
      sandbox: @SANDBOX
    @client.onError.addListener @onDropboxError
    # Use redirect driver with custom popup to get around popup blockers
    # https://github.com/dropbox/dropbox-js/issues/60
    @client.authDriver new Dropbox.Drivers.Redirect
      userQuery: true
      rememberUser: true
    # Check if user is already logged in to Dropbox
    @client.authenticate
      interactive: false
      @authCallback
    this

  initPopup: (selector) ->
    $(selector).popupWindow
      windowURL: '/auth.html'
      windowName: 'Dropbox Authentication'
      width: 980
      height: 700
      centerBrowser: true
    this

  onDropboxError: (error) ->
    console.log(error)

  authCallback: (error, client) =>
    if error
      @onDropboxError(error)
    if @isAuthenticated()
      console.log('Authenticated via Dropbox')

  isAuthenticated: ->
    @client.isAuthenticated()

  authenticate: (callback) ->
    @client.authenticate (error, client) =>
      @authCallback(error, client)
      callback(error, client) if callback
