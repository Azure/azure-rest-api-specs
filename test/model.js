// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  assert = require('assert'),
  utils = require('./util/utils'),
  oav = require('openapi-validation-tools');

describe('Azure swagger model validation using x-ms-examples and examples in spec', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should have valid examples.', function (done) {
      oav.validateExamples(swagger, null, false, 'error').then(function (validationResult) {
        done(assert(validationResult.validityStatus === true, `swagger "${swagger}" contains model validation errors.`));
      }).catch(function (err) {
        console.log(err);
        done(err);
      });
    });
  }).value();
});