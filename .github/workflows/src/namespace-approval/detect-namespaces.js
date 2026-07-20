import { execFile } from "child_process";
import { readFile, writeFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";
import { getChangedFilesStatuses, tspconfig } from "../../../shared/src/changed-files.js";
import { loadFormatRules, validateNamespaceFormat } from "./validate-format.js";

/**
 * Read a file from the base branch (HEAD^) via git show.
 * Returns null if the file does not exist on the base branch.
 *
 * @param {string} file - Relative path to the file
 * @returns {Promise<string | null>}
 */
function readBaseVersion(file) {
  return new Promise((resolve) => {
    execFile("git", ["show", `HEAD^:${file}`], (err, stdout) => {
      if (err) {
        resolve(null);
      } else {
        resolve(stdout);
      }
    });
  });
}

/**
 * Extract namespace values from a parsed tspconfig object.
 * Returns a map of language → namespace (same logic as extractNamespaces but from raw config).
 *
 * @param {Record<string, Record<string, unknown>>} options - The options section of tspconfig
 * @param {Record<string, unknown>} [fullConfig] - Full tspconfig (needed for Go template resolution)
 * @returns {Record<string, string>}
 */
function extractNamespacesFromOptions(options, fullConfig) {
  /** @type {Record<string, string>} */
  const namespaces = {};
  for (const [emitterKey, emitterOpts] of Object.entries(options)) {
    const lang = resolveLanguage(emitterKey);
    if (!lang || !emitterOpts || typeof emitterOpts !== "object") {
      continue;
    }

    const ns = /** @type {string | undefined} */ (emitterOpts.namespace);
    if (ns) {
      namespaces[lang] = ns;
      continue;
    }

    const packageDetails = /** @type {Record<string, unknown> | undefined} */ (
      emitterOpts["package-details"]
    );
    if (packageDetails?.name && typeof packageDetails.name === "string") {
      namespaces[lang] = packageDetails.name;
      continue;
    }

    const module = /** @type {string | undefined} */ (emitterOpts.module);
    if (module && lang === "go" && fullConfig) {
      const expanded = resolveGoModule(module, emitterOpts, fullConfig);
      const goBase = "github.com/Azure/azure-sdk-for-go/";
      namespaces[lang] = expanded.startsWith(goBase) ? expanded.slice(goBase.length) : expanded;
      continue;
    }

    if (module) {
      namespaces[lang] = module;
      continue;
    }

    const crateName = /** @type {string | undefined} */ (emitterOpts["crate-name"]);
    if (crateName) {
      namespaces[lang] = crateName;
    }
  }
  return namespaces;
}

/**
 * Map of emitter package name suffix to normalized language key.
 * @type {Record<string, string>}
 */
const EMITTER_TO_LANG = {
  "typespec-csharp": "dotnet",
  "http-client-csharp": "dotnet",
  "http-client-csharp-mgmt": "dotnet",
  "typespec-java": "java",
  "typespec-python": "python",
  "typespec-ts": "typescript",
  "typespec-go": "go",
  "typespec-rust": "rust",
};

/**
 * Resolve the normalized language from an emitter package name.
 * e.g. "@azure-tools/typespec-java" → "java"
 *
 * @param {string} emitterKey - Full emitter package name (e.g. "@azure-tools/typespec-java")
 * @returns {string | undefined}
 */
function resolveLanguage(emitterKey) {
  for (const [suffix, lang] of Object.entries(EMITTER_TO_LANG)) {
    if (emitterKey.endsWith(`/${suffix}`) || emitterKey === suffix) {
      return lang;
    }
  }
  return undefined;
}

/**
 * Resolve template variables in a Go module path.
 * Replaces {service-dir} with the emitter-level value if present, otherwise
 * falls back to the global parameters.service-dir.default.
 *
 * @param {string} module - Raw module value (e.g. "github.com/Azure/azure-sdk-for-go/{service-dir}/armfoo")
 * @param {Record<string, unknown>} emitterOpts - The emitter options object
 * @param {Record<string, unknown>} config - The full tspconfig object
 * @returns {string} Expanded module path
 */
function resolveGoModule(module, emitterOpts, config) {
  return module.replace(
    /\{([^}]+)\}/g,
    (/** @type {string} */ match, /** @type {string} */ key) => {
      // Check emitter-level option first
      const emitterValue = emitterOpts[key];
      if (typeof emitterValue === "string") {
        return emitterValue;
      }
      // Fall back to global parameters.{varName}.default
      const parameters = /** @type {Record<string, Record<string, unknown>> | undefined} */ (
        config.parameters
      );
      const param = parameters?.[key];
      if (param && typeof param.default === "string") {
        return param.default;
      }
      // Cannot resolve - return as-is
      return match;
    },
  );
}

