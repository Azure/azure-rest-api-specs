import { ExecError, execNpmExec, isExecError } from "@azure-tools/specs-shared/exec";
import { debugLogger } from "@azure-tools/specs-shared/logger";
import { join } from "path";

import { AutoRestMessage, AutorestRunResult, ReadmeAffectedTags } from "./lintdiff-types.js";
import { getOpenapiType } from "./markdown-utils.js";
import { getPathToDependency, isFailure } from "./util.js";

const MAX_EXEC_BUFFER = 64 * 1024 * 1024;

// AutoRest messages are JSON objects that start with the string '{"level":'
// Non-AutoRest messages will start with things like '{"pluginName"'
const AUTOREST_ERROR_PREFIX = '{"level":';

export async function runChecks(
  path: string,
  runList: Map<string, ReadmeAffectedTags>,
): Promise<AutorestRunResult[]> {
  const dependenciesDir = await getPathToDependency("@microsoft.azure/openapi-validator");
  const result: AutorestRunResult[] = [];

  for (const [readme, tags] of runList.entries()) {
    const changedFilePath = join(path, readme);

    let openApiType = await getOpenapiType(tags.readme);

    // From momentOfTruth.ts:executeAutoRestWithLintDiff
    // This is a quick workaround for https://github.com/Azure/azure-sdk-tools/issues/6549
    // We override the openapi-subtype with the value of openapi-type,
    // to prevent LintDiff from reading openapi-subtype from the AutoRest config file (README)
    // and overriding openapi-type with it.
    let openApiSubType = openApiType;

    // If the tags array is empty run the loop once but with a null tag
    const coalescedTags = tags.changedTags?.size ? [...tags.changedTags] : [null];
    for (const tag of coalescedTags) {
      console.log(`::group::Autorest for type: ${openApiType} readme: ${readme} tag: ${tag}`);

      const autorestArgs = [
        "autorest",
        "--v3",
        "--spectral",
        "--azure-validator",
        "--semantic-validator=false",
        "--model-validator=false",
        "--message-format=json",
        `--openapi-type=${openApiType}`,
        `--openapi-subtype=${openApiSubType}`,
        `--use=${dependenciesDir}`,
      ];

      if (tag) {
        autorestArgs.push(`--tag=${tag}`);
      }
      autorestArgs.push(changedFilePath);
      const autorestCommand = `npm exec -- ${autorestArgs.join(" ")}`;
      console.log(`\tAutorest command: ${autorestCommand}`);

      let lintDiffResult: AutorestRunResult;
      try {
        const executionResult = await execNpmExec(autorestArgs, {
          maxBuffer: MAX_EXEC_BUFFER,
          logger: debugLogger,
        });

        lintDiffResult = {
          autorestCommand,
          rootPath: path,
          readme: tags.readme,
          tag: tag ? tag : "",
          openApiType,
          error: null,
          ...executionResult,
        } as AutorestRunResult;
      } catch (error) {
        if (!isExecError(error)) {
          throw error;
        }

        const execError = error as ExecError;
        lintDiffResult = {
          autorestCommand,
          rootPath: path,
          readme: tags.readme,
          tag: tag ? tag : "",
          openApiType,
          error: execError,
          stdout: execError.stdout || "",
          stderr: execError.stderr || "",
        } as AutorestRunResult;

        logAutorestExecutionErrors(lintDiffResult);
      }
      console.log("::endgroup::");

      result.push(lintDiffResult);
      console.log(
        `\tAutorest result length: ${lintDiffResult.stderr.length + lintDiffResult.stdout.length}\n`,
      );
    }
  }

  return result;
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
