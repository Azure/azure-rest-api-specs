// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import * as tsUtils from '../../scripts/ts-utils'
import * as stringMap from '@ts-common/string-map'
import * as os from 'os'
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

export const extensionSwaggerSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json";
export const swaggerSchemaUrl = "http://json.schemastore.org/swagger-2.0";
export const swaggerSchemaAltUrl = "http://23.22.16.221/v2/schema.json";
export const schemaUrl = "http://json-schema.org/draft-04/schema";
export const exampleSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/example-schema.json";
export const compositeSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/composite-swagger.json";

export const isWindows = (process.platform.lastIndexOf('win') === 0);
export const prOnly = undefined !== process.env['PR_ONLY'] ? process.env['PR_ONLY'] : 'false';

export const globPath = path.join(__dirname, '../', '../', '/specification/**/*.json');
export const swaggers = glob.sync(globPath, { ignore: ['**/examples/**/*.json', '**/quickstart-templates/*.json', '**/schema/*.json'] });
export const exampleGlobPath = path.join(__dirname, '../', '../', '/specification/**/examples/**/*.json');
export const examples = glob.sync(exampleGlobPath);
export const readmes = glob.sync(path.join(__dirname, '../', '../', '/specification/**/readme.md'));

// Remove byte order marker. This catches EF BB BF (the UTF-8 BOM)
// because the buffer-to-string conversion in `fs.readFile()`
// translates it to FEFF, the UTF-16 BOM.
export const stripBOM = function(content: Buffer|string) {
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
 * Check out a copy of a branch to a temporary location, execute a function, and then restore the previous state
 */
export const doOnBranch = async function<T>(branch: unknown, func: () => Promise<T>) {
  fetchBranch(branch);
  const branchSha = resolveRef(`origin/${branch}`);
  const tmpDir = path.join(os.tmpdir(), branchSha);

  const currentDir = process.cwd();
  checkoutBranch(branch, tmpDir);

  console.log(`Changing directory and executing the function...`);
  process.chdir(tmpDir);
  const result = await func();

  console.log(`Restoring previous directory and deleting secondary working tree...`);
  process.chdir(currentDir);
  execSync(`rm -rf ${tmpDir}`);

  return result;
}

/**
 * Resolve a ref to its commit hash
 */
export const resolveRef = function(ref: unknown) {
  let cmd = `git rev-parse ${ref}`;
  console.log(`> ${cmd}`);
  return execSync(cmd, { encoding: 'utf8' }).trim();
}

/**
 * Fetch ref for a branch from the origin
 */
export const fetchBranch = function(branch: unknown) {
  let cmds = [
    `git remote -vv`,
    `git branch --all`,
    `git remote set-branches origin --add ${branch}`,
    `git fetch origin ${branch}`
  ];

  console.log(`Fetching branch ${branch} from origin...`);
  for (let cmd of cmds) {
    console.log(`> ${cmd}`);
    execSync(cmd, { encoding: 'utf8', stdio: 'inherit' });
  }
}

/**
 * Checkout a copy of branch to location
 */
export const checkoutBranch = function(ref: unknown, location: unknown) {
  let cmd = `git worktree add -f ${location} origin/${ref}`;
  console.log(`Checking out a copy of branch ${ref} to ${location}...`);
  console.log(`> ${cmd}`);
  execSync(cmd, { encoding: 'utf8', stdio: 'inherit' });
}

/**
 * Gets the name of the source branch from which the PR is sent.
 * @returns {string} branchName The source branch name.
 */
export const getSourceBranch = function() {
  let cmd = 'git rev-parse --abbrev-ref HEAD';
  let result = process.env['TRAVIS_PULL_REQUEST_BRANCH'];
  console.log(`@@@@@ process.env['TRAVIS_PULL_REQUEST_BRANCH'] - ${process.env['TRAVIS_PULL_REQUEST_BRANCH']}`);
  if (!result) {
    try {
      result = execSync(cmd, { encoding: 'utf8' });
    } catch (err) {
      console.log(`An error occurred while getting the current branch ${util.inspect(err, { depth: null })}.`);
    }
  }
  result = tsUtils.asNonUndefined(result).trim();
  console.log(`>>>>> The source branch is: "${result}".`);
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
 * Gets the Repo name. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_REPO_SLUG. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} repo name or 'undefined'.
 */
export const getRepoName = function() {
  let result = process.env['TRAVIS_REPO_SLUG'];
  console.log(`@@@@@ process.env['TRAVIS_REPO_SLUG'] - ${result}`);

  return result;
};

/**
 * Gets the source repo name for PR's. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_PULL_REQUEST_SLUG. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} repo name or 'undefined'.
 */
export const getSourceRepoName = function() {
  let result = process.env['TRAVIS_PULL_REQUEST_SLUG'];
  console.log(`@@@@@ process.env['TRAVIS_PULL_REQUEST_SLUG'] - ${result}`);

  return result;
};

// Retrieves Git Repository Url
/**
 * Gets the repo URL
 * @returns {string} repo URL or 'undefined'
 */
export const getRepoUrl = function() {
  let repoName = getRepoName();
  return `https://github.com/${repoName}`;
};

// Retrieves the source Git Repository Url
/**
 * Gets the repo URL from where the PR originated
 * @returns {string} repo URL or 'undefined'
 */
export const getSourceRepoUrl = function() {
  let repoName = getSourceRepoName();
  return `https://github.com/${repoName}`;
};

export const getTimeStamp = function() {
  // We pad each value so that sorted directory listings show the files in chronological order
  function pad(number: any): any {
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
