// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

'use strict';
var
  execSync = require('child_process').execSync,
  utils = require('./util/utils'),
  fs = require('fs'),
  literate = require('@microsoft.azure/literate'),
  async_io_1 = require("@microsoft.azure/async-io"),
  path = require('path');

async function readConfigFile(file, tag) {
  // autorest configuration type
  const msgs = new literate.MessageEmitter();
  msgs.Message.Subscribe((src, each) => console.log(each.Text));
  const cfg = new literate.Configuration("\n> see https://aka.ms/autorest", new literate.DiskFileSystem("readme.md"), async_io_1.ResolveUri(async_io_1.CreateFolderUri(process.cwd()), async_io_1.CreateFileUri(path.resolve(file)) || "."), {
    "input-file": [],
  });
  return await cfg.CreateView(msgs, true, { tag: tag });
}

async function getTagsMapFromConfig(args) {
  if (!fs.existsSync(path.resolve(args.file))) {
    console.error('config file invalid. cannot read tags from file ' + config);
    return null;
  }

  const allTags = scanForTags(fs.readFileSync(args.file));
  const result = {};
  for (const each of allTags) {
    result[each] = (await readConfigFile(args.file, each))["input-file"];
  }
  return result;
}

function scanForTags(content) {
  const result = new Array();
  const rx = /\$\(tag\)(.*)/g;
  let match = rx.exec(content);
  while (match) {
    const vrx = /['"](.*?)['"]/g;
    let v = vrx.exec(match[1]);
    if (v && v.length && result.indexOf(v[1]) == -1) {
      result.push(v[1]);
    }
    match = rx.exec(content);
  }
  return result;
}

async function getTagsFromConfig(config) {
  // get hold of all tags and their corresponding input files using the literate config tool
  const tagsMap = await getTagsMapFromConfig({ file: config });
  if (tagsMap === null) {
    return null;
  }
  const tags = Object.keys(tagsMap);

  // filter the tags
  if (utils.prOnly) {
    // get path to the modified files relative to their corresponding md file, need to do this since 
    // config files have relative paths to the input files
    let allModifiedFiles = utils.getFilesChangedInPR();
    allModifiedFiles = allModifiedFiles.map(mfile => {
      return mfile.replace(path.dirname(config) + '/', '');
    });

    // for each tag->files, find if there are any modified files and select those tags
    return tags.filter(tag => {

      const tagFiles = (String(tagsMap[tag])).split(',');
      // find intersection with the modified files
      return tagFiles.filter(tagFile => {
        return allModifiedFiles.indexOf(tagFile) > -1;
      }).length > 0;
    });
  }
  return tags;
}

function execLinterCommand(args) {
  var cmd = `npx autorest@2.0.4152 --validation --azure-validator --message-format=json ${args}`.trim();
  console.log(`Executing: ${cmd}`);
  try {
    let result = execSync(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
    console.error(result);
  } catch (err) {
    throw new Error('Linter validation contains error(s)');
  }

}

describe('AutoRest Linter validation:', function () {
  if (utils.prOnly) {
    // Useful when debugging a test for a particular swagger. 
    // Just update the regex. That will return an array of filtered items.
    // configsToProcess = ['specification/sql/resource-manager/readme.md'];
    let configsToProcess = utils.getConfigFilesChangedInPR();
    for (const config of configsToProcess) {
      it(config + ' should honor linter validation rules.', async function () {

        // find all tags in the config file
        const tagsToProcess = await getTagsFromConfig(config);
        // if no tags found to process, run with the defaults    
        if (tagsToProcess === null || tagsToProcess.length === 0) {
          // no tags found
          // this means we need to run validator against the individual 
          // json files included in the PR
          // but in the same directory tree as the config file
          const filesChangedInPR = utils.getFilesChangedInPR();
          const configDir = path.dirname(config);
          filesChangedInPR.filter(prFile => {
            // set any type to string
            prFile += '';
            return prFile.startsWith(configDir) && prFile.indexOf('examples') === -1 && prFile.endsWith('.json');
          }).forEach(prFileInConfigFile => {
            console.warn(`WARNING: Configuration file not found for file: ${prFileInConfigFile}, running validation rules against it in individual context.`);
            execLinterCommand(`--input-file=${prFileInConfigFile}`);
          });
        }
        else {
          // if tags found, run linter against every single tag
          tagsToProcess.forEach((tagToProcess) => {
            execLinterCommand(`${config} --tag=${tagToProcess}`);
          }, this);
        }
      });
    }
  }
  else {
    // we are not handling pr_only=false case today, 
    // to enable, we need to write logic to calculate
    // all config files in the repo and run linter with 
    // every tag in the md file; we can get tags each 
    // config file from getTagsFromCinfig file
    console.warn('Cannot run linter in pr_only false mode');
  }
});
