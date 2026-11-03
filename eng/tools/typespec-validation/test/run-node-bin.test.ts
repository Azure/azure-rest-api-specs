import { execNodeBin } from "@azure-tools/specs-shared/exec";
import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { runNodeBin } from "../src/utils.ts";

vi.mock("@azure-tools/specs-shared/exec", async (importOriginal) => ({
  ...(await importOriginal()),
  execNodeBin: vi.fn(),
}));

describe("runNodeBin", () => {
  beforeEach(() => {
    vi.resetAllMocks();
    vi.stubEnv("NO_COLOR", "1");
  });
  afterEach(() => vi.unstubAllEnvs());

  it.each([new ConsoleLogger(false), new ConsoleLogger(true)])(
    "preserves command output with logger=%j",
    async (logger) => {
      vi.mocked(execNodeBin).mockResolvedValue({ stdout: "output", stderr: "diagnostic" });
      await expect(
        runNodeBin("prettier", ["prettier", "--version"], logger, "project"),
      ).resolves.toEqual([null, "output", "diagnostic"]);
      expect(execNodeBin).toHaveBeenCalledWith("prettier", ["prettier", "--version"], {
        cwd: "project",
        env: expect.objectContaining({ NO_COLOR: "1" }) as unknown,
        maxBuffer: 64 * 1024 * 1024,
      });
    },
  );

  it.each([
    { noColor: undefined, forceColor: "1", expected: "1" },
    { noColor: "1", forceColor: "1", expected: undefined },
    { noColor: undefined, forceColor: "0", expected: undefined },
  ])(
    "passes a consistent per-command color policy: %j",
    async ({ noColor, forceColor, expected }) => {
      vi.stubEnv("NO_COLOR", noColor);
      vi.stubEnv("FORCE_COLOR", forceColor);
      vi.mocked(execNodeBin).mockResolvedValue({ stdout: "", stderr: "" });
      await runNodeBin("prettier", ["prettier"], defaultLogger);
      const options = vi.mocked(execNodeBin).mock.calls[0][2];
      expect(options?.env?.FORCE_COLOR).toBe(expected);
      expect(options?.env?.NO_COLOR).toBe(expected ? undefined : "1");
      expect(process.env.NO_COLOR).toBe(noColor);
      expect(process.env.FORCE_COLOR).toBe(forceColor);
      // The rule, not the shared command helper, renders captured streams.
      expect(options?.logger).toBeUndefined();
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
