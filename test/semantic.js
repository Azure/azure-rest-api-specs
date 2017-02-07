// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  assert = require('assert'),
  utils = require('./util/utils'),
  oav = require('openapi-validation-tools');

describe('Azure swagger semantic validation:', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should be semantically valid.', function (done) {
      oav.validateSpec(swagger, false, 'error').then(function (validationResult) {
        done(assert(validationResult.errors && validationResult.errors.length === 0, `swagger "${swagger}" contains semantic validation errors.`));
      }).catch(function (err) {
        console.log(err);
        done(err);
      });
    });
  }).value();
});