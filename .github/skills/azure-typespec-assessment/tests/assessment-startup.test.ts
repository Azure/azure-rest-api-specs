import { assert, test } from "vitest";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

type Activity = {
  kind: string;
  command?: string;
  args?: string[];
};

void test("invalid assessment inputs do no dependency, network, worktree, compiler, or output work", (t) => {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "assessment-startup-"));
  t.onTestFinished(() => fs.rmSync(root, { recursive: true, force: true }));
  const repo = path.join(root, "repo");
  const nonGit = path.join(root, "non-git");
  const bare = path.join(root, "bare");
  const file = path.join(root, "file");
  fs.mkdirSync(repo);
  fs.mkdirSync(nonGit);
  fs.writeFileSync(file, "not a directory");
  for (const args of [
    ["init", "-q", repo],
    ["init", "-q", "--bare", bare],
  ]) {
    const result = spawnSync("git", args, { encoding: "utf8" });
    assert.equal(result.status, 0, result.stderr);
  }

  const log = path.join(root, "activity.jsonl");
  const guard = path.join(root, "guard.mjs");
  fs.writeFileSync(
    guard,
    `
import fs from "node:fs";
import childProcess from "node:child_process";
import { registerHooks, syncBuiltinESMExports } from "node:module";
const record = (activity) =>
  fs.appendFileSync(process.env.ASSESSMENT_STARTUP_LOG, JSON.stringify(activity) + "\\n");
const spawnSync = childProcess.spawnSync;
childProcess.spawnSync = (command, args, options) => {
  record({ kind: "process", command, args });
  if (command !== "git" ||
      (args[2] !== "rev-parse" &&
       !(args[2] === "remote" && args[3] === "get-url"))) {
    throw new Error("Unexpected startup process: " + command + " " + args.join(" "));
  }
  return spawnSync(command, args, options);
};
syncBuiltinESMExports();
globalThis.fetch = () => {
  record({ kind: "network" });
  throw new Error("Unexpected startup network request");
};
registerHooks({
  load(url, context, nextLoad) {
    if (url.includes("/node_modules/")) {
      record({ kind: "third-party-dependency", url });
      throw new Error("Unexpected third-party dependency before validation");
    }
    if (url.endsWith("/skill-dependencies.ts")) {
      return {
        format: "module",
        shortCircuit: true,
        source: \`import fs from "node:fs";
          export async function ensureSkillDependencies() {
            fs.appendFileSync(process.env.ASSESSMENT_STARTUP_LOG,
              JSON.stringify({ kind: "dependency-setup" }) + "\\\\n");
            throw new Error("Unexpected dependency setup before validation");
          }\`,
      };
    }
    if (/\\/(prepare-assessment|compiler-runner|package-manager)\\.ts$/.test(url)) {
      record({ kind: "assessment-implementation", url });
      throw new Error("Unexpected assessment implementation before validation");
    }
    return nextLoad(url, context);
  },
});
`,
  );
  const script = fileURLToPath(new URL("../scripts/run-assessment-analysis.ts", import.meta.url));
  const cases: {
    name: string;
    args: string[];
    error: RegExp;
    cwd?: string;
    omitOutput?: boolean;
    omitScope?: boolean;
  }[] = [
    {
      name: "slug-like missing path",
      args: ["--repo-path", "Azure/azure-rest-api-specs"],
      error: /local directory does not exist.*Use --repo-path.*--pr/s,
    },
    {
      name: "legacy slug-like missing path",
      args: ["--repo", "Azure/azure-rest-api-specs"],
      error: /local directory does not exist/,
    },
    {
      name: "nonexistent directory",
      args: ["--repo-path", path.join(root, "missing")],
      error: /local directory does not exist/,
    },
    { name: "non-Git directory", args: ["--repo-path", nonGit], error: /not a Git worktree/ },
    { name: "file", args: ["--repo-path", file], error: /not a directory/ },
    { name: "bare repository", args: ["--repo-path", bare], error: /not a Git worktree/ },
    { name: "empty path", args: ["--repo-path", ""], error: /requires a nonempty value/ },
    { name: "empty legacy path", args: ["--repo", ""], error: /requires a nonempty value/ },
    {
      name: "conflicting paths",
      args: ["--repo-path", repo, "--repo", nonGit],
      error: /--repo-path and --repo refer to different directories/,
    },
    {
      name: "PR and base",
      args: ["--pr", "https://github.com/Azure/azure-rest-api-specs/pull/1", "--base", "main"],
      error: /--pr cannot be combined/,
    },
    { name: "head without base", args: ["--head", "feature"], error: /--head requires --base/ },
    { name: "invalid PR", args: ["--pr", "not-a-pr"], error: /Invalid --pr value/ },
    {
      name: "invalid budget",
      args: ["--model-input-budget-bytes", "oops"],
      error: /positive integer/,
    },
    { name: "zero budget", args: ["--model-input-budget-bytes", "0"], error: /positive integer/ },
    { name: "empty output", args: ["--output", ""], error: /--output requires a nonempty value/ },
    { name: "file output", args: ["--output", file], error: /--output must be a directory/ },
    { name: "nonempty output", args: ["--output", repo], error: /must be empty/ },
    {
      name: "missing required output",
      args: [],
      error: /Missing required argument --output/,
      omitOutput: true,
    },
    {
      name: "missing local scope",
      args: [],
      error: /--specification is required/,
      omitScope: true,
    },
    { name: "missing path value", args: ["--repo-path"], error: /Missing value for --repo-path/ },
    { name: "missing output value", args: ["--output"], error: /Missing value for --output/ },
    {
      name: "invalid sparse root",
      args: ["--sparse-root", "../outside"],
      error: /Sparse roots must be under specification/,
    },
    {
      name: "invalid specification",
      args: ["--specification", "../outside"],
      error: /Specification must be under specification/,
    },
    {
      name: "default non-Git cwd",
      args: [],
      error: /Invalid current directory: not a Git worktree/,
      cwd: nonGit,
    },
  ];

  for (const [index, item] of cases.entries()) {
    fs.writeFileSync(log, "");
    const output = path.join(root, `output-${index}`);
    const result = spawnSync(
      process.execPath,
      [
        "--import",
        pathToFileURL(guard).href,
        script,
        ...(item.omitScope ? [] : ["--specification", "specification/widget"]),
        ...(item.omitOutput ? [] : ["--output", output]),
        ...item.args,
      ],
      {
        cwd: item.cwd ?? repo,
        encoding: "utf8",
        env: { ...process.env, ASSESSMENT_STARTUP_LOG: log },
      },
    );
    assert.equal(result.status, 1, `${item.name}: ${result.stderr}`);
    assert.match(result.stderr, item.error, `${item.name}: ${result.stderr}`);
    const activity = fs
      .readFileSync(log, "utf8")
      .split(/\r?\n/)
      .filter(Boolean)
      .map((line) => JSON.parse(line) as Activity);
    assert.ok(
      activity.every(
        (entry) =>
          entry.kind === "process" &&
          entry.command === "git" &&
          (entry.args?.[2] === "rev-parse" || entry.args?.[2] === "remote"),
      ),
      `${item.name}: unexpected side effects ${JSON.stringify(activity)}`,
    );
    assert.equal(fs.existsSync(output), false, `${item.name}: output was created`);
    assert.equal(fs.readFileSync(file, "utf8"), "not a directory");
  }

  fs.writeFileSync(log, "");
  const validOutput = path.join(root, "valid-output");
  const valid = spawnSync(
    process.execPath,
    [
      "--import",
      pathToFileURL(guard).href,
      script,
      "--specification",
      "specification/widget",
      "--output",
      validOutput,
    ],
    {
      cwd: repo,
      encoding: "utf8",
      env: { ...process.env, ASSESSMENT_STARTUP_LOG: log },
    },
  );
  assert.equal(valid.status, 1, valid.stderr);
  assert.match(valid.stderr, /Unexpected dependency setup before validation/);
  assert.match(fs.readFileSync(log, "utf8"), /"kind":"dependency-setup"/);
  assert.equal(fs.existsSync(validOutput), false);

  fs.writeFileSync(log, "");
  const imported = spawnSync(
    process.execPath,
    [
      "--import",
      pathToFileURL(guard).href,
      "--input-type=module",
      "-e",
      `await import(${JSON.stringify(pathToFileURL(script).href)});`,
    ],
    {
      cwd: nonGit,
      encoding: "utf8",
      env: { ...process.env, ASSESSMENT_STARTUP_LOG: log },
    },
  );
  assert.equal(imported.status, 0, imported.stderr);
  assert.equal(fs.readFileSync(log, "utf8"), "");
});
