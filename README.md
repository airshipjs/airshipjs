The goal of airship.js is to provide a standard API for storing, retrieving, and syncing
data for unhosted apps. A key design principle is to allow unhosted apps served from any
domain to request access to IndexedDB data stored under the airship.io domain. This
allows apps to share the same locally cached data like contacts, global preferences, etc.
to improve overall user experience.

The airship.js file is served from http://airship.io in an iframe.

easyXDM.js is used to communicate with airship.js.

This project is experimental.


#  Notes

Conceptually, airship.js serves as a local cache and proxy for browser based apps
to access the user's personal data.

In the current example, the airship.js iframe is used to trigger a Dropbox
authentication request. While this works, there's a UX security issue in that the
Dropbox popup does not provide a way for the user to verify that it was the airship.js
iframe that triggered the request vs any random script that calls itself "Airship".

This security issue can be solved by using a personal cloud instead of Dropbox
that addresses this UX issue by visually verifying to the suer that the request
can from a verified app.


# Running

Run two servers, one for the consumer (app site) and one for the provider (airship).

Install [brunch](http://brunch.io) and python >=2.4

```bash
npm -g install brunch
```

Start servers

```bash
brunch watch --server
cd public
python -m SimpleHTTPServer 3003
```

Open http://localhost:3333





## License
The MIT license.

Copyright (c) 2013 Joe Johnston (http://simple10.com/).

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
