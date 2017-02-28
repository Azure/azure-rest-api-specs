// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var execSync = require('child_process').execSync,
  path = require('path'),
  fs = require('fs'),
  glob = require('glob'),
  _ = require('underscore'),
  oav = require('openapi-validation-tools');

exports = module.exports;
exports.globPath = path.join(__dirname, '../', '/**/swagger/*.json');
exports.swaggers = _(glob.sync(exports.globPath));

var swaggersToProcess = exports.swaggers;
var finalResult = {};
var filename = `log_${getTimeStamp()}.log`;
var logFilepath = path.join(getLogDir(), filename);

function getTimeStamp() {
  // We pad each value so that sorted directory listings show the files in chronological order
  function pad(number) {
    if (number < 10) {
      return '0' + number;
    }

    return number;
  }

  var now = new Date();
  return now.getFullYear()
    + pad(now.getMonth() + 1)
    + pad(now.getDate())
    + "_"
    + pad(now.getHours())
    + pad(now.getMinutes())
    + pad(now.getSeconds());
}

function updateResult(spec, errors, updateLog) {
  if (!finalResult[spec]) {
    finalResult[spec] = errors;
  } else {
    finalResult[spec] = finalResult[spec].concat(errors);
  }
  if (updateLog) {
    writeContent(JSON.stringify(finalResult, null, 2));
  }
  return;
}

function getLogDir() {
  let logDir = path.join(__dirname, '../', 'output');
  if (!fs.existsSync(logDir)) {
    try {
      fs.mkdirSync(logDir);
    } catch (e) {
      if (e.code !== 'EEXIST') throw e;
    }
  }
  return logDir;
}

//creates the log file if it has not been created
function createLogFile() {
  if (!fs.existsSync(logFilepath)) {
    fs.writeFileSync(logFilepath, '');
  }
  return;
}

//appends the content to the log file
function writeContent(content) {
  fs.writeFileSync(logFilepath, content);
}

//executes promises sequentially by chaining them.
function executePromisesSequentially(promiseFactories) {
  let result = Promise.resolve();
  promiseFactories.forEach(function (promiseFactory) {
    result = result.then(promiseFactory);
  });
  return result;
};

//runs the linter on a given swagger spec.
function runLinter(swagger) {
  let cmd = 'autorest -CodeGenerator None -I ' + swagger + ' -JsonValidationMessages true';
  console.log(`\t- Running Linter.`);
  let resultString = '', resultObj = [];
  try {
    resultString = execSync(cmd, { encoding: 'utf8' });
  } catch (err) {
    if (err.stdout && !err.stderr) {
      resultString = err.stdout;
    } else {
      console.log(`An error occurred while running the linter on ${swagger}:`);
      console.dir(err, { depth: null, colors: true });
    }
  }
  //console.log('>>>> Actual result...');
  //console.log(resultString);
  if (resultString) {
    resultString = resultString.trim().substring(resultString.indexOf('['));
    //console.log('>>>>>> Trimmed Result...');
    //console.log(resultString);
    try {
      resultObj = JSON.parse(resultString);
      //console.log('>>>>>> Parsed Result...');
      //console.dir(resultObj, {depth: null, colors: true});
    } catch (e) {
      console.log(`An error occurred while executing JSON.parse() on the linter output for ${swagger}:`);
      console.dir(e, { depth: null, colors: true });
    }
  }
  return Promise.resolve(resultObj);
}

//runs the semantic validator on a given swagger spec.
function runSemanticValidator(swagger) {
  console.log('\t- Running Semantic Validator.')
  return oav.validateSpec(swagger, 'off').then(function (validationResult) {
    //console.dir(validationResult, { depth: null, colors: true });
    return Promise.resolve(validationResult.validateSpec.errors);
  }).catch(function (err) {
    console.dir(err, { depth: null, colors: true });
  });
}

//main function
function runScript() {
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function (item) {
  //   return (item.match(/.*arm-network/ig) !== null);
  // });
  createLogFile();
  console.log(`The results will be logged here: "${logFilepath}".`)
  let promiseFactories = _(swaggersToProcess).map(function (swagger) {
    return function () { return runTools(swagger); };
  });
  return executePromisesSequentially(promiseFactories);
}

//runs the validation and linting tools on all the swaggers in the repo.
function runTools(swagger) {
  console.log(`Processing "${swagger}":`);
  return runSemanticValidator(swagger).then(function (validationErrors) {
    updateResult(swagger, validationErrors, true);
    return swagger;
  }).then(function (swagger) {
    return runLinter(swagger).then(function (linterErrors) {
      updateResult(swagger, linterErrors, true);
      //console.dir(finalResult, { depth: null, colors: true });
      return finalResult;
    });
  });
}

//magic starts here
runScript();