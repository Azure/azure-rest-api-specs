var assert = require("assert"),
fs = require('fs'),
glob = require('glob'),
path = require('path'),
_ = require('lodash'),
z = require('z-schema'),
request = require('request'),
util = require('util');

var extensionSwaggerSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json";
var swaggerSchemaUrl = "http://json.schemastore.org/swagger-2.0";
var swaggerSchemaAltUrl = "http://swagger.io/v2/schema.json";
var schemaUrl = "http://json-schema.org/draft-04/schema";
var swaggerSchema; 
var extensionSwaggerSchema;
var schema4;

var globPath = path.join(__dirname, '../', '/**/swagger/*.json');
var swaggers = _(glob.sync(globPath));

// Remove byte order marker. This catches EF BB BF (the UTF-8 BOM)
// because the buffer-to-string conversion in `fs.readFile()`
// translates it to FEFF, the UTF-16 BOM.
function stripBOM(content) {
  if (Buffer.isBuffer(content)) {
    content = content.toString();
  }
  if (content.charCodeAt(0) === 0xFEFF || content.charCodeAt(0) === 0xFFFE) {
    content = content.slice(1);
  }
  return content;
}

describe('Azure Swagger Schema Validation', function() {
  before(function(done) {
    request({url: extensionSwaggerSchemaUrl, json:true}, function (error, response, extensionSwaggerSchemaBody) {        
      request({url: swaggerSchemaAltUrl, json:true}, function (error, response, swaggerSchemaBody) {
        request({url: schemaUrl, json:true}, function (error, response, schemaBody) {
          extensionSwaggerSchema = extensionSwaggerSchemaBody;
          swaggerSchema = swaggerSchemaBody;
          schema4 = schemaBody;
          done();
        });
      });
    });
  });

  _(swaggers).each(function(swagger){
    it(swagger + ' should be valid Swagger', function(done){
      fs.readFile(swagger, 'utf8', function(err, data){
        if(err) { done(err); }
        
        var parsedData = JSON.parse(stripBOM(data));
        if (parsedData.documents && util.isArray(parsedData.documents)) {
          console.log(util.format('Skipping the test for \'%s\' document as it seems to be a composite swagger doc.', swagger));
          done();
        }
        var validator = new z();
        validator.setRemoteReference(schemaUrl, schema4);
        validator.setRemoteReference(swaggerSchemaUrl, swaggerSchema);
        var valid = validator.validate(JSON.parse(stripBOM(data)), extensionSwaggerSchema);
        if (!valid) {
            var error = validator.getLastErrors();
            throw new Error("Schema validation failed: " + JSON.stringify(error, null, "\t"));
        }
        assert(valid == true);
        done();
      });
    });
  }).value();
});
