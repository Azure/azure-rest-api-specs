import { existsSync, readdirSync, statSync, writeFileSync } from "fs";
import { basename, dirname, join, relative, resolve } from "path";
import { fileURLToPath } from "url";
import { parseArgs } from "util";

/**
 * Check if a directory is a service name directory (not stable, preview, common-types, or examples)
 * @param {string} dirPath - Path to the directory
 * @returns {boolean} True if it's a valid service name directory
 */
export function isServiceNameDirectory(dirPath) {
  const excludeNames = new Set(["stable", "preview", "common-types", "examples"]);
  try {
    return !excludeNames.has(basename(dirPath)) && statSync(dirPath).isDirectory();
  } catch {
    return false;
  }
}

/**
 * Check if a resource provider path has version directories (stable or preview)
 * @param {string} rpPath - Path to the resource provider
 * @returns {boolean} True if it has version directories
 */
export function hasVersionDirectories(rpPath) {
  return existsSync(join(rpPath, "stable")) || existsSync(join(rpPath, "preview"));
}

/**
 * Check if a directory looks like the repository root
 * @param {string} dir - Directory to check
 * @returns {boolean} True if it looks like repo root
 */
function looksLikeRepoRoot(dir) {
  return (
    existsSync(join(dir, ".git")) ||
    existsSync(join(dir, "specification")) ||
    existsSync(join(dir, ".github"))
  );
}

/**
 * Find the repository root by looking for repo markers (.git, specification, .github)
 * Supports sparse checkouts in CI by checking GITHUB_WORKSPACE first
 * @param {string} [startPath] - Starting path to search from
 * @returns {string} The repository root path
 * @throws {Error} If repository root cannot be found
 */
export function findRepoRoot(startPath = process.cwd()) {
  const workspace = process.env.GITHUB_WORKSPACE;
  if (workspace && looksLikeRepoRoot(workspace)) {
    return workspace;
  }

  let current = resolve(startPath);
  for (let i = 0; i < 20; i++) {
    if (looksLikeRepoRoot(current)) return current;
    const parent = dirname(current);
    if (parent === current) break;
    current = parent;
  }
  throw new Error("Could not find repository root. Run from within azure-rest-api-specs.");
}

/**
 * @typedef {Object} ResourceProvider
 * @property {string} rpNamespace - Resource provider namespace (e.g., Microsoft.Storage)
 * @property {string} path - Relative path to the resource provider
 * @property {string} orgName - Organization name from specification folder
 * @property {string[]} [serviceNames] - Service names if withServiceNames is true
 */

/**
 * Find all resource providers in the specification directory
 * @param {string} repoRoot - Repository root path
 * @param {boolean} [withServiceNames=false] - Whether to include only RPs with service names
 * @returns {ResourceProvider[]} Array of resource provider objects
 */
export function findResourceProviders(repoRoot, withServiceNames = false) {
  const results = [];
  const specDir = join(repoRoot, "specification");
  if (!existsSync(specDir)) {
    // In sparse checkouts (CI), specification/ may not exist. Return empty list.
    return [];
  }

  for (const orgName of readdirSync(specDir)) {
    const orgDir = join(specDir, orgName);
    if (!statSync(orgDir).isDirectory()) continue;

    const rmDir = join(orgDir, "resource-manager");
    if (!existsSync(rmDir)) continue;

    for (const rpNamespace of readdirSync(rmDir)) {
      const rpPath = join(rmDir, rpNamespace);
      if (!statSync(rpPath).isDirectory() || !rpNamespace.startsWith("Microsoft.")) {
        continue;
      }

      const serviceNames = readdirSync(rpPath)
        .filter((sn) => isServiceNameDirectory(join(rpPath, sn)))
        .sort();

      if (withServiceNames && serviceNames.length > 0) {
        results.push({
          rpNamespace: rpNamespace,
          path: relative(repoRoot, rpPath),
          orgName: orgName,
          serviceNames: serviceNames,
        });
      } else if (!withServiceNames && serviceNames.length === 0 && hasVersionDirectories(rpPath)) {
        results.push({
          rpNamespace: rpNamespace,
          path: relative(repoRoot, rpPath),
          orgName: orgName,
        });
      }
    }
  }
  return results.sort((a, b) => a.rpNamespace.localeCompare(b.rpNamespace));
}

