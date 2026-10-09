import { mkdir, readFile, rm } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { ExecFileOptions, ExecResult } from "../../../shared/src/exec.ts";
import type { TypeSpecMetadata } from "../../../shared/src/typespec-metadata.ts";

const { execFileMock, generateTypeSpecMetadataMock } = vi.hoisted(() => ({
  execFileMock:
    vi.fn<(file: string, args?: string[], options?: ExecFileOptions) => Promise<ExecResult>>(),
  generateTypeSpecMetadataMock: vi.fn<(folder: string) => Promise<TypeSpecMetadata>>(),
}));

vi.mock("../../../shared/src/exec.ts", () => ({ execFile: execFileMock }));
vi.mock("../../../shared/src/typespec-metadata.ts", () => ({
  generateTypeSpecMetadata: generateTypeSpecMetadataMock,
}));

import { analyzeSdkProjects } from "../../src/sdk-breaking-change/analyze-sdk-projects.ts";

let temporaryDirectory: string;
let sdkRepositoryPath: string;
let specificationRepositoryPath: string;
let azureSdkCliPath: string;

beforeEach(async () => {
  temporaryDirectory = join(import.meta.dirname, `analysis-${crypto.randomUUID()}`);
  sdkRepositoryPath = join(temporaryDirectory, "sdk");
  specificationRepositoryPath = join(temporaryDirectory, "specs");
  azureSdkCliPath = join(temporaryDirectory, "bin");
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
    return Promise.resolve({ stdout: `${JSON.stringify({ operation })}\n`, stderr: "" });
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("analyzeSdkProjects", () => {
  it("runs generation, build, and detection and writes the result manifest", async () => {
    await analyzeSdkProjects({
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultDir: temporaryDirectory,
      azureSdkCliPath,
    });

    const resultsPath = join(temporaryDirectory, "sdk-breaking-change-results");
    await expect(readFile(join(resultsPath, "trigger.json"), "utf8")).resolves.toContain(
      '"pullNumber":42',
    );
    await expect(readFile(join(resultsPath, "projects.json"), "utf8")).resolves.toContain(
      '"typespecProjectPath":"specification/service/Widget.Service"',
    );
    await expect(
      readFile(join(resultsPath, "armwidget", "generate.json"), "utf8"),
    ).resolves.toContain('"operation":"generate"');
    await expect(readFile(join(resultsPath, "armwidget", "build.json"), "utf8")).resolves.toContain(
      '"operation":"build"',
    );
    await expect(
      readFile(join(resultsPath, "armwidget", "breaking-changes.json"), "utf8"),
    ).resolves.toContain('"operation":"detect-breaking-change"');
    await expect(readFile(join(resultsPath, "analysis.log"), "utf8")).resolves.toBe("");
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

  it("rejects metadata without the requested SDK language", async () => {
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
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
      resultDir: temporaryDirectory,
      azureSdkCliPath,
    });

    await expect(result).rejects.toThrow(
      "Expected language metadata for specification/service/Widget.Service and language Go",
    );
    await expect(
      readFile(join(temporaryDirectory, "sdk-breaking-change-results", "error.log"), "utf8"),
    ).resolves.toContain("Expected language metadata");
  });

  it("rejects language metadata without an output directory", async () => {
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

    await expect(
      analyzeSdkProjects({
        localSdkRepositoryPath: sdkRepositoryPath,
        specificationRepositoryPath,
        typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
        pullNumber: 42,
        sdkLanguage: "Go",
        analyzedSha: "a".repeat(40),
        workflowUrl: "https://github.com/owner/repo/actions/runs/123",
        resultDir: temporaryDirectory,
        azureSdkCliPath,
      }),
    ).rejects.toThrow(
      "Expected output directory for specification/service/Widget.Service and language Go",
    );
  });
});
