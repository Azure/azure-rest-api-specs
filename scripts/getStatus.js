// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var exec = require('child_process').exec,
  path = require('path'),
  fs = require('fs'),
  glob = require('glob'),
  oav = require('oav'),
  utils = require("../test/util/utils");

var swaggersToProcess = utils.swaggers;
var readmesToProcess = utils.readmes;
var finalResult = {};
var filename = `log_${utils.getTimeStamp()}.log`;
var logFilepath = path.join(getLogDir(), filename);

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

//runs the command on a given swagger spec.
async function runCmd(cmd) {
  console.log(cmd);
  const {err, stdout, stderr } = await new Promise(res => exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 },
    (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })));
  let resultObject = [];
  let resultString = stdout + stderr;
  //console.log('>>>> Actual result...');
  //console.log(resultString);
  if (resultString.indexOf('{') !== -1) {
    resultString = "[" + resultString.substring(resultString.indexOf('{')).trim().replace(/\}\n\{/g, "},\n{") + "]";
    //console.log('>>>>>> Trimmed Result...');
    //console.log(resultString);
    try {
      resultObject = JSON.parse(resultString);
      //console.log('>>>>>> Parsed Result...');
      //console.dir(resultObject, {depth: null, colors: true});
    } catch (e) {
      console.log(`An error occurred while executing JSON.parse() on the output for ${cmd}:`);
      console.dir(resultString);
      console.dir(e, { depth: null, colors: true });
    }
  }
  return resultObject;
}

//runs the semantic validator on a given swagger spec.
function runSemanticValidator(swagger) {
  return oav.validateSpec(swagger, {consoleLogLevel: 'off'}).then(function (validationResult) {
    //console.dir(validationResult, { depth: null, colors: true });
    return validationResult.validateSpec.errors;
  }).catch(function (err) {
    console.dir(err, { depth: null, colors: true });
  });
}

//main function
async function runScript() {
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
   // swaggersToProcess = swaggersToProcess.filter(function (item) {
   //   return (item.match(/.*Microsoft.network/ig) !== null);
   // });
   // readmesToProcess = readmesToProcess.filter(function (item) {
   //   return (item.match(/.*.network/ig) !== null);
   // });
  createLogFile();
  console.log(`The results will be logged here: "${logFilepath}".`);

  console.log('\t- Running Semantic Validator.')
  for (let swagger of swaggersToProcess) {
      const validationErrors = await runSemanticValidator(swagger);
	  swagger = swagger.split(/\/Microsoft\./gi)[0] + "/readme.md";
	  console.log(`File Name: "${swagger}"`);
	  if (validationErrors != null)
	  {
		updateResult(swagger, validationErrors, true);
	  }
  }

  console.log(`\t- Running Linter.`);
  for (let readme of readmesToProcess) {
      console.log(`Linter Validation on configuration file: "${readme}"`);
      let linterCmd = 'autorest ' + readme + ' --azure-validator=true --validation --message-format=json';
      const linterErrors = await runCmd(linterCmd);
      updateResult(readme, linterErrors, true);
  }

  console.log(`\t- Running Model Validator.`);
    //model validator run
  for (let readme of readmesToProcess) {
      console.log(`Model Validation on configuration file: "${readme}"`);
      let modelValCmd = 'autorest --version=2.0.4174 --model-validator --message-format=json ' + readme;
      const modelValErrors = await runCmd(modelValCmd);
      updateResult(readme, modelValErrors, true);
  }
  
  //console.dir(finalResult, { depth: null, colors: true });
  return finalResult;
}

//magic starts here
runScript();
