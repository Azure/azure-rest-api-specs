// @ts-check

import { readdir, readFile } from "fs/promises";
import yaml from "js-yaml";
import { join } from "path";

/**
 * Shape of a vally eval file, to the depth these checks read. Declared so the
 * loaded YAML is typed rather than `any` -- the lint config rejects unsafe
 * member access, and silencing it per-line would hide real typos in the
 * property names these checks depend on.
 *
 * @typedef {object} GraderConfig
 * @property {string} [pattern]
 * @property {string[]} [strings]
 *
 * @typedef {object} Grader
 * @property {string} type
 * @property {string} [name]
 * @property {GraderConfig} [config]
 *
 * @typedef {object} Stimulus
 * @property {string} name
 * @property {Grader[]} [graders]
 *
 * @typedef {object} EvalDefaults
 * @property {string} [model]
 * @property {string} [judge_model]
 *
 * @typedef {object} EvalFile
 * @property {EvalDefaults} [defaults]
 * @property {Stimulus[]} [stimuli]
 */

/**
 * Shape of the gh-aw workflow frontmatter these checks read.
 *
 * @typedef {object} WorkflowFrontmatter
 * @property {string} [model]
 * @property {{ model?: string }} [engine]
 */

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
 * The primary false-positive regression eval. Production must run the model
 * this file measures, or its results describe a configuration that is never
 * shipped.
 */
export const TRUE_NEGATIVE_EVAL_FILE = "eval-true-negatives.yaml";

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
  // JSON.parse returns `any`; the double cast through `unknown` is the house
  // pattern (see workflows/src/namespace-approval/detect-namespaces.js), and
  // the rule fires on the assignment regardless of the cast.
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  const pkg =
    /** @type {{ dependencies?: Record<string, string>, devDependencies?: Record<string, string> }} */ (
      /** @type {unknown} */ (JSON.parse(packageJsonContent))
    );
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
 * Extracts the pinned agent model from a gh-aw workflow's Markdown frontmatter.
 *
 * gh-aw v0.83.1 deprecated `engine.model` in favor of a top-level `model:`,
 * so both spellings are accepted. The top-level form wins when both are
 * present, matching the compiler's own precedence.
 *
 * This deliberately reads only the *agent* model. `safe-outputs.threat-detection.engine.model`
 * is a separate, intentionally decoupled pin -- threat detection is a cheap
 * classification task and is not what the eval suite measures.
 *
 * @param {string} workflowContent
 * @returns {string} the pinned model identifier
 */
