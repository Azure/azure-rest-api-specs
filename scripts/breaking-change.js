// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var utils = require('../test/util/utils'),
  path = require('path'),
  fs = require('fs'),
  os = require('os'),
  exec = require('child_process').exec,
  execSync = require('child_process').execSync,
  oad = require('oad');

// This map is used to store the mapping between files resolved and stored location
var resolvedMapForNewSpecs = {};
let outputFolder = path.join(os.tmpdir(), "resolved");
// Used to enable running script outside TravisCI for debugging
let isRunningInTraviCI = process.env.MODE === 'BreakingChange' && process.env.PR_ONLY === 'true';

/**
 * Compares old and new specifications for breaking change detection.
 *
 * @param {string} oldSpec Path to the old swagger specification file.
 *
 * @param {string} newSpec Path to the new swagger specification file.
 */
function runOad(oldSpec, newSpec) {
  if (oldSpec === null || oldSpec === undefined || typeof oldSpec.valueOf() !== 'string' || !oldSpec.trim().length) {
    return Promise.reject(new Error('oldSpec is a required parameter of type "string" and it cannot be an empty string.'));
  }

  if (newSpec === null || newSpec === undefined || typeof newSpec.valueOf() !== 'string' || !newSpec.trim().length) {
    return Promise.reject(new Error('newSpec is a required parameter of type "string" and it cannot be an empty string.'));
  }

  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);
  console.log(`Old Spec: "${oldSpec}"`);
  console.log(`New Spec: "${newSpec}"`);
  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);

  return oad.compare(oldSpec, newSpec, { consoleLogLevel: 'warn', json: true }).then((result) => {
    console.log(result);
    if (result !== undefined && typeof result.valueOf() === 'string' && result.indexOf(`"type": "Error"`) > -1) {
      console.log(`There are potential breaking changes in this PR. Please review before moving forward. Thanks!`);
      process.exitCode = 1;
    }
    return Promise.resolve();
  }).catch(err => {
    console.log(err);
    process.exitCode = 1;
  });
}

/**
 * Processes the given swagger and stores the resolved swagger on to disk
 *
 * @param {string} swaggerPath Path to the swagger specification file.
 */
function processViaAutoRest(swaggerPath) {
  if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
    return Promise.reject(new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.'));
  }

  console.log(`Processing via AutoRest...`);

  let outputFileNameWithExt = path.basename(swaggerPath);
  let outputFileNameWithoutExt = path.basename(swaggerPath, '.json');
  let autoRestCmd = `autorest --input-file=${swaggerPath} --output-artifact=swagger-document.json --output-file=${outputFileNameWithoutExt} --output-folder=${outputFolder}`;

  console.log(`Executing : ${autoRestCmd}`);

  try {
    let result = execSync(`${autoRestCmd}`, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
    resolvedMapForNewSpecs[outputFileNameWithExt] = path.join(outputFolder, outputFileNameWithExt);
  } catch (err) {
    // Do not update map in case of errors.
  }

  return Promise.resolve();
}

//main function
async function runScript() {
  // See whether script is in Travis CI context
  console.log(`isRunningInTraviCI: ${isRunningInTraviCI}`);

  // Create directory to store the processed & resolved swaggers
  if (!fs.existsSync(outputFolder)) {
    fs.mkdirSync(outputFolder);
  }

  let swaggersToProcess = utils.getFilesChangedInPR();

  // For debugging in your repo, please uncomment following section and update swaggersToProcess array for the desired swaggers
  // if (!isRunningInTraviCI) {
  //   swaggersToProcess = [ '/Users/vishrut/git-repos/azure-rest-api-specs/specification/storage/resource-manager/Microsoft.Storage/2017-06-01/storage.json',
  //                         '/Users/vishrut/git-repos/azure-rest-api-specs/specification/network/resource-manager/Microsoft.Network/2017-06-01/applicationGateway.json' ];
  // }
  console.log(swaggersToProcess);

  for (const swagger of swaggersToProcess) {
    await processViaAutoRest(swagger);
  }

  if (isRunningInTraviCI) {
    utils.checkoutTargetBranch();
  }

  console.log(`Resolved map for the new specification is:`);
  console.dir(resolvedMapForNewSpecs);

  for (const swagger of swaggersToProcess) {
    // If file does not exists in the previous commits then we ignore it as it's new file
    if (!fs.existsSync(swagger)) {
      console.log(`File: "${swagger}" looks to be newly added in this PR.`);
      continue;
    }

    let outputFileNameWithExt = path.basename(swagger);
    console.log(outputFileNameWithExt);
    if (resolvedMapForNewSpecs[outputFileNameWithExt]) {
      await runOad(swagger, resolvedMapForNewSpecs[outputFileNameWithExt]);
    }
  }
}

// magic starts here
runScript().then(success => {
  console.log(`Thanks for using breaking change tool to review.`);
  console.log(`If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues .`);
}).catch(err => {
  console.log(err);
  process.exitCode = 1;
})
