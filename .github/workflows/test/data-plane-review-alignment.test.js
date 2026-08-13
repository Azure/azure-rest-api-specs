import { mkdir, mkdtemp, readFile, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { dirname, join } from "path";
import { describe, expect, it } from "vitest";
import checkDataPlaneReviewAlignment, {
  AGENT_FILE,
  checkFixtureLabelLeakage,
  checkGraderSoundness,
  checkLinterAlignment,
  checkModelAlignment,
  checkReportFormatContract,
  compileGraderPattern,
  CORRECT_SILENCE_PROBE,
  COVERAGE_FILE,
  EVAL_DIR,
  findFixtureLeakage,
  FROZEN_JUDGE_MODEL,
  getEngineModel,
  getEvalModels,
  getPinnedVersion,
  getVerifiedVersion,
  REAL_FINDINGS_PROBE,
  REPORT_FORMAT_FILE,
  TRUE_NEGATIVE_EVAL_FILE,
  WORKFLOW_FILE,
} from "../src/data-plane-review-alignment.js";
import { createMockCore } from "./mocks.js";

/** Repo root, from .github/workflows/test. */
const REAL_ROOT = join(import.meta.dirname, "..", "..", "..");
const LOCKED_WORKFLOW_FILE = ".github/workflows/data-plane-api-review.lock.yml";

/**
 * @param {string} path
 * @param {string} content
 */
async function writeNested(path, content) {
  await mkdir(dirname(path), { recursive: true });
  await writeFile(path, content);
}

/**
 * Writes a minimal repo layout into a temp dir: package.json, the coverage map,
 * the gh-aw workflow, and one or more eval files.
 *
 * @param {object} options
 * @param {string} [options.pinnedVersion] version in package.json devDependencies
 * @param {string} [options.verifiedVersion] version in the coverage map header
 * @param {string | null} [options.engineModel] engine.model in the workflow frontmatter
 * @param {Record<string, { model?: string, judgeModel?: string }>} [options.evals]
 * @returns {Promise<string>} the temp repo root
 */
async function createFixtureRepo({
  pinnedVersion = "0.70.0",
  verifiedVersion = "0.70.0",
  engineModel = "claude-opus-4.6",
  evals = {
    [TRUE_NEGATIVE_EVAL_FILE]: {
      model: "claude-opus-4.6",
      judgeModel: FROZEN_JUDGE_MODEL,
    },
  },
} = {}) {
  const root = await mkdtemp(join(tmpdir(), "dp-review-align-"));

  await writeFile(
    join(root, "package.json"),
    JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": pinnedVersion },
    }),
  );

  await writeNested(
    join(root, COVERAGE_FILE),
    [
      "<!-- Upstream alignment: 2026-07-24",
      "     Verified against:",
      `       - @azure-tools/typespec-azure-core ${verifiedVersion}`,
      `       - @azure-tools/typespec-azure-rulesets ${verifiedVersion} (data-plane ruleset)`,
      "-->",
      "",
      "# Data-Plane Linter Rule Coverage Map",
    ].join("\n"),
  );

  await writeNested(
    join(root, WORKFLOW_FILE),
    [
      "---",
      'description: "test"',
      "engine:",
      "  id: copilot",
      ...(engineModel ? [`model: ${engineModel}`] : []),
      "---",
      "",
      "# Body",
    ].join("\n"),
  );

  for (const [file, { model, judgeModel }] of Object.entries(evals)) {
    await writeNested(
      join(root, EVAL_DIR, file),
      [
        `name: ${file}`,
        "defaults:",
        "  runs: 1",
        ...(model ? [`  model: ${model}`] : []),
        ...(judgeModel ? [`  judge_model: ${judgeModel}`] : []),
        "stimuli: []",
      ].join("\n"),
    );
  }

  return root;
}

