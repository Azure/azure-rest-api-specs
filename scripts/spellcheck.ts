import { devOps, cli, childProcess } from '@azure/avocado';
import { ExecOptions } from 'child_process';

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
   console.error(result.stdout);
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
    console.warn("Not in CI environment. Run against all the spec json.");
    return verboseExec(`cspell "specification/**/*.json"`);
  }

  const changedJsonFiles = await pr.structuralDiff()
    .filter(filePath => filePath.endsWith('.json') && filePath.startsWith('specification/'))
    .toArray();
  if (changedJsonFiles.length === 0) {
    console.warn("No changed spec json file");
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
    console.error('Please fix the error or add words to custom-words.txt');
  }
  process.exit(retCode);
});