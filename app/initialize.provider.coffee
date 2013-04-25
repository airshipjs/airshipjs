Provider = require 'lib/airship/provider'

# Initialize on DOM ready event
$ ->
  window.provider = (new Provider).initialize()
