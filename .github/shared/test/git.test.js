// @ts-check

import { describe, expect, it, vi } from "vitest";
import * as exec from "../src/exec.js";
import { diff, lsTree, show } from "../src/git.js";

describe("git", () => {
  describe("e2e", () => {
    it("diff", async () => {
      await expect(diff("HEAD", "HEAD")).resolves.toBe("");
    });

    it("lsTree", async () => {
      // lsTree always uses "\n" in output, even on windows
      const expected = ".github\n";

      await expect(
        lsTree("HEAD", ".github", { args: "--full-tree --name-only" }),
      ).resolves.toBe(expected);
    });

    it("show", async () => {
      await expect(
        show("HEAD", ".github/shared/package.json"),
      ).resolves.toContain("scripts");
    });
  });

  describe("mocked", () => {
    it("diff", async () => {
      const execSpy = vi.spyOn(exec, "exec").mockResolvedValue("test diff");

      await expect(diff("HEAD^", "HEAD")).resolves.toBe("test diff");

      expect(execSpy).toBeCalledWith(
        "git -c core.quotepath=off diff HEAD^ HEAD",
        expect.anything(),
      );
    });

    it("lsTree", async () => {
      const execSpy = vi.spyOn(exec, "exec").mockResolvedValue("test lstree");

      await expect(
        lsTree("HEAD", "specification/contosowidgetmanager"),
      ).resolves.toBe("test lstree");

      expect(execSpy).toBeCalledWith(
        "git -c core.quotepath=off ls-tree HEAD specification/contosowidgetmanager",
        expect.anything(),
      );
    });

    it("show", async () => {
      const execSpy = vi.spyOn(exec, "exec").mockResolvedValue("test show");

      await expect(
        show("HEAD", "specification/contosowidgetmanager/cspell.yaml"),
      ).resolves.toBe("test show");

      expect(execSpy).toBeCalledWith(
        "git -c core.quotepath=off show HEAD:specification/contosowidgetmanager/cspell.yaml",
        expect.anything(),
      );
    });
  });
});
