// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var glob = require('glob'),
  path = require('path'),
  _ = require('lodash');

var globPath, swaggers;
var execSync = require('child_process').execSync;
var isWindows = (process.platform.lastIndexOf('win') === 0);
var prOnly = undefined != process.env['PR_ONLY'] ? process.env['PR_ONLY'] : false;
globPath = path.join(__dirname, '../', '/**/swagger/*.json');
swaggers = _(glob.sync(globPath));

/**
 * Converts command to OS specific command by prepending `mono` for non-windows prOnlySwaggers
 * @returns {string} clr command
 */
function clrCmd(cmd) {
  return isWindows ? cmd : ('mono ' + cmd);
};

/**
 * Retrieves list of swagger files to be processed for linting
 * @returns {Array} list of files to be processed for linting
 */
function getFilesForLinter() {
  if (prOnly) {
    // TODO: Currently works for PR into master branch only
    var cmd = 'git diff --name-only HEAD $(git merge-base HEAD master)';
    let result;
    try {
      result = execSync(cmd, { encoding: 'utf8' });
      console.log(result);
      var swaggerFileInPR = result.split('\n').filter(function (item) {
        return (item.match(/.*\/swagger\/*/ig) !== null);
      });
      console.log(`>>>> Number of swaggers found in this PR: ${swaggerFileInPR.length}`);
      return swaggerFileInPR;
    } catch (err) {
      throw err;
    }
  } else {
    // Return all the swagger files for linter processing
    return swaggers;
  }
}

describe('AutoRest Linter validation:', function () {
  var autoRestLocation = './AutoRest.*/tools/AutoRest.exe';
  let swaggersToProcess = getFilesForLinter();
  _(swaggersToProcess).each(function (swagger) {
    it(swagger + ' should follow linter rules.', function (done) {
      var cmd = clrCmd(autoRestLocation + ' -CodeGenerator None -I ' + swagger);
      console.log(cmd);
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
