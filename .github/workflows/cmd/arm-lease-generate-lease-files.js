import { existsSync, mkdirSync, readFileSync, writeFileSync } from "fs";
import { dirname, join, resolve } from "path";
import { createInterface } from "readline";
import { fileURLToPath } from "url";
import { parseArgs } from "util";
import { findRepoRoot } from "./arm-lease-fetch-resource-providers.js";

const DEFAULT_DURATION = "P180D";
const LEASE_BASE_PATH = ".github/arm-leases";

/**
 * Get today's date in ISO format (YYYY-MM-DD)
 * @returns {string} Today's date
 */
export function getTodayDate() {
  return new Date().toISOString().split("T")[0];
}

/**
 * Validate a start date
 * @param {string} date - Date string in YYYY-MM-DD format
 * @returns {string} The validated date
 */
export function validateStartDate(date) {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
    throw new Error(`Invalid date format: ${date}. Expected YYYY-MM-DD`);
  }
  const dateObj = new Date(date);
  if (isNaN(dateObj.getTime())) {
    throw new Error(`Invalid calendar date: ${date}`);
  }
  const gracePeriodDate = new Date();
  gracePeriodDate.setHours(0, 0, 0, 0);
  gracePeriodDate.setDate(gracePeriodDate.getDate() - 10);

  if (dateObj < gracePeriodDate) {
    throw new Error(`Startdate is too far in the past: ${date} (must be within 10 days of today)`);
  }
  return date;
}

/**
 * Validate a duration string
 * @param {string} duration - Duration in ISO 8601 format (e.g., P180D)
 * @returns {string} The validated duration (uppercase)
 */
export function validateDuration(duration) {
  const match = duration.match(/^P(\d+)D$/i);
  if (!match) {
    throw new Error(`Invalid duration format: ${duration}. Expected P#D (e.g., P180D)`);
  }
  const days = parseInt(match[1], 10);
  if (days <= 0 || days > 180) {
    throw new Error(`Duration must be between 1 and 180 days. Got: ${days}`);
  }
  return duration.toUpperCase();
}

/**
 * Validate a resource provider namespace
 * @param {string} rpNamespace - Resource provider namespace (e.g., Microsoft.Storage)
 * @returns {string} The validated namespace
 */
export function validateRpNamespace(rpNamespace) {
  const parts = rpNamespace.split(".");
  for (const part of parts) {
    if (!/^[A-Z]/.test(part)) {
      throw new Error(`rpNamespace parts must start with capital letter: ${rpNamespace}`);
    }
  }
  return rpNamespace;
}

/**
 * Validate an organization name
 * @param {string} orgName - Organization name
 * @returns {string} The validated org name (lowercased)
 */
export function validateOrgName(orgName) {
  const normalized = orgName.toLowerCase();
  if (!/^[a-z0-9-]+$/.test(normalized)) {
    throw new Error(`orgName must be lowercase alphanumeric (hyphens allowed): ${orgName}`);
  }
  return normalized;
}

/**
 * Validate a reviewer GitHub alias
 * @param {string} reviewer - Reviewer GitHub alias
 * @returns {string} The validated reviewer (trimmed)
 */
export function validateReviewer(reviewer) {
  if (!reviewer || reviewer.trim().length === 0) {
    throw new Error("Reviewer is required and cannot be empty");
  }
  const trimmed = reviewer.trim();
  if (!trimmed.startsWith("@") || trimmed.length <= 1) {
    throw new Error(
      `Reviewer must be a GitHub alias starting with @ (e.g., @githubUser). Got: ${reviewer}`,
    );
  }
  return trimmed;
}

/**
 * Parse an input line in CSV format
 * @param {string} line - Input line to parse
 * @returns {{orgName: string, rpNamespace: string, serviceNames: string[]}|null} Parsed entry or null
 */
export function parseInputLine(line) {
  line = line.trim();
  if (!line || line.startsWith("#")) return null;

  const match = line.match(/^([^,]+),\s*([^,[]+)(?:,\s*\[([^\]]+)\])?$/);
  if (!match) {
    console.warn(`Skipping invalid line: ${line}`);
    return null;
  }

  const orgName = match[1].trim();
  const rpNamespace = match[2].trim();
  const serviceNamesStr = match[3];
  const serviceNames = serviceNamesStr
    ? serviceNamesStr
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean)
    : [];

  return { orgName, rpNamespace, serviceNames };
}

/**
 * Generate lease.yaml content
 * @param {string} rpNamespace - Resource provider namespace
 * @param {string} startdate - Start date in YYYY-MM-DD format
 * @param {string} duration - Duration in ISO 8601 format
 * @param {string} reviewer - Reviewer GitHub alias
 * @returns {string} YAML content for lease file
 */
export function generateLeaseYaml(rpNamespace, startdate, duration, reviewer) {
  return `lease:
  resource-provider: ${rpNamespace}
  startdate: "${startdate}"
  duration: ${duration}
  reviewer: "${reviewer}"
`;
}

