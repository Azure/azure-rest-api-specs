// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var exec = require('child_process').exec,
  path = require('path'),
  fs = require('fs'),
  glob = require('glob'),
  oav = require('oav');

exports = module.exports;
exports.globPath = path.join(__dirname, '../', '/**/swagger/*.json');
exports.swaggers = glob.sync(exports.globPath);

var swaggersToProcess = exports.swaggers;
var finalResult = {};
var filename = `log_${getTimeStamp()}.log`;
var logFilepath = path.join(getLogDir(), filename);

function getTimeStamp() {
  // We pad each value so that sorted directory listings show the files in chronological order
  function pad(number) {
    return number < 10 ? '0' + number : number;
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
}

//appends the content to the log file
function writeContent(content) {
  fs.writeFileSync(logFilepath, content);
}

//runs the linter on a given swagger spec.
async function runLinter(swagger) {
  let cmd = 'autorest --azure-validator=true --input-file=' + swagger + ' --message-format=json';
  console.log(`\t- Running Linter.`);
  const {err, stdout, strerr } = await new Promise(res => exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 },
    (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })));
  let resultObject = [];
  if (err) {
    console.log(`An error occurred while running the linter on ${swagger}:`);
    console.dir(err, { depth: null, colors: true });
  } else {
    //console.log('>>>> Actual result...');
    //console.log(resultString);
    let resultString = stdout + stderr;
    if (resultString.indexOf('{') !== -1) {
      resultString = "[" + resultString.substring(resultString.indexOf('{')).trim().replace(/\}\n\{/g, "},\n{") + "]";
      //console.log('>>>>>> Trimmed Result...');
      //console.log(resultString);
      try {
        resultObject = JSON.parse(resultString);
        //console.log('>>>>>> Parsed Result...');
        //console.dir(resultObject, {depth: null, colors: true});
      } catch (e) {
        console.log(`An error occurred while executing JSON.parse() on the linter output for ${swagger}:`);
        console.dir(resultString);
        console.dir(e, { depth: null, colors: true });
      }
    }
  }
  return resultObject;
}

//runs the semantic validator on a given swagger spec.
function runSemanticValidator(swagger) {
  console.log('\t- Running Semantic Validator.')
  return oav.validateSpec(swagger, {consoleLogLevel: 'off'}).then(function (validationResult) {
    //console.dir(validationResult, { depth: null, colors: true });
    return validationResult.validateSpec.errors;
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
  console.log(`The results will be logged here: "${logFilepath}".`);
  for (const swagger of swaggersToProcess) {
    await runTools(swagger);
  }
  //console.dir(finalResult, { depth: null, colors: true });
  return finalResult;
}

//runs the validation and linting tools on all the swaggers in the repo.
async function runTools(swagger) {
  console.log(`Processing "${swagger}":`);
  const validationErrors = await runSemanticValidator(swagger);
  updateResult(swagger, validationErrors, true);
  const linterErrors = runLinter(swagger);
  updateResult(swagger, linterErrors, true);
}

//magic starts here
runScript();