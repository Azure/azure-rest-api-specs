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

/** Directory holding the data-plane eval fixtures. */
export const FIXTURE_DIR = ".github/skills/evals/data-plane-api-reviewer/fixtures";

/**
 * Patterns that must never appear in a fixture `.tsp`.
 *
 * The agent under evaluation reads the fixture. A true negative that announces
 * "the correct review output is silence" measures instruction-following rather
 * than false-positive resistance, and a positive fixture carrying an inline
 * `// VIOLATION (DP-MODEL-01)` annotation hands the agent the exact string the
 * `output-contains` grader looks for. Both were present in the original
 * fixtures and both inflated results in the flattering direction.
 *
 * In-world `@doc` text that a real service author would plausibly have written
 * is fine and often load-bearing -- documenting *why* a list is unpaged is what
 * a competent author does, and reading it correctly is the reviewer's job.
 * Only meta-commentary about the fixture's role is banned.
 */
const LEAKAGE_PATTERNS = [
  { pattern: /\bFIXTURE\b/i, why: "labels the file as a fixture" },
  { pattern: /\bTRUE[ -]NEGATIVE\b/i, why: "announces that the file is a true negative" },
  { pattern: /^\s*\/\/\s*(VIOLATION|BREAKING)\b/im, why: "annotates a seeded defect inline" },
  { pattern: /\bseeded\b/i, why: "describes the file's seeded defects" },
  { pattern: /\bDP-[A-Z]+-\d/, why: "names a rule ID the graders match on" },
  {
    pattern: /\b(reviewer|agent)\s+(must|should|may)\b/i,
    why: "states what the reviewer is expected to do",
  },
  { pattern: /\btest failure\b/i, why: "describes the grading outcome" },
  {
    pattern: /\bcorrect (review )?(output|answer)\b/i,
    why: "states the expected review output",
  },
  { pattern: /\bnot a real service\b/i, why: "breaks the in-world framing" },
];

/**
 * Recursively lists `.tsp` files under a directory.
 *
 * @param {string} dir
 * @returns {Promise<string[]>} absolute paths
 */
async function listFixtures(dir) {
  /** @type {string[]} */
  const found = [];

  /** @type {import("fs").Dirent[]} */
  let entries;
  try {
    entries = await readdir(dir, { withFileTypes: true });
  } catch (error) {
    if (/** @type {NodeJS.ErrnoException} */ (error).code === "ENOENT") return found;
    throw error;
  }

  for (const entry of entries) {
    const full = join(dir, entry.name);
    if (entry.isDirectory()) {
      found.push(...(await listFixtures(full)));
    } else if (entry.name.endsWith(".tsp")) {
      found.push(full);
    }
  }
  return found;
}

/**
 * Scans one fixture's text and returns the leakage it contains.
 *
 * @param {string} content
 * @returns {Array<{ line: number, text: string, why: string }>}
 */
export function findFixtureLeakage(content) {
  /** @type {Array<{ line: number, text: string, why: string }>} */
  const hits = [];
  const lines = content.split(/\r?\n/);

  lines.forEach((line, index) => {
    for (const { pattern, why } of LEAKAGE_PATTERNS) {
      // Anchored patterns are written against a single line, so testing
      // line-by-line keeps `^` meaningful and gives an exact location.
      const single = new RegExp(pattern.source, pattern.flags.replace("m", ""));
      if (single.test(line)) {
        hits.push({ line: index + 1, text: line.trim(), why });
        break;
      }
    }
  });

  return hits;
}

/**
 * Fails when a fixture tells the agent under evaluation what it is or what the
 * expected review output is.
 *
 * Provenance belongs in `fixtures/MANIFEST.md`, which the agent never reads.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} options.rootDir
 * @returns {Promise<boolean>} true when no fixture leaks
 */
