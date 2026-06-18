import { execSync } from "child_process";
import { existsSync, readFileSync, rmSync } from "fs";
import yaml from "js-yaml";
import { dirname, join } from "path";

/**
 * @typedef {Object} ApproversConfig
 * @property {Record<string, string[]>} [data-plane]
 * @property {{ all?: string[] }} [management-plane]
 */

/**
 * @typedef {Object} TypeSpecMetadataEntry
 * @property {string} [namespace]
 * @property {string} [packageName]
 */

/**
 * @typedef {Object} TypeSpecMetadata
 * @property {{ type?: string }} [typespec]
 * @property {Record<string, TypeSpecMetadataEntry[]>} [languages]
 */

/**
 * @typedef {Object} TspConfigEmitterOptions
 * @property {string} [namespace]
 * @property {{ name?: string }} [package-details]
 * @property {string} [module]
 */

/**
 * @typedef {Object} TspConfig
 * @property {Record<string, TspConfigEmitterOptions>} [options]
 */

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

/** @type {Record<string, string>} */
const FALLBACK_EMITTER_MAP = {
  "@azure-typespec/http-client-csharp": "dotnet",
  "@azure-typespec/http-client-csharp-mgmt": "dotnet",
  "@azure-tools/typespec-csharp": "dotnet",
  "@azure-tools/typespec-java": "java",
  "@azure-tools/typespec-python": "python",
  "@azure-tools/typespec-ts": "typescript",
  "@azure-tools/typespec-go": "go",
};

/**
 * Load approvers configuration from YAML file.
 *
 * @param {import("@actions/core")} core
 * @returns {ApproversConfig | null}
 */
function loadApproversConfig(core) {
  try {
    const content = readFileSync(".github/namespace-approvers.yml", "utf8");
    return /** @type {ApproversConfig} */ (yaml.load(content));
  } catch (e) {
    core.setFailed("Failed to load .github/namespace-approvers.yml: " + String(e));
    return null;
  }
}

/**
 * Extract namespaces from tspconfig.yaml using typespec-metadata emitter with YAML fallback.
 *
 * @param {string} file - Path to tspconfig.yaml
 * @param {Record<string, string>} namespacesFound - Map of language to namespace (mutated)
 * @param {import("@actions/core")} core
 * @returns {{ isMgmt: boolean, isDataPlane: boolean }}
 */
function extractNamespaces(file, namespacesFound, core) {
  let isMgmt = false;
  let isDataPlane = false;

  if (!existsSync(file)) return { isMgmt, isDataPlane };

  const tspDir = dirname(file);

  if (file.includes(".Management/") || file.includes("/resource-manager/")) {
    isMgmt = true;
  } else {
    isDataPlane = true;
  }

  // Try typespec-metadata emitter first
  try {
    core.info(`Running typespec-metadata emitter on ${tspDir}`);
    execSync(
      `npx tsp compile "${tspDir}" --emit "@azure-tools/typespec-metadata" --output-dir "${tspDir}" --option "@azure-tools/typespec-metadata.format=json"`,
      { stdio: "pipe", timeout: 120000 },
    );

    const metadataPath = join(
      tspDir,
      "@azure-tools",
      "typespec-metadata",
      "typespec-metadata.json",
    );
    if (!existsSync(metadataPath)) throw new Error("metadata file not found");

    const metadataRaw = /** @type {unknown} */ (JSON.parse(readFileSync(metadataPath, "utf8")));
    const metadata = /** @type {TypeSpecMetadata} */ (metadataRaw);

    if (metadata.typespec?.type === "management") isMgmt = true;
    if (metadata.typespec?.type === "data") isDataPlane = true;

    const languages = metadata.languages ?? {};
    for (const [langKey, entries] of Object.entries(languages)) {
      const lang = EMITTER_TO_LANG[langKey] ?? langKey;
      if (entries.length > 0) {
        const firstEntry = entries[0];
        const ns = firstEntry.namespace ?? firstEntry.packageName;
        if (ns) namespacesFound[lang] = ns;
      }
    }

    try {
      rmSync(join(tspDir, "@azure-tools"), { recursive: true });
    } catch {
      // ignore cleanup errors
    }
  } catch (e) {
    core.warning(`typespec-metadata emitter failed: ${String(e)}. Falling back to YAML parse.`);
    const content = readFileSync(file, "utf8");
    const parsed = /** @type {TspConfig} */ (yaml.load(content));
    if (!parsed?.options) return { isMgmt, isDataPlane };

    for (const [emitter, lang] of Object.entries(FALLBACK_EMITTER_MAP)) {
      const opts = parsed.options[emitter];
      if (!opts) continue;
      if (opts.namespace) namespacesFound[lang] = opts.namespace;
      else if (opts["package-details"]?.name) namespacesFound[lang] = opts["package-details"].name;
      else if (opts.module) namespacesFound[lang] = opts.module;
    }
  }

  return { isMgmt, isDataPlane };
}

/**
 * Detect namespace changes in a PR and apply pending labels.
 *
 * @param {import("@actions/github-script").AsyncFunctionArguments} args
 */
