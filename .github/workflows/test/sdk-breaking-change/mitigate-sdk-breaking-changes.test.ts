import { EventEmitter } from "node:events";
import { mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { delimiter, join } from "node:path";
import { PassThrough } from "node:stream";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

const { spawnMock } = vi.hoisted(() => ({
  spawnMock:
    vi.fn<(command: string, args: string[], options: { env: NodeJS.ProcessEnv }) => unknown>(),
}));

vi.mock("cross-spawn", () => ({ default: spawnMock }));

import { mitigateSdkBreakingChanges } from "../../src/sdk-breaking-change/mitigate-sdk-breaking-changes.ts";

let temporaryDirectory: string;
let analysisResultPath: string;
let mitigationResultPath: string;
let specificationRepositoryPath: string;
let sdkRepositoryPath: string;

beforeEach(async () => {
  temporaryDirectory = join(import.meta.dirname, `mitigation-${crypto.randomUUID()}`);
  analysisResultPath = join(temporaryDirectory, "sdk-breaking-change-analysis.json");
  mitigationResultPath = join(temporaryDirectory, "results", "sdk-breaking-change-mitigation.json");
  specificationRepositoryPath = join(temporaryDirectory, "specs");
  sdkRepositoryPath = join(temporaryDirectory, "sdk");
  await mkdir(join(specificationRepositoryPath, "specification", "service", "Widget.Service"), {
    recursive: true,
  });
  await mkdir(join(sdkRepositoryPath, "sdk", "armwidget"), { recursive: true });
  await writeFile(
    join(sdkRepositoryPath, "sdk", "armwidget", "tsp-location.yaml"),
    "directory: specification\n",
  );
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

  spawnMock.mockImplementation(() => {
    const child = Object.assign(new EventEmitter(), {
      stdout: new PassThrough(),
      stderr: new PassThrough(),
    });
    queueMicrotask(() => {
      child.stdout.end(
        `${JSON.stringify({
          result: {
            success: true,
            typeSpecChangesSummary: ["Added client customization"],
          },
        })}\n`,
      );
      child.stderr.end();
      child.emit("close", 0, null);
    });
    return child;
  });
});

afterEach(async () => {
  vi.clearAllMocks();
  await rm(temporaryDirectory, { recursive: true, force: true });
});

describe("mitigateSdkBreakingChanges", () => {
  it("runs customization and writes a cleaned mitigation result", async () => {
    await mitigateSdkBreakingChanges({
      runnerTemp: temporaryDirectory,
      analysisResultPath,
      mitigationResultPath,
      mitigationWorkflowUrl: "https://github.com/owner/repo/actions/runs/456",
      specificationRepositoryPath,
      sdkRepositoryPath,
      azureSdkCliPath: join(temporaryDirectory, "azsdk"),
    });

    const result = JSON.parse(await readFile(mitigationResultPath, "utf8")) as {
      projects: Array<{ breakingChanges: unknown[] }>;
    };
    expect(result.projects[0].breakingChanges).toEqual([
      {
        breakingChange: "Model changed",
        suggestedFix: "Restore compatibility",
        isResolved: true,
        typespecChangesSummary: ["Added client customization"],
      },
    ]);
    const [command, args, options] = spawnMock.mock.calls[0];
    expect(command).toBe("azsdk");
    expect(args).toContain("customized-update");
    expect(args[args.indexOf("--customization-request") + 1]).toContain("Model changed");
    expect(options.env.PATH).toContain(`${join(temporaryDirectory, "azsdk")}${delimiter}`);
  });
});
