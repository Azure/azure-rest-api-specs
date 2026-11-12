import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import type { ExecFileOptions, ExecResult } from "@azure-tools/specs-shared/exec";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const { execFileMock } = vi.hoisted(() => ({
  execFileMock:
    vi.fn<(file: string, args?: string[], options?: ExecFileOptions) => Promise<ExecResult>>(),
}));

vi.mock("@azure-tools/specs-shared/exec", () => ({ execFile: execFileMock }));

import {
  AnalysisResultSchema,
  MitigationResultSchema,
} from "../../src/sdk-breaking-change/types.ts";
import { mitigateSdkBreakingChanges } from "../../src/sdk-breaking-change/mitigate-sdk-breaking-changes.ts";
import { createMockCore } from "../mocks.ts";

let temporaryDirectory: string;
let analysisResultPath: string;
let mitigationResultPath: string;
let specificationRepositoryPath: string;
let core: ReturnType<typeof createMockCore>;

beforeEach(async () => {
  core = createMockCore();
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
          status: "success",
          analysisStatus: "success",
          breakingChanges: [
            {
              id: "model-change",
              breakingChange: "Model changed",
              category: "spec change",
              suggestedFix: "Restore compatibility",
              originBreaks: ["- Model property removed", "- Method signature changed"],
            },
          ],
        },
      ],
    }),
  );

  execFileMock.mockResolvedValue({
    stdout: `${JSON.stringify({
      success: true,
      typeSpecChangesSummary: ["Added client customization"],
    })}\n`,
    stderr: "",
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("mitigateSdkBreakingChanges", () => {
  it.each(["skipped", "failure"] as const)(
    "ignores projects with analysis status %s while mitigating successful projects",
    async (analysisStatus) => {
      const analysis = AnalysisResultSchema.parse(
        JSON.parse(await readFile(analysisResultPath, "utf8")),
      );
      analysis.projects.unshift({
        typespecProject: "specification/service/Skipped.Service",
        sdkPackage: "",
        analysisStatus,
        breakingChanges: [],
      });
      await writeFile(analysisResultPath, JSON.stringify(analysis));

      await mitigateSdkBreakingChanges({
        core,
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
      expect(result.status).toBe("success");
      expect(result.projects).toHaveLength(1);
      expect(result.projects[0].typespecProject).toBe("specification/service/Widget.Service");
      expect(result.projects[0].breakingChanges[0].isResolved).toBe(true);
      expect(execFileMock).toHaveBeenCalledOnce();
    },
  );

  it("runs customization and writes a cleaned mitigation result", async () => {
    await mitigateSdkBreakingChanges({
      core,
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
        id: "model-change",
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
    expect(core.summary.addRaw).toHaveBeenCalledExactlyOnceWith(
      [
        "## SDK breaking-change mitigation",
        `**Analyzed commit:** \`${"a".repeat(40)}\``,
        '<a name="breaking-change-model-change-mitigation"></a>',
        "## Breaking Change model-change",
        "### Suppression",
        "Follow the [suppression guideline](https://github.com/Azure/azure-rest-api-specs/wiki/SDK-Breaking-Changes#how-to-suppress-the-sdk-breaking-changes) to add follow breaking change items to sdk-suppressions.yaml.\n\n```yaml\n- Model property removed\n- Method signature changed\n```",
      ].join("\n\n"),
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
  });

  it("logs command errors and continues", async () => {
    const error = new Error("azsdk failed");
    execFileMock.mockRejectedValue(error);
    const consoleErrorMock = vi.spyOn(console, "error").mockImplementation(() => {});

    await mitigateSdkBreakingChanges({
      core,
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
    const result = MitigationResultSchema.parse(
      JSON.parse(await readFile(mitigationResultPath, "utf8")),
    );
    expect(result.projects[0].breakingChanges).toEqual([
      {
        id: "model-change",
        breakingChange: "Model changed",
        suggestedFix: "Restore compatibility",
        isResolved: false,
      },
    ]);
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("```yaml\n- Model property removed\n- Method signature changed\n```"),
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
  });

  it("marks the change unresolved when customization does not succeed", async () => {
    execFileMock.mockResolvedValue({
      stdout: `${JSON.stringify({ success: false })}\n`,
      stderr: "",
    });

    await mitigateSdkBreakingChanges({
      core,
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
        id: "model-change",
        breakingChange: "Model changed",
        suggestedFix: "Restore compatibility",
        isResolved: false,
      },
    ]);
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
            status: "success",
            analysisStatus: "success",
            breakingChanges: [
              {
                id: "model-change",
                breakingChange: "Model changed",
                category: "spec change",
                suggestedFix: "Restore compatibility",
                originBreaks: ["- Model property removed"],
              },
            ],
          },
        ],
      }),
    );
    const consoleErrorMock = vi.spyOn(console, "error").mockImplementation(() => {});

    await mitigateSdkBreakingChanges({
      core,
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
    expect(core.summary.addRaw).toHaveBeenCalledExactlyOnceWith(
      `## SDK breaking-change mitigation\n\n**Analyzed commit:** \`${"a".repeat(40)}\``,
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
  });

  it("writes a summary without suppression sections when there are no breaking changes", async () => {
    const analysis = AnalysisResultSchema.parse(
      JSON.parse(await readFile(analysisResultPath, "utf8")),
    );
    analysis.projects[0].breakingChanges = [];
    await writeFile(analysisResultPath, JSON.stringify(analysis));

    await mitigateSdkBreakingChanges({
      core,
      analysisResultPath,
      mitigationResultPath,
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      specificationRepositoryPath,
      resultDirPath: temporaryDirectory,
      azureSdkCliPath: join(temporaryDirectory, "azsdk"),
    });

    expect(execFileMock).not.toHaveBeenCalled();
    expect(core.summary.addRaw).toHaveBeenCalledExactlyOnceWith(
      `## SDK breaking-change mitigation\n\n**Analyzed commit:** \`${"a".repeat(40)}\``,
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
    const result = MitigationResultSchema.parse(
      JSON.parse(await readFile(mitigationResultPath, "utf8")),
    );
    expect(result.status).toBe("success");
    expect(result.projects[0].breakingChanges).toEqual([]);
  });
});
