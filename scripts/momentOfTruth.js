// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const exec = require('child_process').exec,
    execSync = require('child_process').execSync,
    path = require('path'),
    util = require('util'),
    utils = require('../test/util/utils'),
    _ = require('underscore'),
    fs = require('fs'),
    request = require('request');

// let blobService = azure.createBlobService();
let swaggersToProcess = utils.getFilesChangedInPR();
let targetBranch = utils.getTargetBranch();
let sourceBranch = utils.getSourceBranch();
let pullRequestNumber = utils.getPullRequestNumber();
let linterCmd = `autorest --message-format=json --azure-validator=true --input-file=`;
let gitCheckoutCmd = `git checkout ${targetBranch}`;
let gitLogCmd = `git log -3`;
var filename = `${pullRequestNumber}_${utils.getTimeStamp()}.json`;
var logFilepath = path.join(getLogDir(), filename);
var finalResult = {};
finalResult["pullRequest"] = pullRequestNumber;
finalResult["repositoryUrl"] = getRepository();
finalResult["files"] = {};

// Retrieves Git Repository Url
function getRepository() {
    return "https://github.com/" + utils.getRepoName();
}

// Creates and returns path to the logging directory
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

// Executes linter on given swagger path and returns structured JSON of linter output
function getLinterResult(swaggerPath) {
    if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
        throw new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.');
    }

    return new Promise((result) => {
        let jsonResult = [];
        if (!fs.existsSync(swaggerPath)) {
            result([]);
            return;
        }
        let cmd = linterCmd + swaggerPath;
        console.log(`Executing: ${cmd}`);
        exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 }, (err, stdout, stderr) => {
            let resultString = stderr;
            if (resultString.indexOf('{') !== -1) {
                resultString = "[" + resultString.substring(resultString.indexOf('{')).trim().replace(/\}\n\{/g, "},\n{") + "]";
                //console.log('>>>>>> Trimmed Result...');
                //console.log(resultString);
                try {
                    jsonResult = JSON.parse(resultString);
                    //console.log('>>>>>> Parsed Result...');
                    //console.dir(resultObject, {depth: null, colors: true});
                    result(jsonResult);
                } catch (e) {
                    console.log(`An error occurred while executing JSON.parse() on the linter output for ${swaggerPath}:`);
                    console.dir(resultString);
                    console.dir(e, { depth: null, colors: true });
                    result([]);
                }
            }
        });
    });
};

// Uploads the result file to Azure Blob Storage
function uploadToAzureStorage(json) {
    console.log(logFilepath);
    request({
        url: "http://az-bot.azurewebsites.net/process",
        method: "POST",
        json: true,
        body: json
    }, function (error, response, body) {
        console.log(body);
    });
}

// Run linter tool
function runTools(swagger, beforeOrAfter) {
    console.log(`Processing "${swagger}":`);
    return getLinterResult(swagger).then(function (linterErrors) {
        console.log(linterErrors);
        updateResult(swagger, linterErrors, beforeOrAfter);
        return;
    });
};

// Updates final result json to be written to the output file
function updateResult(spec, errors, beforeOrAfter) {
    if (!finalResult['files'][spec]) {
        finalResult['files'][spec] = {};
    }
    if (!finalResult['files'][spec][beforeOrAfter]) {
        finalResult['files'][spec][beforeOrAfter] = {};
    }
    finalResult['files'][spec][beforeOrAfter] = errors;
    return;
}

//main function
function runScript() {
    // Useful when debugging a test for a particular swagger. 
    // Just update the regex. That will return an array of filtered items.
    // swaggersToProcess = ['/Users/vishrut/git-repos/rest-repo-reorg/azure-rest-api-specs/arm-storage/2016-12-01/swagger/storage.json',
    //                     '/Users/vishrut/git-repos/rest-repo-reorg/azure-rest-api-specs/arm-web/2016-09-01/swagger/AppServicePlans.json'];
    swaggersToProcess = swaggersToProcess.filter(function (swaggerFile) {
        return swaggerFile.indexOf('.json') != -1;
    });
    console.log(swaggersToProcess);
    createLogFile();
    console.log(`The results will be logged here: "${logFilepath}".`)

    let afterPRPromiseFactories = _(swaggersToProcess).map(function (swagger) {
        return function () { return runTools(swagger, 'after'); };
    });

    let beforePromiseFactories = _(swaggersToProcess).map(function (swagger) {
        return function () { return runTools(swagger, 'before'); };
    });

    executePromisesSequentially(afterPRPromiseFactories).then(() => {
        execSync(`${gitCheckoutCmd}`, { encoding: 'utf8' });
        execSync(`${gitLogCmd}`, { encoding: 'utf8' });
        executePromisesSequentially(beforePromiseFactories).then(() => {
            writeContent(JSON.stringify(finalResult, null, 2));
            return uploadToAzureStorage(finalResult);
        })
    });
}

// magic starts here
runScript();
