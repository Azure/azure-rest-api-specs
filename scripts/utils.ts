import { ExecOptions } from 'child_process';
import { childProcess, cli, devOps } from '@azure/avocado';

export const logToAzureDevops = (msg: string, type: string) => {
  const lines = msg.split('\n');
  for (const line of lines) {
    console.log(`##vso[task.logissue type=${type}]${line}`);
  }
}

export const logError = (msg: string) => logToAzureDevops(msg, 'error');
export const logWarn = (msg: string) => logToAzureDevops(msg, 'warning');

export type Exec = (commandLine: string, options?: ExecOptions) => Promise<number>;
export type CheckContext = {
  exec: Exec;
};
export type CheckOptions = {
  onExecError(result: childProcess.ExecResult): Promise<unknown>;
  onNotInCI(context: CheckContext): Promise<unknown>;
  onCheckFile(context: CheckContext, filePath: string): Promise<number>;
  onFinalFailed(context: CheckContext): Promise<unknown>;
}

const internalCheck = async (checkOptions: CheckOptions) => {

  const exec = async (commandLine: string, options: ExecOptions = {}) => {
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
    await checkOptions.onExecError(result);

    return result.code;
  }
  const context: CheckContext = { exec };

  const config = cli.defaultConfig();
  const pr = await devOps.createPullRequestProperties(config);
  if (pr === undefined) {
    return checkOptions.onNotInCI(context);
  }

  const changedJsonFiles = (await pr.diff())
    .filter(change => change.kind !== 'Deleted')
    .map(change => change.path)
    .filter(filePath => filePath.endsWith('.json') && filePath.startsWith('specification/'));
  if (changedJsonFiles.length === 0) {
    logWarn("No changed spec json file");
    return;
  }

  let retCode = 0;
  for (const jsonFile of changedJsonFiles) {
    const code = await checkOptions.onCheckFile(context, jsonFile);
    if (code !== 0) {
      retCode = code;
    }
  }

  if (retCode !== 0) {
    await checkOptions.onFinalFailed(context);
  }

  process.exit(retCode);
}

export const runCheckOverChangedSpecFiles = (options: CheckOptions) => {
  internalCheck(options).catch(e => {
    console.error(e);
    logError(`Fatal Error. Please report to adxsr@microsoft.com`);
    process.exit(-1);
  });
}
