// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var execSync = require('child_process').execSync,
  path = require('path'),
  glob = require('glob'),
  _ = require('underscore'),
  oav = require('openapi-validation-tools');

exports = module.exports;
exports.globPath = path.join(__dirname, '../', '/**/swagger/*.json');
exports.swaggers = _(glob.sync(exports.globPath));

var finalResult = {};
var swaggersToProcess = exports.swaggers;

function updateResult(spec, errors) {
  if (!finalResult[spec]) {
    finalResult[spec] = errors;
  } else {
    finalResult[spec] = finalResult[spec].concat(errors);
  }
}

function runTools() {
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function (item) {
  //   return (item.match(/.*arm-redis.2016-04-01*/ig) !== null);
  // });
  _(swaggersToProcess).each(function (swagger) {
    runSemanticValidator(swagger).then(function (validationErrors) {
      updateResult(swagger, validationErrors);
      return swagger;
    }).then(function (swagger) {
      runLinter(swagger).then(function (linterErrors) {
        updateResult(swagger, linterErrors);
        console.dir(finalResult, { depth: null, colors: true });
      });
    });
  });
}

function runLinter(swagger) {
  let cmd = 'autorest -CodeGenerator None -I ' + swagger + ' -JsonValidationMessages true';
  //console.log(`Executing: ${cmd}`);
  let resultString, resultObj;
  try {
    resultString = execSync(cmd, { encoding: 'utf8' });
    // console.log('>>>>');
    // console.log(resultString);
    if (resultString.trim().startsWith("AutoRest")) {
      resultString = resultString.substring(resultString.indexOf('\n') + 1);
    }
    resultObj = JSON.parse(resultString);
    //console.dir(resultObj, {depth: null, colors: true});
    return Promise.resolve(resultObj);
  } catch (err) {
    console.log(`An error occurred while running the linter on ${swagger}:`);
    console.dir(err, { depth: null, colors: true });
  }
}

function runSemanticValidator(swagger) {
  return oav.validateSpec(swagger, 'off').then(function (validationResult) {
    //console.dir(validationResult, { depth: null, colors: true });
    return Promise.resolve(validationResult.validateSpec.errors);
  }).catch(function (err) {
    console.dir(err, { depth: null, colors: true });
  });
}

runTools();