/**
 * Get the path for a lease file
 * @param {string} repoRoot - Repository root path
 * @param {string} orgName - Organization name
 * @param {string} rpNamespace - Resource provider namespace
 * @param {string|null} [serviceName] - Optional service name
 * @returns {string} Full path to lease.yaml file
 */
export function getLeasePath(repoRoot, orgName, rpNamespace, serviceName = null) {
  const basePath = join(repoRoot, LEASE_BASE_PATH, orgName, rpNamespace);
  return serviceName ? join(basePath, serviceName, "lease.yaml") : join(basePath, "lease.yaml");
}

/**
 * Create a lease file
 * @param {string} filePath - Path to the file
 * @param {string} content - File content
 * @param {boolean} isDryRun - Whether this is a dry run
 */
function createLeaseFile(filePath, content, isDryRun) {
  if (isDryRun) {
    console.log(`[DRY RUN] Would create: ${filePath}`);
    console.log(content);
    console.log("---");
    return;
  }

  const dir = dirname(filePath);
  if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
  }

  if (existsSync(filePath)) {
    console.warn(`Warning: File already exists, skipping: ${filePath}`);
    return;
  }

  writeFileSync(filePath, content, "utf-8");
  console.log(`Created: ${filePath}`);
}

/**
 * Process a single entry
 * @param {{orgName: string, rpNamespace: string, serviceNames: string[]}} entry
 * @param {{startdate: string, duration: string, reviewer: string, dryRun: boolean}} options
 * @param {string} repoRoot
 */
function processEntry(entry, options, repoRoot) {
  const { orgName, rpNamespace, serviceNames } = entry;
  const { startdate, duration, reviewer, dryRun: isDryRun } = options;

  try {
    const normalizedOrgName = validateOrgName(orgName);
    validateRpNamespace(rpNamespace);

    const content = generateLeaseYaml(rpNamespace, startdate, duration, reviewer);

    if (serviceNames.length === 0) {
      createLeaseFile(getLeasePath(repoRoot, normalizedOrgName, rpNamespace), content, isDryRun);
    } else {
      for (const serviceName of serviceNames) {
        createLeaseFile(
          getLeasePath(repoRoot, normalizedOrgName, rpNamespace, serviceName),
          content,
          isDryRun,
        );
      }
    }
  } catch (error) {
    console.error(
      `Error processing ${orgName}/${rpNamespace}: ${/** @type {Error} */ (error).message}`,
    );
  }
}

/**
 * Run interactive mode
 * @returns {Promise<{reviewer: string, startdate: string, duration: string, entries: Array<{orgName: string, rpNamespace: string, serviceNames: string[]}>, dryRun: boolean}>}
 */
