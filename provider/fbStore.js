/*jslint devel: true, bitwise: false, undef: false, browser: true, continue: false, debug: false, eqeq: false, es5: false, type: false, evil: false, vars: false, forin: false, white: true, newcap: false, nomen: true, plusplus: false, regexp: true, sloppy: true */
/*globals $, jQuery, FB, TDFriendSelector */

window.fbAsyncInit = function () {

	FB.init({appId: '295452973919932', status: true, cookie: false, xfbml: false, oauth: true});

	$(document).ready(function () {
		
		// IndexedDB
  	var indexedDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB || window.OIndexedDB || window.msIndexedDB,
      IDBTransaction = window.IDBTransaction || window.webkitIDBTransaction || window.OIDBTransaction || window.msIDBTransaction,
      dbVersion = 1.0;

  	// Create/open database
 		var request = indexedDB.open("fbFriends", dbVersion), 
 				db,

      storeFriends = function() {
      	var trans = db.transaction(['friends'], "readwrite");
        var store = trans.objectStore("friends");

    		FB.api('/me/friends?fields=id,name', function(response) {
						if (response.data) {
							
							console.log("Putting fbFriends in IndexedDB");

		      		for (i = 0, len = response.data.length; i < len; i += 1) {
							
								var request = store.put(response.data[i]);
				        request.onsuccess = function(e) {
				          console.log("Put friend: " + response.data[i]);
				        };
				        request.onerror = function(e) {
				          console.error("Error Adding an item: ", e);
				        };

							}

						} else {
							console.log('No friends returned');
							return false;
						}
					});
			}

			request.onerror = function (event) {
			    console.log("Error creating/accessing IndexedDB database");
				};

			request.onsuccess = function (event) {
				db = request.result;

				db.onerror = function (event) {
				    console.log("Error creating/accessing IndexedDB database");
				};

				 // Interim solution for Google Chrome to create an objectStore. Will be deprecated
				if (db.setVersion) {
				    if (db.version != dbVersion) {
				        var setVersion = db.setVersion(dbVersion);
				        setVersion.onsuccess = function () {
				            if(db.objectStoreNames.contains("friends")) {
                      db.deleteObjectStore("friends");
                    }
 
                    var store = db.createObjectStore("friends", {keyPath: "timeStamp"});
                    var trans = req.result;
                    trans.oncomplete = function(e) {
                      console.log("== oncomplete transaction ==");
                    }
				        };
				    }
						else {
                  console.log("not same version");
              }
          }
          else {
              console.log("null db.setVersion");
          }

			};

			//If the version of the db changes, the onupgradeneeded callback is executed.
		  request.onupgradeneeded = function(event) {
		    // event.target.trans is a "changeversion" transaction
		     
		    // create an object store called "friends"        
		    // The keyPath must be what makes an object unique and every object must have it.
		    
		    var datastore = db.createObjectStore("friends", {keyPath: "timeStamp"});
		  }


		$("#btnStore").click(function(e) {

			FB.getLoginStatus(function (response) {

				if (response.authResponse) {
	        storeFriends();
	        console.log("Facebook Logged in");
	      } else {
	        FB.login(function (response) {
	          if (response.authResponse) {
	            console.log("Facebook Logged in");
	            storeFriends();
	          } else {
	            console.log("Facebook login failed.");
	            //TODO: display message
	          }
	        }, {});
	      }
			});
				 	      

		});


	});
};

(function () {
	var e = document.createElement('script');
	e.async = true;
	e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
	document.getElementById('fb-root').appendChild(e);
}());

