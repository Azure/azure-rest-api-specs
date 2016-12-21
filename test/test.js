// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var assert = require("assert"),
  fs = require('fs'),
  glob = require('glob'),
  path = require('path'),
  _ = require('lodash'),
  z = require('z-schema'),
  request = require('request'),
  async = require('async'),
  RefParser = require('json-schema-ref-parser'),
  util = require('util');

var extensionSwaggerSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json";
var swaggerSchemaUrl = "http://json.schemastore.org/swagger-2.0";
var swaggerSchemaAltUrl = "http://swagger.io/v2/schema.json";
var schemaUrl = "http://json-schema.org/draft-04/schema";
var exampleSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/example-schema.json";
var compositeSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/composite-swagger.json";

var swaggerSchema, extensionSwaggerSchema, schema4, exampleSchema, compositeSchema,
    globPath, compositeGlobPath, swaggers, compositeSwaggers, validator;

globPath = path.join(__dirname, '../', '/**/swagger/*.json');
swaggers = _(glob.sync(globPath));

// Useful when debugging a test for a particular swagger. 
// Just update the regex. That will return an array of filtered items.
// swaggers = swaggers.filter(function(item) {
//   return (item.match(/.*arm-redis.*/ig) !== null);
// })

compositeGlobPath = path.join(__dirname, '../', '/**/composite*.json');
compositeSwaggers = _(glob.sync(compositeGlobPath));

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

describe('Azure Swagger Schema Validation', function () {
  before(function (done) {
    request({ url: extensionSwaggerSchemaUrl, json: true }, function (error, response, extensionSwaggerSchemaBody) {
      request({ url: swaggerSchemaAltUrl, json: true }, function (error, response, swaggerSchemaBody) {
        request({ url: exampleSchemaUrl, json: true }, function (error, response, exampleSchemaBody) {
          request({ url: compositeSchemaUrl, json: true }, function (error, response, compositeSchemaBody) {
            extensionSwaggerSchema = extensionSwaggerSchemaBody;
            swaggerSchema = swaggerSchemaBody;
            exampleSchema = exampleSchemaBody;
            compositeSchema = compositeSchemaBody;
            validator = new z({ breakOnFirstError: false });
            validator.setRemoteReference(swaggerSchemaUrl, swaggerSchema);
            validator.setRemoteReference(exampleSchemaUrl, exampleSchema);
            validator.setRemoteReference(compositeSchemaUrl, compositeSchema);
            done();
          });
        });
      });
    });
  });

  _(swaggers).each(function (swagger) {
    it(swagger + ' should be a valid Swagger document.', function (done) {
      fs.readFile(swagger, 'utf8', function (err, data) {
        if (err) { done(err); }
        var parsedData;
        try {
          parsedData = JSON.parse(stripBOM(data));
        } catch (err) {
          throw new Error("swagger " + swagger + " is an invalid JSON. " + util.inspect(err, { depth: null }));
        }

        if (parsedData.documents && util.isArray(parsedData.documents)) {
          console.log(util.format('Skipping the test for \'%s\' document as it seems to be a composite swagger doc.', swagger));
          done();
        }
        var valid = validator.validate(parsedData, extensionSwaggerSchema);
        if (!valid) {
          var error = validator.getLastErrors();
          throw new Error("Schema validation failed: " + util.inspect(error, { depth: null }));
        }
        assert(valid === true);
        done();
      });
    });
  }).value();

  _(compositeSwaggers).each(function (compositeSwagger) {
    it('composite: ' + compositeSwagger + ' should be a valid Composite Swagger document.', function (done) {
      fs.readFile(compositeSwagger, 'utf8', function (err, data) {
        if (err) { done(err); }
        var parsedData;
        try {
          parsedData = JSON.parse(stripBOM(data));
        } catch (err) {
          throw new Error("compositeSwagger " + compositeSwagger + " is an invalid JSON. " + util.inspect(err, { depth: null }));
        }
        var valid = validator.validate(parsedData, compositeSchema);
        if (!valid) {
          var error = validator.getLastErrors();
          throw new Error("Schema validation for Composite Swagger failed: " + util.inspect(error, { depth: null }));
        }
        assert(valid === true);
        var compositeSwaggerDir = path.dirname(compositeSwagger);
        var messages = [];
        if (parsedData.documents && parsedData.documents.length > 0) {
          async.eachSeries(parsedData.documents, function (docUrl, loopCallback) {
            //construct the absolue path if the item in the documents array is a relative path
            if (!path.isAbsolute(docUrl) && !docUrl.startsWith('http')) {
              docUrl = path.join(compositeSwaggerDir, docUrl);
            }
            //make a request if it is a url
            if (docUrl.startsWith('http')) {
              request({ url: docUrl, json: true }, function (error, response, responseBody) {
                if (error) {
                  messages.push('An error occurred while accessing the swagger doc ' +
                    docUrl + ' from the documents list. The error is ' + util.inspect(error, { depth: null }));
                }
                if (response.statusCode !== 200) {
                  messages.push('\'' + response.statusCode + '\': \'File Not Found\'- error occurred while accessing the swagger doc ' +
                    docUrl + ' from the documents list.');
                }
                loopCallback();
              });
            } else {
              //check whether the file exists
              if (!fs.existsSync(docUrl)) {
                messages.push('\'File Not Found\': error occurred while accessing the swagger doc ' +
                  docUrl + ' from the documents list on the host filesystem.');
              }
              loopCallback();
            }
          }, function (err) {
            if (err) {
              throw err;
            }
            if (messages.length > 0) {
              throw new Error(JSON.stringify(messages));
            }
            done();
          });
        } else {
          done();
        }
      });
    });
  }).value();
});

describe('External file or url references ("$ref") in a swagger spec', function () {
  var swaggersToProcess = swaggers.concat(compositeSwaggers);
  _(swaggersToProcess).each(function(swagger) {
    it(swagger + ' should be completely resolvable.', function(done) {
      RefParser.bundle(swagger, function(bundleErr, bundleResult) {
        if (bundleErr) {
          var msg = swagger + ' has references that cannot be resolved. They are as follows: \n' + util.inspect(bundleErr.message, {depth : null});
          console.log(msg);
          throw new Error (msg);
        }
        done();
      });
    });
  }).value();
});
