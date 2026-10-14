import { mkdir, rm, writeFile } from "node:fs/promises";
import { join } from "node:path";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import {
  buildAnalysisSummary,
  publishAnalysisSummary,
} from "../../src/sdk-breaking-change/publish-analysis-summary.ts";
import { createMockCore } from "../mocks.ts";

let resultsPath: string;

beforeEach(async () => {
  resultsPath = join(import.meta.dirname, `summary-${crypto.randomUUID()}`);
  await mkdir(join(resultsPath, "package"), { recursive: true });
});

afterEach(async () => {
  await rm(resultsPath, { recursive: true, force: true });
});

describe("buildAnalysisSummary", () => {
  it("renders project result files for a successful analysis", async () => {
    await writeFile(
      join(resultsPath, "projects.json"),
      JSON.stringify([
        {
          typespecProjectPath: "specification/service/Widget.Service",
          packageName: "armwidget",
          resultsPath: "package",
        },
      ]),
    );
    await writeFile(join(resultsPath, "package", "generate.json"), '{"result":"succeeded"}\n');
    await writeFile(
      join(resultsPath, "package", "breaking-changes.json"),
      '{"result":{"breakingChanges":[]}}\n',
    );

    const summary = await buildAnalysisSummary({
      resultsPath,
      jobStatus: "success",
      analysisOutcome: "success",
      analyzedSha: "a".repeat(40),
      jobLogUrl: "https://github.com/owner/repo/actions/runs/1/job/2",
    });

    expect(summary).toContain(`**Analyzed commit:** \`${"a".repeat(40)}\``);
    expect(summary).toContain("### specification/service/Widget.Service");
    expect(summary).toContain("**SDK Package:** armwidget");
    expect(summary).toContain('#### generate.json\n\n```json\n{"result":"succeeded"}\n```');
    expect(summary).not.toContain("#### build.json");
    expect(summary).toContain("#### breaking-changes.json");
  });

  it("renders only the last 10 error lines for a failed analysis", async () => {
    await writeFile(
      join(resultsPath, "error.log"),
      `${Array.from({ length: 35 }, (_, index) => `error ${index + 1}`).join("\n")}\n`,
    );

    const summary = await buildAnalysisSummary({
      resultsPath,
      jobStatus: "failure",
      analysisOutcome: "failure",
      analyzedSha: "",
      jobLogUrl: "https://github.com/owner/repo/actions/runs/1/job/2",
    });

    expect(summary).not.toContain("error 25\n");
    expect(summary).toContain("    error 26\n");
    expect(summary).toContain("    error 35");
    expect(summary).toContain(
      "[See failed step](https://github.com/owner/repo/actions/runs/1/job/2)",
    );
  });

  it("refers to the failed step when no analysis error log is available", async () => {
    const summary = await buildAnalysisSummary({
      resultsPath,
      jobStatus: "failure",
      analysisOutcome: "skipped",
      analyzedSha: "a".repeat(40),
      jobLogUrl: "https://github.com/owner/repo/actions/runs/1/job/2",
    });

    expect(summary).toContain("Error output is available in the failed step log.");
    expect(summary).not.toContain("### Error");
  });

  it("warns and continues when a result file cannot be read", async () => {
    await mkdir(join(resultsPath, "projects.json"));
    const warning = vi.fn();

    const summary = await buildAnalysisSummary({
      resultsPath,
      jobStatus: "success",
      analysisOutcome: "success",
      analyzedSha: "",
      jobLogUrl: "https://github.com/owner/repo/actions/runs/1/job/2",
      warning,
    });

    expect(summary).toBe("## SDK breaking-change analysis");
    expect(warning).toHaveBeenCalledWith(expect.stringContaining("Failed to read"));
  });
});

describe("publishAnalysisSummary", () => {
  it("writes the generated Markdown to the job summary", async () => {
    const core = createMockCore();

    await publishAnalysisSummary({
      core,
      resultsPath,
      jobStatus: "success",
      analysisOutcome: "success",
      analyzedSha: "",
      jobLogUrl: "https://github.com/owner/repo/actions/runs/1/job/2",
    });

    expect(core.summary.addRaw).toHaveBeenCalledWith("## SDK breaking-change analysis");
    expect(core.summary.write).toHaveBeenCalledOnce();
  });
});