/**
 * Extract namespaces directly from tspconfig.yaml emitter options.
 * Parses the `options` section to find `namespace` or `package-details.name` per language emitter.
 *
 * @param {string} file - Path to tspconfig.yaml
 * @param {Record<string, string>} namespacesFound - Map of language to namespace (mutated)
 * @param {Record<string, string>} artifactNames - Map of language to artifact name (mutated)
 * @param {import("@actions/core")} core
 * @returns {Promise<{ isMgmt: boolean, isDataPlane: boolean }>}
 */
async function extractNamespaces(file, namespacesFound, artifactNames, core) {
  let isMgmt = false;
  let isDataPlane = false;

  // Step 1: Initial guess based on file path (fast, works without parsing).
  // Step 2 below overrides this with linter.extends from the parsed config,
  // which is the authoritative plane indicator.
  if (file.includes(".Management/") || file.includes("/resource-manager/")) {
    isMgmt = true;
  } else {
    isDataPlane = true;
  }

  core.info(`Parsing tspconfig.yaml for namespace info: ${file}`);
  const content = await readFile(file, "utf8");
  const config = /** @type {Record<string, unknown>} */ (yaml.load(content));

  if (!config || typeof config !== "object") {
    core.warning(`Could not parse tspconfig.yaml: ${file}`);
    return { isMgmt, isDataPlane };
  }

  // Step 2: Linter extends is the authoritative plane indicator — overrides path-based guess
  const linter = /** @type {Record<string, unknown> | undefined} */ (config.linter);
  if (linter) {
    const linterExtends = /** @type {string[] | undefined} */ (linter.extends);
    if (linterExtends?.some((e) => e.includes("resource-manager"))) {
      isMgmt = true;
      isDataPlane = false;
    } else if (linterExtends?.some((e) => e.includes("data-plane"))) {
      isDataPlane = true;
      isMgmt = false;
    }
  }

  const options = /** @type {Record<string, Record<string, unknown>> | undefined} */ (
    config.options
  );
  if (!options) {
    core.info(`No emitter options found in ${file}`);
    return { isMgmt, isDataPlane };
  }

  for (const [emitterKey, emitterOpts] of Object.entries(options)) {
    const lang = resolveLanguage(emitterKey);
    if (!lang || !emitterOpts || typeof emitterOpts !== "object") {
      continue;
    }

    // Prefer `namespace`, fall back to `package-details.name`, `module`, `crate-name`
    const ns = /** @type {string | undefined} */ (emitterOpts.namespace);
    if (ns) {
      namespacesFound[lang] = ns;
    }

    // For Java, also extract Maven artifact name from emitter-output-dir
    if (lang === "java") {
      const outputDir = /** @type {string | undefined} */ (emitterOpts["emitter-output-dir"]);
      if (outputDir) {
        // Last path segment is the artifact name, e.g. "{output-dir}/{service-dir}/azure-resourcemanager-contoso"
        const segments = outputDir.split("/");
        const artifactName = segments[segments.length - 1];
        if (artifactName && !artifactName.startsWith("{")) {
          artifactNames[lang] = artifactName;
        }
      }
    }

    if (ns) {
      continue;
    }

    const packageDetails = /** @type {Record<string, unknown> | undefined} */ (
      emitterOpts["package-details"]
    );
    if (packageDetails?.name && typeof packageDetails.name === "string") {
      namespacesFound[lang] = packageDetails.name;
      continue;
    }

    const module = /** @type {string | undefined} */ (emitterOpts.module);
    if (module && lang === "go") {
      // Go module values contain template variables like {service-dir} that need expanding.
      // Resolution order: emitter-level service-dir > global parameters.service-dir.default
      const expanded = resolveGoModule(module, emitterOpts, config);
      // Extract path after the Go SDK base URL for format validation
      const goBase = "github.com/Azure/azure-sdk-for-go/";
      if (expanded.startsWith(goBase)) {
        namespacesFound[lang] = expanded.slice(goBase.length);
      } else {
        namespacesFound[lang] = expanded;
      }
      continue;
    }

    if (module) {
      namespacesFound[lang] = module;
      continue;
    }

    const crateName = /** @type {string | undefined} */ (emitterOpts["crate-name"]);
    if (crateName) {
      namespacesFound[lang] = crateName;
    }
  }

  return { isMgmt, isDataPlane };
}

