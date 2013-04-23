$(function () {
  var client = new Dropbox.Client({
      key: "JPV0lpf0g5A=|rXZdMsbZbCGpGK8utNJDrTF8bY5OHxRBgSSMzxqOrg==", sandbox: true
  });
  var writeSome = function () {
    client.writeFile("foo.txt", "foo bar baz", function(error, stat) {
      if (error) {
        alert(error);
        return;
      }
      alert("Written");
    });
  };
  client.authDriver(new Dropbox.Drivers.Redirect());
  // Try to use cached credentials.
  client.authenticate({interactive: false}, function(error, client) {
    if (error) {
      alert(error);
      return;
    }
    if (client.isAuthenticated()) {
      // Cached credentials are available, make Dropbox API calls.
      alert("Success");
      writeSome();
    } else {
      // show and set up the "Sign into Dropbox" button
      var button = document.querySelector("#signin-button");
      button.setAttribute("class", "visible");
      button.addEventListener("click", function() {
        // The user will have to click an 'Authorize' button.
        client.authenticate(function(error, client) {
          if (error) {
            alert(error);
            return;
          }
          alert("Success");
          writeSome();
        });
      });
    }
  });
});