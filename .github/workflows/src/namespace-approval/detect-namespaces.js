import { readFile, writeFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";
import { getChangedFiles, tspconfig } from "../../../shared/src/changed-files.js";
import { loadFormatRules, validateNamespaceFormat } from "./validate-format.js";

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

  // Linter extends is the most reliable plane indicator — override path-based guess
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

  const changedFiles = (
    await getChangedFiles({
      cwd: process.env.GITHUB_WORKSPACE ?? process.cwd(),
      paths: ["specification"],
    })
  ).filter((file) => tspconfig(file));

  if (changedFiles.length === 0) {
    core.info("No tspconfig.yaml changes detected, skipping");
    return;
  }

  core.info(`Found tspconfig.yaml changes: ${changedFiles.join(", ")}`);

  /** @type {Record<string, string>} */
  const namespacesFound = {};
  /** @type {Record<string, string>} */
  const artifactNames = {};
  let isMgmt = false;
  let isDataPlane = false;

  for (const file of changedFiles) {
    const result = await extractNamespaces(file, namespacesFound, artifactNames, core);
    if (result.isMgmt) {
      isMgmt = true;
    }
    if (result.isDataPlane) {
      isDataPlane = true;
    }
  }

  const formatRules = loadFormatRules(core);
  /** @type {Record<string, import("./validate-format.js").FormatValidationResult>} */
  const formatResults = {};
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
