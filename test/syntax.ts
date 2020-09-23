// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

var assert = require("assert"),
  RefParser = require('json-schema-ref-parser'),
  util = require('util'),
  utils = require('@azure/rest-api-specs-scripts').utils;

type Context = {
  readonly validator: {
    readonly validate: (parsedData: unknown, schema: unknown) => unknown
    readonly getLastErrors: () => unknown
  }
  readonly extensionSwaggerSchema: unknown
  readonly exampleSchema: unknown
}

let syntaxContext: Context


// Useful when debugging a test for a particular swagger.
// Just update the regex. That will return an array of filtered items.
// utils.swaggers = utils.swaggers.filter(function(item) {
//   return (item.match(/.*Microsoft.Logic.*2016-06-01.*/ig) !== null);
// });
// utils.examples = utils.examples.filter(function(item) {
//   return (item.match(/.*Microsoft.Logic.*2016-06-01.*/ig) !== null);
// });


describe('Azure swagger schema validation:', function () {
  before(function (done) {
    utils.initializeValidator().then((result: Context) => {
      syntaxContext = result;
      done();
    });

  });

  for (const swagger of utils.getSwaggers()) {
    it(swagger + ' should be a valid Swagger document.', function (done) {
      utils.parseJsonFromFile(swagger).then((parsedData: unknown)=> {
        var valid = syntaxContext.validator.validate(parsedData, syntaxContext.extensionSwaggerSchema);
      if (!valid) {
        var error = syntaxContext.validator.getLastErrors();
        throw new Error("Schema validation failed: " + util.inspect(error, { depth: null }));
      }
      assert(valid === true);
      done();
      });
    });
  }

  describe('Azure x-ms-example schema validation:', function () {
    for (const example of utils.getExamples()) {
      it('x-ms-examples: ' + example + ' should be a valid x-ms-example.', function (done) {
        utils.parseJsonFromFile(example).then((parsedData: unknown) => {
          var valid = syntaxContext.validator.validate(parsedData, syntaxContext.exampleSchema);
        if (!valid) {
          var error = syntaxContext.validator.getLastErrors();
          throw new Error("Schema validation failed: " + util.inspect(error, { depth: null }));
        }
        assert(valid === true);
        done();
        });
      });
    }
  });
});

describe('External file or url references ("$ref") in a swagger spec:', function () {
  for (const swagger of utils.getSwaggers()) {
    it(swagger + ' should be completely resolvable.', function (done) {
      RefParser.bundle(swagger, function (bundleErr: { readonly message: unknown }, _bundleResult: unknown) {
        if (bundleErr) {
          var msg = swagger + ' has references that cannot be resolved. They are as follows: \n' + util.inspect(bundleErr.message, { depth: null });
          console.log(msg);
          throw new Error(msg);
        }
        done();
      });
    });
  }
});