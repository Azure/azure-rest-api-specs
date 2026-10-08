import { resolve } from "node:path";
import { afterEach, expect, it, vi } from "vitest";
import { checkRequirements } from "../src/check-requirements.ts";

afterEach(() => vi.restoreAllMocks());

it("returns brownfield and reports through the injected reporter", async () => {
  const version =
    "hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01";
  const reporter = {
    info: vi.fn(),
    warning: vi.fn(),
    warningForFile: vi.fn(),
    error: vi.fn(),
    errorForFile: vi.fn(),
    jobFailure: vi.fn(),
  };
  const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
  const result = await checkRequirements(
    {
      repoRoot: resolve(import.meta.dirname, "../../../.."),
      baseCommitish: "HEAD^",
      headCommitish: "HEAD",
      checkAllUnder: resolve(import.meta.dirname, "specification", version),
      responseCache: {
        [`https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${version}`]: 200,
      },
    },
    reporter,
  );

  expect(result).toEqual({ brownfield: true, exitCode: 0 });
  expect(reporter.warningForFile).toHaveBeenCalledOnce();
  expect(stdout).not.toHaveBeenCalled();
});
