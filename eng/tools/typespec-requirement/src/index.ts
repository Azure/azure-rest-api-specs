import { appendFile } from "node:fs/promises";
import { resolve } from "node:path";
import { checkRequirements, type RequirementOptions } from "./check-requirements.ts";

type Options = Omit<RequirementOptions, "repoRoot">;

function escapeData(value: string): string {
  return value.replaceAll("%", "%25").replaceAll("\r", "%0D").replaceAll("\n", "%0A");
}

function escapeProperty(value: string): string {
  return escapeData(value).replaceAll(":", "%3A").replaceAll(",", "%2C");
}

function logInfo(message: string): void {
  console.log(message);
}

function logWarning(message: string): void {
  if (process.env.SYSTEM_TEAMPROJECTID) {
    console.log(`##vso[task.logissue type=warning;]${escapeData(message)}`);
  } else if (process.env.GITHUB_ACTIONS) {
    console.log(`::warning::${escapeData(message)}`);
  } else {
    console.log(message);
  }
}

function logWarningForFile(file: string, message: string): void {
  if (process.env.SYSTEM_TEAMPROJECTID) {
    console.log(
      `##vso[task.logissue type=warning;sourcepath=${escapeData(file)};linenumber=1;columnnumber=1;]${escapeData(message)}`,
    );
  } else if (process.env.GITHUB_ACTIONS) {
    console.log(`::warning file=${escapeProperty(file)},line=1,col=1::${escapeData(message)}`);
  } else {
    console.log(`[Warning in file ${file}] ${message}`);
  }
}

function logError(message: string): void {
  if (process.env.SYSTEM_TEAMPROJECTID) {
    console.error(`##vso[task.logissue type=error;]${escapeData(message)}`);
  } else if (process.env.GITHUB_ACTIONS) {
    console.error(`::error::${escapeData(message)}`);
  } else {
    console.error(message);
  }
}

function logErrorForFile(file: string, message: string): void {
  if (process.env.SYSTEM_TEAMPROJECTID) {
    console.error(
      `##vso[task.logissue type=error;sourcepath=${escapeData(file)};linenumber=1;columnnumber=1;]${escapeData(message)}`,
    );
  } else if (process.env.GITHUB_ACTIONS) {
    console.error(`::error file=${escapeProperty(file)},line=1,col=1::${escapeData(message)}`);
  } else {
    console.error(`[Error in file ${file}]${message}`);
  }
}

function logJobFailure(): void {
  if (process.env.SYSTEM_TEAMPROJECTID) {
    console.log("##vso[task.complete result=Failed;]");
  }
}

function parseArgs(args: string[]): Options {
  const options: Options = {
    baseCommitish: "HEAD^",
    headCommitish: "HEAD",
    responseCache: {},
  };

  for (let index = 0; index < args.length; index++) {
    const argument = args[index];
    const value = args[++index];
    if (!value) {
      throw new Error(`Missing value for ${argument}`);
    }

    switch (argument) {
      case "--base-commitish":
        options.baseCommitish = value;
        break;
      case "--head-commitish":
        options.headCommitish = value;
        break;
      case "--spec-type":
        if (value !== "data-plane" && value !== "resource-manager") {
          throw new Error("--spec-type must be either 'data-plane' or 'resource-manager'");
        }
        options.specType = value;
        break;
      case "--check-all-under":
        options.checkAllUnder = value;
        break;
      case "--response-cache": {
        const cache: unknown = JSON.parse(value);
        if (
          cache === null ||
          typeof cache !== "object" ||
          Array.isArray(cache) ||
          Object.values(cache).some((status) => typeof status !== "number")
        ) {
          throw new Error("--response-cache must be a JSON object of URL/status pairs");
        }
        options.responseCache = cache as Record<string, number>;
        break;
      }
      default:
        throw new Error(`Unknown argument: ${argument}`);
    }
  }

  return options;
}

async function main(): Promise<void> {
  try {
    const result = await checkRequirements(
      {
        ...parseArgs(process.argv.slice(2)),
        repoRoot: resolve(import.meta.dirname, "../../../../"),
      },
      {
        info: logInfo,
        warning: logWarning,
        warningForFile: logWarningForFile,
        error: logError,
        errorForFile: logErrorForFile,
        jobFailure: logJobFailure,
        brownfield: async () => {
          if (process.env.GITHUB_OUTPUT) {
            await appendFile(process.env.GITHUB_OUTPUT, "brownfield=true\n");
          }
        },
      },
    );
    process.exitCode = result.exitCode;
  } catch (error) {
    logError(`TypeSpec Requirement failed: ${String(error)}`);
    process.exitCode = 1;
  }
}

await main();
