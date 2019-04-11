import * as avocado from '@azure/avocado'
// import * as process from 'process'
import * as path from 'path'
import * as os from 'os'
import * as fsExtra from 'fs-extra'
import * as childProcess from 'child_process'
import * as util from 'util'
import * as stringMap from '@ts-common/string-map'
import * as oad from '@azure/oad'

const exec = util.promisify(childProcess.exec)

const getFilesChangedInPR = async (pr: avocado.PullRequestProperties) => {
  const filesChanged = await pr.diff()
  console.log('>>>>> Files changed in this PR are as follows:')
  console.log(filesChanged);
  const swaggerFilesInPR = filesChanged.filter(({ path }) => {
    if (path.match(/.*(json|yaml)$/ig) == null || path.match(/.*specification.*/ig) == null) {
      return false
    }
    if (path.match(/.*\/examples\/*/ig) !== null) {
      return false
    }
    if (path.match(/.*\/quickstart-templates\/*/ig) !== null) {
      return false
    }
    return true
  })
  console.log(`>>>> Number of swaggers found in this PR: ${swaggerFilesInPR.length}`)
  const deletedFiles = swaggerFilesInPR.filter(v => v.kind === "Deleted")
  console.log('>>>>> Files deleted in this PR are as follows:')
  console.log(deletedFiles)
  return swaggerFilesInPR.filter(v => v.kind !== "Deleted")
}

const iconFor = (type: string) => {
  switch (type) {
    case 'Error': return ':x:'
    case 'Warning': return ':warning:'
    case 'Info': return ':speech_balloon:'
    default: return ''
  }
}

const blobHref = (file: string) =>
  `https://github.com/${process.env.TRAVIS_PULL_REQUEST_SLUG}/blob/${process.env.TRAVIS_PULL_REQUEST_SHA}/${file}`

const tableLine = (filePath: string, diff: oad.Message) =>
  `|${iconFor(diff['type'])}|[${diff['type']} ${diff['id']} - ${diff['code']}](https://github.com/Azure/openapi-diff/blob/master/docs/rules/${diff['id']}.md)|[${shortName(filePath)}](${blobHref(filePath)} "${filePath}")|${diff['message']}|\n`

const shortName = (filePath: string) =>
  `${path.basename(path.dirname(filePath))}/&#8203;<strong>${path.basename(filePath)}</strong>`

/**
 * Compares old and new specifications for breaking change detection.
 *
 * @param oldSpec Path to the old swagger specification file.
 *
 * @param newSpec Path to the new swagger specification file.
 */
const runOad = async (oldSpec: string, newSpec: string): Promise<oad.Messages> => {
  if (oldSpec === null || oldSpec === undefined || typeof oldSpec.valueOf() !== 'string' || !oldSpec.trim().length) {
    throw new Error('oldSpec is a required parameter of type "string" and it cannot be an empty string.');
  }

  if (newSpec === null || newSpec === undefined || typeof newSpec.valueOf() !== 'string' || !newSpec.trim().length) {
    throw new Error('newSpec is a required parameter of type "string" and it cannot be an empty string.');
  }

  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);
  console.log(`Old Spec: "${oldSpec}"`)
  console.log(`New Spec: "${newSpec}"`)
  console.log(`>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>`);

  let result = await oad.compare(oldSpec, newSpec, { consoleLogLevel: 'warn' })
  console.log(result)

  if (!result) {
    return []
  }

  return JSON.parse(result)
}

const headerText = `
| | Rule | Location | Message |
|-|------|----------|---------|
`;

/**
 * main function
 */
const runScript = async () => {
  const outputFolder = path.join(os.tmpdir(), "resolved");

  // This map is used to store the mapping between files resolved and stored location
  const resolvedMapForNewSpecs: stringMap.MutableStringMap<string> = {};

  const processViaAutoRest = async (swaggerPath: string) => {
    if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
      throw new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.');
    }

    const swaggerOutputFolder = path.join(outputFolder, path.dirname(swaggerPath));
    const swaggerOutputFileNameWithoutExt = path.basename(swaggerPath, '.json');
    const autoRestCmd = `autorest --input-file=${swaggerPath} --output-artifact=swagger-document.json --output-file=${swaggerOutputFileNameWithoutExt} --output-folder=${swaggerOutputFolder}`;

    console.log(`Executing : ${autoRestCmd}`);

    try {
      await fsExtra.ensureDir(swaggerOutputFolder);
      await exec(`${autoRestCmd}`, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 });
      resolvedMapForNewSpecs[swaggerPath] = path.join(swaggerOutputFolder, swaggerOutputFileNameWithoutExt + '.json');
    } catch (err) {
      console.log(`Error processing via AutoRest: ${err}`);
    }
  }

  // config.cwd is used as a source repository
  const config = avocado.defaultConfig()
  // pr.workingDir is used as a target repository
  const pr = await avocado.createPullRequestProperties(config)
  if (pr === undefined) {
    return
  }

  const swaggersToProcess = await getFilesChangedInPR(pr);

  console.log('Processing swaggers:');
  console.log(swaggersToProcess);

  console.log('Finding new swaggers...')
  const newSwaggers = swaggersToProcess.filter(v => v.kind === "Added")

  console.log('Processing via AutoRest...');
  pr.checkout(pr.targetBranch)
  for (const swagger of swaggersToProcess) {
    if (!newSwaggers.includes(swagger)) {
      await processViaAutoRest(path.join(pr.workingDir, swagger.path));
    }
  }

  console.log(`Resolved map for the new specifications:`);
  console.dir(resolvedMapForNewSpecs);

  let errors = 0, warnings = 0;
  const diffFiles: stringMap.MutableStringMap<oad.Messages> = {};
  const newFiles = [];
  for (const swagger of swaggersToProcess) {
    // If file is new then we ignore it as it's new file
    if (swagger.kind === "Added") {
      console.log(`File: "${swagger.path}" looks to be newly added in this PR.`);
      newFiles.push(swagger.path);
      continue;
    }
    const resolved = resolvedMapForNewSpecs[swagger.path]
    if (resolved) {
      const diffs = await runOad(swagger.path, resolved);
      if (diffs) {
        diffFiles[swagger.path] = diffs;
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

  let summary = '';
  if (errors > 0) {
    summary += '**There are potential breaking changes in this PR. Please review before moving forward. Thanks!**\n\n';
  }
  summary += `Compared to the target branch (**${pr.targetBranch}**), this pull request introduces:\n\n`;
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

  const diffFileEntries = Array.from(stringMap.entries(diffFiles))
  if (diffFileEntries.length > 0) {
    message += '### OpenAPI diff results\n';
    message += headerText;

    diffFileEntries.sort();
    for (const [swagger, diff] of diffFileEntries) {
      const diffs = diff as oad.Message[]
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

// magic starts here
runScript().then(() => {
  console.log('Thanks for using breaking change tool to review.')
  console.log('If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues .')
}).catch(err => {
  console.log(err)
  process.exitCode = 1
})