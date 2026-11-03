import { spawnSync } from "node:child_process";
import fs from "node:fs";
import { fileURLToPath } from "node:url";
import { expect, test, vi } from "vitest";
import { parse } from "yaml";
import { parseArguments, prepareSpecGenSdkCommand } from "../src/command-helpers.ts";

interface ScriptStep {
  displayName?: string;
  script?: string;
  env?: Record<string, string>;
}

const template = parse(
  fs.readFileSync(
    new URL("../../../pipelines/templates/stages/archetype-spec-gen-sdk.yml", import.meta.url),
    "utf8",
  ),
) as { stages: { jobs: { steps: ScriptStep[] }[] }[] };
const generateStep = template.stages[0].jobs[0].steps.find(
  (step) => step.displayName === "Generate SDK",
);

test.each([
  { name: "configured", value: "@azure-tools/typespec-ts-provisioning" },
  { name: "unset macro", value: "$(TypeSpecEmitter)" },
  { name: "empty", value: "" },
  { name: "missing environment variable", value: undefined },
  { name: "shell metacharacters", value: "@scope/emitter with spaces; 'quoted' \"$(exit 1)\" *" },
])("handles $name TypeSpecEmitter in the generation script", ({ value }) => {
  expect(generateStep?.env?.TYPE_SPEC_EMITTER).toBe("$(TypeSpecEmitter)");
  expect(generateStep?.script).toBeTypeOf("string");
  if (!generateStep?.script) {
    throw new Error("Generate SDK script is missing");
  }

  const variables: Record<string, string> = {
    "Build.Reason": "Manual",
    SpecRepoCommit: "HEAD",
    SpecRepoDirectory: "/spec",
    SdkRepoDirectory: "/sdk",
    SdkRepoName: "azure-sdk-for-js",
    "System.DefaultWorkingDirectory": "/work",
    "System.CollectionUri": "https://dev.azure.com/",
    "System.TeamProject": "test",
    "Build.BuildId": "123",
  };
  if (value !== undefined && value !== "$(TypeSpecEmitter)") {
    variables.TypeSpecEmitter = value;
  }
  // Model Azure DevOps macro expansion, including leaving unknown macros intact.
  const script = generateStep.script
    .replace(/\$\{\{\s*parameters\.(\w+)\s*\}\}/g, (_, name: string) =>
      name === "SpecRepoUrl" ? "https://github.com/Azure/azure-rest-api-specs" : "",
    )
    .replace(/\$\(([^)]+)\)/g, (macro: string, name: string) => variables[name] ?? macro);
  const env = { ...process.env };
  if (value === undefined) {
    delete env.TYPE_SPEC_EMITTER;
  } else {
    env.TYPE_SPEC_EMITTER = value;
  }
  const result = spawnSync(
    "bash",
    [
      "-c",
      `
npm() { :; }
pnpm() { :; }
cd() { :; }
node() { printf '__RUNNER_ARGS__'; printf '%s\\0' "$@"; }
${script}
`,
    ],
    {
      cwd: fileURLToPath(new URL(".", import.meta.url)),
      env,
      encoding: "utf8",
    },
  );
  expect(result.error).toBeUndefined();
  expect(result.status, result.stderr).toBe(0);
  const marker = "__RUNNER_ARGS__";
  expect(result.stdout).toContain(marker);
  const args = result.stdout.slice(result.stdout.indexOf(marker) + marker.length).split("\0");
  expect(args.pop()).toBe("");
  expect(args.shift()).toBe("/spec/eng/tools/spec-gen-sdk-runner/cmd/spec-gen-sdk-runner.js");
  const expectedEmitter = value && value !== "$(TypeSpecEmitter)" ? value : undefined;
  expect(args.filter((arg) => arg === "--typespec-emitter")).toHaveLength(expectedEmitter ? 1 : 0);

  const argv = vi.spyOn(process, "argv", "get").mockReturnValue(["node", "runner", ...args]);
  try {
    const input = parseArguments();
    expect(input.typespecEmitter).toBe(expectedEmitter);
    const command = prepareSpecGenSdkCommand(input);
    if (expectedEmitter) {
      expect(command.slice(-2)).toEqual(["--typespec-emitter", expectedEmitter]);
    } else {
      expect(command).not.toContain("--typespec-emitter");
    }
  } finally {
    argv.mockRestore();
  }
});