describe("getPinnedVersion", () => {
  it("reads devDependencies", () => {
    const content = JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": "0.70.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.70.0");
  });

  it("reads dependencies", () => {
    const content = JSON.stringify({
      dependencies: { "@azure-tools/typespec-azure-core": "0.71.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.71.0");
  });

  it("strips range prefixes", () => {
    const content = JSON.stringify({
      devDependencies: { "@azure-tools/typespec-azure-core": "^0.70.0" },
    });

    expect(getPinnedVersion(content)).toBe("0.70.0");
  });

  it("throws when the package is absent", () => {
    expect(() => getPinnedVersion(JSON.stringify({ devDependencies: {} }))).toThrow(
      /not a dependency/,
    );
  });
});

describe("getVerifiedVersion", () => {
  it("reads the version from the header comment", () => {
    const content = "<!-- Verified against:\n - @azure-tools/typespec-azure-core 0.70.0\n-->";

    expect(getVerifiedVersion(content)).toBe("0.70.0");
  });

  it("throws when the header does not name the package", () => {
    expect(() => getVerifiedVersion("# No header here")).toThrow(/Could not find/);
  });
});

describe("data-plane review workflow scope", () => {
  it("supports modern TypeSpec project layouts and excludes generated Swagger", async () => {
    const [workflow, agent] = await Promise.all([
      readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8"),
      readFile(join(REAL_ROOT, AGENT_FILE), "utf8"),
    ]);

    for (const content of [workflow, agent]) {
      expect(content).toMatch(/Do not require a\s+`data-plane` path segment/);
    }
    expect(workflow).toContain("Exclude projects under\n   `resource-manager/`");
    expect(agent).toContain("Exclude every project under\n`resource-manager/`");
    expect(workflow).toContain("review the changed `.tsp` files plus its\n   `tspconfig.yaml`");
    expect(workflow).toContain("Do not review any `.json` Swagger/OpenAPI files");
  });

  it("does not dispatch the critic when no TypeSpec data-plane project changed", async () => {
    const content = await readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8");
    const emptyScope = content.indexOf("If the PR changes no TypeSpec data-plane project");
    const stop = content.indexOf("Stop here. Do not dispatch the critic.");
    const critic = content.indexOf("**Run the critic after the scope gate.**");

    expect(emptyScope).toBeGreaterThan(-1);
    expect(stop).toBeGreaterThan(emptyScope);
    expect(critic).toBeGreaterThan(stop);
  });

  it("keeps trusted guidance local without checking out untrusted PR content", async () => {
    const content = await readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8");

    expect(content).not.toContain("checkout: false");
    expect(content).toContain("checkout:\n  sparse-checkout:");
    expect(content).not.toContain("ref: ${{ github.workflow_sha }}");
    expect(content).toContain(".github/agents");
    expect(content).toContain(".github/skills/azure-api-review");
    expect(content).toContain("allowed: [get_file_contents, pull_request_read, search_code]");
    expect(content).toContain('"jq"');
    expect(content).toContain('"nl"');
    expect(content).toContain("Read PR\n  metadata and PR-authored files only through the");
    expect(content).toContain("Do not emulate it with a general-purpose");
  });

  it("checks out the trusted event commit instead of a potentially stale PR base", async () => {
    const [source, compiled] = await Promise.all([
      readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8"),
      readFile(join(REAL_ROOT, LOCKED_WORKFLOW_FILE), "utf8"),
    ]);

    expect(source).not.toContain("ref: ${{ github.workflow_sha }}");
    expect(source).not.toContain("pull.base.sha");
    expect(source).not.toContain("resolve_pr_base");

    const checkoutIndex = compiled.indexOf("- name: Checkout repository\n");
    const checkoutEndIndex = compiled.indexOf(
      "- name: Clear partial clone markers after sparse checkout",
      checkoutIndex,
    );
    expect(checkoutIndex).toBeGreaterThan(-1);
    expect(checkoutEndIndex).toBeGreaterThan(checkoutIndex);
    const checkoutStep = compiled.slice(checkoutIndex, checkoutEndIndex);
    expect(checkoutStep.match(/uses: actions\/checkout@/g)).toHaveLength(1);
    expect(checkoutStep).not.toContain("ref:");
  });

  it("keeps Phase 2 manually gated, non-blocking, and capped at five inline findings", async () => {
    const [workflow, rollout] = await Promise.all([
      readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8"),
      readFile(join(REAL_ROOT, ".github/skills/evals/data-plane-api-reviewer/ROLLOUT.md"), "utf8"),
    ]);

    expect(workflow).toContain("create-pull-request-review-comment:\n    max: 5");
    expect(workflow).toContain('side: "RIGHT"');
    expect(workflow).toContain("submit-pull-request-review:");
    expect(workflow).toContain("allowed-events: [COMMENT]");
    expect(workflow).toContain("Always call `add_comment` exactly once");
    expect(workflow).toContain("Questions are not findings and always remain in the summary");
    expect(workflow).toContain("Post the complete finding\n   at the first instance");
    expect(workflow).toContain("further repetitions are omitted for brevity");
    expect(rollout).toContain("The workflow is at **Phase 2**");
    expect(rollout).toContain("The manually applied label is the safety control");
    expect(rollout).toContain("not a hard rollout gate");
  });

  it("uses the manual dispatch PR number throughout the runtime contract", async () => {
    const content = await readFile(join(REAL_ROOT, WORKFLOW_FILE), "utf8");
    const effectivePrNumber = "${{ github.event.pull_request.number || inputs.item_number }}";

    expect(content).toContain("item_number:\n        description: PR number to review");
    expect(content.split(effectivePrNumber)).toHaveLength(6);
    expect(content).not.toContain('target: "${{ github.event.pull_request.number }}"');
  });
});

describe("getEngineModel", () => {
  it("reads the top-level model (gh-aw >= 0.83.1)", () => {
    const content = "---\nengine:\n  id: copilot\nmodel: claude-opus-4.6\n---\n\n# Body\n";

    expect(getEngineModel(content)).toBe("claude-opus-4.6");
  });

  it("still reads the deprecated engine.model", () => {
    const content = "---\nengine:\n  id: copilot\n  model: claude-opus-4.6\n---\n\n# Body\n";

    expect(getEngineModel(content)).toBe("claude-opus-4.6");
  });

  it("prefers the top-level model when both are present", () => {
    const content =
      "---\nengine:\n  id: copilot\n  model: old-model\nmodel: claude-opus-4.6\n---\n\n# Body\n";

    expect(getEngineModel(content)).toBe("claude-opus-4.6");
  });

  it("ignores the decoupled threat-detection model", () => {
    // safe-outputs.threat-detection.engine.model is intentionally a different
    // model; the eval-equivalence invariant must not read it.
    const content = [
      "---",
      "engine:",
      "  id: copilot",
      "model: claude-opus-4.6",
      "safe-outputs:",
      "  threat-detection:",
      "    engine:",
      "      id: copilot",
      "      model: claude-sonnet-4.6",
      "---",
      "",
      "# Body",
    ].join("\n");

    expect(getEngineModel(content)).toBe("claude-opus-4.6");
  });

  it("ignores a --- that is not frontmatter", () => {
    const content = "---\nengine:\n  id: copilot\nmodel: a-model\n---\n\ntext\n\n---\n\nmore\n";

    expect(getEngineModel(content)).toBe("a-model");
  });

  it("throws when no model is pinned in either spelling", () => {
    expect(() => getEngineModel("---\nengine:\n  id: copilot\n---\n\n# Body\n")).toThrow(
      /does not pin a model/,
    );
  });

  it("throws when there is no frontmatter", () => {
    expect(() => getEngineModel("# Body\n")).toThrow(/frontmatter/);
  });
});

describe("getEvalModels", () => {
  it("reads both model fields", () => {
    const content = "defaults:\n  model: claude-opus-4.6\n  judge_model: claude-sonnet-4.6\n";

    expect(getEvalModels(content)).toEqual({
      model: "claude-opus-4.6",
      judgeModel: "claude-sonnet-4.6",
    });
  });

  it("returns undefined for missing fields", () => {
    expect(getEvalModels("defaults:\n  runs: 3\n")).toEqual({
      model: undefined,
      judgeModel: undefined,
    });
  });
});

describe("checkLinterAlignment", () => {
  it("passes when the versions match", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();

    await expect(checkLinterAlignment({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("fails when the versions differ", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({ pinnedVersion: "0.71.0" });

    await expect(checkLinterAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("0.71.0"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("0.70.0"));
  });

  it("tolerates a range prefix in package.json", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({ pinnedVersion: "^0.70.0" });

    await expect(checkLinterAlignment({ core, rootDir })).resolves.toBe(true);
  });
});

describe("checkModelAlignment", () => {
  it("passes when the workflow and every eval agree", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      evals: {
        [TRUE_NEGATIVE_EVAL_FILE]: {
          model: "claude-opus-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
        "eval-error-design.yaml": {
          model: "claude-opus-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("fails when production drifts from the false-positive regression eval", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({ engineModel: "claude-opus-5" });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("claude-opus-5"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("never shipped"));
  });

  it("fails when a single eval file drifts while the rest agree", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      evals: {
        [TRUE_NEGATIVE_EVAL_FILE]: {
          model: "claude-opus-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
        "eval-versioning.yaml": {
          model: "claude-sonnet-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("eval-versioning.yaml"));
  });

  it("fails when judge_model drifts from the frozen baseline", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      evals: {
        [TRUE_NEGATIVE_EVAL_FILE]: {
          model: "claude-opus-4.6",
          judgeModel: "claude-opus-4.6",
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("judge_model"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("historical run"));
  });

  it("fails when the true-negative regression eval file is missing", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      evals: {
        "eval-error-design.yaml": {
          model: "claude-opus-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining(TRUE_NEGATIVE_EVAL_FILE));
  });

  it("reports every problem at once rather than the first", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      engineModel: "claude-opus-5",
      evals: {
        [TRUE_NEGATIVE_EVAL_FILE]: {
          model: "claude-opus-4.6",
          judgeModel: "gpt-5.4",
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    const message = String(core.setFailed.mock.calls[0][0]);
    expect(message).toContain("claude-opus-5");
    expect(message).toContain("gpt-5.4");
  });
});

describe("findFixtureLeakage", () => {
  it("accepts a fixture that reads like a real spec", () => {
    const content = [
      'import "@typespec/http";',
      "",
      '@doc("Lists the languages the analyzer supports. This collection is fixed by the service, is currently 42 entries, and is documented never to exceed 200; it is therefore returned unpaged.")',
      "op listSupportedLanguages(): SupportedLanguage[];",
    ].join("\n");

    expect(findFixtureLeakage(content)).toEqual([]);
  });

  it("catches a true-negative label", () => {
    const content = '// FIXTURE (TRUE NEGATIVE -- class 2).\nimport "@typespec/http";';

    const hits = findFixtureLeakage(content);
    expect(hits).toHaveLength(1);
    expect(hits[0].line).toBe(1);
  });

  it("catches an inline violation annotation naming a rule ID", () => {
    const content = [
      "model Widget {",
      "  // VIOLATION (DP-MODEL-01): this is a PATCH.",
      "  name: string;",
      "}",
    ].join("\n");

    const hits = findFixtureLeakage(content);
    expect(hits).toHaveLength(1);
    expect(hits[0].why).toMatch(/annotates a seeded defect/);
  });

  it("catches a statement about what the reviewer should report", () => {
    const content = "// The reviewer must stay silent on all of them.";

    expect(findFixtureLeakage(content)).toHaveLength(1);
  });

  it("catches a bare rule ID anywhere, including inside a doc string", () => {
    const content = '@doc("See DP-VIS-02 for why this is fine.")';

    expect(findFixtureLeakage(content)).toHaveLength(1);
  });
});

describe("checkFixtureLabelLeakage", () => {
  it("passes on the real fixtures", async () => {
    const core = createMockCore();

    await expect(checkFixtureLabelLeakage({ core, rootDir: REAL_ROOT })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });
});

describe("compileGraderPattern", () => {
  it("honours a leading inline flag group", () => {
    const re = compileGraderPattern("(?im)^\\s*🔴");

    expect(re.flags).toContain("i");
    expect(re.flags).toContain("m");
    expect(re.test("  🔴 Blocking")).toBe(true);
  });

  it("compiles a pattern with no flag group", () => {
    expect(compileGraderPattern("\\[DP-VIS-0[0-9]\\]").test("**[DP-VIS-02]**")).toBe(true);
  });
});

describe("checkGraderSoundness", () => {
  it("passes on the real eval suite", async () => {
    const core = createMockCore();

    await expect(checkGraderSoundness({ core, rootDir: REAL_ROOT })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("distinguishes a considered rule from a reported finding", () => {
    // The exact defect from the first run: a bare rule ID matches the
    // "considered but declined" table, the bracketed form does not.
    const bare = compileGraderPattern("\\bDP-PAGE-0[0-9]\\b");
    const bracketed = compileGraderPattern("\\[DP-PAGE-0[0-9]\\]");

    expect(bare.test(CORRECT_SILENCE_PROBE)).toBe(true);
    expect(bracketed.test(CORRECT_SILENCE_PROBE)).toBe(false);
    expect(bracketed.test(REAL_FINDINGS_PROBE)).toBe(true);
  });

  it("requires the bold anchor to survive a markdown link to the rule", () => {
    // `See [DP-VIS-02](../references/...)` is something the agent plausibly
    // writes while explaining why a rule does NOT apply.
    const unanchored = compileGraderPattern("\\[DP-VIS-0[0-9]\\]");
    const anchored = compileGraderPattern("\\*\\*\\[DP-VIS-0[0-9]\\]");

    expect(unanchored.test(CORRECT_SILENCE_PROBE)).toBe(true);
    expect(anchored.test(CORRECT_SILENCE_PROBE)).toBe(false);
    expect(anchored.test(REAL_FINDINGS_PROBE)).toBe(true);
  });

  it("supports exact rule graders for sparse positive fixtures", () => {
    const exact = compileGraderPattern("\\*\\*\\[DP-VIS-01\\]");

    expect(exact.test(CORRECT_SILENCE_PROBE)).toBe(false);
    expect(exact.test(REAL_FINDINGS_PROBE)).toBe(true);
  });

  it("the general finding pattern spans every rule-ID family the skill defines", () => {
    const general = compileGraderPattern("\\*\\*\\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\\]");

    for (const id of ["DP-VIS-02", "SEC-SECRET-DETECT", "EX-ORPHAN", "DDP-002", "RPC-Put-V1-11"]) {
      expect(general.test(`**[${id}] Title** -- \`x.tsp:1\``), id).toBe(true);
    }
  });

  it("the general finding pattern does not match non-findings", () => {
    const general = compileGraderPattern("\\*\\*\\[[A-Z][A-Za-z0-9]*(?:-[A-Za-z0-9]+)+\\]");

    expect(general.test(CORRECT_SILENCE_PROBE)).toBe(false);
    for (const text of [
      "**[Note]** emphasis, no hyphen",
      "**[RFC 2119]** contains a space",
      "See [DP-VIS-02](refs/x.md) — a link, not bold",
      "- [ ] a task checkbox",
      "| **DP-VIS-02** (secrets) | Pass |",
    ]) {
      expect(general.test(text), text).toBe(false);
    }
  });

  it("rejects a family-agnostic grader that cannot see non-DP rule IDs", async () => {
    // The gap the smoke test exposed: a grader asserting "no finding of any
    // kind" that only knows the DP-XXX-NN shape.
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: tn-example",
        "    graders:",
        "      - type: output-not-matches",
        '        name: "no finding raised"',
        "        config:",
        '          pattern: "\\\\*\\\\*\\\\[DP-[A-Z]+-\\\\d\\\\d\\\\]"',
      ].join("\n"),
    );

    await expect(checkGraderSoundness({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("non-DP rule ID"));
  });

  it("leaves specific-trap graders alone", async () => {
    // A grader naming ONE rule is asserting a specific trap did not fire. It
    // is correct for it to ignore other families, so it must not be flagged.
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: tn-example",
        "    graders:",
        "      - type: output-not-matches",
        '        name: "no CRUD-in-disguise false positive"',
        "        config:",
        '          pattern: "\\\\*\\\\*\\\\[DP-MODEL-01\\\\]"',
      ].join("\n"),
    );

    await expect(checkGraderSoundness({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("rejects a grader that fires on correct silence", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: tn-example",
        "    graders:",
        "      - type: output-not-matches",
        '        name: "no pagination false positive"',
        "        config:",
        '          pattern: "\\\\bDP-PAGE-0[0-9]\\\\b"',
      ].join("\n"),
    );

    await expect(checkGraderSoundness({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("fires on correct silence"));
  });

  it("rejects output-contains, which matches a bare substring", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: positive-example",
        "    graders:",
        "      - type: output-contains",
        '        name: "reports pagination findings"',
        "        config:",
        '          strings: ["DP-PAGE-"]',
      ].join("\n"),
    );

    await expect(checkGraderSoundness({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("has no pattern"));
  });

  it("rejects an inert grader", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: positive-example",
        "    graders:",
        "      - type: output-matches",
        '        name: "reports something that never appears"',
        "        config:",
        '          pattern: "\\\\[DP-ABSENT-01\\\\]"',
      ].join("\n"),
    );

    await expect(checkGraderSoundness({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("inert"));
  });
});

describe("data-plane upstream references", () => {
  it("renders authoritative source links in every reviewer rule family", async () => {
    const referenceFiles = [
      "data-plane-resource-modeling.md",
      "data-plane-lro-and-paging.md",
      "data-plane-error-design.md",
      "data-plane-naming-and-docs.md",
      "data-plane-visibility-and-secrets.md",
      "data-plane-design-decisions.md",
    ];
    const referenceDir = join(REAL_ROOT, ".github/skills/azure-api-review/references");
    const contents = await Promise.all(
      referenceFiles.map(async (file) => [file, await readFile(join(referenceDir, file), "utf8")]),
    );

    for (const [file, content] of contents) {
      expect(content, file).toMatch(/\*\*Authoritative upstream(?: context)?:\*\*/);
      expect(content, file).toMatch(
        /https:\/\/github\.com\/microsoft\/api-guidelines\/blob\/vNext\/azure\/Guidelines\.md#[a-z0-9-]+/,
      );
    }

    const secretDetection = await readFile(join(referenceDir, "secret-detection.md"), "utf8");
    expect(secretDetection).toContain("Guidelines.md#rest-no-secrets-in-get-response");
    expect(secretDetection).toContain("Guidelines.md#rest-secrets-allowed-in-post-response");
  });
});

describe("checkReportFormatContract", () => {
  it("passes on the real repository", async () => {
    const core = createMockCore();

    await expect(checkReportFormatContract({ core, rootDir: REAL_ROOT })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("catches the original defect: format defined only in the agent file", async () => {
    // The regression this check exists for. The eval harness loads the skill,
    // not the agent, so a contract that lives only in the agent file is
    // invisible to every eval that grades it.
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(join(rootDir, AGENT_FILE), "# Agent\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n");

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("is missing"));
  });

  it("requires the contract to show the bracketed finding syntax", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\nReport findings as DP-VIS-02 with a file and line.\n\n🔴 🟡 💡\n",
    );
    await writeNested(join(rootDir, AGENT_FILE), "See data-plane-report-format.md.\n");

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("bracketed"));
  });

  it("requires the contract to define every severity glyph", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n\n🔴 only\n",
    );
    await writeNested(join(rootDir, AGENT_FILE), "See data-plane-report-format.md.\n");

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("🟡"));
  });

  it("requires the contract to disambiguate severity glyphs from interlock status glyphs", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    // Defines all three severity glyphs but never mentions the interlock
    // vocabulary -- the exact state that let a real run emit `| 🚫 Blocking |`.
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n\n🔴 🟡 💡\n",
    );
    await writeNested(join(rootDir, AGENT_FILE), "See data-plane-report-format.md.\n");

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("🚫"));
  });

  it("rejects an agent file that restates the template instead of deferring", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n\n🔴 🟡 💡\n",
    );
    await writeNested(
      join(rootDir, AGENT_FILE),
      [
        "See data-plane-report-format.md.",
        "",
        "```markdown",
        "## Data-Plane API Review",
        "",
        "_Automated review by Copilot (data-plane API reviewer agent)._",
        "```",
      ].join("\n"),
    );

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("own copy of the report"));
  });

  it("rejects an agent file that does not reference the contract", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n\n🔴 🟡 💡\n",
    );
    await writeNested(join(rootDir, AGENT_FILE), "# Agent\n\nNo pointer here.\n");

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("does not reference"));
  });

  it("rejects a positive grader using a syntax the contract does not teach", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo();
    await writeNested(
      join(rootDir, REPORT_FORMAT_FILE),
      "# Format\n\n**[DP-VIS-02] Title** -- `a.tsp:1`\n\n🔴 🟡 💡\n",
    );
    await writeNested(join(rootDir, AGENT_FILE), "See data-plane-report-format.md.\n");
    await writeNested(
      join(rootDir, EVAL_DIR, TRUE_NEGATIVE_EVAL_FILE),
      [
        "name: gate",
        "defaults:",
        "  model: claude-opus-4.6",
        `  judge_model: ${FROZEN_JUDGE_MODEL}`,
        "stimuli:",
        "  - name: positive-example",
        "    graders:",
        "      - type: output-matches",
        '        name: "reports something"',
        "        config:",
        '          pattern: "(?i)\\\\bfound a problem\\\\b"',
      ].join("\n"),
    );

    await expect(checkReportFormatContract({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("does not teach"));
  });
});

describe("checkDataPlaneReviewAlignment", () => {
  it("runs every check even when the first fails", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      pinnedVersion: "0.71.0",
      engineModel: "claude-opus-5",
    });

    await expect(checkDataPlaneReviewAlignment({ core, rootDir })).resolves.toBe(false);

    // linter + model fail; fixture and grader checks fail on the missing dirs.
    expect(core.setFailed.mock.calls.length).toBeGreaterThanOrEqual(2);
  });

  it("stays aligned in the real repository", async () => {
    const core = createMockCore();

    await expect(checkDataPlaneReviewAlignment({ core, rootDir: REAL_ROOT })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });
});
