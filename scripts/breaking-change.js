// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
const utils = require('../test/util/utils'),
  path = require('path'),
  fs = require('fs-extra'),
  os = require('os'),
  exec = require('util').promisify(require('child_process').exec),
  oad = require('@azure/oad');

// This map is used to store the mapping between files resolved and stored location
var resolvedMapForNewSpecs = {};
let outputFolder = path.join(os.tmpdir(), "resolved");
// Used to enable running script outside TravisCI for debugging
let isRunningInTravisCI = process.env.TRAVIS === 'true';

const headerText = `
| | Rule | Location | Message |
|-|------|----------|---------|
`;

function iconFor(type) {
  if (type === 'Error') {
    return ':x:';
  } else if (type === 'Warning') {
    return ':warning:';
  } else if (type === 'Info') {
    return ':speech_balloon:';
  } else {
    return '';
  }
}

function shortName(filePath) {
  return `${path.basename(path.dirname(filePath))}/&#8203;<strong>${path.basename(filePath)}</strong>`;
}

function tableLine(filePath, diff) {
  return `|${iconFor(diff['type'])}|[${diff['type']} ${diff['id']} - ${diff['code']}](https://github.com/Azure/openapi-diff/blob/master/docs/rules/${diff['id']}.md)|[${shortName(filePath)}](${blobHref(filePath)} "${filePath}")|${diff['message']}|\n`;
}

function blobHref(file) {
  return `https://github.com/${process.env.TRAVIS_PULL_REQUEST_SLUG}/blob/${process.env.TRAVIS_PULL_REQUEST_SHA}/${file}`;
}

/**
 * Compares old and new specifications for breaking change detection.
 *
 * @param {string} oldSpec Path to the old swagger specification file.
 *
 * @param {string} newSpec Path to the new swagger specification file.
 */
async function runOad(oldSpec, newSpec) {
  if (oldSpec === null || oldSpec === undefined || typeof oldSpec.valueOf() !== 'string' || !oldSpec.trim().length) {
    throw new Error('oldSpec is a required parameter of type "string" and it cannot be an empty string.');
  }

  if (newSpec === null || newSpec === undefined || typeof newSpec.valueOf() !== 'string' || !newSpec.trim().length) {
    throw new Error('newSpec is a required parameter of type "string" and it cannot be an empty string.');
  }

  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);
  console.log(`Old Spec: "${oldSpec}"`);
  console.log(`New Spec: "${newSpec}"`);
  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);

  let result = await oad.compare(oldSpec, newSpec, { consoleLogLevel: 'warn', json: true });
  console.log(result);

  if (!result) {
    return;
  }

  // fix up output from OAD, it does not output valid JSON
  result = '[' + result.replace(/}\s+{/gi,"},{") + ']'

  return JSON.parse(result);
}

/**
 * Processes the given swagger and stores the resolved swagger on to disk
 *
 * @param {string} swaggerPath Path to the swagger specification file.
 */
async function processViaAutoRest(swaggerPath) {
  if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
    throw new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.');
  }

  const swaggerOutputFolder = path.join(outputFolder, path.dirname(swaggerPath));
  const swaggerOutputFileNameWithoutExt = path.basename(swaggerPath, '.json');
  const autoRestCmd = `autorest --input-file=${swaggerPath} --output-artifact=swagger-document.json --output-file=${swaggerOutputFileNameWithoutExt} --output-folder=${swaggerOutputFolder}`;

  console.log(`Executing : ${autoRestCmd}`);

  try {
    await fs.ensureDir(swaggerOutputFolder);
    await exec(`${autoRestCmd}`, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
    resolvedMapForNewSpecs[swaggerPath] = path.join(swaggerOutputFolder, swaggerOutputFileNameWithoutExt + '.json');
  } catch (err) {
    console.log(`Error processing via AutoRest: ${err}`);
  }
}

