import { Octokit } from "@octokit/rest";
import { writeFile } from "fs/promises";
import { parseArgs, ParseArgsConfig } from "node:util";
import { fetchPRDetails, generateMarkdownSummary } from "./summarizer.js";
import { PRSummaryOptions } from "./types.js";

export async function main() {
  const config: ParseArgsConfig = {
    options: {
      number: {
        type: "string",
        short: "n",
        multiple: false,
      },
      owner: {
        type: "string",
        short: "o",
        multiple: false,
        default: "Azure",
      },
      repo: {
        type: "string",
        short: "r",
        multiple: false,
        default: "azure-rest-api-specs",
      },
      output: {
        type: "string",
        short: "f",
        multiple: false,
      },
      help: {
        type: "boolean",
        short: "h",
        multiple: false,
        default: false,
      },
    },
    allowPositionals: false,
  };

  const { values: opts } = parseArgs(config);

  // Show help if requested
  if (opts.help) {
    console.log(`
Usage: summarize-pr [options]

Options:
  -n, --number <number>   PR number (required)
  -o, --owner <owner>     Repository owner (default: "Azure")
  -r, --repo <repo>       Repository name (default: "azure-rest-api-specs")
  -f, --output <file>     Output file path (optional, defaults to stdout)
  -h, --help              Show this help message

Environment Variables:
  GITHUB_TOKEN            GitHub personal access token (optional, for higher rate limits)

Examples:
  summarize-pr --number 12345
  summarize-pr --number 12345 --output summary.md
  summarize-pr --number 12345 --owner microsoft --repo typespec
`);
    return;
  }

  // Validate required options
  if (!opts.number) {
    console.error("Error: --number is required");
    process.exit(1);
  }

  const options: PRSummaryOptions = {
    number: parseInt(opts.number as string, 10),
    owner: opts.owner as string,
    repo: opts.repo as string,
    outputFile: opts.output as string | undefined,
  };

  // Validate PR number
  if (isNaN(options.number) || options.number <= 0) {
    console.error("Error: --number must be a positive integer");
    process.exit(1);
  }

  try {
    // Create GitHub client
    const octokit = new Octokit({
      ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN }),
    });

    console.error(`Fetching PR #${options.number} from ${options.owner}/${options.repo}...`);

    // Fetch PR details
    const summary = await fetchPRDetails(octokit, options);

    console.error(`Generating summary for PR #${summary.number}...`);

    // Generate markdown
    const markdown = generateMarkdownSummary(summary);

    // Output to file or stdout
    if (options.outputFile) {
      await writeFile(options.outputFile, markdown, "utf-8");
      console.error(`Summary written to ${options.outputFile}`);
    } else {
      console.log(markdown);
    }
  } catch (error: any) {
    if (error.status === 404) {
      console.error(
        `Error: PR #${options.number} not found in ${options.owner}/${options.repo}`,
      );
    } else if (error.status === 403) {
      console.error(
        "Error: API rate limit exceeded. Set GITHUB_TOKEN environment variable to increase limits.",
      );
    } else {
      console.error(`Error: ${error.message}`);
    }
    process.exit(1);
  }
}