async function promptInteractive() {
  const rl = createInterface({ input: process.stdin, output: process.stdout });
  /** @param {string} prompt */
  const question = (prompt) =>
    /** @type {Promise<string>} */ (new Promise((resolve) => rl.question(prompt, resolve)));

  console.log("\nInteractive Lease File Generator");
  console.log("=================================\n");

  const reviewer = await question("Enter reviewer GitHub alias (required, e.g., @githubUser): ");
  if (!reviewer.trim()) {
    console.error("Error: Reviewer name is required");
    rl.close();
    process.exit(1);
  }

  const startdateInput = await question(
    `Enter start date [YYYY-MM-DD] (default: ${getTodayDate()}): `,
  );
  const startdate = startdateInput.trim() || getTodayDate();

  const durationInput = await question(`Enter duration [P#D] (default: ${DEFAULT_DURATION}): `);
  const duration = durationInput.trim() || DEFAULT_DURATION;

  console.log("\nEnter resource provider entries (one per line, empty line to finish):");
  console.log("Format: orgName, rpNamespace, [optional serviceNames]");
  console.log("Example: storage, Microsoft.Storage");
  console.log("Example: compute, Microsoft.Compute, [ComputeRP, DiskRP]\n");

  /** @type {Array<{orgName: string, rpNamespace: string, serviceNames: string[]}>} */
  const entries = [];
  while (true) {
    const line = await question("> ");
    if (!line.trim()) break;
    const entry = parseInputLine(line);
    if (entry) entries.push(entry);
  }

  rl.close();
  return { reviewer: reviewer.trim(), startdate, duration, entries, dryRun: false };
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function usage() {
  console.log(`Usage:
npx arm-lease-generate-lease-files --orgName <name> --rpNamespace <name> --reviewer <alias> [options]
npx arm-lease-generate-lease-files --input <file> --reviewer <alias> [options]
npx arm-lease-generate-lease-files --interactive

Options:
  --orgName <name>           Organization/service name (lowercase alphanumeric)
  --rpNamespace <name>       Resource provider namespace (e.g., Microsoft.Storage)
  --serviceName <list>       Comma-separated service groups (e.g., DiskRP,ComputeRP)
  --reviewer <alias>         Reviewer GitHub alias starting with @ (e.g., @githubUser)
  --startdate <date>         Lease start date YYYY-MM-DD (default: today)
  --duration <duration>      Lease duration (default: P180D, max: P180D)
  --input <file>             Input file with RP entries (one per line)
  --repo-root <path>         Repository root path (auto-detected if not provided)
  --dry-run                  Show what would be created without writing files
  --interactive, -i          Interactive mode with prompts
  --help                     Show this help message

Input File Format:
  - Without service groups: orgName, rpNamespace
  - With service groups: orgName, rpNamespace, [serviceName1, serviceName2, ...]

Examples:
  # Single RP
  npx arm-lease-generate-lease-files --orgName storage --rpNamespace Microsoft.Storage --reviewer "@johndoe"

  # With service groups
  npx arm-lease-generate-lease-files --orgName compute --rpNamespace Microsoft.Compute --serviceName "DiskRP,ComputeRP" --reviewer "@johndoe"

  # From file
  npx arm-lease-fetch-resource-providers --output rps.txt
  npx arm-lease-generate-lease-files --input rps.txt --reviewer "@johndoe"

  # Interactive mode
  npx arm-lease-generate-lease-files --interactive`);
}

// Only run CLI if this file is executed directly (not imported)
if (process.argv[1] === __filename) {
  const {
    values: {
      orgName: orgNameArg,
      rpNamespace: rpNamespaceArg,
      serviceName: serviceNameArg,
      reviewer: reviewerArg,
      startdate: startdateArg,
      duration: durationArg,
      input: inputArg,
      "repo-root": repoRootArg,
      "dry-run": dryRun,
      interactive,
      help,
    },
  } = parseArgs({
    options: {
      orgName: { type: "string", default: "" },
      rpNamespace: { type: "string", default: "" },
      serviceName: { type: "string", default: "" },
      reviewer: { type: "string", default: "" },
      startdate: { type: "string", default: "" },
      duration: { type: "string", default: DEFAULT_DURATION },
      input: { type: "string", default: "" },
      "repo-root": { type: "string", default: "" },
      "dry-run": { type: "boolean", default: false },
      interactive: { type: "boolean", short: "i", default: false },
      help: { type: "boolean", default: false },
    },
    allowPositionals: false,
  });

  if (help) {
    usage();
    process.exit(0);
  }

  async function main() {
    try {
      const repoRoot = repoRootArg
        ? resolve(repoRootArg)
        : findRepoRoot(resolve(__dirname, "../../../"));
      /** @type {Array<{orgName: string, rpNamespace: string, serviceNames: string[]}>} */
      let entries = [];
      let reviewer = reviewerArg;
      let startdate = startdateArg || getTodayDate();
      let duration = durationArg;

      if (interactive) {
        const result = await promptInteractive();
        reviewer = result.reviewer;
        startdate = result.startdate;
        duration = result.duration;
        entries = result.entries;

        if (entries.length === 0) {
          console.error("Error: No entries provided");
          process.exit(1);
        }
      } else if (inputArg) {
        if (!reviewer) {
          console.error("Error: --reviewer is required");
          usage();
          process.exit(1);
        }

        if (!existsSync(inputArg)) {
          throw new Error(`Input file not found: ${inputArg}`);
        }

        const content = readFileSync(inputArg, "utf-8");
        for (const line of content.split("\n")) {
          const entry = parseInputLine(line);
          if (entry) entries.push(entry);
        }

        if (entries.length === 0) {
          console.warn("Warning: No valid entries found in input file");
          process.exit(0);
        }
      } else if (orgNameArg && rpNamespaceArg) {
        if (!reviewer) {
          console.error("Error: --reviewer is required");
          usage();
          process.exit(1);
        }

        entries.push({
          orgName: orgNameArg,
          rpNamespace: rpNamespaceArg,
          serviceNames: serviceNameArg
            ? serviceNameArg
                .split(",")
                .map((s) => s.trim())
                .filter(Boolean)
            : [],
        });
      } else {
        console.error(
          "Error: Either --input, --interactive, or both --orgName and --rpNamespace are required",
        );
        usage();
        process.exit(1);
      }

      // Validate inputs
      reviewer = validateReviewer(reviewer);
      startdate = validateStartDate(startdate);
      duration = validateDuration(duration);

      console.log(`Repository root: ${repoRoot}`);
      console.log(`Reviewer: ${reviewer}`);
      console.log(`Start date: ${startdate}`);
      console.log(`Duration: ${duration}\n`);

      for (const entry of entries) {
        processEntry(entry, { startdate, duration, reviewer, dryRun }, repoRoot);
      }

      console.log(`\nProcessed ${entries.length} entries`);
    } catch (error) {
      console.error(`Error: ${/** @type {Error} */ (error).message}`);
      process.exit(1);
    }
  }

  void main();
}
