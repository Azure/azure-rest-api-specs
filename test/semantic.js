// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  assert = require('assert'),
  utils = require('./util/utils'),
  oav = require('openapi-validation-tools');

describe('Azure swagger semantic validation:', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.arm-containerregistry.*2017-03-01.*/ig) !== null);
  // });

  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should be semantically valid.', function (done) {
      oav.validateSpec(swagger, 'error').then(function (validationResult) {
        //console.dir(validationResult, {depth: null, colors: true});
        done(assert(validationResult.validateSpec && validationResult.validateSpec.errors && validationResult.validateSpec.errors.length === 0, 
        `swagger "${swagger}" contains semantic validation errors.`));
      }).catch(function (err) {
        console.dir(err, {depth: null, colors: true});
        done(err);
      });
    });
  }).value();
});