import { readFileContent, mergeFiles } from './helper.js';
import { logHeader } from './log.js';
import { sortOpenAPIDocument } from '@azure-tools/typespec-autorest';
import fs from 'fs';
import { processDocument } from './document.js';
import yargs from 'yargs';
import { hideBin } from "yargs/helpers";
import { diffString } from 'json-diff';

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
  const { oldPath, newPath, outputFolder } = args;

  logHeader(`Processing old swagger from: ${oldPath}...`);
  const mergedOldfile = mergeFiles(oldPath!);
  const processedOldFile = processDocument(mergedOldfile);
  const sortedOldFile = sortOpenAPIDocument(processedOldFile);

  logHeader(`Processing new swagger from: ${newPath}`);
  const newFile = readFileContent(newPath!);
  const processedNewFile = processDocument(JSON.parse(newFile.toString()));
  const sortedNewFile = sortOpenAPIDocument(processedNewFile);

  logHeader("Comparing old and new Swagger files...");
  const differences = diffString(sortedOldFile, sortedNewFile);
  console.log(differences);

  if (outputFolder) {
    fs.writeFileSync(`${outputFolder}/oldSwagger.json`, JSON.stringify(sortedOldFile, null, 2));
    fs.writeFileSync(`${outputFolder}/newSwagger.json`, JSON.stringify(sortedNewFile, null, 2));
    fs.writeFileSync(`${outputFolder}/diff.json`, JSON.stringify(differences, null, 2));
  }
}
