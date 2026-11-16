import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { describe, expect, it } from "vitest";

const command = fileURLToPath(new URL("../cmd/spec-gen-sdk-runner.js", import.meta.url));

describe("CLI help", () => {
  it.each(["--help", "-h"])("exits successfully for %s without starting generation", (flag) => {
    const result = spawnSync(process.execPath, [command, flag], { encoding: "utf8" });
    expect(result.status).toBe(0);
    expect(result.stdout).toContain("Usage:");
    expect(result.stdout).toContain("--typespec-emitter");
    expect(result.stdout).toContain("--batch-type");
    expect(result.stdout).not.toContain("Current working directory:");
  });
});
