import { SdkName } from "@azure-tools/specs-shared/sdk-types";
import fs from "node:fs";
import path from "node:path";
import { afterEach, beforeEach, describe, expect, test, vi } from "vitest";
import { LogIssueType, vsoLogIssue } from "../src/log.ts";
import { getGeneratedSdkApiVersions } from "../src/package-info.ts";
import { type ExecutionReport, type SpecGenSdkCmdInput } from "../src/types.ts";
import { runCommandWithOutput } from "../src/utils.ts";

vi.mock("../src/utils.ts", () => ({ runCommandWithOutput: vi.fn() }));
vi.mock("../src/log.ts", () => ({
  LogIssueType: { Warning: "warning" },
  vsoLogIssue: vi.fn(),
}));

const commandInput: SpecGenSdkCmdInput = {
  workingFolder: process.cwd(),
  runMode: "release",
  localSpecRepoPath: process.cwd(),
  localSdkRepoPath: path.resolve("sdk repo"),
  sdkRepoName: "azure-sdk-for-js",
  sdkLanguage: SdkName.Js,
  specCommitSha: "",
  specRepoHttpsUrl: "",
};

function report(...packagePaths: string[]): ExecutionReport {
  return {
    executionResult: "succeeded",
    packages: packagePaths.map((packageRootPath) => ({
      packageName: path.basename(packageRootPath),
      packageRootPath,
    })),
  };
}

function writePackageInfo(args: string[], packageInfo: unknown): void {
  const outputDir = args[args.indexOf("--out-dir") + 1];
  fs.writeFileSync(path.join(outputDir, "package.json"), JSON.stringify(packageInfo));
}

