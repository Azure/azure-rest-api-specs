import { spawnSync } from "node:child_process";
import { cp, mkdir, mkdtemp, realpath, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { afterEach, beforeEach, describe, expect, it } from "vitest";

const repoRoot = fileURLToPath(new URL("../../../", import.meta.url));
const oxlint = fileURLToPath(new URL("./bin/oxlint", import.meta.resolve("oxlint/package.json")));

describe.each([
  {
    name: "assessment script",
    skillPath: ".github/skills/azure-typespec-assessment",
    script: "scripts/example.ts",
  },
  {
    name: "SDK naming eval",
    skillPath: ".github/skills/azure-typespec-sdk-naming/evals",
    script: "fixtures/example.mjs",
  },
])("$name lint configuration", { timeout: 60_000 }, ({ skillPath, script }) => {
  const scriptPath = `${skillPath}/${script}`;
  let fixture: string;

  beforeEach(async () => {
    fixture = await mkdtemp(join(tmpdir(), "skill-lint-"));
    for (const path of [
      ".oxlintrc.json",
      "tsconfig.base.json",
      "tsconfig.json",
      ".github/tsconfig.json",
      `${skillPath}/tsconfig.json`,
    ]) {
      const destination = join(fixture, path);
      await mkdir(dirname(destination), { recursive: true });
      await cp(join(repoRoot, path), destination);
    }
    await symlink(
      await realpath(join(repoRoot, "node_modules")),
      join(fixture, "node_modules"),
      "junction",
    );
    await mkdir(dirname(join(fixture, scriptPath)), { recursive: true });
    await writeFile(join(fixture, dirname(scriptPath), "runtime-types.d.ts"), "export {};\n");
  });

  afterEach(async () => {
    await rm(fixture, { recursive: true, force: true, maxRetries: 5, retryDelay: 100 });
  });

  const invocations = [
    { name: "repository root", cwd: ".", path: "." },
    { name: "GitHub package", cwd: ".github", path: "." },
    { name: "individual file", cwd: ".", path: scriptPath },
  ];

  function lint(cwd: string, path: string) {
    return spawnSync(process.execPath, [oxlint, "--format=unix", path], {
      cwd: join(fixture, cwd),
      encoding: "utf8",
      timeout: 60_000,
    });
  }

  it.each(invocations)("resolves Node.js types from the $name", async ({ cwd, path }) => {
    await writeFile(
      join(fixture, scriptPath),
      [
        'import crypto from "node:crypto";',
        'import path from "node:path";',
        'const digest = crypto.createHash("sha256").update("example").digest("hex");',
        'console.log(path.join("output", digest.slice(0, 16)));',
      ].join("\n"),
    );

    const result = lint(cwd, path);

    expect(result.error).toBeUndefined();
    expect(result.status, result.stdout + result.stderr).toBe(0);
  });

  it.each(invocations)("still rejects floating promises from the $name", async ({ cwd, path }) => {
    await writeFile(
      join(fixture, scriptPath),
      'import { readFile } from "node:fs/promises";\nreadFile("example.txt");\n',
    );

    const result = lint(cwd, path);

    expect(result.error).toBeUndefined();
    expect(result.status, result.stdout + result.stderr).toBe(1);
    expect(result.stdout + result.stderr).toContain("typescript(no-floating-promises)");
    expect(result.stdout + result.stderr).not.toContain("no-unsafe");
  });
});
