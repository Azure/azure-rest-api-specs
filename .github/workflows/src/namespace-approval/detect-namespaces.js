import { execFile as execFileCb } from "child_process";
import { existsSync } from "fs";
import { readFile, writeFile } from "fs/promises";
import { dirname, join } from "path";
import { promisify } from "util";
import { getChangedFilesStatuses, tspconfig } from "../../../shared/src/changed-files.js";
import { loadFormatRules, validateAllNamespaces } from "./validate-format.js";

const execFileAsync = promisify(execFileCb);

// ---------------------------------------------------------------------------
// Metadata emitter language key mapping
// ---------------------------------------------------------------------------

/**
 * Map typespec-metadata language keys to our normalized language keys.
 * The emitter uses "csharp" but our labels use "dotnet".
 * @type {Record<string, string>}
 */
const METADATA_LANG_MAP = {
  csharp: "dotnet",
  "http-client-csharp": "dotnet",
  "http-client-csharp-mgmt": "dotnet",
  java: "java",
  python: "python",
  typescript: "typescript",
  go: "go",
  rust: "rust",
};

// ---------------------------------------------------------------------------
// tsp compile with typespec-metadata emitter
// ---------------------------------------------------------------------------

/**
 * @typedef {Object} LanguageMetadata
 * @property {string} emitterName
 * @property {string} packageName
 * @property {string} [namespace]
 * @property {string} [outputDir]
 * @property {string} [flavor]
 * @property {string} [serviceDir]
 */

/**
 * @typedef {Object} TypeSpecMetadata
 * @property {string} emitterVersion
 * @property {string} generatedAt
 * @property {{ namespace: string, documentation?: string, type: "data" | "management" }} typespec
 * @property {Record<string, LanguageMetadata[]>} languages
 * @property {string} sourceConfigPath
 */

/**
 * @typedef {Object} EmitterResult
 * @property {Record<string, string>} packageNames - Map of normalized language to package name
 * @property {Record<string, string>} namespaces - Map of normalized language to namespace
 * @property {boolean} isMgmt
 * @property {boolean} isDataPlane
 */

/**
 * Run `tsp compile` with the `@azure-tools/typespec-metadata` emitter to extract
 * package names and namespaces for all configured languages.
 *
 * @param {string} tspConfigDir - Absolute path to the directory containing tspconfig.yaml
 * @param {import("@actions/core")} core
 * @returns {Promise<EmitterResult>}
 */
async function runMetadataEmitter(tspConfigDir, core) {
  /** @type {Record<string, string>} */
  const packageNames = {};
  /** @type {Record<string, string>} */
  const namespaces = {};

  const metadataOutputDir = join(tspConfigDir, "@azure-tools", "typespec-metadata");
  const jsonPath = join(metadataOutputDir, "typespec-metadata.json");

  const tspArgs = [
    "tsp",
    "compile",
    tspConfigDir,
    "--emit",
    "@azure-tools/typespec-metadata",
    "--output-dir",
    tspConfigDir,
    "--option",
    "@azure-tools/typespec-metadata.format=json",
  ];

  core.info(`Running: npx ${tspArgs.join(" ")}`);

  const { stderr } = await execFileAsync("npx", tspArgs, {
    cwd: tspConfigDir,
    timeout: 120_000,
  });

  if (stderr) {
    core.warning(`typespec-metadata emitter warnings: ${stderr}`);
  }

  if (!existsSync(jsonPath)) {
    throw new Error(`typespec-metadata output not found at ${jsonPath}`);
  }

  const raw = await readFile(jsonPath, "utf8");
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  const metadata = /** @type {TypeSpecMetadata} */ (/** @type {unknown} */ (JSON.parse(raw)));

  for (const [langKey, entries] of Object.entries(metadata.languages)) {
    const normalizedLang = METADATA_LANG_MAP[langKey] || langKey;
    if (!entries || entries.length === 0) continue;

    const entry = entries[0];
    if (entry.packageName) packageNames[normalizedLang] = entry.packageName;
    if (entry.namespace) namespaces[normalizedLang] = entry.namespace;
  }

  const isMgmt = metadata.typespec?.type === "management";
  const isDataPlane = metadata.typespec?.type === "data";

  return { packageNames, namespaces, isMgmt, isDataPlane };
}

// ---------------------------------------------------------------------------
// Base branch compilation
// ---------------------------------------------------------------------------

/**
 * Compile the base branch version of a tspconfig to get its package names.
 * Uses the base-ref checkout (separate directory) to avoid modifying the PR head.
 *
 * @param {string} file - Relative path to tspconfig.yaml from repo root
 * @param {string} baseRefDir - Absolute path to the base branch checkout directory
 * @param {import("@actions/core")} core
 * @returns {Promise<EmitterResult | null>} Null if base version doesn't exist or compile fails
 */
async function compileBaseVersion(file, baseRefDir, core) {
  const baseTspConfigPath = join(baseRefDir, file);
  if (!existsSync(baseTspConfigPath)) {
    core.info(`File does not exist on base branch: ${file}`);
    return null;
  }

  const baseTspConfigDir = dirname(baseTspConfigPath);
  try {
    core.info(`Compiling base branch version: ${file}`);
    return await runMetadataEmitter(baseTspConfigDir, core);
  } catch (e) {
    core.warning(
      `Failed to compile base version of ${file}: ${/** @type {Error} */ (e).message}, treating as new`,
    );
    return null;
  }
}

