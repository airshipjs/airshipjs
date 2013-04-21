exports.config =
  # See http://brunch.io/#documentation for documentation.

  plugins:
    stylus:
      linenos: yes
      firebug: yes

  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
        'test/javascripts/test.js': /^test[\\/](?!vendor)/
        'test/javascripts/test-vendor.js': /^test[\\/](?=vendor)/
      order:
        before: [
          'vendor/scripts/console-polyfill.js',
        ]
        after: [
          'test/vendor/scripts/test-helper.js'
        ]

    stylesheets:
      joinTo:
        #'stylesheets/app.css': /^(app|vendor)/
        'stylesheets/app.css': /^vendor/
        'test/stylesheets/test.css': /^test/
      order:
        after: ['vendor/styles/helpers.css']
