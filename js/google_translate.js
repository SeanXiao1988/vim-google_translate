(function() {
  "use strict";
  var http, langpair, query, tl;

  http = require("http");

  query = process.argv[2] || '';
  tl = process.argv[3] || 'zh-CN'

  console.log(query);
  console.log(tl);

  return http.get({
    host: 'translate.google.com',
         path: "/translate_a/t?client=t&sl=" + 'auto' + '&tl=' + tl + '&text=' + query + '&ie=UTF-8&oe=UTF-8&multires=1&prev=conf&psl=en&ptl=en&otf=1&it=sel.2016&ssel=0&tsel=0&prev=enter&oc=3&ssel=0&tsel=0&sc=1',
         port: 80,
         headers: {
           'user-agent': 'Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1'
         }
  }, function(res) {
    var body;
    body = [];
    return res.on("data", function(chunk) {
      return body.push(chunk);
    }).on("end", function() {
      return console.log(eval(body.join('')))
    });
  }).on('error', function(e) {
    return console.log("Error " + e);
  });

}).call(this);