/**
 * Compare PR package names against base branch package names and return only changed entries.
 *
 * @param {Record<string, string>} prPackageNames - Package names from PR head
 * @param {Record<string, string>} prNamespaces - Namespaces from PR head
 * @param {EmitterResult | null} baseResult - Emitter result from base branch (null = all new)
 * @param {import("@actions/core")} core
 * @returns {{ packageNames: Record<string, string>, namespaces: Record<string, string> }}
 */
function filterUnchanged(prPackageNames, prNamespaces, baseResult, core) {
  if (!baseResult) {
    return { packageNames: { ...prPackageNames }, namespaces: { ...prNamespaces } };
  }

  /** @type {Record<string, string>} */
  const changedPackageNames = {};
  /** @type {Record<string, string>} */
  const changedNamespaces = {};

  for (const [lang, prPkg] of Object.entries(prPackageNames)) {
    const basePkg = baseResult.packageNames[lang];
    if (basePkg === prPkg) {
      core.info(`Package name unchanged for ${lang}: "${prPkg}", skipping`);
    } else {
      changedPackageNames[lang] = prPkg;
      if (prNamespaces[lang]) changedNamespaces[lang] = prNamespaces[lang];
    }
  }

  return { packageNames: changedPackageNames, namespaces: changedNamespaces };
}

// ---------------------------------------------------------------------------
// Main detection logic
// ---------------------------------------------------------------------------

/**
 * Detect package name changes in a PR and write results to an artifact file.
 * Compiles both PR head and base branch using tsp compile with the typespec-metadata
 * emitter to reliably extract package names, then reports only changed entries.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function detectNamespaces({ context, core }) {
  const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
    context.payload
  );

  const cwd = process.env.GITHUB_WORKSPACE ?? process.cwd();
  const baseRefDir = process.env.BASE_REF_DIR ?? join(cwd, "..", "base-ref");
  const statuses = await getChangedFilesStatuses({ cwd, paths: ["specification"] });

  /** @type {{ file: string, basePath: string | null }[]} */
  const changedTspconfigs = [];
  for (const file of statuses.additions.filter(tspconfig)) {
    changedTspconfigs.push({ file, basePath: null });
  }
  for (const file of statuses.modifications.filter(tspconfig)) {
    changedTspconfigs.push({ file, basePath: file });
  }
  for (const rename of statuses.renames) {
    if (tspconfig(rename.to)) {
      changedTspconfigs.push({ file: rename.to, basePath: rename.from });
    }
  }

  if (changedTspconfigs.length === 0) {
    core.info("No tspconfig.yaml changes detected, skipping");
    return;
  }

  core.info(`Found tspconfig.yaml changes: ${changedTspconfigs.map((c) => c.file).join(", ")}`);

  /** @type {Record<string, string>} */
  const packageNamesFound = {};
  /** @type {Record<string, string>} */
  const namespacesFound = {};
  let isMgmt = false;
  let isDataPlane = false;

  for (const { file, basePath } of changedTspconfigs) {
    const tspConfigDir = dirname(join(cwd, file));
    core.info(`Running typespec-metadata emitter for: ${file}`);

    const prResult = await runMetadataEmitter(tspConfigDir, core);
    if (prResult.isMgmt) isMgmt = true;
    if (prResult.isDataPlane) isDataPlane = true;

    // Compile base branch version for comparison (uses same emitter mechanism)
    const baseResult = basePath ? await compileBaseVersion(basePath, baseRefDir, core) : null;

    // Only keep package names that actually changed from the base branch
    const { packageNames, namespaces } = filterUnchanged(
      prResult.packageNames,
      prResult.namespaces,
      baseResult,
      core,
    );

    Object.assign(packageNamesFound, packageNames);
    Object.assign(namespacesFound, namespaces);
  }

  if (Object.keys(packageNamesFound).length === 0) {
    core.info("No package name changes detected after comparing with base branch");
    return;
  }

  // Validate package name formats against naming convention rules.
  // Format validation only applies to management-plane package names. Data-plane package names
  // follow language-specific conventions that vary too widely for regex-based rules.
  const formatRules = await loadFormatRules(core);
  /** @type {import("./validate-format.js").FormatValidationResult[]} */
  let formatResults = [];
  if (formatRules && isMgmt) {
    formatResults = validateAllNamespaces(packageNamesFound, formatRules);
    for (const r of formatResults) {
      if (!r.valid) {
        core.warning(`Format validation failed for ${r.language}: ${r.error}`);
      }
    }
  }

  const results = {
    namespacesFound: packageNamesFound,
    namespaces: namespacesFound,
    formatResults,
    isMgmt,
    isDataPlane,
    prNumber: payload.pull_request.number,
    action: payload.action,
  };

  const runnerTemp = process.env.RUNNER_TEMP;
  if (!runnerTemp) {
    throw new Error("RUNNER_TEMP environment variable is required");
  }
  const resultsPath = join(runnerTemp, "package-name-results.json");
  await writeFile(resultsPath, JSON.stringify(results, null, 2));
  core.setOutput("results", "true");
  core.setOutput("results_path", resultsPath);
}
