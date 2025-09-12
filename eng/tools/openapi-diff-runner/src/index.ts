import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { exit } from "node:process";
import { fileURLToPath } from "node:url";
import { parseArgs, type ParseArgsConfig } from "node:util";
import {
  buildPrInfo,
  createContextFromParsedArgs,
  type ParsedCliArguments,
} from "./command-helpers.js";
import { validateBreakingChange } from "./commands.js";
import { logError, logMessage } from "./log.js";
import { BreakingChangesCheckType } from "./types/breaking-change.js";

const __filename: string = fileURLToPath(import.meta.url);
const __dirname: string = path.dirname(__filename);

/**
 * Parse command line arguments using Node.js parseArgs
 */
function parseCliArguments(): ParsedCliArguments {
  const options: ParseArgsConfig = {
    options: {
      "spec-repo-path": {
        type: "string",
        short: "p",
        default: path.join(__dirname, ".."),
      },
      "target-repo": {
        type: "string",
        short: "r",
        default: "azure/azure-rest-api-specs",
      },
      "source-repo": {
        type: "string",
        short: "s",
        default: "azure/azure-rest-api-specs",
      },
      "pr-number": {
        type: "string",
        short: "n",
        default: "",
      },
      "run-type": {
        type: "string",
        short: "t",
        default: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
      },
      "base-branch": {
        type: "string",
        short: "b",
        default: "main",
      },
      "head-commit": {
        type: "string",
        short: "c",
        default: "HEAD",
      },
      "pr-source-branch": {
        type: "string",
        default: "",
      },
      "pr-target-branch": {
        type: "string",
        default: "",
      },
      help: {
        type: "boolean",
        short: "h",
        default: false,
      },
    },
    allowPositionals: false,
    strict: true,
  };

  try {
    const { values } = parseArgs(options);

    // Show help if requested
    if (values.help) {
      showHelp();
      exit(0);
    }

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
    if (!validRunTypes.includes(values["run-type"] as BreakingChangesCheckType)) {
      logError(`Error: --run-type must be one of: ${validRunTypes.join(", ")}`);
      exit(1);
    }

    return {
      localSpecRepoPath: path.resolve(values["spec-repo-path"] as string),
      targetRepo: values["target-repo"] as string,
      sourceRepo: values["source-repo"] as string,
      prNumber: values["pr-number"] as string,
      runType: values["run-type"] as BreakingChangesCheckType,
      baseBranch: values["base-branch"] as string,
      headCommit: values["head-commit"] as string,
      prSourceBranch: values["pr-source-branch"] as string,
      prTargetBranch: values["pr-target-branch"] as string,
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
  logMessage("OpenAPI Diff Runner - Breaking Change Detection Tool");
  logMessage("");
  logMessage("Usage: node index.js [options]");
  logMessage("");
  logMessage("Options:");
  logMessage("  -h, --help                Show help message");
  logMessage("  -p, --spec-repo-path      Local spec repository path (default: ..)");
  logMessage(
    "  -r, --target-repo         Target repository (owner/repo format) (default: azure/azure-rest-api-specs)",
  );
  logMessage(
    "  -s, --source-repo         Source repository (owner/repo format) (default: azure/azure-rest-api-specs)",
  );
  logMessage("  -n, --pr-number           Pull request number (required)");
  logMessage(
    "  -t, --run-type            Run type (SameVersion or CrossVersion) (default: SameVersion)",
  );
  logMessage("  -b, --base-branch         Base branch for comparison (default: main)");
  logMessage("  -c, --head-commit         Head commit SHA (default: HEAD)");
  logMessage("      --pr-source-branch    PR source branch (default: '')");
  logMessage("      --pr-target-branch    PR target branch (default: '')");
  logMessage("");
  logMessage("Examples:");
  logMessage("  node index.js --pr-number 12345 --run-type SameVersion");
  logMessage("  node index.js -n 12345 -t CrossVersion -b main");
  logMessage("  node index.js --pr-number 12345 --target-repo myorg/my-specs");
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
