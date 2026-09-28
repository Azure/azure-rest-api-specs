import { execNodeBin } from "@azure-tools/specs-shared/exec";
import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { runNodeBin } from "../src/utils.ts";

vi.mock("@azure-tools/specs-shared/exec", async (importOriginal) => ({
  ...(await importOriginal()),
  execNodeBin: vi.fn(),
}));

describe("runNodeBin", () => {
  beforeEach(() => {
    vi.resetAllMocks();
  });

  it.each([new ConsoleLogger(false), new ConsoleLogger(true)])(
    "preserves command output with logger=%j",
    async (logger) => {
      vi.mocked(execNodeBin).mockResolvedValue({ stdout: "output", stderr: "diagnostic" });
      await expect(
        runNodeBin("prettier", ["prettier", "--version"], logger, "project"),
      ).resolves.toEqual([null, "output", "diagnostic"]);
      expect(execNodeBin).toHaveBeenCalledWith("prettier", ["prettier", "--version"], {
        cwd: "project",
        logger,
        maxBuffer: 64 * 1024 * 1024,
      });
    },
  );

  it("returns command failures and their diagnostics to the rule", async () => {
    const error = Object.assign(new Error("failed"), { stdout: "output", stderr: "diagnostic" });
    vi.mocked(execNodeBin).mockRejectedValue(error);
    await expect(runNodeBin("prettier", ["prettier"], defaultLogger)).resolves.toEqual([
      error,
      "output",
      "diagnostic",
    ]);
  });

  it("does not hide dependency resolution failures", async () => {
    const error = new Error("Cannot find module");
    vi.mocked(execNodeBin).mockRejectedValue(error);
    await expect(runNodeBin("missing", ["missing"], defaultLogger)).rejects.toBe(error);
  });
});
