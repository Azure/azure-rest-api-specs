// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var _ = require('lodash'),
  execSync = require('child_process').execSync,
  utils = require('./util/utils');

describe('AutoRest Linter validation:', function () {
  var autoRestLocation = './AutoRest.*/tools/AutoRest.exe';
  let swaggersToProcess = utils.getFilesChangedInPR();
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should honor linter validation rules.', function (done) {
      var cmd = utils.clrCmd(autoRestLocation + ' -CodeGenerator None -I ' + swagger);
      console.log(`Executing: ${cmd}`);
      let result;
      try {
        result = execSync(cmd, { encoding: 'utf8' });
        console.log(result);
      } catch (err) {
        throw err;
      }
      done();
    });
  }).value();
});
