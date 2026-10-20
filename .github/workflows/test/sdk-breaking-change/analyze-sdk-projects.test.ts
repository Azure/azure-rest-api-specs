import { mkdir, readFile, rm } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { ExecFileOptions, ExecResult } from "@azure-tools/specs-shared/exec";
import type { TypeSpecMetadata } from "@azure-tools/specs-shared/typespec-metadata";

const { execFileMock, generateTypeSpecMetadataMock } = vi.hoisted(() => ({
  execFileMock:
    vi.fn<(file: string, args?: string[], options?: ExecFileOptions) => Promise<ExecResult>>(),
  generateTypeSpecMetadataMock: vi.fn<(folder: string) => Promise<TypeSpecMetadata>>(),
}));

vi.mock("@azure-tools/specs-shared/exec", () => ({ execFile: execFileMock }));
vi.mock("@azure-tools/specs-shared/typespec-metadata", () => ({
  generateTypeSpecMetadata: generateTypeSpecMetadataMock,
}));

import { analyzeSdkProjects } from "../../src/sdk-breaking-change/analyze-sdk-projects.ts";
import { AnalysisResultSchema } from "../../src/sdk-breaking-change/types.ts";
import { createMockCore } from "../mocks.ts";

let core: ReturnType<typeof createMockCore>;
let temporaryDirectory: string;
let sdkRepositoryPath: string;
let specificationRepositoryPath: string;
let azureSdkCliPath: string;
let resultFilePath: string;

