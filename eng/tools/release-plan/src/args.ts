import path from "node:path";
import process from "node:process";
import { parseArgs, type ParseArgsConfig } from "node:util";
import type { CliArguments } from "./types.js";

/**
 * Parse command line arguments for release plan tool.
 */
export function parseCliArguments(argv: string[] = process.argv.slice(2)): CliArguments {
  const options: ParseArgsConfig = {
    args: argv,
    options: {
      "commit-sha": {
        type: "string",
        short: "c",
      },
      repo: {
        type: "string",
        short: "r",
        default: process.env.GITHUB_REPOSITORY || "Azure/azure-rest-api-specs",
      },
      workspace: {
        type: "string",
        short: "w",
        default: process.cwd(),
      },
      "azsdk-path": {
        type: "string",
      },
      "output-file": {
        type: "string",
      },
      "test-release-plan": {
        type: "string",
        default: "false",
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

  const { values } = parseArgs(options);

  if (values.help) {
    showHelp();
    process.exit(0);
  }

  const commitSha = String(values["commit-sha"] ?? "").trim() || undefined;
  if (!commitSha) {
    throw new Error("--commit-sha is required.");
  }

  const repoRaw = String(values.repo ?? "").trim();
  const [owner, repo] = repoRaw.split("/");
  if (!owner || !repo) {
    throw new Error("--repo must be in the form 'owner/repo'.");
  }

  const workspace = path.resolve(String(values.workspace ?? process.cwd()));
  const azsdkPath = String(values["azsdk-path"] ?? "").trim() || undefined;
  const outputFile = String(values["output-file"] ?? "").trim() || undefined;
  const testReleaseRaw = String(values["test-release-plan"] ?? "false")
    .trim()
    .toLowerCase();
  if (testReleaseRaw !== "true" && testReleaseRaw !== "false") {
    throw new Error("--test-release-plan must be either 'true' or 'false'.");
  }
  const testReleasePlan = testReleaseRaw === "true";

  return {
    commitSha,
    owner,
    repo,
    workspace,
    azsdkPath,
    outputFile,
    testReleasePlan,
  };
}

function showHelp(): void {
  console.log("Release Plan Tool");
  console.log("");
  console.log("Usage:");
  console.log("  release-plan --commit-sha <sha> [options]");
  console.log("");
  console.log("Options:");
  console.log("  -c, --commit-sha      Commit SHA to resolve PR or analyze changed files");
  console.log("  -r, --repo            GitHub repository in owner/repo format");
  console.log("  -w, --workspace       Path to local repo root (default: cwd)");
  console.log("      --azsdk-path      Absolute path to the azsdk executable");
  console.log("      --output-file     Write JSON result to this file path");
  console.log(
    "      --test-release-plan  Create release plan as test (true|false, default: false)",
  );
  console.log("  -h, --help            Show help");
}
