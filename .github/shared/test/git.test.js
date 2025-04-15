// @ts-check

import { describe, expect, it, vi } from "vitest";
import * as exec from "../src/exec.js";
import { diff, lsTree, show, status } from "../src/git.js";

describe("git", () => {
  describe("e2e", () => {
    it("diff", async () => {
      await expect(diff("HEAD", "HEAD")).resolves.toEqual({
        stdout: "",
        stderr: "",
      });
    });

    it("lsTree", async () => {
      // lsTree always uses "\n" in output, even on windows
      const expected = { stdout: ".github\n", stderr: "" };

      await expect(
        lsTree("HEAD", ".github", { args: ["--full-tree", "--name-only"] }),
      ).resolves.toEqual(expected);
    });

    it("show", async () => {
      await expect(
        show("HEAD", ".github/shared/package.json"),
      ).resolves.toEqual({
        stdout: expect.stringContaining("scripts"),
        stderr: "",
      });
    });

    it("status", async () => {
      // example: "## main...origin/main"
      await expect(
        status({ args: ["-b", "--porcelain", "does-not-exist"] }),
      ).resolves.toEqual({
        stdout: expect.stringContaining("##"),
        stderr: "",
      });
    });
  });

  describe("mocked", () => {
    it("diff", async () => {
      const execResult = { stdout: "test diff", stderr: "" };

      const execSpy = vi.spyOn(exec, "execFile").mockResolvedValue(execResult);

      await expect(diff("HEAD^", "HEAD")).resolves.toBe(execResult);

      expect(execSpy).toBeCalledWith(
        "git",
        ["-c", "core.quotepath=off", "diff", "HEAD^", "HEAD"],
        expect.anything(),
      );
    });

    it("lsTree", async () => {
      const execResult = { stdout: "test lstree", stderr: "" };

      const execSpy = vi.spyOn(exec, "execFile").mockResolvedValue(execResult);

      await expect(
        lsTree("HEAD", "specification/contosowidgetmanager"),
      ).resolves.toBe(execResult);

      expect(execSpy).toBeCalledWith(
        "git",
        [
          "-c",
          "core.quotepath=off",
          "ls-tree",
          "HEAD",
          "specification/contosowidgetmanager",
        ],
        expect.anything(),
      );
    });

    it("show", async () => {
      const execResult = { stdout: "test show", stderr: "" };

      const execSpy = vi.spyOn(exec, "execFile").mockResolvedValue(execResult);

      await expect(
        show("HEAD", "specification/contosowidgetmanager/cspell.yaml"),
      ).resolves.toBe(execResult);

      expect(execSpy).toBeCalledWith(
        "git",
        [
          "-c",
          "core.quotepath=off",
          "show",
          "HEAD:specification/contosowidgetmanager/cspell.yaml",
        ],
        expect.anything(),
      );
    });

    it("status", async () => {
      const execResult = { stdout: "test status", stderr: "" };

      const execSpy = vi.spyOn(exec, "execFile").mockResolvedValue(execResult);

      await expect(
        status({ args: ["-b", "--porcelain", "does-not-exist"] }),
      ).resolves.toBe(execResult);

      expect(execSpy).toBeCalledWith(
        "git",
        [
          "-c",
          "core.quotepath=off",
          "status",
          "-b",
          "--porcelain",
          "does-not-exist",
        ],
        expect.anything(),
      );
    });
  });
});
