// @ts-check

import { readdir, readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";

/**
 * Path (relative to the repo root) of the data-plane linter interlock file whose
 * header pins the `@azure-tools/typespec-azure-core` version the
 * Data-Plane API Reviewer agent was verified against.
 */
export const COVERAGE_FILE =
  ".github/skills/azure-api-review/references/data-plane-linter-rule-coverage.md";

/** Package whose pinned version the coverage map must stay aligned with. */
export const PACKAGE_NAME = "@azure-tools/typespec-azure-core";

/** The gh-aw workflow whose `engine.model` runs the reviewer in production. */
export const WORKFLOW_FILE = ".github/workflows/data-plane-api-review.md";

/** Directory holding the data-plane eval files. */
export const EVAL_DIR = ".github/skills/evals/data-plane-api-reviewer/vally";

/**
 * The eval file that defines the phase-2 promotion gate. Production must run
 * the model this file measures, or the gate certifies a configuration that is
 * never shipped.
 */
export const GATE_EVAL_FILE = "eval-true-negatives.yaml";

/**
 * The judge model is deliberately frozen. It does not need to match production;
 * it needs to be *stable*, because changing it invalidates comparison against
 * every historical run -- including the ARM suite's numbers, which are the only
 * baseline available for judging whether the true-negative ratio is doing its
 * job. Changing this constant is a re-baselining decision, not a config tweak.
 */
export const FROZEN_JUDGE_MODEL = "claude-sonnet-4.6";

/**
 * Extracts the version of {@link PACKAGE_NAME} pinned in the repo root
 * `package.json` (either dependency section).
 *
 * @param {string} packageJsonContent
 * @returns {string} the pinned version, with any range prefix stripped
 */
export function getPinnedVersion(packageJsonContent) {
  const pkg = JSON.parse(packageJsonContent);
  const spec = pkg.devDependencies?.[PACKAGE_NAME] ?? pkg.dependencies?.[PACKAGE_NAME];

  if (!spec) {
    throw new Error(`${PACKAGE_NAME} is not a dependency of the root package.json`);
  }

  return String(spec).replace(/^[\^~>=<\s]+/, "");
}

/**
 * Extracts the version the coverage map claims to have been verified against,
 * from its `Verified against:` header comment.
 *
 * @param {string} coverageContent
 * @returns {string}
 */
export function getVerifiedVersion(coverageContent) {
  const match = coverageContent.match(
    new RegExp(`${PACKAGE_NAME.replace(/[/\\^$*+?.()|[\]{}]/g, "\\$&")}\\s+([0-9][^\\s]*)`),
  );

  if (!match) {
    throw new Error(
      `Could not find a "${PACKAGE_NAME} <version>" line in the header of ${COVERAGE_FILE}`,
    );
  }

  return match[1];
}

/**
 * Extracts `engine.model` from a gh-aw workflow's Markdown frontmatter.
 *
 * @param {string} workflowContent
 * @returns {string} the pinned model identifier
 */
export function getEngineModel(workflowContent) {
  const match = workflowContent.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n/);

  if (!match) {
    throw new Error(`Could not find YAML frontmatter in ${WORKFLOW_FILE}`);
  }

  const frontmatter = /** @type {any} */ (yaml.load(match[1]));
  const model = frontmatter?.engine?.model;

  if (!model) {
    throw new Error(
      `${WORKFLOW_FILE} does not pin engine.model. An unpinned engine resolves to ` +
        "vars.GH_AW_MODEL_AGENT_COPILOT, which can change without a pull request -- and a " +
        "false-positive rate measured on one model transfers nothing to another.",
    );
  }

  return String(model);
}

/**
 * Extracts `defaults.model` and `defaults.judge_model` from a vally eval file.
 *
 * @param {string} evalContent
 * @returns {{ model?: string, judgeModel?: string }}
 */
export function getEvalModels(evalContent) {
  const doc = /** @type {any} */ (yaml.load(evalContent));

  return {
    model: doc?.defaults?.model,
    judgeModel: doc?.defaults?.judge_model,
  };
}

/**
 * Fails when the `@azure-tools/typespec-azure-core` version pinned in the repo
 * root `package.json` differs from the version the data-plane linter coverage
 * map was verified against.
 *
 * A linter bump can flip a rule from agent-owned to linter-enforced. When that
 * happens the coverage map must be re-verified, otherwise the Data-Plane API
 * Reviewer agent starts double-reporting findings CI already surfaces -- the
 * single most reliable way to get a review bot muted.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} options.rootDir
 * @returns {Promise<boolean>} true when aligned
 */
