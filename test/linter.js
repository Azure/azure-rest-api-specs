// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  execSync = require('child_process').execSync,
  utils = require('./util/utils');

describe('AutoRest Linter validation:', function () {
  let swaggersToProcess = utils.getFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.arm-containerregistry.*2017-03-01.*/ig) !== null);
  // });
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should honor linter validation rules.', function (done) {
      var cmd = 'autorest -CodeGenerator None -I ' + swagger + ' -JsonValidationMessages true';
      console.log(`Executing: ${cmd}`);
      let result;
      try {
        result = execSync(cmd, { encoding: 'utf8' });
        console.log(result);
      } catch (err) {
        if (err.stdout && !err.stderr) {
          console.log(err.stdout);
        } else {
          console.log(`An error occurred while running the linter on ${swagger}:`);
          console.dir(err, { depth: null, colors: true });
        }
        throw err;
      }
      done();
    });
  }).value();
});
