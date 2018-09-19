// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

'use strict';

const exec = require('child_process').exec,
    path = require('path'),
    utils = require('../test/util/utils'),
    fs = require('fs');

let configsToProcess = utils.getConfigFilesChangedInPR();
let pullRequestNumber = utils.getPullRequestNumber();
let linterCmd = `npx autorest@2.0.4152 --validation --azure-validator --message-format=json `;
var filename = `${pullRequestNumber}.json`;
var logFilepath = path.join(getLogDir(), filename);
var finalResult = {};
finalResult["pullRequest"] = pullRequestNumber;
finalResult["repositoryUrl"] = utils.getRepoUrl();
finalResult["files"] = {};

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
    let cmd = "npx autorest --reset && " + linterCmd + swaggerPath;
    console.log(`Executing: ${cmd}`);
    const { err, stdout, stderr } = await new Promise(res => exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 },
        (err, stdout, stderr) => res({ err: err, stdout: stdout, stderr: stderr })));

    if (err && stderr.indexOf("Process() cancelled due to exception") !== -1) {
        console.log(`AutoRest exited with code ${err.code}`);
        console.log(stderr);
        throw new Error("AutoRest failed");
    }

    let resultString = stdout + stderr;
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

// Run linter tool
async function runTools(swagger, beforeOrAfter) {
    console.log(`Processing "${swagger}":`);
    const linterErrors = await getLinterResult(swagger);
    console.log(`Linter produced ${linterErrors.length} results`);
    await updateResult(swagger, linterErrors, beforeOrAfter);
};

// Updates final result json to be written to the output file
async function updateResult(spec, errors, beforeOrAfter) {
    if (!finalResult['files'][spec]) {
        finalResult['files'][spec] = {};
    }
    if (!finalResult['files'][spec][beforeOrAfter]) {
        finalResult['files'][spec][beforeOrAfter] = {};
    }
    finalResult['files'][spec][beforeOrAfter] = errors;
}

//main function
async function runScript() {
    console.log('Processing configs:');
    console.log(configsToProcess);
    createLogFile();
    console.log(`The results will be logged here: "${logFilepath}".`)

    if (configsToProcess.length > 0) {
        for (const configFile of configsToProcess) {
            await runTools(configFile, 'after');
        }

        await utils.doOnBranch(utils.getTargetBranch(), async () => {
            for (const configFile of configsToProcess) {
                await runTools(configFile, 'before');
            }
        });
    }

    writeContent(JSON.stringify(finalResult, null, 2));
}

// magic starts here
runScript().then(_ => {
    process.exit(0);
}).catch(_ => {
    process.exit(1);
})
