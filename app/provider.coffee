# Airship.js provider class
#
# This class is the main Airship.js RPC API. It runs in an iframe embedded in the
# consumer app and allows the app to store and retrieve data managed by Airship.js.

module.exports = class Provider
  initialize: ->
    console.log('initialized')
    @initRPC()
    # Prevent changes to app instance
    Object.freeze? this

  initRPC: ->
    channel =
      local: '/name.html'
      swf: '/easyxdm.swf'
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
