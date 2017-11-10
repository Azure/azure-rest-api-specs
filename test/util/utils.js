// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var assert = require("assert"),
  fs = require('fs'),
  glob = require('glob'),
  path = require('path'),
  _ = require('lodash'),
  z = require('z-schema'),
  YAML = require('js-yaml'),
  request = require('request'),
  util = require('util'),
  execSync = require('child_process').execSync;

exports = module.exports;

exports.extensionSwaggerSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json";
exports.swaggerSchemaUrl = "http://json.schemastore.org/swagger-2.0";
exports.swaggerSchemaAltUrl = "http://swagger.io/v2/schema.json";
exports.schemaUrl = "http://json-schema.org/draft-04/schema";
exports.exampleSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/example-schema.json";
exports.compositeSchemaUrl = "https://raw.githubusercontent.com/Azure/autorest/master/schema/composite-swagger.json";

exports.isWindows = (process.platform.lastIndexOf('win') === 0);
exports.prOnly = undefined !== process.env['PR_ONLY'] ? process.env['PR_ONLY'] : 'false';

exports.globPath = path.join(__dirname, '../', '../', '/**/swagger/*.json');
exports.swaggers = _(glob.sync(exports.globPath));
exports.compositeGlobPath = path.join(__dirname, '../', '../', '/**/composite*.json');
exports.compositeSwaggers = _(glob.sync(exports.compositeGlobPath));
exports.exampleGlobPath = path.join(__dirname, '../', '../', '/**/examples/*.json');
exports.examples = _(glob.sync(exports.exampleGlobPath));

// Remove byte order marker. This catches EF BB BF (the UTF-8 BOM)
// because the buffer-to-string conversion in `fs.readFile()`
// translates it to FEFF, the UTF-16 BOM.
exports.stripBOM = function stripBOM(content) {
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
exports.parseJsonFromFile = function parseJsonFromFile(filepath, callback) {
  fs.readFile(filepath, 'utf8', function (err, data) {
    if (err) return callback(err);
    try {
      return callback(null, YAML.safeLoad(exports.stripBOM(data)));
    } catch (error) {
      let e = new Error(`swagger "${filepath}" is an invalid JSON.\n${util.inspect(error, { depth: null })}`);
      return callback(e);
    }
  });
};

/**
 * Gets the name of the target branch to which the PR is sent. We are using the environment 
 * variable provided by travis-ci. It is called TRAVIS_BRANCH. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Default-Environment-Variables
 * If the environment variable is undefined then the method returns 'master' as the default value.
 * @returns {string} branchName The target branch name.
 */
exports.getTargetBranch = function getTargetBranch() {
  console.log(`@@@@@ process.env['TRAVIS_BRANCH'] - ${process.env['TRAVIS_BRANCH']}`);
  let result = process.env['TRAVIS_BRANCH'] || 'master';
  result = result.trim();
  console.log(`>>>>> The target branch is: "${result}".`);
  return result;
};

/**
 * Gets the name of the source branch from which the PR is sent.
 * @returns {string} branchName The source branch name.
 */
exports.getSourceBranch = function getSourceBranch() {
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
  result = result.trim();
  console.log(`>>>>> The source branch is: "${result}".`);
  return result;
};

/**
 * Gets the PR number. We are using the environment 
 * variable provided by travis-ci. It is called TRAVIS_PULL_REQUEST. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} PR number or 'undefined'.
 */
exports.getPullRequestNumber = function getPullRequestNumber() {
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
 * @returns {string} PR number or 'undefined'.
 */
exports.getRepoName = function getRepoName() {
  let result = process.env['TRAVIS_REPO_SLUG'];
  console.log(`@@@@@ process.env['TRAVIS_REPO_SLUG'] - ${process.env['TRAVIS_REPO_SLUG']}`);

  return result;
};

exports.getTimeStamp = function getTimeStamp() {
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

/**
 * Retrieves list of swagger files to be processed for linting
 * @returns {Array} list of files to be processed for linting
 */
exports.getFilesChangedInPR = function getFilesChangedInPR() {
  let result = exports.swaggers;
  if (exports.prOnly === 'true') {
    let targetBranch, cmd, filesChanged, swaggerFilesInPR;
    try {
      targetBranch = exports.getTargetBranch();
      cmd = `git diff --name-only HEAD $(git merge-base HEAD ${targetBranch})`;
      filesChanged = execSync(cmd, { encoding: 'utf8' });
      console.log('>>>>> Files changed in this PR are as follows:')
      console.log(filesChanged);
      swaggerFilesInPR = filesChanged.split('\n').filter(function (item) {
        return (item.match(/.*\/swagger\/*/ig) !== null);
      });
      console.log(`>>>> Number of swaggers found in this PR: ${swaggerFilesInPR.length}`);
      
      var deletedFiles = swaggerFilesInPR.filter(function(swaggerFile){
        return !fs.existsSync(swaggerFile);
      });
      console.log('>>>>> Files deleted in this PR are as follows:')
      console.log(deletedFiles);
      // Remove files that have been deleted in the PR
      swaggerFilesInPR = swaggerFilesInPR.filter(function(x) { return deletedFiles.indexOf(x) < 0 });

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
exports.initializeValidator = function initializeValidator(callback) {
  request({ url: exports.extensionSwaggerSchemaUrl, json: true }, function (error, response, extensionSwaggerSchemaBody) {
    if (error) {
      return callback(error);
    }
    request({ url: exports.swaggerSchemaAltUrl, json: true }, function (error, response, swaggerSchemaBody) {
      if (error) {
        return callback(error);
      }
      request({ url: exports.exampleSchemaUrl, json: true }, function (error, response, exampleSchemaBody) {
        if (error) {
          return callback(error);
        }
        request({ url: exports.compositeSchemaUrl, json: true }, function (error, response, compositeSchemaBody) {
          if (error) {
            return callback(error);
          }
          let context = {
            extensionSwaggerSchema: extensionSwaggerSchemaBody,
            swaggerSchema: swaggerSchemaBody,
            exampleSchema: exampleSchemaBody,
            compositeSchema: compositeSchemaBody
          };
          let validator = new z({ breakOnFirstError: false });
          validator.setRemoteReference(exports.swaggerSchemaUrl, context.swaggerSchema);
          validator.setRemoteReference(exports.exampleSchemaUrl, context.exampleSchema);
          validator.setRemoteReference(exports.compositeSchemaUrl, context.compositeSchema);
          context.validator = validator;
          return callback(null, context);
        });
      });
    });
  });
};