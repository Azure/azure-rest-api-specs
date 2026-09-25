import { EventEmitter } from "node:events";
import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { PassThrough } from "node:stream";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const { spawnMock } = vi.hoisted(() => ({ spawnMock: vi.fn() }));

vi.mock("cross-spawn", () => ({ default: spawnMock }));

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

  spawnMock.mockImplementation((_command: string, args: string[]) => {
    const child = Object.assign(new EventEmitter(), {
      stdout: new PassThrough(),
      stderr: new PassThrough(),
    });

    queueMicrotask(() => {
      void (async () => {
        const operation = args[1];
        if (operation === "generate") {
          const packagePath = join(sdkRepositoryPath, "sdk", "armwidget");
          await mkdir(packagePath, { recursive: true });
          await writeFile(join(packagePath, "tsp-location.yaml"), "directory: specification\n");
        }
        child.stdout.end(`${JSON.stringify({ operation })}\n`);
        child.stderr.end();
        child.emit("close", 0, null);
      })();
    });

    return child;
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("analyzeSdkProjects", () => {
  it("runs generation, build, and detection and writes the result manifest", async () => {
    await analyzeSdkProjects({
      runnerTemp: temporaryDirectory,
      localSdkRepositoryPath: sdkRepositoryPath,
      specificationRepositoryPath,
      typeSpecConfigPaths: ["specification/service/Widget.Service/tspconfig.yaml"],
      pullNumber: 42,
      sdkLanguage: "Go",
      analyzedSha: "a".repeat(40),
      workflowUrl: "https://github.com/owner/repo/actions/runs/123",
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
    await expect(readFile(join(resultsPath, "analysis.log"), "utf8")).resolves.toContain(
      '"operation":"detect-breaking-change"',
    );
    expect(spawnMock).toHaveBeenCalledTimes(3);
  });
});
