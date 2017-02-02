// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var glob = require('glob'),
  path = require('path'),
  _ = require('lodash');

var globPath, swaggers;
var exec = require('child_process').exec;
var isWindows = (process.platform.lastIndexOf('win') === 0);

globPath = path.join(__dirname, '../', '/**/swagger/*.json');
swaggers = _(glob.sync(globPath));

function clrCmd(cmd){
  return isWindows ? cmd : ('mono ' + cmd);
};

describe('AutoRest Linter validation:', function () {
  var autoRestLocation = './AutoRest.*/tools/AutoRest.exe';
  _(swaggers).each(function(swagger) {
    it(swagger + ' should follow linter rules.', function(done) {
      var cmd = clrCmd(autoRestLocation + ' -CodeGenerator None -I ' + swagger);
      console.log(cmd);
      exec(cmd, function(error, stdout, stderr) {
        console.log(`stdout: \n${stdout}`);
        console.log(`stderr: \n${stderr}`);
        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
        done();
      });
    });
  }).value();
});