/**
 * Format resource providers for output
 * @param {ResourceProvider[]} rps - Array of resource providers
 * @param {"list"|"json"|"table"} fmt - Output format
 * @param {boolean} withSN - Whether resource providers have service names
 * @returns {string} Formatted output string
 */
export function formatOutput(rps, fmt, withSN) {
  if (fmt === "json") return JSON.stringify(rps, null, 2);
  if (rps.length === 0) {
    return `No resource providers ${withSN ? "with" : "without"} serviceNames found.`;
  }

  if (fmt === "table") {
    const maxOrg = Math.max(...rps.map((r) => r.orgName.length));
    const maxRp = Math.max(...rps.map((r) => r.rpNamespace.length));
    const header = withSN
      ? `${"orgName".padEnd(maxOrg)}  ${"rpNamespace".padEnd(maxRp)}  serviceNames`
      : `${"orgName".padEnd(maxOrg)}  ${"rpNamespace".padEnd(maxRp)}  Path`;
    const sep = `${"-".repeat(maxOrg)}  ${"-".repeat(maxRp)}  ${"-".repeat(60)}`;
    const rows = withSN
      ? rps.map(
          (r) =>
            `${r.orgName.padEnd(maxOrg)}  ${r.rpNamespace.padEnd(maxRp)}  ${/** @type {string[]} */ (r.serviceNames).join(", ")}`,
        )
      : rps.map((r) => `${r.orgName.padEnd(maxOrg)}  ${r.rpNamespace.padEnd(maxRp)}  ${r.path}`);
    return [header, sep, ...rows].join("\n");
  }

  return withSN
    ? rps
        .map(
          (r) =>
            `${r.orgName}, ${r.rpNamespace}, [${/** @type {string[]} */ (r.serviceNames).join(", ")}]`,
        )
        .join("\n")
    : rps.map((r) => `${r.orgName}, ${r.rpNamespace}`).join("\n");
}

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function usage() {
  console.log(`Usage:
npx arm-lease-fetch-resource-providers [options]

Options:
  --with-service-groups      Include only RPs with serviceNames (service groups)
  --format <format>          Output format: list, json, table (default: list)
  --count                    Output only the count
  --output <file>            Write output to file instead of stdout
  --repo-root <path>         Repository root path (auto-detected if not provided)
  --help                     Show this help message

Examples:
  # RPs without service names
  npx arm-lease-fetch-resource-providers

  # RPs with service names
  npx arm-lease-fetch-resource-providers --with-service-groups

  # Output to file
  npx arm-lease-fetch-resource-providers --output rps.txt

  # JSON format
  npx arm-lease-fetch-resource-providers --format json`);
}

// Only run CLI if this file is executed directly (not imported)
if (process.argv[1] === __filename) {
  const {
    values: {
      "with-service-groups": withServiceGroups,
      format,
      count,
      output,
      "repo-root": repoRootArg,
      help,
    },
  } = parseArgs({
    options: {
      "with-service-groups": { type: "boolean", default: false },
      format: { type: "string", default: "list" },
      count: { type: "boolean", default: false },
      output: { type: "string", default: "" },
      "repo-root": { type: "string", default: "" },
      help: { type: "boolean", default: false },
    },
    allowPositionals: false,
  });

  if (help) {
    usage();
    process.exit(0);
  }

  try {
    const repoRoot = repoRootArg
      ? resolve(repoRootArg)
      : findRepoRoot(resolve(__dirname, "../../../"));
    const rps = findResourceProviders(repoRoot, withServiceGroups);

    let outputText;
    if (count) {
      outputText = String(rps.length);
    } else {
      outputText = formatOutput(
        rps,
        /** @type {"list"|"json"|"table"} */ (format),
        withServiceGroups,
      );
      if (format !== "json") {
        outputText += `\n\nTotal: ${rps.length} resource provider(s) ${withServiceGroups ? "with" : "without"} serviceNames`;
      }
    }

    if (output) {
      writeFileSync(output, outputText + "\n");
      console.log(`Output written to ${output}`);
    } else {
      console.log(outputText);
    }
  } catch (error) {
    console.error(`Error: ${/** @type {Error} */ (error).message}`);
    process.exit(1);
  }
}
