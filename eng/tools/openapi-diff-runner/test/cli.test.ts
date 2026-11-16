import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";
import { parseCliArguments } from "../src/index.ts";

const command = fileURLToPath(new URL("../cmd/openapi-diff-runner.js", import.meta.url));

describe("CLI arguments", () => {
  it("preserves short aliases, defaults, and repeated-option precedence", () => {
    expect(
      parseCliArguments([
        "-n",
        "123",
        "-p",
        ".",
        "-r",
        "target/specs",
        "-s",
        "source/specs",
        "-t",
        "CrossVersion",
        "-b",
        "release",
        "-c",
        "abc",
        "--pr-source-branch",
        "feature",
        "--pr-target-branch",
        "main",
        "--pr-number=456",
      ]),
    ).toEqual({
      localSpecRepoPath: process.cwd(),
      targetRepo: "target/specs",
      sourceRepo: "source/specs",
      prNumber: "456",
      runType: "CrossVersion",
      baseBranch: "release",
      headCommit: "abc",
      prSourceBranch: "feature",
      prTargetBranch: "main",
    });
    expect(parseCliArguments(["--pr-number", "123"])).toMatchObject({
      targetRepo: "azure/azure-rest-api-specs",
      sourceRepo: "azure/azure-rest-api-specs",
      runType: "SameVersion",
      baseBranch: "main",
      headCommit: "HEAD",
      prSourceBranch: "",
      prTargetBranch: "",
    });
  });

  it.each(["--help", "-h"])("exits successfully for %s without requiring a PR", (flag) => {
    const result = spawnSync(process.execPath, [command, flag], { encoding: "utf8" });
    expect(result.status).toBe(0);
    expect(result.stdout).toContain("Usage:");
    expect(result.stdout).toContain("--pr-number");
    expect(result.stdout).toContain("--pr-target-branch");
    expect(result.stdout).not.toContain("Current working directory:");
  });

  it.each([
    [[], "--pr-number (PR number) is required"],
    [["--pr-number", "123", "--run-type", "invalid"], "--run-type must be one of"],
    [["--pr-number", "123", "--unknown"], "Error parsing arguments:"],
    [["--pr-number"], "Error parsing arguments:"],
    [["--pr-number", "123", "extra"], "Error parsing arguments:"],
    [["--help", "--unknown"], "Error parsing arguments:"],
  ])("rejects invalid arguments %j with a failing exit code", (args, message) => {
    const result = spawnSync(process.execPath, [command, ...args], { encoding: "utf8" });
    expect(result.status).toBe(1);
    expect(result.stdout + result.stderr).toContain(message);
    expect(result.stdout).not.toContain("Current working directory:");
  });
});