export async function checkFixtureLabelLeakage({ core, rootDir }) {
  const fixtures = await listFixtures(join(rootDir, FIXTURE_DIR));

  if (fixtures.length === 0) {
    core.setFailed(
      `No fixtures found under ${FIXTURE_DIR}. The eval suite cannot run without them, ` +
        "and an empty scan must not read as a clean one.",
    );
    return false;
  }

  /** @type {string[]} */
  const problems = [];

  for (const file of fixtures.sort()) {
    const relative = file.slice(rootDir.length + 1).replaceAll("\\", "/");
    for (const hit of findFixtureLeakage(await readFile(file, "utf8"))) {
      problems.push(`${relative}:${hit.line} ${hit.why}\n      ${hit.text}`);
    }
  }

  if (problems.length === 0) {
    core.info(`No label leakage in ${fixtures.length} data-plane eval fixture(s).`);
    return true;
  }

  core.setFailed(
    [
      "Eval fixtures leak information to the agent under evaluation:",
      "",
      ...problems.map((p) => `  - ${p}`),
      "",
      "The agent reads these files. A fixture that says what it is, or what the",
      "reviewer should report, measures instruction-following rather than review",
      "quality -- and a rule ID in a comment is the exact string an",
      "`output-contains` grader matches, so the grader passes without the agent",
      "having found anything.",
      "",
      `Move the provenance to ${FIXTURE_DIR}/MANIFEST.md, which the agent never reads.`,
      "In-world @doc text a real service author would have written is fine.",
    ].join("\n"),
  );

  return false;
}

/**
 * Text an agent plausibly emits while CORRECTLY declining to raise a finding:
 * a considered-rules table, an explicit refutation, a deferral to the linter,
 * an enumeration of what it is not flagging. No grader may fire on any of it.
 *
 * This is the defect class that produced 12 failed trials on the first real
 * run: `output-not-matches /\bDP-PAGE-0[0-9]\b/` fails when the agent cites
 * DP-PAGE-01 to explain why it does *not* apply, and
 * `output-contains "DP-MODEL-01"` passes when the agent tabulates the rule as
 * ✅ Pass having missed the violation entirely.
 */
export const CORRECT_SILENCE_PROBE = [
  "| **DP-MODEL-01** (actions ≠ CRUD) | ✅ Pass | Stateless computation. |",
  "| **DP-PAGE-01** (list ops paged) | ✅ Pass | Collection is bounded. |",
  "DP-VERSION-01: N/A — no prior version to compare against.",
  "This is **not** CRUD in disguise.",
  "No missing delete operation; `:reset` is the delete-equivalent.",
  "Deferred to the linter: no-enum, casing-style, documentation-required.",
  "Not flagged (🚫 Runtime): sort ordering, retention window, page size, Retry-After, idempotency.",
  "## Review Result: No Findings",
  "No blocking findings. Severity: Blocking — none.",
  "The closed union is justified; this is not a violation.",
  "This is a breaking change, but preview versions are not prohibited from making them.",
].join("\n");

/**
 * A report in the mandated format containing real findings, plus the specific
 * assertive phrasings the vocabulary-based graders exist to catch. Every
 * grader must fire on something here, or it is inert and passes vacuously.
 */
export const REAL_FINDINGS_PROBE = [
  "### 🔴 Blocking",
  "",
  "**[DP-VIS-02] Secret readable in response** --",
  "`specification/foo/data-plane/Foo/models.tsp:42`",
  "",
  "### 🟡 Warning",
  "",
  "**[DP-MODEL-01] Update expressed as a POST action** -- `main.tsp:63`",
  "**[DP-MODEL-04] No update path** -- `main.tsp:51`",
  "**[DP-PAGE-01] Unbounded collection returned unpaged** -- `main.tsp:102`",
  "**[DP-VERSION-01] Property removed** -- `main.tsp:45`",
  "**[DP-ERR-01] Undocumented error code** -- `main.tsp:24`",
  "**[DP-LRO-01] Status monitor has no error member** -- `main.tsp:30`",
  "**[DP-NAME-01] Non-obvious abbreviation** -- `main.tsp:29`",
  "**[DP-DOC-01] Tautological documentation** -- `main.tsp:24`",
  "The `mode` union must be extensible; add `string`.",
  "`accountId` should be camelCase.",
  "Missing @doc on `Widget`.",
  "Use `Azure-AsyncOperation` for polling, with `final-state-via`.",
  "The `state` enum should be a union.",
  "`retryCount` must not be nullable.",
].join("\n");

