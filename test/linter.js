// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var
  execSync = require('child_process').execSync,
  utils = require('./util/utils');

describe('AutoRest Linter validation:', function () {
  let configsToProcess = utils.getConfigFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // configsToProcess = ['specification/sql/resource-manager/readme.md'];
  for (const config of configsToProcess) {
    it(config + ' should honor linter validation rules.', async function () {
      var cmd = `autorest --validation --azure-validator ${config} --message-format=json`;
      console.log(`Executing: ${cmd}`);

      try {
        let result = execSync(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
      } catch (err) {
        throw new Error('Linter validation contains error(s)');
      }
    });
  }
});
