import fs from "node:fs";
import { createRequire } from "node:module";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const requireEval = createRequire(new URL("../common/scripts/eval/package.json", import.meta.url));
const { parseDocument } = requireEval(
  requireEval.resolve("yaml", {
    paths: [
      fileURLToPath(new URL("../common/scripts/eval/", import.meta.url)),
      import.meta.dirname,
    ],
  }),
);

function requireModel(value: string | undefined, name: string): string {
  if (!value?.trim() || /[\0\r\n]|\$\([^)]+\)/.test(value)) {
    throw new Error(`Configure the pipeline variable ${name} before running skill evals.`);
  }
  return value.trim();
}

export function setEvalModels({
  evalRoot,
  evalArgs,
  model,
  armModel,
  judgeModel,
}: {
  evalRoot: string;
  evalArgs: string;
  model: string | undefined;
  armModel: string | undefined;
  judgeModel: string | undefined;
}): number {
  const normalModel = requireModel(model, "EvalModel");
  const reviewerModel = requireModel(armModel, "ArmEvalModel");
  const explicitJudge = requireModel(judgeModel, "EvalJudgeModel");
  const root = path.resolve(evalRoot);
  const args = evalArgs.trim().split(/\s+/).filter(Boolean);
  if (
    !args.length ||
    args.length % 2 !== 0 ||
    args.some((arg, index) => index % 2 === 0 && arg !== "-e")
  ) {
    throw new Error("Expected the shard matrix's -e <file> argument pairs.");
  }

  const updates = new Map<string, string>();
  for (let index = 1; index < args.length; index += 2) {
    const file = path.resolve(root, args[index]);
    const relative = path.relative(root, file);
    if (
      !relative ||
      relative === ".." ||
      relative.startsWith(`..${path.sep}`) ||
      path.isAbsolute(relative)
    ) {
      throw new Error("Selected eval files must stay inside the eval root.");
    }
    if (!fs.lstatSync(file).isFile()) {
      throw new Error("Selected eval inputs must be regular files.");
    }
    const document = parseDocument(fs.readFileSync(file, "utf8"));
    if (document.errors.length) {
      throw new Error(`Invalid eval YAML: ${relative}`);
    }
    const area = document.getIn(["tags", "area"]);
    const arm = area === "arm-api-reviewer";
    if (
      !arm &&
      !["azure-api-review", "azure-ps-design-review", "openai-typespec-update"].includes(area)
    ) {
      continue;
    }
    document.setIn(["defaults", "model"], arm ? reviewerModel : normalModel);
    if (arm || document.hasIn(["defaults", "judge_model"])) {
      document.setIn(["defaults", "judge_model"], explicitJudge);
    }
    updates.set(file, document.toString({ lineWidth: 0 }));
  }
  for (const [file, contents] of updates) {
    fs.writeFileSync(file, contents);
  }
  return updates.size;
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    const count = setEvalModels({
      evalRoot: process.env.SPEC_EVAL_ROOT ?? process.cwd(),
      evalArgs: process.env.SPEC_EVAL_ARGS ?? "",
      model: process.env.SPEC_EVAL_MODEL,
      armModel: process.env.SPEC_ARM_EVAL_MODEL,
      judgeModel: process.env.SPEC_EVAL_JUDGE_MODEL,
    });
    console.log(`Applied pipeline model settings to ${count} selected eval files.`);
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exitCode = 1;
  }
}
