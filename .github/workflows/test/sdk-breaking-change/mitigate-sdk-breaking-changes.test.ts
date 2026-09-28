import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { ExecFileOptions, ExecResult } from "../../../shared/src/exec.ts";

const { execFileMock } = vi.hoisted(() => ({
  execFileMock:
    vi.fn<(file: string, args?: string[], options?: ExecFileOptions) => Promise<ExecResult>>(),
}));

vi.mock("../../../shared/src/exec.ts", () => ({ execFile: execFileMock }));

import {
  mitigateSdkBreakingChanges,
  MitigationResultSchema,
} from "../../src/sdk-breaking-change/mitigate-sdk-breaking-changes.ts";

let temporaryDirectory: string;
let analysisResultPath: string;
let mitigationResultPath: string;
let specificationRepositoryPath: string;

beforeEach(async () => {
  temporaryDirectory = join(import.meta.dirname, `mitigation-${crypto.randomUUID()}`);
  analysisResultPath = join(temporaryDirectory, "sdk-breaking-change-analysis.json");
  mitigationResultPath = join(temporaryDirectory, "results", "sdk-breaking-change-mitigation.json");
  specificationRepositoryPath = join(temporaryDirectory, "specs");
  await mkdir(join(specificationRepositoryPath, "specification", "service", "Widget.Service"), {
    recursive: true,
  });
  await writeFile(
    analysisResultPath,
    JSON.stringify({
      schemaVersion: 1,
      prNumber: 42,
      headSha: "a".repeat(40),
      sdkLanguage: "Java",
      analysisWorkflowUrl: "https://github.com/owner/repo/actions/runs/123",
      status: "success",
      projects: [
        {
          typespecProject: "specification/service/Widget.Service",
          sdkPackage: "armwidget",
          breakingChanges: [
            {
              breakingChange: "Model changed",
              category: "spec change",
              suggestedFix: "Restore compatibility",
            },
          ],
        },
      ],
    }),
  );

  execFileMock.mockResolvedValue({
    stdout: `${JSON.stringify({
      result: {
        success: true,
        typeSpecChangesSummary: ["Added client customization"],
      },
    })}\n`,
    stderr: "",
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("mitigateSdkBreakingChanges", () => {
  it("runs customization and writes a cleaned mitigation result", async () => {
    await mitigateSdkBreakingChanges({
      analysisResultPath,
      mitigationResultPath,
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      specificationRepositoryPath,
      resultDirPath: temporaryDirectory,
      azureSdkCliPath: join(temporaryDirectory, "azsdk"),
    });

    const result = MitigationResultSchema.parse(
      JSON.parse(await readFile(mitigationResultPath, "utf8")),
    );
    expect(result.projects[0].breakingChanges).toEqual([
      {
        breakingChange: "Model changed",
        suggestedFix: "Restore compatibility",
        isResolved: true,
        typespecChangesSummary: ["Added client customization"],
      },
    ]);
    const [command, args, options] = execFileMock.mock.calls[0];
    expect(command).toBe(
      join(temporaryDirectory, "azsdk", process.platform === "win32" ? "azsdk.exe" : "azsdk"),
    );
    expect(args).toContain("customized-update");
    expect(args?.[(args?.indexOf("--customization-request") ?? -2) + 1]).toContain("Model changed");
    expect(options).toBeUndefined();
  });

  it("logs command errors and continues", async () => {
    const error = new Error("azsdk failed");
    execFileMock.mockRejectedValue(error);
    const consoleErrorMock = vi.spyOn(console, "error").mockImplementation(() => {});

    await mitigateSdkBreakingChanges({
      analysisResultPath,
      mitigationResultPath,
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      specificationRepositoryPath,
      resultDirPath: temporaryDirectory,
      azureSdkCliPath: join(temporaryDirectory, "azsdk"),
    });

    expect(consoleErrorMock).toHaveBeenCalledWith(
      "Failed to mitigate SDK breaking change 1 for specification/service/Widget.Service:",
      error,
    );
  });

  it("writes a failure result for orchestration errors", async () => {
    await writeFile(
      analysisResultPath,
      JSON.stringify({
        schemaVersion: 1,
        prNumber: 42,
        headSha: "a".repeat(40),
        sdkLanguage: "Java",
        analysisWorkflowUrl: "https://github.com/owner/repo/actions/runs/123",
        status: "success",
        projects: [
          {
            typespecProject: "specification/service/Missing.Service",
            sdkPackage: "armwidget",
            breakingChanges: [
              {
                breakingChange: "Model changed",
                category: "spec change",
                suggestedFix: "Restore compatibility",
              },
            ],
          },
        ],
      }),
    );
    const consoleErrorMock = vi.spyOn(console, "error").mockImplementation(() => {});

    await mitigateSdkBreakingChanges({
      analysisResultPath,
      mitigationResultPath,
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      specificationRepositoryPath,
      resultDirPath: temporaryDirectory,
      azureSdkCliPath: join(temporaryDirectory, "azsdk"),
    });

    const result = MitigationResultSchema.parse(
      JSON.parse(await readFile(mitigationResultPath, "utf8")),
    );
    expect(result.status).toBe("failure");
    expect(result.errorMessage).toContain("Missing.Service");
    expect(consoleErrorMock).toHaveBeenCalledWith(
      "SDK breaking-change mitigation failed.",
      expect.any(Error),
    );
  });
});