//main function
async function runScript() {
  // See whether script is in Travis CI context
  console.log(`isRunningInTravisCI: ${isRunningInTravisCI}`);

  let targetBranch = utils.getTargetBranch();
  let swaggersToProcess = utils.getFilesChangedInPR();

  console.log('Processing swaggers:');
  console.log(swaggersToProcess);

  console.log('Finding new swaggers...')
  let newSwaggers = [];
  if (isRunningInTravisCI && swaggersToProcess.length > 0) {
    newSwaggers = await utils.doOnBranch(utils.getTargetBranch(), async () => {
      return swaggersToProcess.filter(s => !fs.existsSync(s))
    });
  }

  console.log('Processing via AutoRest...');
  for (const swagger of swaggersToProcess) {
    if (!newSwaggers.includes(swagger)) {
      await processViaAutoRest(swagger);
    }
  }

  console.log(`Resolved map for the new specifications:`);
  console.dir(resolvedMapForNewSpecs);

  let errors = 0, warnings = 0;
  const diffFiles = {};
  const newFiles = [];

  for (const swagger of swaggersToProcess) {
    // If file does not exists in the previous commits then we ignore it as it's new file
    if (newSwaggers.includes(swagger)) {
      console.log(`File: "${swagger}" looks to be newly added in this PR.`);
      newFiles.push(swagger);
      continue;
    }

    if (resolvedMapForNewSpecs[swagger]) {
      const diffs = await runOad(swagger, resolvedMapForNewSpecs[swagger]);
      if (diffs) {
        diffFiles[swagger] = diffs;
        for (const diff of diffs) {
          if (diff['type'] === 'Error') {
            if (errors === 0) {
              console.log(`There are potential breaking changes in this PR. Please review before moving forward. Thanks!`);
              process.exitCode = 1;
            }
            errors += 1;
          } else if (diff['type'] === 'Warning') {
            warnings += 1;
          }
        }
      }
    }
  }

  if (isRunningInTravisCI) {
    let summary = '';
    if (errors > 0) {
      summary += '**There are potential breaking changes in this PR. Please review before moving forward. Thanks!**\n\n';
    }
    summary += `Compared to the target branch (**${targetBranch}**), this pull request introduces:\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${errors > 0 ? iconFor('Error') : ':white_check_mark:'}&nbsp;&nbsp;&nbsp;**${errors}** new error${errors !== 1 ? 's' : ''}\n\n`;
    summary += `&nbsp;&nbsp;&nbsp;${warnings > 0 ? iconFor('Warning') : ':white_check_mark:'}&nbsp;&nbsp;&nbsp;**${warnings}** new warning${warnings !== 1 ? 's' : ''}\n\n`;

    let message = '';
    if (newFiles.length > 0) {
      message += '### The following files look to be newly added in this PR:\n';
      newFiles.sort();
      for (const swagger of newFiles) {
        message += `* [${swagger}](${blobHref(swagger)})\n`;
      }
      message += '<br><br>\n';
    }

    const diffFileNames = Object.keys(diffFiles);
    if (diffFileNames.length > 0) {
      message += '### OpenAPI diff results\n';
      message += headerText;

      diffFileNames.sort();
      for (const swagger of diffFileNames) {
        const diffs = diffFiles[swagger];
        diffs.sort((a, b) => {
          if (a.type === b.type) {
            return a.id.localeCompare(b.id);
          } else if (a.type === "Error") {
            return 1;
          } else if (b.type === "Error") {
            return -1;
          } else if (a.type === "Warning") {
            return 1;
          } else {
            return -1;
          }
        });

        for (const diff of diffs) {
          message += tableLine(swagger, diff);
        }
      }
    } else {
      message += '**There were no files containing new errors or warnings.**\n';
    }

    message += '\n<br><br>\nThanks for using breaking change tool to review.\nIf you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues.';

    const output = {
      title: `${errors === 0 ? 'No' : errors} potential breaking change${errors !== 1 ? 's' : ''}`,
      summary,
      text: message
    };

    console.log('---output');
    console.log(JSON.stringify(output));
    console.log('---');
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
