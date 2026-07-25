import { mkdir, mkdtemp, writeFile } from "fs/promises";
import { tmpdir } from "os";
import { dirname, join } from "path";
import { describe, expect, it } from "vitest";
import checkDataPlaneReviewAlignment, {
  checkLinterAlignment,
  checkModelAlignment,
  COVERAGE_FILE,
  EVAL_DIR,
  FROZEN_JUDGE_MODEL,
  GATE_EVAL_FILE,
  getEngineModel,
  getEvalModels,
  getPinnedVersion,
  getVerifiedVersion,
  WORKFLOW_FILE,
} from "../src/data-plane-review-alignment.js";
import { createMockCore } from "./mocks.js";

/** Repo root, from .github/workflows/test. */
const REAL_ROOT = join(import.meta.dirname, "..", "..", "..");

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
    [GATE_EVAL_FILE]: { model: "claude-opus-4.6", judgeModel: FROZEN_JUDGE_MODEL },
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
      ...(engineModel ? [`  model: ${engineModel}`] : []),
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

describe("getEngineModel", () => {
  it("reads engine.model from frontmatter", () => {
    const content = "---\nengine:\n  id: copilot\n  model: claude-opus-4.6\n---\n\n# Body\n";

    expect(getEngineModel(content)).toBe("claude-opus-4.6");
  });

  it("ignores a --- that is not frontmatter", () => {
    const content = "---\nengine:\n  model: a-model\n---\n\ntext\n\n---\n\nmore text\n";

    expect(getEngineModel(content)).toBe("a-model");
  });

  it("throws when engine.model is absent", () => {
    expect(() => getEngineModel("---\nengine:\n  id: copilot\n---\n\n# Body\n")).toThrow(
      /does not pin engine\.model/,
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
        [GATE_EVAL_FILE]: { model: "claude-opus-4.6", judgeModel: FROZEN_JUDGE_MODEL },
        "eval-error-design.yaml": {
          model: "claude-opus-4.6",
          judgeModel: FROZEN_JUDGE_MODEL,
        },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });

  it("fails when production drifts from the eval that defines the gate", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({ engineModel: "claude-opus-5" });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("claude-opus-5"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("certifies a configuration"));
  });

  it("fails when a single eval file drifts while the rest agree", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      evals: {
        [GATE_EVAL_FILE]: { model: "claude-opus-4.6", judgeModel: FROZEN_JUDGE_MODEL },
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
        [GATE_EVAL_FILE]: { model: "claude-opus-4.6", judgeModel: "claude-opus-4.6" },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledWith(expect.stringContaining("judge_model"));
    expect(core.setFailed).toBeCalledWith(expect.stringContaining("historical run"));
  });

  it("fails when the gate eval file is missing", async () => {
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

    expect(core.setFailed).toBeCalledWith(expect.stringContaining(GATE_EVAL_FILE));
  });

  it("reports every problem at once rather than the first", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      engineModel: "claude-opus-5",
      evals: {
        [GATE_EVAL_FILE]: { model: "claude-opus-4.6", judgeModel: "gpt-5.4" },
      },
    });

    await expect(checkModelAlignment({ core, rootDir })).resolves.toBe(false);

    const message = core.setFailed.mock.calls[0][0];
    expect(message).toContain("claude-opus-5");
    expect(message).toContain("gpt-5.4");
  });
});

describe("checkDataPlaneReviewAlignment", () => {
  it("runs both checks even when the first fails", async () => {
    const core = createMockCore();
    const rootDir = await createFixtureRepo({
      pinnedVersion: "0.71.0",
      engineModel: "claude-opus-5",
    });

    await expect(checkDataPlaneReviewAlignment({ core, rootDir })).resolves.toBe(false);

    expect(core.setFailed).toBeCalledTimes(2);
  });

  it("stays aligned in the real repository", async () => {
    const core = createMockCore();

    await expect(checkDataPlaneReviewAlignment({ core, rootDir: REAL_ROOT })).resolves.toBe(true);

    expect(core.setFailed).not.toBeCalled();
  });
});
