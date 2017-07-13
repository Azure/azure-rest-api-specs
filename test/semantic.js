// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var assert = require('assert'),
  utils = require('./util/utils'),
  oav = require('oav');

describe('Azure swagger semantic validation:', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.*Microsoft.Logic.*2016-06-01.*/ig) !== null);
  // });
  for (const swagger of swaggersToProcess) {
    it(swagger + ' should be semantically valid.', async function () {
      try {
        const validationResult = await oav.validateSpec(swagger, null, {consoleLogLevel: 'error'});
        return assert(
          validationResult.validateSpec && validationResult.validateSpec.errors && validationResult.validateSpec.errors.length === 0, 
          `swagger "${swagger}" contains semantic validation errors.`);
      } catch (err) {
        console.dir(err, {depth: null, colors: true});
        throw err;
      }
    });
  }
});