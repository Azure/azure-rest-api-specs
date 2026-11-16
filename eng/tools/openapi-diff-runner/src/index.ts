import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { parseArgsWithHelp, type CliArgsConfig } from "@azure-tools/specs-shared/cli";
import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { exit } from "node:process";
import { fileURLToPath } from "node:url";
import {
  buildPrInfo,
  createContextFromParsedArgs,
  type ParsedCliArguments,
} from "./command-helpers.ts";
import { validateBreakingChange } from "./commands.ts";
import { logError, logMessage } from "./log.ts";
import { type BreakingChangesCheckType } from "./types/breaking-change.ts";

const __filename: string = fileURLToPath(import.meta.url);
const __dirname: string = path.dirname(__filename);

const cliConfig = {
  options: {
    "spec-repo-path": {
      type: "string",
      short: "p",
      default: path.join(__dirname, ".."),
      description: "Local spec repository path (default: runner directory).",
    },
    "target-repo": {
      type: "string",
      short: "r",
      default: "azure/azure-rest-api-specs",
      description: "Target repository (default: azure/azure-rest-api-specs).",
    },
    "source-repo": {
      type: "string",
      short: "s",
      default: "azure/azure-rest-api-specs",
      description: "Source repository (default: azure/azure-rest-api-specs).",
    },
    "pr-number": {
      type: "string",
      short: "n",
      default: "",
      description: "Pull request number (required).",
    },
    "run-type": {
      type: "string",
      short: "t",
      default: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
      description: "Run type: SameVersion or CrossVersion (default: SameVersion).",
    },
    "base-branch": {
      type: "string",
      short: "b",
      default: "main",
      description: "Base branch for comparison (default: main).",
    },
    "head-commit": {
      type: "string",
      short: "c",
      default: "HEAD",
      description: "Head commit SHA (default: HEAD).",
    },
    "pr-source-branch": {
      type: "string",
      default: "",
      description: "PR source branch.",
    },
    "pr-target-branch": {
      type: "string",
      default: "",
      description: "PR target branch.",
    },
  },
  allowPositionals: false,
  strict: true,
  help: {
    command: "openapi-diff-runner",
    title: "OpenAPI Diff Runner - Breaking Change Detection Tool",
    examples: [
      "--pr-number 12345 --run-type SameVersion",
      "-n 12345 -t CrossVersion -b main",
      "--pr-number 12345 --target-repo myorg/my-specs",
    ],
  },
} as const satisfies CliArgsConfig;

export function parseCliArguments(args = process.argv.slice(2)): ParsedCliArguments {
  try {
    const parsed = parseArgsWithHelp({ ...cliConfig, args });
    if (!parsed) {
      exit(0);
    }
    const { values } = parsed;

    // Validate required arguments
    if (!values["pr-number"]) {
      logError("Error: --pr-number (PR number) is required");
      showHelp();
      exit(1);
    }

    // Validate run type
    const validRunTypes = [
      BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
      BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
    ];
    const runType = values["run-type"];
    if (!validRunTypes.some((validRunType) => validRunType === runType)) {
      logError(`Error: --run-type must be one of: ${validRunTypes.join(", ")}`);
      exit(1);
    }

    return {
      localSpecRepoPath: path.resolve(values["spec-repo-path"]),
      targetRepo: values["target-repo"],
      sourceRepo: values["source-repo"],
      prNumber: values["pr-number"],
      runType: runType as BreakingChangesCheckType,
      baseBranch: values["base-branch"],
      headCommit: values["head-commit"],
      prSourceBranch: values["pr-source-branch"],
      prTargetBranch: values["pr-target-branch"],
    };
  } catch (error) {
    logError(`Error parsing arguments: ${error}`);
    showHelp();
    exit(1);
  }
}

/**
 * Show help message
 */
function showHelp() {
  parseArgsWithHelp({ ...cliConfig, args: ["--help"] });
}

export async function main() {
  // Parse command line arguments
  const parsedArgs = parseCliArguments();

  // Log the arguments to the console
  logMessage(`Arguments: ${JSON.stringify(parsedArgs, null, 2)}`);
  logMessage(`Current working directory: ${process.cwd()}`);

  // Create working folder and log file folder
  const workingFolder = path.join(parsedArgs.localSpecRepoPath, "..");
  const logFileFolder = path.join(workingFolder, "out/logs");

  // Create the log file folder if it does not exist
  if (!existsSync(logFileFolder)) {
    mkdirSync(logFileFolder, { recursive: true });
  }

  // Create context from parsed arguments
  const context = createContextFromParsedArgs(parsedArgs, workingFolder, logFileFolder);
  await buildPrInfo(context);
  let statusCode = 0;
  statusCode = await validateBreakingChange(context);

  if (process.env.GITHUB_SERVER_URL && process.env.GITHUB_REPOSITORY && process.env.GITHUB_RUN_ID) {
    logMessage(
      `See validation report summary at: ${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}/actions/runs/${process.env.GITHUB_RUN_ID}`,
    );
  }
  exit(statusCode);
}
