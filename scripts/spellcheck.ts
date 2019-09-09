import { devOps, cli, childProcess } from '@azure/avocado';
import { ExecOptions } from 'child_process';

const logToAzureDevops = (msg: string, type: string) => {
  const lines = msg.split('\n');
  for (const line of lines) {
    console.log(`##vso[task.logissue type=${type}]${line}`);
  }
}

const logError = (msg: string) => logToAzureDevops(msg, 'error');
const logWarn = (msg: string) => logToAzureDevops(msg, 'warning');

const verboseExec = async (commandLine: string, options: ExecOptions = {}) => {
  console.log(commandLine);
  let result: any = {};
  try {
    result = await childProcess.exec(commandLine, options);
  } catch (e) {
    result = e;
  }

  if (!result.code) {
    return 0;
  }

  if (result.stdout) {
    logError(result.stdout);
  }
  if (result.stderr) {
    console.error(result.stderr);
  }
  return result.code;
}

const main = async () => {
  const config = cli.defaultConfig();
  const pr = await devOps.createPullRequestProperties(config);
  if (pr === undefined) {
    logWarn("Not in CI environment. Run against all the spec json.");
    return verboseExec(`cspell "specification/**/*.json"`);
  }

  const changedJsonFiles = await pr.structuralDiff()
    .filter(filePath => filePath.endsWith('.json') && filePath.startsWith('specification/'))
    .toArray();
  if (changedJsonFiles.length === 0) {
    logWarn("No changed spec json file");
    return 0;
  }

  let retCode = 0;
  for (const jsonFile of changedJsonFiles) {
    const code = await verboseExec(`cspell ${jsonFile}`);
    if (code !== 0) {
      retCode = code;
    }
  }

  return retCode;
}

main().then(retCode => {
  if (retCode !== 0) {
    logError('Please fix the error or add words to ./custom-words.txt');
  }
  process.exit(retCode);
});
