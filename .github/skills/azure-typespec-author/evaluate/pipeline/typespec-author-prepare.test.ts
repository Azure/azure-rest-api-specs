import assert from "node:assert/strict";
import { execFileSync, spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { test } from "node:test";
import { z } from "zod";

import { configureSkillEnvironments, prepareBenchmark } from "./typespec-author-prepare.ts";

const preparedConfigSchema = z
  .object({
    environments: z
      .object({
        sdk: z
          .object({
            skills: z.array(z.string()),
            mcpServers: z.object({ sdk: z.object({ cwd: z.string() }).passthrough() }),
          })
          .passthrough(),
        "azsdk-mcp": z
          .object({
            mcpServers: z.object({
              "azure-sdk-mcp": z
                .object({
                  command: z.string(),
                  args: z.array(z.string()),
                  cwd: z.string(),
                  timeout: z.string(),
                  env: z.record(z.string(), z.string()),
                })
                .passthrough(),
            }),
          })
          .passthrough(),
      })
      .passthrough(),
  })
  .passthrough();

function readPreparedConfig(filePath: string) {
  return preparedConfigSchema.parse(JSON.parse(fs.readFileSync(filePath, "utf8")) as unknown);
}

function createMcpBinary(root: string, kind: "live" | "mock") {
  const file = path.join(
    root,
    "artifacts",
    "mcp",
    kind === "live" ? "cli" : "mock",
    kind === "live" ? "azsdk.dll" : "azsdk-mock.dll",
  );
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, "");
  return file;
}

function fixture(t: { after: (fn: () => void) => void }, naming = true, required = true) {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "typespec-skill-config with spaces-"));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  const author = path.join(root, "azure-typespec-author");
  const evalRoot = path.join(author, "evaluate");
  fs.mkdirSync(evalRoot, { recursive: true });
  for (const name of ["azure-typespec-author", ...(naming ? ["azure-typespec-sdk-naming"] : [])]) {
    const dir = path.join(root, name);
    fs.mkdirSync(path.join(dir, "references"), { recursive: true });
    fs.mkdirSync(path.join(dir, "evals"), { recursive: true });
    fs.writeFileSync(
      path.join(dir, "SKILL.md"),
      name === "azure-typespec-author" && required ? "Depends on azure-typespec-sdk-naming" : name,
    );
    fs.writeFileSync(path.join(dir, "references", "rules.md"), name);
    fs.writeFileSync(path.join(dir, "evals", "secret-grader.yaml"), "must not leak");
  }
  const environments = {
    sdk: {
      skills: ["../..", "../../../azure-typespec-sdk-naming"],
      mcpServers: { sdk: { cwd: "../../.." } },
    },
    "azsdk-mcp": {
      mcpServers: {
        "azure-sdk-mcp": {
          type: "stdio",
          command: "node",
          args: ["local-launcher.cjs"],
          cwd: root,
          timeout: "5m",
          env: { AZURE_SDK_KB_ENDPOINT: "https://example.test" },
        },
      },
    },
  };
  createMcpBinary(root, "live");
  createMcpBinary(root, "mock");
  return { root, evalRoot, environments, stage: path.join(root, "runtime", "skills") };
}

void test("mounts declared definitions and references, never evaluators or fixture dependencies", (t) => {
  const { root, evalRoot, environments, stage } = fixture(t);
  configureSkillEnvironments(environments, evalRoot, false, stage);
  assert.equal(environments.sdk.skills.length, 2);
  for (const skill of environments.sdk.skills) {
    assert.deepEqual(fs.readdirSync(skill).sort(), ["SKILL.md", "references"]);
    assert.equal(
      fs.readFileSync(path.join(skill, "references", "rules.md"), "utf8"),
      path.basename(skill),
    );
    assert.ok(path.isAbsolute(skill));
  }
  assert.equal(environments.sdk.mcpServers.sdk.cwd, path.resolve(evalRoot, "../../.."));
  assert.ok(fs.existsSync(path.join(root, "azure-typespec-author", "evals", "secret-grader.yaml")));
});

void test("no-skill mode overrides explicit mounts and does not stage source skills", (t) => {
  const { evalRoot, environments, stage } = fixture(t);
  configureSkillEnvironments(environments, evalRoot, true, stage);
  assert.deepEqual(environments.sdk.skills, []);
  assert.equal(fs.existsSync(stage), false);
});

void test("a branch predating naming mounts only its own authoring skill", (t) => {
  const { evalRoot, environments, stage } = fixture(t, false, false);
  configureSkillEnvironments(environments, evalRoot, false, stage);
  assert.deepEqual(
    environments.sdk.skills.map((entry) => path.basename(entry)),
    ["azure-typespec-author"],
  );
  assert.equal(fs.existsSync(path.join(stage, "azure-typespec-sdk-naming")), false);
});

