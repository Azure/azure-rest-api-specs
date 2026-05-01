// Fetch Azure resource providers with or without service names (service groups)
// Usage: node arm-lease-fetch-resource-providers.js [--with-service-groups] [--format list|json|table] [--count] [--output FILE]

import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

export function isServiceNameDirectory(dirPath) {
  const excludeNames = new Set([
    "stable",
    "preview",
    "common-types",
    "examples",
  ]);
  try {
    return (
      !excludeNames.has(path.basename(dirPath)) &&
      fs.statSync(dirPath).isDirectory()
    );
  } catch {
    return false;
  }
}

export function hasVersionDirectories(rpPath) {
  return (
    fs.existsSync(path.join(rpPath, "stable")) ||
    fs.existsSync(path.join(rpPath, "preview"))
  );
}

export function findRepoRoot(startPath = process.cwd()) {
  let current = path.resolve(startPath);
  for (let i = 0; i < 10; i++) {
    if (fs.existsSync(path.join(current, "specification"))) return current;
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  throw new Error(
    "Could not find repository root. Run from within azure-rest-api-specs.",
  );
}

export function findResourceProviders(repoRoot, withServiceNames = false) {
  const results = [];
  const specDir = path.join(repoRoot, "specification");
  if (!fs.existsSync(specDir))
    throw new Error(`Specification directory not found: ${specDir}`);

  for (const orgName of fs.readdirSync(specDir)) {
    const orgDir = path.join(specDir, orgName);
    if (!fs.statSync(orgDir).isDirectory()) continue;

    const rmDir = path.join(orgDir, "resource-manager");
    if (!fs.existsSync(rmDir)) continue;

    for (const rpNamespace of fs.readdirSync(rmDir)) {
      const rpPath = path.join(rmDir, rpNamespace);
      if (
        !fs.statSync(rpPath).isDirectory() ||
        !rpNamespace.startsWith("Microsoft.")
      )
        continue;

      const serviceNames = fs
        .readdirSync(rpPath)
        .filter((sn) => isServiceNameDirectory(path.join(rpPath, sn)))
        .sort();

      if (withServiceNames && serviceNames.length > 0) {
        results.push({
          rpNamespace: rpNamespace,
          path: path.relative(repoRoot, rpPath),
          orgName: orgName,
          serviceNames: serviceNames,
        });
      } else if (
        !withServiceNames &&
        serviceNames.length === 0 &&
        hasVersionDirectories(rpPath)
      ) {
        results.push({
          rpNamespace: rpNamespace,
          path: path.relative(repoRoot, rpPath),
          orgName: orgName,
        });
      }
    }
  }
  return results.sort((a, b) => a.rpNamespace.localeCompare(b.rpNamespace));
}

export function formatOutput(rps, format, withSN) {
  if (format === "json") return JSON.stringify(rps, null, 2);
  if (rps.length === 0)
    return `No resource providers ${withSN ? "with" : "without"} serviceNames found.`;

  if (format === "table") {
    const maxOrg = Math.max(...rps.map((r) => r.orgName.length));
    const maxRp = Math.max(...rps.map((r) => r.rpNamespace.length));
    const header = withSN
      ? `${"orgName".padEnd(maxOrg)}  ${"rpNamespace".padEnd(maxRp)}  serviceNames`
      : `${"orgName".padEnd(maxOrg)}  ${"rpNamespace".padEnd(maxRp)}  Path`;
    const sep = `${"-".repeat(maxOrg)}  ${"-".repeat(maxRp)}  ${"-".repeat(60)}`;
    const rows = withSN
      ? rps.map(
          (r) =>
            `${r.orgName.padEnd(maxOrg)}  ${r.rpNamespace.padEnd(maxRp)}  ${r.serviceNames.join(", ")}`,
        )
      : rps.map(
          (r) =>
            `${r.orgName.padEnd(maxOrg)}  ${r.rpNamespace.padEnd(maxRp)}  ${r.path}`,
        );
    return [header, sep, ...rows].join("\n");
  }

  return withSN
    ? rps
        .map(
          (r) =>
            `${r.orgName}, ${r.rpNamespace}, [${r.serviceNames.join(", ")}]`,
        )
        .join("\n")
    : rps.map((r) => `${r.orgName}, ${r.rpNamespace}`).join("\n");
}

function printHelp() {
  console.log(`
Fetch Azure resource providers with or without service names (service groups)

Usage:
  node arm-lease-fetch-resource-providers.js [options]

Options:
  --with-service-groups      Include only RPs with serviceNames (service groups)
  --format list|json|table   Output format (default: list)
  --count                    Output only the count
  --output FILE              Write output to file instead of stdout
  --repo-root PATH           Local repo root path (auto-detected if not provided)
  --help, -h                 Show this help message

Examples:
  # RPs without service names
  node arm-lease-fetch-resource-providers.js

  # RPs with service names
  node arm-lease-fetch-resource-providers.js --with-service-groups

  # Output to file
  node arm-lease-fetch-resource-providers.js --output rps.txt

  # JSON format
  node arm-lease-fetch-resource-providers.js --format json
`);
}

function main() {
  const args = {
    repoRoot: null,
    format: "list",
    count: false,
    withSN: false,
    output: null,
  };

  for (let i = 2; i < process.argv.length; i++) {
    const arg = process.argv[i];
    if (arg === "--help" || arg === "-h") {
      printHelp();
      return 0;
    }
    if (arg === "--repo-root") args.repoRoot = process.argv[++i];
    else if (arg === "--format") args.format = process.argv[++i];
    else if (arg === "--output" || arg === "-o")
      args.output = process.argv[++i];
    else if (arg === "--count") args.count = true;
    else if (arg === "--with-service-groups") args.withSN = true;
  }

  try {
    const repoRoot = args.repoRoot
      ? path.resolve(args.repoRoot)
      : findRepoRoot();
    const rps = findResourceProviders(repoRoot, args.withSN);

    let outputText;
    if (args.count) {
      outputText = String(rps.length);
    } else {
      outputText = formatOutput(rps, args.format, args.withSN);
      if (args.format !== "json") {
        outputText += `\n\nTotal: ${rps.length} resource provider(s) ${args.withSN ? "with" : "without"} serviceNames`;
      }
    }

    if (args.output) {
      fs.writeFileSync(args.output, outputText + "\n");
      console.log(`Output written to ${args.output}`);
    } else {
      console.log(outputText);
    }
    return 0;
  } catch (error) {
    console.error(`Error: ${error.message}`);
    return 1;
  }
}

// Check if this module is being run directly
const __filename = fileURLToPath(import.meta.url);
if (process.argv[1] === __filename) {
  process.exit(main());
}
