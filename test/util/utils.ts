// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import * as stringMap from '@ts-common/string-map'
import * as fs from 'fs-extra'
import * as glob from 'glob'
import * as path from 'path'
const z = require('z-schema')
import * as YAML from 'js-yaml'
import request = require('request')
import * as util from 'util'
import { execSync } from 'child_process'

const asyncJsonRequest = (url: string) => new Promise<unknown>((res, rej) => request(
  { url, json: true },
  (error: unknown, _: unknown, body: unknown) => error ? rej(error) : res(body)
));

const extensionSwaggerSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json";
const swaggerSchemaUrl = "http://json.schemastore.org/swagger-2.0";
const swaggerSchemaAltUrl = "http://swagger.io/v2/schema.json";
const exampleSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/example-schema.json";
const compositeSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/composite-swagger.json";

export const prOnly = undefined !== process.env['PR_ONLY'] ? process.env['PR_ONLY'] : 'false';

const globPath = path.join(__dirname, '../', '../', '/specification/**/*.json');
export const swaggers = glob.sync(globPath, { ignore: ['**/examples/**/*.json', '**/quickstart-templates/*.json', '**/schema/*.json'] });
const exampleGlobPath = path.join(__dirname, '../', '../', '/specification/**/examples/**/*.json');
export const examples = glob.sync(exampleGlobPath);

// Remove byte order marker. This catches EF BB BF (the UTF-8 BOM)
// because the buffer-to-string conversion in `fs.readFile()`
// translates it to FEFF, the UTF-16 BOM.
const stripBOM = function(content: Buffer|string) {
  if (Buffer.isBuffer(content)) {
    content = content.toString();
  }
  if (content.charCodeAt(0) === 0xFEFF || content.charCodeAt(0) === 0xFFFE) {
    content = content.slice(1);
  }
  return content;
};

/**
 * Parses the json from the given filepath
 * @returns {string} clr command
 */
export const parseJsonFromFile = async function(filepath: string) {
  const data = await fs.readFile(filepath, { encoding: 'utf8' });
  try {
    return YAML.safeLoad(stripBOM(data));
  } catch (error) {
    throw new Error(`swagger "${filepath}" is an invalid JSON.\n${util.inspect(error, { depth: null })}`);
  }
};

/**
 * Gets the name of the target branch to which the PR is sent. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_BRANCH. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
 * If the environment variable is undefined then the method returns 'master' as the default value.
 * @returns {string} branchName The target branch name.
 */
export const getTargetBranch = function() {
  console.log(`@@@@@ process.env['TRAVIS_BRANCH'] - ${process.env['TRAVIS_BRANCH']}`);
  let result = process.env['TRAVIS_BRANCH'] || 'master';
  result = result.trim();
  console.log(`>>>>> The target branch is: "${result}".`);
  return result;
};

/**
 * Gets the PR number. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_PULL_REQUEST. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} PR number or 'undefined'.
 */
export const getPullRequestNumber = function() {
  let result = process.env['TRAVIS_PULL_REQUEST'];
  console.log(`@@@@@ process.env['TRAVIS_PULL_REQUEST'] - ${process.env['TRAVIS_PULL_REQUEST']}`);

  if (!result) {
    result = 'undefined';
  }

  return result;
};

/**
 * Retrieves list of swagger files to be processed for linting
 * @returns {Array} list of files to be processed for linting
 */
export const getConfigFilesChangedInPR = function() {
  if (prOnly === 'true') {
    let targetBranch, cmd, filesChanged;
    try {
      targetBranch = getTargetBranch();
      execSync(`git fetch origin ${targetBranch}`);
      cmd = `git diff --name-only HEAD $(git merge-base HEAD FETCH_HEAD)`;
      filesChanged = execSync(cmd, { encoding: 'utf8' }).split('\n');
      console.log('>>>>> Files changed in this PR are as follows:');
      console.log(filesChanged);

      // traverse up to readme.md files
      const configFiles = new Set();
      for (let fileChanged of filesChanged) {
        while (fileChanged.startsWith("specification")) {
          if (fileChanged.toLowerCase().endsWith("readme.md") && fs.existsSync(fileChanged)) {
            configFiles.add(fileChanged);
            break;
          }
          // select parent readme
          const parts = fileChanged.split('/');
          parts.pop();
          parts.pop();
          parts.push("readme.md");
          fileChanged = parts.join('/');
        }
      }
      filesChanged = [...configFiles.values()];

      console.log('>>>>> Affected configuration files:');
      console.log(filesChanged);

      return filesChanged;
    } catch (err) {
      throw err;
    }
  } else {
    return swaggers;
  }
};

/**
 * Retrieves list of swagger files to be processed for linting
 * @returns {Array} list of files to be processed for linting
 */
export const getFilesChangedInPR = function() {
  let result = swaggers;
  if (prOnly === 'true') {
    let targetBranch, cmd, filesChanged, swaggerFilesInPR;
    try {
      targetBranch = getTargetBranch();
      execSync(`git fetch origin ${targetBranch}`);
      cmd = `git diff --name-only HEAD $(git merge-base HEAD FETCH_HEAD)`;
      filesChanged = execSync(cmd, { encoding: 'utf8' });
      console.log('>>>>> Files changed in this PR are as follows:')
      console.log(filesChanged);
      swaggerFilesInPR = filesChanged.split('\n').filter(function (item: string) {
        if (item.match(/.*(json|yaml)$/ig) == null || item.match(/.*specification.*/ig) == null) {
          return false;
        }
        if (item.match(/.*\/examples\/*/ig) !== null) {
          return false;
        }
        if (item.match(/.*\/quickstart-templates\/*/ig) !== null) {
          return false;
        }
        return true;
      });
      console.log(`>>>> Number of swaggers found in this PR: ${swaggerFilesInPR.length}`);

      var deletedFiles = swaggerFilesInPR.filter(function (swaggerFile: string) {
        return !fs.existsSync(swaggerFile);
      });
      console.log('>>>>> Files deleted in this PR are as follows:')
      console.log(deletedFiles);
      // Remove files that have been deleted in the PR
      swaggerFilesInPR = swaggerFilesInPR.filter(function (x: string) { return deletedFiles.indexOf(x) < 0 });

      result = swaggerFilesInPR;
    } catch (err) {
      throw err;
    }
  }
  return result;
};

/**
 * Downloads the remote schemas and initializes the validator with remote references.
 * @returns {Object} context Provides the schemas in json format and the validator.
 */
export const initializeValidator = async function() {
  const context: stringMap.MutableStringMap<unknown> = {
    extensionSwaggerSchema: await asyncJsonRequest(extensionSwaggerSchemaUrl),
    swaggerSchema: await asyncJsonRequest(swaggerSchemaAltUrl),
    exampleSchema: await asyncJsonRequest(exampleSchemaUrl),
    compositeSchema: await asyncJsonRequest(compositeSchemaUrl)
  };
  let validator = new z({ breakOnFirstError: false });
  validator.setRemoteReference(swaggerSchemaUrl, context.swaggerSchema);
  validator.setRemoteReference(exampleSchemaUrl, context.exampleSchema);
  validator.setRemoteReference(compositeSchemaUrl, context.compositeSchema);
  context.validator = validator;
  return context;
};
