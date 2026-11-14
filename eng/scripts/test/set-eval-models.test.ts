import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import { createRequire } from "node:module";
import os from "node:os";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";
import { onTestFinished, test } from "vitest";
import { setEvalModels } from "../set-eval-models.ts";

const requireEval = createRequire(import.meta.url);
const { parse } = requireEval("yaml");

function fixture() {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "spec-eval-models-"));
  onTestFinished(() => fs.rmSync(root, { recursive: true, force: true }));
  const spec = {
    name: "model-configuration",
    tags: { area: "azure-api-review" },
    defaults: { runs: 3, model: "previous-model", timeout: "90s" },
    scoring: { threshold: 0.8 },
    stimuli: [
      {
        name: "example",
        prompt: "Keep this prompt",
        graders: [{ type: "output-contains", config: { substring: "required" } }],
      },
    ],
  };
  fs.writeFileSync(path.join(root, "normal.yaml"), JSON.stringify(spec));
  const arm = structuredClone(spec);
  arm.tags.area = "arm-api-reviewer";
  fs.writeFileSync(path.join(root, "arm.yaml"), JSON.stringify(arm));
  const options = {
    evalRoot: root,
    evalArgs: "-e normal.yaml -e arm.yaml",
    model: "configured-model",
    armModel: "configured-arm-model",
    judgeModel: "configured-judge",
  };
  return { root, spec, arm, options };
}

test("pipeline variables select normal, ARM and judge models without changing assertions", () => {
  const { root, spec, arm, options } = fixture();
  assert.equal(setEvalModels(options), 2);
  assert.deepEqual(parse(fs.readFileSync(path.join(root, "normal.yaml"), "utf8")), {
    ...spec,
    defaults: { ...spec.defaults, model: options.model },
  });
  assert.deepEqual(parse(fs.readFileSync(path.join(root, "arm.yaml"), "utf8")), {
    ...arm,
    defaults: { ...arm.defaults, model: options.armModel, judge_model: options.judgeModel },
  });
});

test("missing and unresolved model variables fail before changing any eval", () => {
  const { root, options } = fixture();
  const original = fs.readFileSync(path.join(root, "normal.yaml"), "utf8");
  for (const key of ["model", "armModel", "judgeModel"] as const) {
    for (const value of [undefined, "", "  ", "$(UnsetModel)", "model\nother"]) {
      assert.throws(
        () => setEvalModels({ ...options, [key]: value }),
        /Configure the pipeline variable/,
      );
    }
  }
  assert.equal(fs.readFileSync(path.join(root, "normal.yaml"), "utf8"), original);
});

test("malformed matrix arguments and paths outside the eval root are rejected", () => {
  const { options } = fixture();
  for (const evalArgs of [
    "",
    "-e",
    "--model other",
    "-e normal.yaml extra",
    "-e ../outside.yaml",
  ]) {
    assert.throws(() => setEvalModels({ ...options, evalArgs }));
  }
});

test("an invalid selected file leaves earlier valid files unchanged", () => {
  const { root, options } = fixture();
  const original = fs.readFileSync(path.join(root, "normal.yaml"), "utf8");
  fs.writeFileSync(path.join(root, "arm.yaml"), "defaults: [");
  assert.throws(() => setEvalModels(options), /Invalid eval YAML/);
  assert.equal(fs.readFileSync(path.join(root, "normal.yaml"), "utf8"), original);
});