export function getEngineModel(workflowContent) {
  const match = workflowContent.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n/);

  if (!match) {
    throw new Error(`Could not find YAML frontmatter in ${WORKFLOW_FILE}`);
  }

  const frontmatter = /** @type {WorkflowFrontmatter} */ (yaml.load(match[1]));
  const model = frontmatter?.model ?? frontmatter?.engine?.model;

  if (!model) {
    throw new Error(
      `${WORKFLOW_FILE} does not pin a model (top-level \`model:\`, or the deprecated ` +
        "`engine.model`). An unpinned engine resolves to vars.GH_AW_MODEL_AGENT_COPILOT, " +
        "which can change without a pull request -- and a false-positive rate measured on " +
        "one model transfers nothing to another.",
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
  const doc = /** @type {EvalFile} */ (yaml.load(evalContent));

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
  // A comment naming the mechanism that owns a defect is the same leak in a
  // different vocabulary: `// LINTER-OWNED: no-enum` tells the agent both that
  // there is a defect on the next line and who owns it. Found in
  // tn-linter-owned.tsp after the first widening pass missed it.
  {
    pattern:
      /^\s*\/\/[^\n]*\b(LINTER[- ]OWNED|AGENT[- ]OWNED|RUNTIME[- ]ONLY|NOT[- ]A[- ]DEFECT)\b/im,
    why: "names the mechanism that owns a defect on the following line",
  },
  // Bare azure-core rule names in a comment do the same job without the label.
  {
    pattern:
      /^\s*\/\/[^\n]*\b(no-enum|no-nullable|no-format|no-unknown|no-generic-numeric|documentation-required|casing-style|request-body-problem|no-explicit-routes-resource-ops|use-standard-operations)\b/im,
    why: "names a linter rule in a comment, flagging the defect for the agent",
  },
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
  "| **SEC-SECRET-DETECT** (credentials) | ✅ Pass | No credential-shaped properties. |",
  "DP-VERSION-01: N/A — no prior version to compare against.",
  "See [DP-VIS-02](../references/data-plane-visibility-and-secrets.md) for the rule.",
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
 * A report whose findings use only NON-`DP-` rule-ID families.
 *
 * Adding non-DP findings to {@link REAL_FINDINGS_PROBE} alone cannot catch a
 * grader that has been narrowed back to the `DP-XXX-NN` shape, because that
 * probe also contains DP findings, which such a grader still matches. This
 * probe isolates the case.
 *
 * It deliberately carries **no severity glyph**. An earlier draft opened with
 * `### 🔴 Blocking`, which let a stimulus's severity grader match it and so
 * reported coverage the rule-ID graders did not actually have. The probe must
 * isolate the rule-ID dimension and nothing else.
 *
 * The families are real. `SEC-SECRET-DETECT` was observed in a live run;
 * `EX-*`, `DDP-*` and the mixed-case `RPC-Put-V1-11` all appear in the skill
 * corpus the agent loads.
 */
export const NON_DP_FINDING_PROBE = [
  "**[SEC-SECRET-DETECT] Credential-shaped property is readable** -- `main.tsp:33`",
  "**[EX-ORPHAN] Example references a removed operation** -- `examples/get.json:1`",
  "**[DDP-002] Batch endpoint trade-off** -- `main.tsp:70`",
  "**[RPC-Put-V1-11] Mixed-case rule identifier** -- `main.json:12`",
].join("\n");

/**
 * Two DP findings from different rule families, used to tell a *family-agnostic*
 * grader from a *specific-trap* one. A grader matching both is asserting
 * "no finding of any kind"; a grader matching only one is naming a specific
 * trap and is correct to stay narrow.
 */
export const TWO_DP_FAMILIES_PROBE = [
  "**[DP-VIS-02] Secret readable in response** -- `main.tsp:36`",
  "**[DP-PAGE-01] Unbounded collection returned unpaged** -- `main.tsp:102`",
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
  "**[DP-VIS-01] Durable stored property is write-only** -- `main.tsp:55`",
  "**[DP-MODEL-01] Update expressed as a POST action** -- `main.tsp:63`",
  "**[DP-MODEL-02] Config has identity and lifecycle but no path** -- `main.tsp:51`",
  // DP-MODEL-04's declared severity is Question, so the contract says it must
  // never appear in bracketed form. It is here deliberately: that makes it a
  // *contract violation*, and the "no operation-symmetry false positive"
  // grader exists precisely to catch the agent raising it as a finding rather
  // than asking it as a question. A grader must be able to see the failure it
  // is named for.
  "**[DP-MODEL-04] Create without delete** -- `main.tsp:82`",
  "**[DP-PAGE-01] Unbounded collection returned unpaged** -- `main.tsp:102`",
  "**[DP-VERSION-01] Property removed** -- `main.tsp:45`",
  "**[DP-VERSION-03] Missing @added on a new property** -- `main.tsp:47`",
  "**[DP-VERSION-04] Version segment in a newly-added route** -- `main.tsp:71`",
  // DP-ERR-01 trigger 2 (one code covering many distinct failures), which is
  // Warning severity and therefore legitimately bracketed. Deliberately NOT
  // trigger 3 (nothing enumerated): that trigger is capped at Question, so a
  // bracketed form of it would be a contract violation rather than a real
  // finding, and this probe exists to supply real findings.
  "**[DP-ERR-01] One `InvalidRequest` code for eleven distinct failures** -- `main.tsp:24`",
  "**[DP-LRO-01] Status monitor has no error member** -- `main.tsp:30`",
  "**[DP-NAME-01] Non-obvious abbreviation** -- `main.tsp:29`",
  // DP-NAME-03 is Suggestion severity, so the bracketed form is correct for it.
  // Present so the "no boolean-should-be-enum false positive" grader on
  // tn-genuine-booleans is not inert -- a grader that can never fire has a
  // vacuous verdict, and that guard exists precisely because this rule produced
  // a confirmed false positive.
  "**[DP-NAME-03] Boolean `enabled` where a union may belong** -- `main.tsp:31`",
  "**[DP-DOC-01] Tautological documentation** -- `main.tsp:24`",
  // A doc-retroactivity finding: changing an unversioned @doc is claimed to
  // alter the already-published version. Mechanically true, but there is no
  // doc-versioning decorator in @typespec/versioning, so it is unactionable,
  // unavoidable and non-breaking. Present so the grader that bans it can see
  // the failure it is named for.
  //
  // The rule ID is deliberately one the skill does NOT define. An agent raising
  // this has no rule to cite, so it invents one, and the grader must catch it
  // by the shape of the claim rather than by a known ID. Do not substitute a
  // real ID here: DP-VERSION-04 in particular is now the version-in-route rule,
  // and using it would make this probe read as that rule misfiring.
  "**[DP-VERSION-09] Documentation changed retroactively on a published version** -- `main.tsp:18`",
  // Non-DP rule-ID families. The agent really does use the bracketed
  // convention for cross-cutting IDs -- SEC-SECRET-DETECT was observed in a
  // live run -- so a grader that only knows the DP-XXX-NN shape silently
  // under-reports false positives. Keeping these in the probe means
  // checkGraderSoundness fails a grader that cannot see them.
  "**[SEC-SECRET-DETECT] Credential-shaped property is readable** -- `main.tsp:33`",
  "**[EX-ORPHAN] Example references a removed operation** -- `examples/get.json:1`",
  "**[DDP-002] Batch endpoint trade-off** -- `main.tsp:70`",
  "**[RPC-Put-V1-11] Mixed-case rule identifier** -- `main.json:12`",
  // Findings that duplicate a linter rule or invent a runtime-behavior claim.
  // Both are defects the true-negative graders exist to catch, and both are
  // only distinguishable from a legitimate deferral by their position: a
  // bracketed rule ID at the head of the line.
  "**[DP-NAME-01] casing-style violation on `accountID`** -- `main.tsp:29`",
  "**[DP-DOC-01] documentation-required not satisfied** -- `main.tsp:12`",
  "**[DP-PAGE-02] Sort order is unspecified across pages** -- `main.tsp:88`",
  "The `mode` union must be extensible; add `string`.",
  "`accountId` should be camelCase.",
  "Missing @doc on `Widget`.",
  "Avoid @format on `createdAt`.",
  "Use `Azure-AsyncOperation` for polling, with `final-state-via`.",
  "The `state` enum should be a union.",
  "`retryCount` must not be nullable.",
  // A retracted finding: emitted, then withdrawn in the same report. The
  // "no retracted findings" grader exists to catch this, so it must be visible
  // here or that grader reads as inert.
  "_(Retracted — `supplierEmail` is contact info, not a secret.)_",
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
    const doc = /** @type {EvalFile} */ (yaml.load(await readFile(join(evalDir, file), "utf8")));

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
          problems.push(`${file} :: "${grader.name}" pattern does not compile: ${String(error)}`);
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

        // A grader matching two different DP families is family-agnostic: it is
        // asserting "no finding of any kind", not "this specific trap did not
        // fire". Such a grader must also see non-DP families, or it silently
        // under-reports false positives -- the agent really does raise
        // **[SEC-SECRET-DETECT] ...** findings. A grader matching only one
        // family is naming a specific trap and is correct to stay narrow.
        const familyAgnostic =
          TWO_DP_FAMILIES_PROBE.split("\n").every((line) => regex.test(line)) &&
          !regex.test(CORRECT_SILENCE_PROBE);

        if (familyAgnostic && !regex.test(NON_DP_FINDING_PROBE)) {
          problems.push(
            `${file} :: "${grader.name}" is family-agnostic across DP rules but\n` +
              "      cannot see a finding raised under a non-DP rule ID.\n" +
              `      ${pattern}\n` +
              "      A false positive reported as **[SEC-SECRET-DETECT] ...** would pass\n" +
              "      silently. Use the general finding form:\n" +
              String.raw`        \*\*\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\]`,
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

/** The report-format contract, inside the skill so the eval harness loads it. */
export const REPORT_FORMAT_FILE =
  ".github/skills/azure-api-review/references/data-plane-report-format.md";

/** The reviewer agent file, which must defer to the contract rather than restate it. */
export const AGENT_FILE = ".github/agents/data-plane-api-reviewer.agent.md";

/**
 * Fails when the report-format contract the graders depend on is not present in
 * what the eval harness actually loads, or when the agent file has grown a
 * second copy of it.
 *
 * This exists because the defect it guards was invisible until a run was
 * attempted. The format was defined only in the agent file; vally loads the
 * skill and has no concept of an agent file; and the graders matched on the
 * format. Nothing failed at PR time -- it would have surfaced as a ~100%
 * false-failure rate on the positive suite after a 30-minute, ~500-AIU run.
 *
 * Three properties are asserted:
 *
 *   1. The contract file exists and defines the bracketed finding syntax and
 *      the severity glyphs, so a skill-only agent is told to emit what the
 *      graders match.
 *   2. Its example finding satisfies the graders' own patterns. This is the
 *      end-to-end link: if someone changes the syntax here, the graders that
 *      match on it must change in the same pull request.
 *   3. The agent file points at it and does not restate it, so the two cannot
 *      drift apart again.
 *
 * @param {object} options
 * @param {typeof import("@actions/core")} options.core
 * @param {string} options.rootDir
 * @returns {Promise<boolean>} true when the contract holds
 */
export async function checkReportFormatContract({ core, rootDir }) {
  /** @type {string[]} */
  const problems = [];

  /** @type {string} */
  let contract;
  try {
    contract = await readFile(join(rootDir, REPORT_FORMAT_FILE), "utf8");
  } catch {
    core.setFailed(
      `${REPORT_FORMAT_FILE} is missing. It is the only definition of the finding ` +
        "syntax that the eval harness loads; without it every mechanical grader " +
        "matches a format the agent under evaluation was never given.",
    );
    return false;
  }

  // 1. The contract must define what the graders match.
  if (!/\[DP-[A-Z]+-\d\d\]/.test(contract)) {
    problems.push(
      `${REPORT_FORMAT_FILE} does not show the bracketed \`[DP-XXX-NN]\` finding syntax.`,
    );
  }
  for (const glyph of ["🔴", "🟡", "💡"]) {
    if (!contract.includes(glyph)) {
      problems.push(`${REPORT_FORMAT_FILE} does not define the ${glyph} severity glyph.`);
    }
  }

  // 1b. The contract must disambiguate the two emoji vocabularies. The skill
  //     uses 🔴/🟡/💡 for severity and 🔒/⏳/📋/🤖/🚫/❓/🚷 for linter-interlock
  //     status, and several rule files carry an interlock glyph within a few
  //     lines of the rule text. A real run emitted `| 🚫 Blocking |` in a
  //     findings table, borrowing a status glyph as a severity marker. Prose
  //     alone rots, so the disambiguation is asserted here.
  for (const statusGlyph of ["🚫", "🔒"]) {
    if (!contract.includes(statusGlyph)) {
      problems.push(
        `${REPORT_FORMAT_FILE} does not warn that ${statusGlyph} is a linter-interlock\n` +
          "      STATUS glyph and never a severity glyph. The reference files use both\n" +
          "      vocabularies, and an agent that borrows one for the other emits a report\n" +
          "      no grader can read.",
      );
    }
  }

  // 2. The graders and the contract must speak the same syntax. Requiring the
  //    contract to carry an example for every rule family would be padding a
  //    document to satisfy a checker, so the assertion is structural instead:
  //    each positive grader either matches the bracketed family the contract
  //    teaches, or matches a severity glyph the contract defines. Plus one
  //    end-to-end proof that the two shapes really are compatible.
  const evalDir = join(rootDir, EVAL_DIR);
  /** @type {string[]} */
  let evalFiles = [];
  try {
    evalFiles = (await readdir(evalDir)).filter((f) => f.startsWith("eval-"));
  } catch {
    /* checkModelAlignment reports a missing eval directory. */
  }

  const contractFinding = contract.match(/\*\*\[DP-[A-Z]+-\d\d\][^\n]*/)?.[0];
  if (!contractFinding) {
    problems.push(
      `${REPORT_FORMAT_FILE} has no example finding line of the form ` +
        "`**[DP-XXX-NN] Title** -- `file:line``.",
    );
  }

  let compatibleGraders = 0;

  for (const file of evalFiles.sort()) {
    const doc = /** @type {EvalFile} */ (yaml.load(await readFile(join(evalDir, file), "utf8")));
    for (const stimulus of doc?.stimuli ?? []) {
      for (const grader of stimulus.graders ?? []) {
        // Only positive assertions are checked. An `output-not-matches` grader
        // is supposed to miss, and the contract deliberately contains a
        // "considered but not raised" example for exactly that reason.
        if (grader.type !== "output-matches") continue;
        const pattern = grader.config?.pattern;
        if (!pattern) continue;

        // The bracketed finding form, in either spelling: a literal family
        // prefix (`\[DP-`) or a generalized family character class
        // (`\[[A-Z]...`). The latter is what a format-TOLERANT grader uses --
        // one that accepts any severity heading glyph but still demands the
        // bracket, because the bracket is the only thing separating a raised
        // finding from a considered-rules table entry, which writes plain bold
        // IDs without brackets.
        //
        // Deliberately does NOT accept a bare `\[`: a grader matching any
        // bracket at all would match prose and would not be asserting the
        // finding form.
        const targetsBracketedForm = /\\\[(?:DP-|\[A-Z)/.test(pattern);
        const targetsDefinedGlyph = ["🔴", "🟡", "💡"].some(
          (g) => pattern.includes(g) && contract.includes(g),
        );
        // A severity WORD in heading position is an accepted alternative to the
        // glyph: format instability costs nothing in production, and the
        // contract names the severities in words as well as glyphs. Still
        // requires the bracketed form above, so this only widens which
        // *heading* shapes a grader may anchor on.
        const targetsSeverityWord = /\\b(?:Blocking|Warning|Suggestion)\\b/.test(pattern);

        if (!targetsBracketedForm && !targetsDefinedGlyph && !targetsSeverityWord) {
          problems.push(
            `${file} :: "${grader.name}" asserts a finding using a syntax the\n` +
              `      contract does not teach.\n` +
              `      ${pattern}\n` +
              "      Positive graders must match either the bracketed `[DP-XXX-NN]` form or a\n" +
              "      severity glyph defined in the contract, or they are matching a shape the\n" +
              "      agent is never told to emit.",
          );
          continue;
        }

        // End-to-end: does this grader actually fire on the contract's own
        // example? Only meaningful for graders whose rule family the example
        // happens to use, but one such grader proves the shapes line up.
        if (contractFinding) {
          try {
            if (compileGraderPattern(pattern).test(contractFinding)) compatibleGraders++;
          } catch {
            /* checkGraderSoundness reports patterns that do not compile. */
          }
        }
      }
    }
  }

  if (contractFinding && evalFiles.length > 0 && compatibleGraders === 0) {
    problems.push(
      `No grader matches the example finding in ${REPORT_FORMAT_FILE}:\n` +
        `      ${contractFinding}\n` +
        "      The contract and the graders have drifted into different syntaxes.",
    );
  }

  // 3. The agent must defer, not duplicate.
  const agent = await readFile(join(rootDir, AGENT_FILE), "utf8");
  if (!agent.includes("data-plane-report-format.md")) {
    problems.push(
      `${AGENT_FILE} does not reference ${REPORT_FORMAT_FILE}. The agent must be ` +
        "pointed at the contract, or production and the evals describe different formats.",
    );
  }
  // A full template in the agent file is the duplication that caused the drift.
  // The fenced markdown block plus the self-identification line is the tell.
  if (/```+markdown[\s\S]*?Automated review by Copilot/.test(agent)) {
    problems.push(
      `${AGENT_FILE} contains its own copy of the report template. Delete it and ` +
        `defer to ${REPORT_FORMAT_FILE}; a second copy is what let the format drift ` +
        "out of what the eval harness loads.",
    );
  }

  if (problems.length === 0) {
    core.info("Report-format contract is present in the skill and matches every grader.");
    return true;
  }

  core.setFailed(
    [
      "The report-format contract and the graders that depend on it are out of sync:",
      "",
      ...problems.map((p) => `  - ${p}`),
      "",
      "Why this is enforced: the eval harness (vally) loads the SKILL, not the agent",
      "file. A finding syntax defined only in the agent file is invisible to every",
      "eval that grades it. That is not hypothetical -- measured across the 21 trials",
      "of the first real run, the agent emitted 0 bracketed rule IDs and 0 🔴 glyphs,",
      "because the format lived somewhere it never read.",
      "",
      `Keep ${REPORT_FORMAT_FILE} authoritative, keep the agent deferring to it, and`,
      "change the graders in the same pull request as the syntax.",
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
 * Eval results are useful as a rollout regression signal only when production
 * runs the model the suite measured. Nothing in the two files makes that
 * coupling visible to someone editing one of them six months from now, so it is
 * asserted here instead.
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

  if (!evalFiles.includes(TRUE_NEGATIVE_EVAL_FILE)) {
    core.setFailed(
      `${EVAL_DIR}/${TRUE_NEGATIVE_EVAL_FILE} is missing. It is the primary false-positive ` +
        "regression suite for the reviewer.",
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
      `  ${EVAL_DIR}/${TRUE_NEGATIVE_EVAL_FILE} tracks false-positive regressions. If`,
      "  production runs a different model, the results describe a configuration",
      "  that is never shipped.",
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
    await checkReportFormatContract({ core, rootDir }),
  ];

  return results.every(Boolean);
}