/**
 * Compiles a vally grader pattern, honouring a leading inline flag group.
 *
 * @param {string} pattern
 * @returns {RegExp}
 */
export function compileGraderPattern(pattern) {
  const flags = pattern.match(/^\(\?([a-z]+)\)/);
  return flags ? new RegExp(pattern.slice(flags[0].length), flags[1]) : new RegExp(pattern);
}

/**
 * Fails when a mechanical grader can be satisfied, or tripped, by an agent
 * that is behaving correctly.
 *
 * Two properties are asserted per grader:
 *
 *   1. It does not fire on {@link CORRECT_SILENCE_PROBE}. A grader that does
 *      is matching the *vocabulary* of a finding rather than a finding, so a
 *      correct answer trips it (false failure) or a missed violation satisfies
 *      it (false pass) depending on polarity.
 *   2. It does fire on {@link REAL_FINDINGS_PROBE}. A grader that never fires
 *      on a real report is inert and its verdict is vacuous.
 *
 * The report format renders findings as `**[DP-XXX-NN] Title** -- file:line`,
 * so the bracket is what distinguishes "reported a finding" from "cited a rule
 * while declining to fire it". Graders should match the bracketed form, or
 * match phrasing that is inherently an assertion.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} options.rootDir
 * @returns {Promise<boolean>} true when every grader is sound
 */
export async function checkGraderSoundness({ core, rootDir }) {
  const evalDir = join(rootDir, EVAL_DIR);
  const files = (await readdir(evalDir)).filter(
    (f) => f.startsWith("eval-") && f.endsWith(".yaml"),
  );

  /** @type {string[]} */
  const problems = [];
  let count = 0;

  for (const file of files.sort()) {
    const doc = /** @type {any} */ (yaml.load(await readFile(join(evalDir, file), "utf8")));

    for (const stimulus of doc?.stimuli ?? []) {
      for (const grader of stimulus.graders ?? []) {
        if (grader.type === "prompt") continue;
        count++;

        const pattern = grader.config?.pattern;
        if (!pattern) {
          problems.push(
            `${file} :: "${grader.name}" has no pattern. ` +
              "`output-contains` matches a bare substring, which a considered-rules " +
              "table satisfies; use `output-matches` with the bracketed finding form.",
          );
          continue;
        }

        /** @type {RegExp} */
        let regex;
        try {
          regex = compileGraderPattern(pattern);
        } catch (error) {
          problems.push(`${file} :: "${grader.name}" pattern does not compile: ${error}`);
          continue;
        }

        if (regex.test(CORRECT_SILENCE_PROBE)) {
          problems.push(
            `${file} :: "${grader.name}" fires on correct silence.\n` +
              `      ${pattern}\n` +
              "      It matches an agent citing a rule while declining to raise it.",
          );
        }

        if (!regex.test(REAL_FINDINGS_PROBE)) {
          problems.push(
            `${file} :: "${grader.name}" is inert -- it does not fire on a report\n` +
              `      containing real findings, so its verdict is vacuous.\n` +
              `      ${pattern}`,
          );
        }
      }
    }
  }

  if (problems.length === 0) {
    core.info(`All ${count} mechanical grader(s) distinguish findings from mentions.`);
    return true;
  }

  core.setFailed(
    [
      "Eval graders match the vocabulary of a finding rather than a finding:",
      "",
      ...problems.map((p) => `  - ${p}`),
      "",
      "A correct true-negative answer names the rule it considered and explains why",
      "it does not fire, so a grader keyed on the bare rule ID punishes the right",
      "answer. In the other direction, an agent that MISSES a violation still emits",
      'the rule ID in a "considered" table, so a bare `output-contains` passes on a',
      "complete miss.",
      "",
      "Match the report's finding syntax instead -- `\\[DP-XXX-NN\\]`, bracketed --",
      "or phrasing that is inherently an assertion. If neither is possible, delete",
      "the mechanical grader and rely on the LLM judge.",
    ].join("\n"),
  );

  return false;
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
    await checkFixtureLabelLeakage({ core, rootDir }),
    await checkGraderSoundness({ core, rootDir }),
  ];

  return results.every(Boolean);
}
