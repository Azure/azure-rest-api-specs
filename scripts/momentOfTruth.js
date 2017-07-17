// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const exec = require('child_process').exec,
    execSync = require('child_process').execSync,
    path = require('path'),
    util = require('util'),
    utils = require('../test/util/utils'),
    fs = require('fs'),
    request = require('request');

// let blobService = azure.createBlobService();
let configsToProcess = utils.getConfigFilesChangedInPR();
let targetBranch = utils.getTargetBranch();
let sourceBranch = utils.getSourceBranch();
let pullRequestNumber = utils.getPullRequestNumber();
let linterCmd = `autorest --validation --azure-validator --message-format=json `;
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
}

//appends the content to the log file
function writeContent(content) {
    fs.writeFileSync(logFilepath, content);
}

// Executes linter on given swagger path and returns structured JSON of linter output
async function getLinterResult(swaggerPath) {
    if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
        throw new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.');
    }

    let jsonResult = [];
    if (!fs.existsSync(swaggerPath)) {
        return [];
    }
    let cmd = linterCmd + swaggerPath;
    console.log(`Executing: ${cmd}`);
    const {err, stdout, stderr } = await new Promise(res => exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 },
        (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })));

    let resultString = stderr;
    if (resultString.indexOf('{') !== -1) {
        resultString = "[" + resultString.substring(resultString.indexOf('{')).trim().replace(/\}\n\{/g, "},\n{") + "]";
        //console.log('>>>>>> Trimmed Result...');
        //console.log(resultString);
        try {
            jsonResult = JSON.parse(resultString);
            //console.log('>>>>>> Parsed Result...');
            //console.dir(resultObject, {depth: null, colors: true});
            return jsonResult;
        } catch (e) {
            console.log(`An error occurred while executing JSON.parse() on the linter output for ${swaggerPath}:`);
            console.dir(resultString);
            console.dir(e, { depth: null, colors: true });
        }
    }
    return [];
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
async function runTools(swagger, beforeOrAfter) {
    console.log(`Processing "${swagger}":`);
    const linterErrors = await getLinterResult(swagger);
    console.log(linterErrors);
    updateResult(swagger, linterErrors, beforeOrAfter);
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
}

//main function
function runScript() {
    // Useful when debugging a test for a particular swagger. 
    // Just update the regex. That will return an array of filtered items.
    // configsToProcess = ['/Users/vishrut/git-repos/azure-rest-api-specs/specification/storage/resource-manager/readme.md',
    //                    '/Users/vishrut/git-repos/azure-rest-api-specs/specification/web/resource-manager/readme.md'];
    configsToProcess = configsToProcess.filter(function (configFile) {
        return configFile.indexOf('.md') != -1;
    });
    console.log(configsToProcess);
    createLogFile();
    console.log(`The results will be logged here: "${logFilepath}".`)

    for (const configFile of configsToProcess) {
        await runTools(configFile, 'after');
    }
    execSync(`${gitCheckoutCmd}`, { encoding: 'utf8' });
    execSync(`${gitLogCmd}`, { encoding: 'utf8' });
    for (const configFile of configsToProcess) {
        await runTools(configFile, 'before');
    }
    writeContent(JSON.stringify(finalResult, null, 2));
    return uploadToAzureStorage(finalResult);
}

// magic starts here
runScript();
