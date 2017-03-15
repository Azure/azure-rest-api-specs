// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  assert = require('assert'),
  utils = require('./util/utils'),
  oav = require('openapi-validation-tools');

describe('Azure swagger model validation using x-ms-examples and examples in spec', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.*arm-logic.*2016-06-01.*/ig) !== null);
  // });
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should have valid examples.', function (done) {
      oav.validateExamples(swagger, null, 'error').then(function (validationResult) {
        //console.dir(validationResult, {depth: null, colors: true});
        done(assert(validationResult.validityStatus === true, `swagger "${swagger}" contains model validation errors.`));
      }).catch(function (err) {
        console.dir(err, {depth: null, colors: true});
        done(err);
      });
    });
  }).value();
});