/**
 * Detect namespace changes in a PR and write results to an artifact file.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function detectNamespaces({ context, core }) {
  const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
    context.payload
  );

  const cwd = process.env.GITHUB_WORKSPACE ?? process.cwd();
  const statuses = await getChangedFilesStatuses({ cwd, paths: ["specification"] });

  // Build a list of changed tspconfig files with their base path for comparison.
  // - Additions: new files, no base path (all namespaces are new)
  // - Modifications: same path on base
  // - Renames: use the old (from) path for base comparison
  // - Deletions: skip (file removed, nothing to review)
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
  const namespacesFound = {};
  /** @type {Record<string, string>} */
  const artifactNames = {};
  let isMgmt = false;
  let isDataPlane = false;

  for (const { file } of changedTspconfigs) {
    const result = await extractNamespaces(file, namespacesFound, artifactNames, core);
    if (result.isMgmt) {
      isMgmt = true;
    }
    if (result.isDataPlane) {
      isDataPlane = true;
    }
  }

  // Compare against base branch to filter out languages with unchanged namespaces.
  // Only report languages whose namespace actually differs from the base version.
  for (const { basePath } of changedTspconfigs) {
    if (!basePath) {
      // File is new (addition) — all namespaces are genuinely new
      continue;
    }
    const baseContent = await readBaseVersion(basePath);
    if (!baseContent) {
      // Shouldn't happen for modifications, but possible for renames if git history is shallow
      continue;
    }
    try {
      const baseConfig = /** @type {Record<string, unknown> | undefined} */ (
        yaml.load(baseContent)
      );
      const baseOptions = /** @type {Record<string, Record<string, unknown>> | undefined} */ (
        baseConfig?.options
      );
      if (!baseOptions) {
        continue;
      }
      const baseNamespaces = extractNamespacesFromOptions(baseOptions, baseConfig);
      for (const [lang, ns] of Object.entries(namespacesFound)) {
        if (baseNamespaces[lang] === ns) {
          core.info(`Namespace unchanged for ${lang}: "${ns}", skipping`);
          delete namespacesFound[lang];
          delete artifactNames[lang];
        }
      }
    } catch (e) {
      core.warning(
        `Failed to parse base version of ${basePath}: ${/** @type {Error} */ (e).message}, treating as new`,
      );
    }
  }

  if (Object.keys(namespacesFound).length === 0) {
    core.info("No namespace changes detected after comparing with base branch");
    return;
  }

  const formatRules = await loadFormatRules(core);
  /** @type {Record<string, import("./validate-format.js").FormatValidationResult>} */
  const formatResults = {};
  // Format validation only applies to management-plane namespaces. Data-plane namespaces
  // follow language-specific conventions that vary too widely for regex-based rules.
  if (formatRules && isMgmt) {
    for (const [language, namespace] of Object.entries(namespacesFound)) {
      formatResults[language] = validateNamespaceFormat(language, namespace, formatRules);
    }
    for (const [language, artifact] of Object.entries(artifactNames)) {
      const key = `${language}-artifact`;
      formatResults[key] = validateNamespaceFormat(language, artifact, formatRules);
    }
  }

  const results = {
    namespacesFound,
    artifactNames,
    isMgmt,
    isDataPlane,
    formatResults,
    prNumber: payload.pull_request.number,
    action: payload.action,
  };

  const runnerTemp = process.env.RUNNER_TEMP;
  if (!runnerTemp) {
    throw new Error("RUNNER_TEMP environment variable is required");
  }
  const resultsPath = join(runnerTemp, "namespace-results.json");
  await writeFile(resultsPath, JSON.stringify(results, null, 2));
  core.setOutput("results", "true");
  core.setOutput("results_path", resultsPath);
}
