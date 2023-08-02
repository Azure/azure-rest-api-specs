import { exec } from "child_process";
import debug from "debug";
import { access } from "fs/promises";
import { parseArgs, ParseArgsConfig } from "node:util";
import path from "path";
import { simpleGit } from "simple-git";

debug.enable("simple-git");

interface TSVRule {
  readonly name: string;
  readonly description: string;
  execute(folder?: string): Promise<TSVRuleResult>;
}

interface TSVRuleResult {
  readonly success: boolean;
  readonly stdOutput?: string;
  readonly errorOutput?: string;
}

class NpmPrefixRule implements TSVRule {
  readonly name = "NpmPrefix";
  readonly description = "Verify spec is using root level package.json";

  async execute(folder: string): Promise<TSVRuleResult> {
    let expected_npm_prefix = process.cwd();
    const actual_npm_prefix = (await runCmd(`npm prefix`, folder))[0].trim();

    let success = true;
    let stdOutput =
      "Expected npm prefix: " +
      expected_npm_prefix +
      "\n" +
      "Actual npm prefix: " +
      actual_npm_prefix;
    let errorOutput: string | undefined;

    if (expected_npm_prefix !== actual_npm_prefix) {
      success = false;
      errorOutput =
        "TypeSpec folders MUST NOT contain a package.json, and instead MUST rely on the package.json at repo root";
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}

class CompileRule implements TSVRule {
  readonly name = "Compile";
  readonly description = "Compile TypeSpec";

  async execute(folder: string): Promise<TSVRuleResult> {
    let success = true;
    let stdOutput = "";
    let errorOutput: string | undefined;

    if (await checkFileExists(path.join(folder, "main.tsp"))) {
      let [std, err] = await runCmd(`npx --no tsp compile . --warn-as-error`, folder);
      stdOutput += std;
      console.log("errrr");
      console.log(err);
      if (err == null) {
        success = false;
        errorOutput += err;
      }
    }
    if (await checkFileExists(path.join(folder, "client.tsp"))) {
      let [std, err] = await runCmd(
        `npx --no tsp compile client.tsp --no-emit --warn-as-error`,
        folder
      );
      stdOutput += std;
      if (err == null) {
        success = false;
        errorOutput += err;
      }
    }

    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}

class FormatRule implements TSVRule {
  readonly name = "Format";
  readonly description = "Format TypeSpec";

  async execute(folder: string): Promise<TSVRuleResult> {
    // Format parent folder to include shared files
    let [stdOutput, errorOutput] = await runCmd(`npx tsp format ../**/*.tsp`, folder);

    let success = errorOutput ? false : true;
    return {
      success: success,
      stdOutput: stdOutput,
      errorOutput: errorOutput,
    };
  }
}

class GitDiffRule implements TSVRule {
  readonly name = "GitDiff";
  readonly description = "Checks if previous rules resulted in a git diff";

  async execute(): Promise<TSVRuleResult> {
    const git = simpleGit();
    let gitStatusIsClean = await (await git.status(["--porcelain"])).isClean();

    let success = true;
    let errorOutput: string | undefined;

    if (!gitStatusIsClean) {
      success = false;
      errorOutput = JSON.stringify(await git.status());
      errorOutput += await git.diff();
    }

    return {
      success: success,
      errorOutput: errorOutput,
    };
  }
}

async function runCmd(cmd: string, cwd: string) {
  console.log(`run command:${cmd}`);
  const { err, stdout, stderr } = (await new Promise((res) =>
    exec(
      cmd,
      { encoding: "utf8", maxBuffer: 1024 * 1024 * 64, cwd: cwd },
      (err: unknown, stdout: unknown, stderr: unknown) =>
        res({ err: err, stdout: stdout, stderr: stderr })
    )
  )) as any;

  return [stdout, stderr + err?.message] as string[];
}

async function checkFileExists(file: string) {
  return access(file)
    .then(() => true)
    .catch(() => false);
}

export async function main() {
  const args = process.argv.slice(2);
  const options = {
    folder: {
      type: "string",
      short: "f",
    },
  };
  const parsedArgs = parseArgs({ args, options, allowPositionals: true } as ParseArgsConfig);
  const folder = parsedArgs.positionals[0];
  console.log("Running TypeSpecValidation on folder:", folder);

  let TSVRules = [new NpmPrefixRule(), new CompileRule(), new FormatRule(), new GitDiffRule()];
  let success = true;
  for (let i = 0; i < TSVRules.length; i++) {
    const rule = TSVRules[i];
    console.log("\nExecuting rule: " + rule.name);
    const result = await rule.execute(folder);
    if (result.stdOutput) console.log(result.stdOutput);
    if (!result.success) {
      success = false;
      console.log("Rule " + rule.name + " failed");
      if (result.errorOutput) console.log(result.errorOutput);
    }
  }

  if (!success) {
    return process.exit(1);
  }
  return;
}
