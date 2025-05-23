import { readFileContent, mergeFiles } from './helper.js';
import { logHeader, logWarning } from './log.js';
import { sortOpenAPIDocument } from '@azure-tools/typespec-autorest';
import fs from 'fs';
import { processDocument } from './document.js';
import yargs from 'yargs';
import { hideBin } from "yargs/helpers";
import { diff, diffString } from 'json-diff';
import { suggestFix, suggestPrompt } from './fix/troubleshooting.js';
import { configuration } from './configuration.js';

function parseArguments() {
  return yargs(hideBin(process.argv))
    .usage('Usage: $0 [options]')
    .example('$0 --oldPath ./old-spec-folder --newPath ./new-spec-file', 'Compare two swagger specs')
    .example('$0 oldSpecPath newSpecPath', 'Compare using positional arguments')
    .option('oldPath', {
      alias: 'o',
      describe: 'Path to old/original Swagger specification folder',
      type: 'string',
    })
    .option('newPath', {
      alias: 'n',
      describe: 'Path to new/updated Swagger specification file',
      type: 'string',
    })
    .option('outputFolder', {
      alias: 'out',
      describe: 'Output folder for analysis results',
      type: 'string',
    })
    .option('ignoreDescription', {
      description: 'Ignore description differences',
      type: 'boolean',
      default: true,
    })
    .option('ignorePathCase', {
      description: 'Set case insensitive for the segments before provider, e.g. resourceGroups',
      type: 'boolean'
    })
    .check((argv) => {
      const positional = argv._;
      if (!argv.oldPath && positional.length > 0) {
        argv.oldPath = positional[0]!.toString();
      }
      if (!argv.newPath && positional.length > 1) {
        argv.newPath = positional[1]!.toString();
      }
      if (!argv.outputFolder && positional.length > 2) {
        argv.outputFolder = positional[2]!.toString();
      }

      if (!argv.oldPath || !argv.newPath) {
        throw new Error('Both oldPath and newPath are required');
      }
      
      // Verify paths exist
      if (!fs.existsSync(argv.oldPath)) {
        throw new Error(`oldPath does not exist: ${argv.oldPath}`);
      }
      
      if (!fs.existsSync(argv.newPath)) {
        throw new Error(`newPath does not exist: ${argv.newPath}`);
      }
      
      return true;
    })
    .help()
    .alias('help', 'h')
    .parseSync();
}

export async function main() {
  const args = parseArguments();
  const { oldPath, newPath, outputFolder, ignoreDescription, ignorePathCase } = args;
  configuration.ignoreDescription = ignoreDescription;
  if (ignorePathCase !== undefined) {
    configuration.ignorePathCase = ignorePathCase;
  }

  logHeader(`Processing old swagger from: ${oldPath}...`);
  const mergedOldfile = mergeFiles(oldPath!);
  const processedOldFile = processDocument(mergedOldfile);
  const sortedOldFile = sortOpenAPIDocument(processedOldFile);

  logHeader(`Processing new swagger from: ${newPath}`);
  const newFile = readFileContent(newPath!);
  const processedNewFile = processDocument(JSON.parse(newFile.toString()));
  const sortedNewFile = sortOpenAPIDocument(processedNewFile);

  logHeader("Comparing old and new Swagger files...");
  if (outputFolder) {
    fs.writeFileSync(`${outputFolder}/oldNormalizedSwagger.json`, JSON.stringify(sortedOldFile, null, 2));
    fs.writeFileSync(`${outputFolder}/newNormalizedSwagger.json`, JSON.stringify(sortedNewFile, null, 2));
    const diffForFile = diff(sortedOldFile, sortedNewFile);
    fs.writeFileSync(`${outputFolder}/diff.json`, JSON.stringify(diffForFile, null, 2));
    const suggestedFixes = suggestFix(diffForFile);
    if (suggestedFixes.length > 0) {
      logWarning(`Considering these suggested fixes for the diff:`);
      suggestedFixes.forEach(fix => {
        console.log(fix);
      });
    }
    const suggestedPrompt = suggestPrompt(diffForFile);
    if (suggestedPrompt.length > 0) {
      logWarning(`Considering these suggested prompts for the diff:`);
      suggestedPrompt.forEach(prompt => {
        console.log(prompt);
      });
    }
    // fs.writeFileSync(`${outputFolder}/diff.md`, `\`\`\`diff\n${diffForFile}\n\`\`\`\n`);
  }
  else {
    const differences = diffString(sortedOldFile, sortedNewFile);
    console.log(differences);
  }
}