beforeEach(async () => {
  core = createMockCore();
  temporaryDirectory = join(import.meta.dirname, `analysis-${crypto.randomUUID()}`);
  sdkRepositoryPath = join(temporaryDirectory, "sdk");
  specificationRepositoryPath = join(temporaryDirectory, "specs");
  azureSdkCliPath = join(temporaryDirectory, "bin");
  resultFilePath = join(temporaryDirectory, "custom-results", "nested", "analysis.json");
  await mkdir(sdkRepositoryPath, { recursive: true });
  await mkdir(join(specificationRepositoryPath, "specification", "service", "Widget.Service"), {
    recursive: true,
  });

  generateTypeSpecMetadataMock.mockResolvedValue({
    emitterVersion: "1.0.0",
    generatedAt: "2026-10-08T00:00:00Z",
    typespec: {
      namespace: "Widget.Service",
      type: "management",
    },
    languages: {
      go: [
        {
          emitterName: "@azure-tools/typespec-go",
          outputDir: "{output-dir}/sdk/armwidget",
        },
      ],
    },
  });

  execFileMock.mockImplementation((_file, args = []) => {
    const operation = args[1];
    const response =
      operation === "generate"
        ? {
            result: "succeeded",
            package_name: "armwidget",
            language: "Go",
            version: "1.0.0",
            package_type: "mgmt",
            typespec_project: "specification/service/Widget.Service",
            sdk_repo: "azure-sdk-for-go",
            operation_status: "Succeeded",
          }
        : operation === "build"
          ? {
              result: "succeeded",
              package_name: "armwidget",
              language: "Go",
            }
          : {
              result: {
                hasBreakingChange: false,
                breakingChanges: [],
              },
            };
    return Promise.resolve({ stdout: `${JSON.stringify(response)}\n`, stderr: "" });
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("analyzeSdkProjects", () => {
  it("runs generation, build, and detection and writes the analysis artifact and summary", async () => {
    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    const artifact = AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8")));
    expect(artifact).toEqual({
      schemaVersion: 1,
      prNumber: 42,
      headSha: "a".repeat(40),
      sdkLanguage: "Go",
      analysisWorkflowUrl: "https://github.com/owner/repo/actions/runs/123",
      status: "success",
      projects: [
        {
          typespecProject: "specification/service/Widget.Service",
          sdkPackage: "armwidget",
          analysisStatus: "success",
          breakingChanges: [],
        },
      ],
    });
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining(`**Analyzed commit:** \`${"a".repeat(40)}\``),
    );
    for (const section of [
      "generate.json",
      "build.json",
      "Analysis succeeded",
      "Breaking Changes",
    ]) {
      expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining(section));
    }
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining('<a name="armwidget-breaking-change"></a>\n\n## Breaking Changes'),
    );
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(execFileMock).toHaveBeenCalledTimes(3);
    const azureSdkCli = join(azureSdkCliPath, process.platform === "win32" ? "azsdk.exe" : "azsdk");
    expect(execFileMock).toHaveBeenNthCalledWith(
      1,
      azureSdkCli,
      expect.arrayContaining(["generate"]),
    );
    expect(execFileMock).toHaveBeenNthCalledWith(2, azureSdkCli, expect.arrayContaining(["build"]));
    expect(execFileMock).toHaveBeenNthCalledWith(
      3,
      azureSdkCli,
      expect.arrayContaining(["detect-breaking-change"]),
    );
    expect(generateTypeSpecMetadataMock).toHaveBeenCalledWith(
      join(specificationRepositoryPath, "specification", "service", "Widget.Service"),
    );
  });

  it("includes deterministic change IDs and the normalized detection JSON in the anchored summary", async () => {
    execFileMock
      .mockResolvedValueOnce({ stdout: JSON.stringify({ result: "succeeded" }), stderr: "" })
      .mockResolvedValueOnce({ stdout: JSON.stringify({ result: "succeeded" }), stderr: "" })
      .mockResolvedValueOnce({
        stdout: JSON.stringify({
          result: {
            hasBreakingChange: true,
            breakingChanges: [
              {
                breakingChange: "Model changed",
                category: "spec change",
                resolution: "Restore old_model",
                originBreaks: ["- Model property removed", "- Model constructor changed"],
              },
              {
                breakingChange: "Property removed",
                category: "spec change",
                originBreaks: ["- Property removed"],
              },
              {
                breakingChange: "Model changed",
                category: "other",
                resolution: "",
                originBreaks: ["- Model type changed"],
              },
            ],
          },
        }),
        stderr: "",
      });

    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    const artifact = AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8")));
    const changes = [
      {
        id: "89118517",
        breakingChange: "Model changed",
        category: "spec change",
        suggestedFix: "Restore old_model",
        originBreaks: ["- Model property removed", "- Model constructor changed"],
      },
      {
        id: "83349090",
        breakingChange: "Property removed",
        category: "spec change",
        suggestedFix: "",
        originBreaks: ["- Property removed"],
      },
      {
        id: "89118517",
        breakingChange: "Model changed",
        category: "other",
        suggestedFix: "",
        originBreaks: ["- Model type changed"],
      },
    ];
    expect(artifact.projects[0].breakingChanges).toEqual(changes);
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining(
        [
          '<a name="armwidget-breaking-change"></a>',
          "",
          "## Breaking Changes",
          "",
          "```",
          JSON.stringify(
            { result: { hasBreakingChange: true, breakingChanges: changes } },
            null,
            2,
          ),
          "```",
        ].join("\n"),
      ),
    );
    expect(core.setFailed).not.toHaveBeenCalled();
  });

  it("records skipped projects without the requested SDK language", async () => {
    generateTypeSpecMetadataMock.mockResolvedValue({
      emitterVersion: "1.0.0",
      generatedAt: "2026-10-08T00:00:00Z",
      typespec: {
        namespace: "Widget.Service",
        type: "management",
      },
      languages: {},
    });

    const result = analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    await result;
    const message =
      "No language key found for specification/service/Widget.Service and SDK repo azure-sdk-for-go. Skipping this project.";
    expect(
      AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8"))).projects,
    ).toEqual([
      {
        typespecProject: "specification/service/Widget.Service",
        sdkPackage: "",
        analysisStatus: "skipped",
        breakingChanges: [],
      },
    ]);
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining(message));
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(execFileMock).not.toHaveBeenCalled();
  });

  it("records skipped language metadata without an output directory", async () => {
    generateTypeSpecMetadataMock.mockResolvedValue({
      emitterVersion: "1.0.0",
      generatedAt: "2026-10-08T00:00:00Z",
      typespec: {
        namespace: "Widget.Service",
        type: "management",
      },
      languages: {
        go: [{ emitterName: "@azure-tools/typespec-go" }],
      },
    });

    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });
    const message =
      "No output directory found for specification/service/Widget.Service and language Go. Skipping this project.";
    expect(
      AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8"))).projects,
    ).toEqual([
      {
        typespecProject: "specification/service/Widget.Service",
        sdkPackage: "",
        analysisStatus: "skipped",
        breakingChanges: [],
      },
    ]);
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining(message));
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(execFileMock).not.toHaveBeenCalled();
  });

  it("continues analyzing other projects after skipping unsupported metadata", async () => {
    generateTypeSpecMetadataMock.mockResolvedValueOnce({
      emitterVersion: "1.0.0",
      generatedAt: "2026-10-08T00:00:00Z",
      typespec: { namespace: "Other.Service", type: "management" },
      languages: {},
    });

    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: [
        "specification/other/Other.Service/tspconfig.yaml",
        "specification/service/Widget.Service/tspconfig.yaml",
      ],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    const artifact = AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8")));
    expect(artifact.projects.map((project) => project.analysisStatus)).toEqual([
      "skipped",
      "success",
    ]);
    expect(execFileMock).toHaveBeenCalledTimes(3);
  });

  it.each([
    ["generation", 0],
    ["build", 1],
    ["breaking-change detection", 2],
  ] as const)("continues after a project's %s fails", async (stage, previousSteps) => {
    for (let index = 0; index < previousSteps; index++) {
      execFileMock.mockResolvedValueOnce({
        stdout: JSON.stringify({ result: "succeeded" }),
        stderr: "",
      });
    }
    execFileMock.mockResolvedValueOnce({
      stdout: JSON.stringify({ result: "failed", response_error: `${stage} failed` }),
      stderr: "",
    });

    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: [
        "specification/service/Failed.Service/tspconfig.yaml",
        "specification/service/Widget.Service/tspconfig.yaml",
      ],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    const artifact = AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8")));
    expect(artifact.projects.map((project) => project.analysisStatus)).toEqual([
      "failure",
      "success",
    ]);
    expect(artifact.projects[1].sdkPackage).toBe("armwidget");
    expect(core.summary.addRaw).toHaveBeenCalledWith(expect.stringContaining(`${stage} failed`));
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(core.setFailed).not.toHaveBeenCalled();
    expect(execFileMock).toHaveBeenCalledTimes(previousSteps + 4);
  });

  it("marks the step failed and writes the partial artifact and summary when execution throws", async () => {
    execFileMock.mockRejectedValueOnce(new Error("SDK CLI execution failed"));

    await analyzeSdkProjects({
      core,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      sdkRepoName: "azure-sdk-for-go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultFilePath,
      azureSdkCliPath,
    });

    const artifact = AnalysisResultSchema.parse(JSON.parse(await readFile(resultFilePath, "utf8")));
    expect(artifact.status).toBe("failure");
    expect(artifact.projects).toEqual([]);
    expect(core.setFailed).toHaveBeenCalledExactlyOnceWith("SDK CLI execution failed");
    expect(core.summary.addRaw).toHaveBeenCalledWith(
      expect.stringContaining("**Analysis failed:** SDK CLI execution failed"),
    );
    expect(core.summary.write).toHaveBeenCalledOnce();
    expect(execFileMock).toHaveBeenCalledOnce();
  });
});