export default async function detectNamespaces({ github, context, core }) {
  const approversConfig = loadApproversConfig(core);
  if (!approversConfig) return;

  const payload = /** @type {import("@octokit/webhooks-types").PullRequestEvent} */ (
    context.payload
  );

  const baseSha = payload.pull_request.base.sha;
  const headSha = payload.pull_request.head.sha;
  const diffOutput = execSync(`git diff --name-only ${baseSha}...${headSha}`).toString().trim();
  const changedFiles = diffOutput
    .split("\n")
    .filter((f) => /specification\/.*\/tspconfig\.yaml$/.test(f));

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
    const result = extractNamespaces(file, namespacesFound, core);
    if (result.isMgmt) isMgmt = true;
    if (result.isDataPlane) isDataPlane = true;
  }

  const prNumber = payload.pull_request.number;

  // On synchronize: reset approvals for changed namespaces
  if (payload.action === "synchronize") {
    const { data: currentPR } = await github.rest.pulls.get({
      owner: context.repo.owner,
      repo: context.repo.repo,
      pull_number: prNumber,
    });
    /** @type {string[]} */
    const existingLabels = currentPR.labels.map((l) => l.name ?? "");

    for (const lang of Object.keys(namespacesFound)) {
      const approvedLabel = `${lang}-namespace-approved`;
      if (existingLabels.includes(approvedLabel)) {
        core.info(`Namespace changed for ${lang}, resetting approval`);
        try {
          await github.rest.issues.removeLabel({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: prNumber,
            name: approvedLabel,
          });
        } catch {
          // label may not exist
        }
      }
    }

    for (const label of ["namespace-approved-all", "namespace-approved"]) {
      if (existingLabels.includes(label)) {
        try {
          await github.rest.issues.removeLabel({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: prNumber,
            name: label,
          });
        } catch {
          // label may not exist
        }
      }
    }
  }

  const languages = Object.keys(namespacesFound);
  if (languages.length === 0) {
    core.info("No namespace changes detected");
    return;
  }

  // Apply labels
  /** @type {string[]} */
  const labelsToAdd = ["namespace-review-required"];
  if (isMgmt) labelsToAdd.push("Mgmt");
  if (isDataPlane) labelsToAdd.push("data-plane");
  for (const lang of languages) labelsToAdd.push(`${lang}-namespace-pending`);

  // cspell:words fbbf
  for (const label of labelsToAdd) {
    try {
      await github.rest.issues.getLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        name: label,
      });
    } catch {
      /** @type {Record<string, string>} */
      const colors = { "namespace-review-required": "e11d48" };
      await github.rest.issues.createLabel({
        owner: context.repo.owner,
        repo: context.repo.repo,
        name: label,
        color: colors[label] ?? (label.includes("pending") ? "fbbf24" : "94a3b8"),
      });
    }
  }

  await github.rest.issues.addLabels({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: prNumber,
    labels: labelsToAdd,
  });

  // Build bot comment
  /**
   * @param {string} lang
   * @returns {string[]}
   */
  const getApprovers = (lang) => {
    if (isMgmt) {
      const mgmtApprovers = approversConfig["management-plane"]?.all;
      if (mgmtApprovers) return mgmtApprovers;
    }
    return approversConfig["data-plane"]?.[lang] ?? ["TBD"];
  };

  const planeType = isMgmt ? "Management Plane" : "Data Plane";
  const baseRef = payload.pull_request.base.ref;
  let body = `## Namespace Review Required\n\n**Plane:** ${planeType}\n\n`;
  body += `| Language | Proposed Namespace | Status | Approvers |\n`;
  body += `|----------|-------------------|--------|----------|\n`;
  for (const [lang, ns] of Object.entries(namespacesFound)) {
    body += `| ${lang} | \`${ns}\` | ⏳ Pending | ${getApprovers(lang).join(", ")} |\n`;
  }
  body += `\n**How to approve:**\n`;
  body += `- Per language: apply \`<language>-namespace-approved\` label\n`;
  body += `- All at once: apply \`namespace-approved-all\` label (shortcut for mgmt plane)\n\n`;
  body += `Merge is blocked until all languages are approved.\n`;
  if (payload.action === "synchronize") {
    body += `\n> ⚠️ **Namespace changed** — approvals for affected languages have been reset.\n`;
  }
  body += `\n_Approver list: [.github/namespace-approvers.yml](../blob/${baseRef}/.github/namespace-approvers.yml)_\n`;
  body += `_Namespaces extracted via [@azure-tools/typespec-metadata](https://www.npmjs.com/package/@azure-tools/typespec-metadata) emitter_\n`;
  body += `<!-- namespace-review-bot -->`;

  const comments = await github.rest.issues.listComments({
    owner: context.repo.owner,
    repo: context.repo.repo,
    issue_number: prNumber,
  });
  const botComment = comments.data.find(
    (c) => c.user?.type === "Bot" && c.body?.includes("<!-- namespace-review-bot -->"),
  );

  if (botComment) {
    await github.rest.issues.updateComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      comment_id: botComment.id,
      body,
    });
  } else {
    await github.rest.issues.createComment({
      owner: context.repo.owner,
      repo: context.repo.repo,
      issue_number: prNumber,
      body,
    });
  }

  core.setOutput("has_pending", "true");
}