describe("getGeneratedSdkApiVersions", () => {
  beforeEach(() => {
    vi.resetAllMocks();
    vi.stubEnv("AZSDK", "");
  });

  afterEach(() => {
    vi.unstubAllEnvs();
  });

  test("reads a version without a namespace and uses the installed CLI", async () => {
    vi.stubEnv("AZSDK", path.resolve("tools", "azsdk"));
    let outputDir = "";
    vi.mocked(runCommandWithOutput).mockImplementation((_exe, args) => {
      outputDir = args[args.indexOf("--out-dir") + 1];
      writePackageInfo(args, { ApiVersions: [{ Version: "2024-01-01" }] });
      return Promise.resolve("Package info exported");
    });

    expect(await getGeneratedSdkApiVersions(report("sdk/example/package"), commandInput)).toBe(
      "API Versions: '2024-01-01'",
    );
    expect(runCommandWithOutput).toHaveBeenCalledWith(process.env.AZSDK, [
      "eng",
      "package-info",
      "--package-path",
      path.resolve(commandInput.localSdkRepoPath, "sdk/example/package"),
      "--out-dir",
      outputDir,
    ]);
    expect(fs.existsSync(outputDir)).toBe(false);
    expect(vsoLogIssue).not.toHaveBeenCalled();
  });

  test("preserves multiple versions and optional namespaces across all generated packages", async () => {
    vi.mocked(runCommandWithOutput)
      .mockImplementationOnce((_exe, args) => {
        writePackageInfo(args, {
          ApiVersions: [
            { Version: "2025-01-01", Namespace: "Example" },
            { Version: "2026-01-01", Namespace: "Other" },
          ],
        });
        return Promise.resolve("");
      })
      .mockImplementationOnce((_exe, args) => {
        writePackageInfo(args, {
          ApiVersions: [
            { Version: "2025-01-01", Namespace: "Example" },
            { Version: "2025-01-01", Namespace: "Another" },
            { Version: "2024-01-01", Namespace: null },
            { Version: "2023-01-01", Namespace: "" },
          ],
        });
        return Promise.resolve("");
      });

    const absolutePath = path.resolve(commandInput.localSdkRepoPath, "sdk/other/package");
    expect(
      await getGeneratedSdkApiVersions(report("sdk/example/package", absolutePath), commandInput),
    ).toBe(
      "API Versions: '2025-01-01' (Namespace: 'Example'), '2026-01-01' (Namespace: 'Other'), '2025-01-01' (Namespace: 'Another'), '2024-01-01', '2023-01-01'",
    );
    expect(runCommandWithOutput).toHaveBeenLastCalledWith(
      "azsdk",
      expect.arrayContaining(["--package-path", absolutePath]),
    );
  });

  test.each([
    {
      apiVersions: [
        { Version: "2025-01-01", Namespace: "Example" },
        { Version: "2026-01-01", Namespace: "Other" },
      ],
      expected:
        "API Versions: '2025-01-01' (Namespace: 'Example'), '2026-01-01' (Namespace: 'Other')",
    },
    {
      apiVersions: [
        { Version: "2025-01-01", Namespace: "Example" },
        { Version: "2025-01-01", Namespace: "Example" },
      ],
      expected: "API Versions: '2025-01-01' (Namespace: 'Example')",
    },
    {
      apiVersions: [{ Version: "2024-01-01" }, { Version: "2025-01-01" }],
      expected: "API Versions: '2024-01-01', '2025-01-01'",
    },
  ])("formats the inline version list as $expected", async ({ apiVersions, expected }) => {
    vi.mocked(runCommandWithOutput).mockImplementation((_exe, args) => {
      writePackageInfo(args, { ApiVersions: apiVersions });
      return Promise.resolve("");
    });
    expect(await getGeneratedSdkApiVersions(report("sdk/package"), commandInput)).toBe(expected);
  });

  test.each([{}, { ApiVersions: [] }, { ApiVersions: null }])(
    "omits the API version text when metadata has no versions: %j",
    async (packageInfo) => {
      vi.mocked(runCommandWithOutput).mockImplementation((_exe, args) => {
        writePackageInfo(args, packageInfo);
        return Promise.resolve("");
      });
      expect(await getGeneratedSdkApiVersions(report("sdk/package"), commandInput)).toBe("");
      expect(vsoLogIssue).not.toHaveBeenCalled();
    },
  );

  test.each([
    null,
    { ApiVersions: "2024-01-01" },
    { ApiVersions: [{ Version: 123 }] },
    { ApiVersions: [{ Version: "" }] },
    { ApiVersions: [{ Version: "2024-01-01", Namespace: 123 }] },
  ])("warns about malformed metadata: %j", async (packageInfo) => {
    vi.mocked(runCommandWithOutput).mockImplementation((_exe, args) => {
      writePackageInfo(args, packageInfo);
      return Promise.resolve("");
    });
    expect(await getGeneratedSdkApiVersions(report("sdk/package"), commandInput)).toBe("");
    expect(vsoLogIssue).toHaveBeenCalledWith(
      expect.stringContaining("Unable to collect API versions"),
      LogIssueType.Warning,
    );
  });

  test("warns on missing output instead of reading stale metadata", async () => {
    vi.mocked(runCommandWithOutput).mockResolvedValue("");
    expect(await getGeneratedSdkApiVersions(report("sdk/package"), commandInput)).toBe("");
    expect(vsoLogIssue).toHaveBeenCalledWith(
      expect.stringContaining("did not produce any package info JSON files"),
      LogIssueType.Warning,
    );
  });

  test("warns on invalid JSON and cleans up the output directory", async () => {
    let outputDir = "";
    vi.mocked(runCommandWithOutput).mockImplementation((_exe, args) => {
      outputDir = args[args.indexOf("--out-dir") + 1];
      fs.writeFileSync(path.join(outputDir, "package.json"), "{invalid");
      return Promise.resolve("");
    });
    expect(await getGeneratedSdkApiVersions(report("sdk/package"), commandInput)).toBe("");
    expect(vsoLogIssue).toHaveBeenCalledWith(
      expect.stringContaining("SyntaxError"),
      LogIssueType.Warning,
    );
    expect(fs.existsSync(outputDir)).toBe(false);
  });

  test("continues collecting other packages after a CLI failure, even for failed builds", async () => {
    vi.mocked(runCommandWithOutput)
      .mockRejectedValueOnce(new Error("CLI failed"))
      .mockImplementationOnce((_exe, args) => {
        writePackageInfo(args, { ApiVersions: [{ Version: "2024-01-01" }] });
        return Promise.resolve("");
      });
    const executionReport = report("sdk/failed", "sdk/succeeded");
    executionReport.executionResult = "failed";
    expect(await getGeneratedSdkApiVersions(executionReport, commandInput)).toBe(
      "API Versions: '2024-01-01'",
    );
    expect(vsoLogIssue).toHaveBeenCalledWith(
      expect.stringContaining("CLI failed"),
      LogIssueType.Warning,
    );
  });

  test("warns when a package path is missing and skips packages that were not generated", async () => {
    expect(
      await getGeneratedSdkApiVersions(
        { executionResult: "failed", packages: [{ packageName: "unknown" }] },
        commandInput,
      ),
    ).toBe("");
    expect(vsoLogIssue).toHaveBeenCalledWith(
      "Cannot collect API versions: no packageRootPath for unknown",
      LogIssueType.Warning,
    );
    expect(await getGeneratedSdkApiVersions(report(), commandInput)).toBe("");
    expect(runCommandWithOutput).not.toHaveBeenCalled();
  });
});