void test("a missing required naming dependency remains an explicit error", (t) => {
  const { evalRoot, environments, stage } = fixture(t, false, true);
  assert.throws(
    () => configureSkillEnvironments(environments, evalRoot, false, stage),
    /Missing declared benchmark skill: .*azure-typespec-sdk-naming/,
  );
});

void test("missing non-naming inputs are not silently omitted", (t) => {
  const { evalRoot, environments, stage } = fixture(t);
  environments.sdk.skills.push("../../../missing-skill");
  assert.throws(
    () => configureSkillEnvironments(environments, evalRoot, false, stage),
    /Missing declared benchmark skill: .*missing-skill/,
  );
});

for (const [mode, kind] of ["forced", "trigger", "no-skill"].flatMap((mode) =>
  ["live", "mock"].map((kind) => [mode, kind]),
)) {
  void test(`${mode}/${kind} prepares direct MCP startup and isolated skill inputs`, async (t) => {
    const { root, evalRoot, environments, stage } = fixture(t);
    fs.writeFileSync(path.join(evalRoot, ".vally.yaml"), JSON.stringify({ environments }));
    await prepareBenchmark(evalRoot, mode, stage, kind);
    const prepared = readPreparedConfig(path.join(evalRoot, ".vally.yaml")).environments;
    const skills: string[] = prepared.sdk.skills;
    if (mode === "no-skill") {
      assert.deepEqual(skills, []);
      assert.equal(fs.existsSync(stage), false);
    } else {
      assert.equal(skills.length, 2);
      for (const skill of skills) {
        assert.ok(path.isAbsolute(skill));
        assert.deepEqual(fs.readdirSync(skill).sort(), ["SKILL.md", "references"]);
      }
    }
    assert.equal(prepared.sdk.mcpServers.sdk.cwd, path.resolve(evalRoot, "../../.."));
    const server = prepared["azsdk-mcp"].mcpServers["azure-sdk-mcp"];
    const expectedDll = path.join(
      root,
      "artifacts",
      "mcp",
      kind === "live" ? "cli" : "mock",
      kind === "live" ? "azsdk.dll" : "azsdk-mock.dll",
    );
    assert.equal(server.command, "dotnet");
    assert.deepEqual(server.args, kind === "live" ? [expectedDll, "mcp"] : [expectedDll]);
    assert.equal(server.cwd, root);
    assert.equal(server.timeout, environments["azsdk-mcp"].mcpServers["azure-sdk-mcp"].timeout);
    assert.deepEqual(server.env, environments["azsdk-mcp"].mcpServers["azure-sdk-mcp"].env);
  });
}

void test("invalid MCP kinds and missing binaries fail before writing prepared configuration", async (t) => {
  const { root, evalRoot, environments, stage } = fixture(t);
  const configPath = path.join(evalRoot, ".vally.yaml");
  const original = JSON.stringify({ environments });
  fs.writeFileSync(configPath, original);
  for (const kind of ["", "LIVE", "unknown"]) {
    await assert.rejects(
      prepareBenchmark(evalRoot, "forced", stage, kind),
      /AZSDK_EVAL_MCP_KIND must be live or mock/,
    );
  }
  for (const kind of ["live", "mock"] as const) {
    const file = createMcpBinary(root, kind);
    fs.unlinkSync(file);
    await assert.rejects(
      prepareBenchmark(evalRoot, "forced", stage, kind),
      /Prebuilt .* MCP binary does not exist/,
    );
    fs.mkdirSync(file);
    await assert.rejects(
      prepareBenchmark(evalRoot, "forced", stage, kind),
      /Prebuilt .* MCP binary does not exist or is not a file/,
    );
  }
  assert.equal(fs.readFileSync(configPath, "utf8"), original);
  assert.equal(fs.existsSync(stage), false);
});

void test("the prepare CLI reads the pipeline MCP kind and rejects a missing selection", (t) => {
  const { evalRoot, environments, stage } = fixture(t);
  const configPath = path.join(evalRoot, ".vally.yaml");
  fs.writeFileSync(configPath, JSON.stringify({ environments }));
  const args = [
    "--experimental-strip-types",
    path.join(import.meta.dirname, "typespec-author-prepare.ts"),
    "--prepare",
    "--eval-root",
    evalRoot,
    "--mode",
    "no-skill",
    "--skill-root",
    stage,
  ];
  const env = { ...process.env };
  delete env.AZSDK_EVAL_MCP_KIND;
  const missing = spawnSync(process.execPath, args, { env, encoding: "utf8" });
  assert.ifError(missing.error);
  assert.equal(missing.status, 1);
  assert.match(missing.stderr, /AZSDK_EVAL_MCP_KIND must be live or mock/);
  execFileSync(process.execPath, args, {
    env: { ...env, AZSDK_EVAL_MCP_KIND: "live" },
    stdio: "pipe",
  });
  const server =
    readPreparedConfig(configPath).environments["azsdk-mcp"].mcpServers["azure-sdk-mcp"];
  assert.equal(server.command, "dotnet");
  assert.equal(server.args[1], "mcp");
});
