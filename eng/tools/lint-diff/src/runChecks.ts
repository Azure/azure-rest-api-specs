import { join } from "path";
import { exec, ExecException } from "node:child_process";

import { getOpenapiType } from "./markdown-utils.js";
import { getPathToDependency, isFailure } from "./util.js";
import { AutoRestMessage, AutorestRunResult } from "./lintdiff-types.js";

const MAX_EXEC_BUFFER = 64 * 1024 * 1024;

// AutoRest messages are JSON objects that start with the string '{"level":'
// Non-AutoRest messages will start with things like '{"pluginName"'
const AUTOREST_ERROR_PREFIX = '{"level":';

export async function runChecks(
  path: string,
  runList: Map<string, string[]>,
): Promise<AutorestRunResult[]> {
  const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");
  const result: AutorestRunResult[] = [];

  for (const [readme, tags] of runList.entries()) {
    const changedFilePath = join(path, readme);

    // TODO: Move this into getRunList
    let openApiType = await getOpenapiType(changedFilePath);

    // From momentOfTruth.ts:executeAutoRestWithLintDiff
    // This is a quick workaround for https://github.com/Azure/azure-sdk-tools/issues/6549
    // We override the openapi-subtype with the value of openapi-type,
    // to prevent LintDiff from reading openapi-subtype from the AutoRest config file (README)
    // and overriding openapi-type with it.
    let openApiSubType = openApiType;

    // If the tags array is empty run the loop once but with a null tag
    const coalescedTags = tags?.length ? tags : [null];
    for (const tag of coalescedTags) {
      let tagArg = tag ? `--tag=${tag} ` : "";

      let autorestCommand =
        `npm exec --no -- autorest ` +
        `--v3 ` +
        `--spectral ` +
        `--azure-validator ` +
        `--semantic-validator=false ` +
        `--model-validator=false ` +
        `--message-format=json ` +
        `--openapi-type=${openApiType} ` +
        `--openapi-subtype=${openApiSubType} ` +
        `--use=${dependenciesDir} ` +
        `${tagArg} ` +
        `${changedFilePath}`;

      console.log(`::group::Autorest for type: ${openApiType} readme: ${readme} tag: ${tag}`);
      console.log(`\tAutorest command: ${autorestCommand}`);

      const executionResult = await executeCommand(autorestCommand);
      
      console.log(executionResult.stderr + executionResult.stdout);

      const lintDiffResult = {
        autorestCommand,
        rootPath: path,
        readme,
        tag: tag ? tag : "",
        openApiType,
        ...executionResult,
      };
      logAutorestExecutionErrors(lintDiffResult);
      console.log("::endgroup::");

      result.push(lintDiffResult);
      console.log(`\tAutorest result length: ${lintDiffResult.stderr.length + lintDiffResult.stdout.length}\n`);
    }
  }

  return result;
}

export async function executeCommand(
  command: string,
  cwd: string = ".",
): Promise<{ error: ExecException | null; stdout: string; stderr: string }> {
  return new Promise((resolve) => {
    exec(
      command,
      { cwd, encoding: "utf-8", maxBuffer: MAX_EXEC_BUFFER },
      (error, stdout, stderr) => {
        resolve({ error, stdout, stderr });
      },
    );
  });
}

export function getAutorestErrors(runResult: AutorestRunResult): AutoRestMessage[] {
  const errors = [];
  const lines = (runResult.stdout + runResult.stderr).split("\n").map((line) => line.trim());

  for (const line of lines) {
    if (line.startsWith(AUTOREST_ERROR_PREFIX)) {
      const error = JSON.parse(line) as AutoRestMessage;
      if (isFailure(error.level)) {
        errors.push(error);
      }
    }
  }

  return errors;
}

export function logAutorestExecutionErrors(runResult: AutorestRunResult) {
  if (runResult.error !== null) {
    const autoRestPrefix = `{`;
    const stdoutContainsLevelError = runResult.stdout.includes(`${autoRestPrefix}"level":"error"`);
    const stdoutContainsLevelFatal = runResult.stdout.includes(`${autoRestPrefix}"level":"fatal"`);
    const stderrContainsLevelError = runResult.stderr.includes(`${autoRestPrefix}"level":"error"`);
    const stderrContainsLevelFatal = runResult.stderr.includes(`${autoRestPrefix}"level":"fatal"`);

    console.log(
      `\tAutorest completed with errors:
\t\tExit code: ${runResult.error.code}
\t\tError is not null: true, 
\t\tstdout contains AutoRest 'error': ${stdoutContainsLevelError}
\t\tstdout contains AutoRest 'fatal': ${stdoutContainsLevelFatal} 
\t\tstderr contains AutoRest 'error': ${stderrContainsLevelError} 
\t\tstderr contains AutoRest 'fatal': ${stderrContainsLevelFatal}`,
    );
  }
}
