import { mkdir, readFile, rm, utimes, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { ExecFileOptions, ExecResult } from "../../../shared/src/exec.ts";

const { execFileMock } = vi.hoisted(() => ({
  execFileMock:
    vi.fn<(file: string, args?: string[], options?: ExecFileOptions) => Promise<ExecResult>>(),
}));

vi.mock("../../../shared/src/exec.ts", () => ({ execFile: execFileMock }));

import { analyzeSdkProjects } from "../../src/sdk-breaking-change/analyze-sdk-projects.ts";

let temporaryDirectory: string;
let sdkRepositoryPath: string;
let specificationRepositoryPath: string;

beforeEach(async () => {
  temporaryDirectory = join(import.meta.dirname, `analysis-${crypto.randomUUID()}`);
  sdkRepositoryPath = join(temporaryDirectory, "sdk");
  specificationRepositoryPath = join(temporaryDirectory, "specs");
  await mkdir(sdkRepositoryPath, { recursive: true });
  await mkdir(join(specificationRepositoryPath, "specification", "service", "Widget.Service"), {
    recursive: true,
  });

  execFileMock.mockImplementation(async (_file, args = []) => {
    const operation = args[1];
    if (operation === "generate") {
      const packagePath = join(sdkRepositoryPath, "sdk", "armwidget");
      await mkdir(packagePath, { recursive: true });
      const configPath = join(packagePath, "tsp-location.yaml");
      await writeFile(configPath, "directory: specification\n");
      await utimes(configPath, new Date(0), new Date(0));
    }
    return { stdout: `${JSON.stringify({ operation })}\n`, stderr: "" };
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
    expect(execFileMock).toHaveBeenNthCalledWith(1, "azsdk", expect.arrayContaining(["generate"]));
    expect(execFileMock).toHaveBeenNthCalledWith(2, "azsdk", expect.arrayContaining(["build"]));
    expect(execFileMock).toHaveBeenNthCalledWith(
      3,
      "azsdk",
      expect.arrayContaining(["detect-breaking-change"]),
    );
  });
});
