import { access, readFile, rm, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { basename, dirname, join } from "path";
import { z } from "zod";
import { getChangedFiles } from "../../../shared/src/changed-files.js";
import { execFile, execNpmExec } from "../../../shared/src/exec.js";
import { loadFormatRules, validateNamespaceFormat } from "./validate-format.js";

const TypeSpecMetadataSchema = z.object({
  typespec: z
    .object({
      type: z.enum(["management", "data"]).optional(),
    })
    .optional(),
  languages: z
    .record(
      z.string(),
      z.array(
        z.object({
          namespace: z.string().optional(),
          packageName: z.string().optional(),
        }),
      ),
    )
    .optional(),
});

/** @typedef {{ namespace?: string, packageName?: string }} TypeSpecMetadataEntry */
/** @typedef {Record<string, TypeSpecMetadataEntry[]>} TypeSpecLanguages */

/** @type {Record<string, string>} */
const EMITTER_TO_LANG = {
  csharp: "dotnet",
  "http-client-csharp": "dotnet",
  "http-client-csharp-mgmt": "dotnet",
  java: "java",
  python: "python",
  typescript: "typescript",
  go: "go",
};

/**
 * @param {string} path
 * @returns {Promise<boolean>}
 */
async function exists(path) {
  try {
    await access(path);
    return true;
  } catch {
    return false;
  }
}

/**
 * Sparse checkout only materializes .github/, so hydrate changed TypeSpec directories on demand.
 *
 * @param {string} file
 * @param {import("@actions/core")} core
 */
async function ensureTypeSpecFilesAvailable(file, core) {
  if (await exists(file)) {
    return;
  }

  const tspDir = dirname(file);
  const workspace = process.env.GITHUB_WORKSPACE ?? process.cwd();
  core.info(`Hydrating ${tspDir} from git for namespace detection`);
  await execFile("git", ["checkout", "HEAD", "--", tspDir], {
    cwd: workspace,
  });
}

/**
 * Extract namespaces from tspconfig.yaml using typespec-metadata emitter.
 *
 * @param {string} file - Path to tspconfig.yaml
 * @param {Record<string, string>} namespacesFound - Map of language to namespace (mutated)
 * @param {import("@actions/core")} core
 * @returns {Promise<{ isMgmt: boolean, isDataPlane: boolean }>}
 */
async function extractNamespaces(file, namespacesFound, core) {
  let isMgmt = false;
  let isDataPlane = false;

  await ensureTypeSpecFilesAvailable(file, core);
  if (!(await exists(file))) {
    core.info(`Skipping missing file: ${file}`);
    return { isMgmt, isDataPlane };
  }

  const tspDir = dirname(file);

  if (file.includes(".Management/") || file.includes("/resource-manager/")) {
    isMgmt = true;
  } else {
    isDataPlane = true;
  }

  const outputDir = join(
    process.env.RUNNER_TEMP || tmpdir(),
    "typespec-metadata",
    basename(tspDir),
  );
  await rm(outputDir, { recursive: true, force: true });

  core.info(`Running typespec-metadata emitter on ${tspDir}`);
  await execNpmExec(
    [
      "tsp",
      "compile",
      tspDir,
      "--emit",
      "@azure-tools/typespec-metadata",
      "--output-dir",
      outputDir,
      "--option",
      "@azure-tools/typespec-metadata.format=json",
    ],
    {
      cwd: process.env.GITHUB_WORKSPACE ?? process.cwd(),
    },
  );

  const metadataPath = join(
    outputDir,
    "@azure-tools",
    "typespec-metadata",
    "typespec-metadata.json",
  );
  const metadata = TypeSpecMetadataSchema.parse(JSON.parse(await readFile(metadataPath, "utf8")));

  if (metadata.typespec?.type === "management") {
    isMgmt = true;
  }
  if (metadata.typespec?.type === "data") {
    isDataPlane = true;
  }

  const languages = /** @type {TypeSpecLanguages} */ (metadata.languages ?? {});
  for (const [langKey, entries] of Object.entries(languages)) {
    const lang = EMITTER_TO_LANG[langKey] ?? langKey;
    const firstEntry = entries[0];
    const namespace = firstEntry?.namespace ?? firstEntry?.packageName;
    if (namespace) {
      namespacesFound[lang] = namespace;
    }
  }

  await rm(outputDir, { recursive: true, force: true });
  return { isMgmt, isDataPlane };
}

/**
 * Detect namespace changes in a PR and write results to an artifact file.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function detectNamespaces({ context, core }) {
  try {
    const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
      context.payload
    );

    const changedFiles = (
      await getChangedFiles({
        cwd: process.env.GITHUB_WORKSPACE ?? process.cwd(),
        paths: ["specification"],
      })
    ).filter((file) => /specification\/.*\/tspconfig\.yaml$/.test(file));

    if (changedFiles.length === 0) {
      core.info("No tspconfig.yaml changes detected, skipping");
      return;
    }

    core.info(`Found tspconfig.yaml changes: ${changedFiles.join(", ")}`);

    /** @type {Record<string, string>} */
    const namespacesFound = {};
    let isMgmt = false;
    let isDataPlane = false;

    for (const file of changedFiles) {
      const result = await extractNamespaces(file, namespacesFound, core);
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
    if (formatRules) {
      for (const [language, namespace] of Object.entries(namespacesFound)) {
        formatResults[language] = validateNamespaceFormat(language, namespace, formatRules);
      }
    }

    const results = {
      namespacesFound,
      isMgmt,
      isDataPlane,
      formatResults,
      prNumber: payload.pull_request.number,
      action: payload.action,
    };
    const resultsPath = join(process.env.RUNNER_TEMP || ".", "namespace-results.json");
    await writeFile(resultsPath, JSON.stringify(results, null, 2));
    core.setOutput("results", "true");
    core.setOutput("results_path", resultsPath);
  } catch (error) {
    core.setFailed(`Namespace detection failed: ${String(error)}`);
  }
}