test("the pipeline CLI reads model values from environment variables", () => {
  const { root, options } = fixture();
  const child = spawnSync(
    process.execPath,
    [fileURLToPath(new URL("../set-eval-models.ts", import.meta.url))],
    {
      encoding: "utf8",
      env: {
        ...process.env,
        SPEC_EVAL_ROOT: root,
        SPEC_EVAL_ARGS: options.evalArgs,
        SPEC_EVAL_MODEL: options.model,
        SPEC_ARM_EVAL_MODEL: options.armModel,
        SPEC_EVAL_JUDGE_MODEL: options.judgeModel,
      },
    },
  );
  assert.ifError(child.error);
  assert.equal(child.status, 0, child.stderr);
  assert.equal(
    parse(fs.readFileSync(path.join(root, "normal.yaml"), "utf8")).defaults.model,
    options.model,
  );
  assert.equal(
    parse(fs.readFileSync(path.join(root, "arm.yaml"), "utf8")).defaults.judge_model,
    options.judgeModel,
  );
});

test("the actual pipeline selection uses variable models and unchanged graders", async () => {
  type EvalSpec = {
    tags?: { area?: string };
    defaults?: Record<string, unknown>;
  };
  const repository = path.resolve(import.meta.dirname, "../../..");
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "spec-eval-model-integration-"));
  onTestFinished(() => fs.rmSync(root, { recursive: true, force: true }));
  const evalRoot = path.join(root, ".github", "skills");
  fs.cpSync(path.join(repository, ".github", "skills"), evalRoot, {
    recursive: true,
    filter: (source) => path.basename(source) !== "node_modules",
  });
  const pipeline = parse(
    fs.readFileSync(path.join(repository, "eng/pipelines/skill-eval.yml"), "utf8"),
  );
  const matrixParameters = pipeline.extends.parameters.stages
    .find((stage: { stage: string }) => stage.stage === "Prepare")
    .jobs.find((job: { template: string }) =>
      job.template.includes("generate-eval-matrix"),
    ).parameters;
  const { buildMatrix } = await import(
    pathToFileURL(path.join(repository, "eng/common/scripts/eval/collect-stimuli.ts")).href
  );
  const matrix: Record<string, { evalArgs: string; shardName: string }> = buildMatrix({
    roots: [evalRoot],
    patterns: matrixParameters.evalGlobs,
    warn: () => {},
  });
  let affectedFiles = 0;
  for (const entry of Object.values(matrix)) {
    const files = entry.evalArgs.split(/\s+/).filter((value) => value !== "-e");
    const before = new Map<string, EvalSpec>(
      files.map((file) => [file, parse(fs.readFileSync(path.join(evalRoot, file), "utf8"))]),
    );
    const updated = setEvalModels({
      evalRoot,
      evalArgs: entry.evalArgs,
      model: "variable-executor",
      armModel: "variable-arm-executor",
      judgeModel: "variable-judge",
    });
    let expectedUpdates = 0;
    for (const file of files) {
      const expected = before.get(file);
      assert.ok(expected);
      const arm = expected.tags?.area === "arm-api-reviewer";
      const local =
        arm ||
        ["azure-api-review", "azure-ps-design-review", "openai-typespec-update"].includes(
          expected.tags?.area ?? "",
        );
      if (local) {
        expectedUpdates++;
        expected.defaults ??= {};
        expected.defaults.model = arm ? "variable-arm-executor" : "variable-executor";
        if (arm || Object.hasOwn(expected.defaults, "judge_model")) {
          expected.defaults.judge_model = "variable-judge";
        }
      }
      assert.deepEqual(parse(fs.readFileSync(path.join(evalRoot, file), "utf8")), expected);
    }
    assert.equal(updated, expectedUpdates);
    affectedFiles += updated;
  }
  assert.ok(matrix.area_arm_api_reviewer);
  assert.ok(affectedFiles > 0);
}, 60_000);

test("pipeline model variables leave synced suite configuration untouched", () => {
  const { root, spec, options } = fixture();
  spec.tags.area = "azsdk-common-pipeline-analysis";
  const file = path.join(root, "shared.yaml");
  const original = JSON.stringify(spec);
  fs.writeFileSync(file, original);
  assert.equal(setEvalModels({ ...options, evalArgs: "-e shared.yaml" }), 0);
  assert.equal(fs.readFileSync(file, "utf8"), original);
});
