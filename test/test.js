var assert = require("assert"),
fs = require('fs'),
glob = require('glob'),
path = require('path'),
_ = require('lodash'),
z = require('z-schema'),
request = require("request")

var globPath = path.join(__dirname, '../', '/**/swagger/*.json');
var swaggers = _(glob.sync(globPath));

var schema = JSON.parse(fs.readFileSync(
  path.join(
    __dirname,
    '../node_modules/swagger-validator/schemas/v2.0/schema.json'
  ), 'utf8'));


describe('Azure Swagger Schema Validation', function() {
  before(function(done) {
    request({
        url: "http://json-schema.org/draft-04/schema"
      },
      function (error, response, body) {
        if (!error && response.statusCode === 200) {
          z.setRemoteReference("http://json-schema.org/draft-04/schema", body);
          done();
        } else {
          done(new Error("Request failed"));
        }
      });
  });

  _(swaggers).each(function(swagger){
    it(swagger + ' should be valid Swagger', function(done){
      var validator = new z();
      fs.readFile(swagger, 'utf8', function(err, data){
        if(err) { done(err); }
        validator.validate(JSON.parse(data), schema, function (err, result) {
          if(err) {
            done(new Error(JSON.stringify(err, null, "\t")));
          } else {
            assert.equal(result.valid, true, JSON.stringify(validator.getLastError(), null, "\t"));
            done();
          }
        });
      });
    });
  }).value();
});
