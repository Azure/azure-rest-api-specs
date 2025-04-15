// @ts-check

import { describe, expect, it } from "vitest";
import { diff, lsTree, show, status } from "../src/git.js";
import { ConsoleLogger } from "../src/logger.js";

const gitOpts = { logger: new ConsoleLogger(/*isDebug*/ true) };

describe("git.e2e", () => {
  it("diff", async () => {
    await expect(diff("HEAD", "HEAD", gitOpts)).resolves.toBe("");
  });

  it("lsTree", async () => {
    // lsTree always uses "\n" in output, even on windows
    const expected = ".github\n";

    await expect(
      lsTree("HEAD", ".github", {
        args: ["--full-tree", "--name-only"],
        ...gitOpts,
      }),
    ).resolves.toBe(expected);
  });

  it("show", async () => {
    await expect(
      show("HEAD", ".github/shared/package.json"),
    ).resolves.toContain("scripts");
  });

  it("status", async () => {
    // example: "## main...origin/main"
    await expect(
      status({ args: ["-b", "--porcelain", "does-not-exist"] }),
    ).resolves.toContain("##");
  });
});
