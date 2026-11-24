import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";

const command = fileURLToPath(new URL("../cmd/spec-gen-sdk-runner.js", import.meta.url));

describe("CLI arguments", () => {
  it.each(["--help", "-h"])("exits successfully for %s without starting generation", (flag) => {
    const result = spawnSync(process.execPath, [command, flag], { encoding: "utf8" });
    expect(result.status).toBe(0);
    expect(result.stdout).toContain("Usage:");
    expect(result.stdout).toContain("--typespec-emitter");
    expect(result.stdout).toContain("--batch-type");
    expect(result.stdout).not.toContain("##vso[task.complete result=Failed;]");
    expect(result.stdout).not.toContain("Current working directory:");
  });

  it.each([
    [["--commit"], "ERR_PARSE_ARGS_INVALID_OPTION_VALUE"],
    [["--unknown"], "ERR_PARSE_ARGS_UNKNOWN_OPTION"],
    [["extra"], "ERR_PARSE_ARGS_UNEXPECTED_POSITIONAL"],
  ])("rejects malformed invocation %j before generation starts", (args, code) => {
    const result = spawnSync(process.execPath, [command, ...args], { encoding: "utf8" });
    expect(result.status).toBe(1);
    expect(result.stderr).toContain(code);
    expect(result.stdout).toContain("##vso[task.complete result=Failed;]");
    expect(result.stdout).not.toContain("Current working directory:");
  });
});
