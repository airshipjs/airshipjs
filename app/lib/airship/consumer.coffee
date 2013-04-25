# Airship.js Consumer
#
# This is the consumer API that should be included in the actual app.
# It sets up the provider iframe and exposes the API to the consumer app.

module.exports = class Consumer
  # base URL for provider.html
  REMOTE_URL: 'http://localhost:3003/'
  # iframe container element ID
  CONTAINER_DOM_ID: 'airship-container'

  initialize: ->
    console.log('Initialized Consumer')
    @initRPC()
    Object.freeze? this
    this

  initRPC: ->
    @remote = new easyXDM.Rpc @getChannel(),
      remote:
        addNumbers: {}
        multiplyNumbers: {}
        noOp: {}
      local:
        alertMessage: (msg) ->
          alert(msg)
    this

  getChannel: ->
    local: '/name.html'
    swf: @REMOTE_URL + '/swf/easyxdm.swf'
    remote: @REMOTE_URL + '/provider.html'
    remoteHelper: @REMOTE_URL + '/name.html'
    container: @CONTAINER_DOM_ID
    props:
      style:
        border: '2px dotted red'
        height: '200px'
        width: '100%'
    onReady: =>
      # call method on the other side
      # todo: remote this after testing
      @remote.noOp()
