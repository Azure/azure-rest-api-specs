import { spawnSync } from "node:child_process";
import * as path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { getPassAtKVerdict, setJunitPassAtKThreshold } from "./typespec-author-pass-at-k.ts";

const SCRIPT_DIR = path.dirname(fileURLToPath(import.meta.url));
const SHARED_EVAL_SCRIPT_DIR = path.resolve(SCRIPT_DIR, "../../../../../eng/common/scripts/eval");

type ShardRunOptions = {
  evalArgs: string;
  shardName: string;
  outputDir: string;
  extraArgs?: string;
  runs?: number;
};

function normalizeExtraArgs(extraArgs: string): string[] {
  if (!extraArgs || extraArgs === "$(TypeSpecAuthorEvalExtraArgs)") {
    return [];
  }

  return extraArgs.split(/\s+/).filter(Boolean);
}

export function runShard({
  evalArgs,
  shardName,
  outputDir,
  extraArgs = "",
  runs = 1,
}: ShardRunOptions) {
  if (!Number.isInteger(runs) || runs < 1) {
    throw new Error("--runs must be a positive integer.");
  }

  const evalArgList = evalArgs.split(/\s+/).filter(Boolean);
  const extraArgList = normalizeExtraArgs(extraArgs);

  console.log(
    `Running: vally eval ${evalArgs} --junit --output-dir "${outputDir}" --runs ${runs} ${extraArgList.join(" ")}`,
  );

  const vallyArgs = [
    "exec",
    "--no",
    "--prefix",
    SHARED_EVAL_SCRIPT_DIR,
    "--",
    "vally",
    "eval",
    ...evalArgList,
    "--junit",
    "--output-dir",
    outputDir,
    "--runs",
    String(runs),
    ...extraArgList,
  ];

  const proc = spawnSync("npm", vallyArgs, {
    stdio: "inherit",
    shell: process.platform === "win32",
    env: process.env,
  });
  const vallyExit = proc.status ?? 1;

  const updatedJunitFiles = setJunitPassAtKThreshold(outputDir, runs);
  console.log(`Configured ${updatedJunitFiles} JUnit file(s) for pass@${runs} summary gating.`);

  const verdict = getPassAtKVerdict(outputDir);
  for (const line of verdict.lines) {
    console.log(`  ${line}`);
  }

  if (!verdict.found) {
    console.log(
      `##vso[task.logissue type=error]Shard '${shardName}' produced no usable verdict (vally exit ${vallyExit}). Treating as failure.`,
    );
    return 1;
  }

  if (verdict.passed) {
    if (verdict.hadExecutionErrors) {
      console.log(
        `Shard '${shardName}' passed pass@${runs}; vally flagged execution errors (post-run teardown noise, not blocking).`,
      );
    }
    if (vallyExit !== 0) {
      console.log(
        `vally exited ${vallyExit} during post-run shutdown; shard '${shardName}' is PASSED per results.jsonl (exit code ignored).`,
      );
    }
    console.log(`##[section]Shard '${shardName}' PASSED (verdict from results.jsonl).`);
    return 0;
  }

  console.log(
    `##vso[task.logissue type=error]Shard '${shardName}' FAILED - one or more stimuli have no passing trial.`,
  );
  return 1;
}

function parseArgs(argv: string[]): ShardRunOptions {
  const options: Partial<ShardRunOptions> = { extraArgs: "" };
  for (let index = 0; index < argv.length; index++) {
    const next = () => argv[++index];
    switch (argv[index]) {
      case "--eval-args":
        options.evalArgs = next();
        break;
      case "--shard-name":
        options.shardName = next();
        break;
      case "--output-dir":
        options.outputDir = next();
        break;
      case "--extra-args":
        options.extraArgs = next();
        break;
      case "--runs":
        options.runs = Number(next());
        break;
      default:
        throw new Error(`Unknown argument: ${argv[index]}`);
    }
  }

  for (const required of ["evalArgs", "shardName", "outputDir"] as const) {
    if (!options[required]) {
      throw new Error(`Missing required argument for ${required}.`);
    }
  }

  return options as ShardRunOptions;
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    process.exit(runShard(parseArgs(process.argv.slice(2))));
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exit(1);
  }
}