export async function checkLinterAlignment({ core, rootDir }) {
  const packageJsonContent = await readFile(join(rootDir, "package.json"), "utf8");
  const coverageContent = await readFile(join(rootDir, COVERAGE_FILE), "utf8");

  const pinned = getPinnedVersion(packageJsonContent);
  const verified = getVerifiedVersion(coverageContent);

  if (pinned === verified) {
    core.info(`${PACKAGE_NAME} ${pinned} matches ${COVERAGE_FILE}`);
    return true;
  }

  core.setFailed(
    [
      `${PACKAGE_NAME} is pinned at ${pinned} in package.json, but ${COVERAGE_FILE}`,
      `was verified against ${verified}.`,
      "",
      "A linter version bump can move rules between the agent-owned and linter-enforced",
      "sets. Re-verify the coverage map before merging:",
      "",
      `  1. Diff the ${PACKAGE_NAME} linter rules and the`,
      "     @azure-tools/typespec-azure-rulesets data-plane ruleset between the two versions.",
      "  2. Move any newly enabled rule to the 🔒 Linted table.",
      "  3. Flip any ⏳ Landing rule that now ships to 🔒 Linted, and add a true-negative",
      "     eval stimulus asserting the agent stays silent on it.",
      `  4. Update the "Upstream alignment" date and the pinned versions in the`,
      `     ${COVERAGE_FILE} header comment.`,
    ].join("\n"),
  );

  return false;
}

/**
 * Fails when the model the reviewer runs in production diverges from the model
 * the eval suite measures, or when an eval file drifts from the frozen judge
 * model.
 *
 * The promotion gate for enabling inline review comments is "zero blocking
 * false positives across three runs of the true-negative suite". That statement
 * is only meaningful if production runs the model the suite measured. Nothing
 * in the two files makes the coupling visible to someone editing one of them
 * six months from now, so it is asserted here instead.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} options.rootDir
 * @returns {Promise<boolean>} true when aligned
 */
export async function checkModelAlignment({ core, rootDir }) {
  const workflowContent = await readFile(join(rootDir, WORKFLOW_FILE), "utf8");
  const engineModel = getEngineModel(workflowContent);

  const evalDir = join(rootDir, EVAL_DIR);
  const evalFiles = (await readdir(evalDir)).filter(
    (f) => f.startsWith("eval-") && f.endsWith(".yaml"),
  );

  if (!evalFiles.includes(GATE_EVAL_FILE)) {
    core.setFailed(
      `${EVAL_DIR}/${GATE_EVAL_FILE} is missing. It defines the phase-2 promotion gate; ` +
        "without it there is nothing holding the reviewer's false-positive rate.",
    );
    return false;
  }

  /** @type {string[]} */
  const problems = [];

  for (const file of evalFiles.sort()) {
    const { model, judgeModel } = getEvalModels(await readFile(join(evalDir, file), "utf8"));

    if (!model) {
      problems.push(`${EVAL_DIR}/${file} does not set defaults.model.`);
    } else if (model !== engineModel) {
      problems.push(
        `${EVAL_DIR}/${file} measures "${model}" but ${WORKFLOW_FILE} runs "${engineModel}".`,
      );
    }

    if (!judgeModel) {
      problems.push(`${EVAL_DIR}/${file} does not set defaults.judge_model.`);
    } else if (judgeModel !== FROZEN_JUDGE_MODEL) {
      problems.push(
        `${EVAL_DIR}/${file} sets judge_model "${judgeModel}"; ` +
          `the frozen baseline is "${FROZEN_JUDGE_MODEL}".`,
      );
    }
  }

  if (problems.length === 0) {
    core.info(
      `Data-plane reviewer model "${engineModel}" matches all ${evalFiles.length} eval file(s), ` +
        `judged by "${FROZEN_JUDGE_MODEL}".`,
    );
    return true;
  }

  core.setFailed(
    [
      "Data-plane reviewer model pins are out of alignment:",
      "",
      ...problems.map((p) => `  - ${p}`),
      "",
      "Why this is enforced:",
      "",
      "  The phase-2 promotion gate is measured by",
      `  ${EVAL_DIR}/${GATE_EVAL_FILE}. If production runs a different model,`,
      "  the gate certifies a configuration that is never shipped.",
      "",
      "  judge_model is frozen separately. It does not need to match production, it needs",
      "  to be stable -- changing it invalidates comparison against every historical run,",
      "  including the ARM suite's numbers, which are the only baseline we have.",
      "",
      "To change the reviewer model, do it as one deliberate, separately evaluated change:",
      "",
      `  1. Bump engine.model in ${WORKFLOW_FILE} and model in every`,
      `     ${EVAL_DIR}/eval-*.yaml in the SAME pull request.`,
      "  2. Re-run the full data-plane suite and compare against the previous baseline.",
      "  3. Leave judge_model alone.",
      "",
      "Never bump one side alone, and never fold a model upgrade into an unrelated change.",
    ].join("\n"),
  );

  return false;
}

/**
 * Runs every data-plane reviewer alignment check.
 *
 * Both checks always run, so a pull request that breaks both sees both failures
 * rather than fixing one and rediscovering the other on the next push.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} [options.rootDir] repo root; defaults to the current working directory
 * @returns {Promise<boolean>} true when every check passes
 */
export default async function checkDataPlaneReviewAlignment({ core, rootDir = process.cwd() }) {
  const results = [
    await checkLinterAlignment({ core, rootDir }),
    await checkModelAlignment({ core, rootDir }),
  ];

  return results.every(Boolean);
}
