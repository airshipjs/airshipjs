The goal of airship.js is to provide a standard API for storing, retrieving, and syncing
data for unhosted apps. A key design principle is to allow unhosted apps served from any 
domain to request access to IndexedDB data stored under the airship.io domain. This 
allows apps to share the same locally cached data like contacts, global preferences, etc. 
to improve overall user experience.

The airship.js file is served from http://airship.io in an iframe.

easyXDM.js is used to communicate with airship.js.




# Running

Run two servers, one for the consumer (app site) and one for the provider (airship).

With python >=2.4 installed ...

```bash
cd consumer
python -m SimpleHTTPServer 3000
cd ../provider
python -m SimpleHTTPServer 3001
```

