// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var
  execSync = require('child_process').execSync,
  utils = require('./util/utils'),
  fs = require('fs'),
  path = require('path');

function getTagsFromConfig(config){
  // get hold of all tags and their corresponding input files using the literate config tool
  const result = execSync(`node node_modules/@microsoft.azure/literate/dist/app.js all --file=${path.resolve(config)}`);
  // can't get JS to parse a string with "'" 
  const tagsMap = JSON.parse(result.toString().replace(/'/g,'"'));
  const tags = Object.keys(tagsMap);
  
  // filter the tags
  if(utils.prOnly)
  {
    // get path to the modified files relative to their corresponding md file, need to do this since 
    // config files have relative paths to the input files
    let allModifiedFiles = utils.getFilesChangedInPR();
    allModifiedFiles = allModifiedFiles.map(mfile=>{
      return path.relative(config, mfile);
    });
    
    // for each tag->files, find if there are any modified files and select those tags
    return tags.filter(tag=>{
      const tagFiles = (tagsMap[tag]+'').split(',');
      // find intersection with the modified files
      return tagFiles.filter(tagFile=>{
        return allModifiedFiles.indexOf(path.normalize(tagFile))>-1;
      }).length>0;
    });
  } 
  return tags;
}

function execLinterCommand(config, tag)
{
    it(config + ' should honor linter validation rules.', async function () {
      var cmd = `autorest --validation --azure-validator ${config} --message-format=json ${tag}`.trim();
      console.log(`Executing: ${cmd}`);
      try {
        let result = execSync(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
      } catch (err) {
        throw new Error('Linter validation contains error(s)');
      }
    });
}

describe('AutoRest Linter validation:', function () {
  let configsToProcess = utils.getConfigFilesChangedInPR();
  // Useful when debugging a test for a particular swagger. 
  // Just update the regex. That will return an array of filtered items.
  // configsToProcess = ['specification/sql/resource-manager/readme.md'];
  for (const config of configsToProcess) {
    // find all tags in the config file
    const tagsToProcess = getTagsFromConfig(config);
    // if no tags found to process, run with the defaults    
    if(tagsToProcess===undefined || tagsToProcess.length===0)
    {
      execLinterCommand(config, '');
    } 
    else
    {
      // if tags found, run linter against every single tag
      tagsToProcess.forEach((tagToProcess) => {
        execLinterCommand(config, `--tag=${tagToProcess}`);
      }, this);
    }
  }
});
