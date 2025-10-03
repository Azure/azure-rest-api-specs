import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { describe, expect, it } from "vitest";
import { Context } from "../../src/types/breaking-change.js";
import {
  addOadTrace,
  createOadTrace,
  generateOadMarkdown,
  setOadBaseBranch,
} from "../../src/types/oad-types.js";

const mockContext: Context = {
  runType: BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
  prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/12345",
  prTargetBranch: "main",
  prSourceBranch: "feature-branch",
  headCommit: "abc123",
  baseBranch: "main",
  localSpecRepoPath: "/path/to/repo",
  workingFolder: "/path/to/working",
  logFileFolder: "/path/to/logs",
  swaggerDirs: ["/path/to/swagger"],
  checkName: "test-check",
  targetRepo: "Azure/azure-rest-api-specs",
  sourceRepo: "Azure/azure-rest-api-specs",
  prNumber: "12345",
  oadMessageProcessorContext: {
    logFilePath: "/path/to/log",
    prUrl: "https://github.com/Azure/azure-rest-api-specs/pull/12345",
    messageCache: [],
  },
};

describe("OAD Trace Functions", () => {
  it("should create an empty trace data structure", () => {
    const traceData = createOadTrace(mockContext);
    expect(traceData.traces).toEqual([]);
    expect(traceData.context).toBe(mockContext);
  });

  it("should add a trace entry", () => {
    const traceData = createOadTrace(mockContext);
    const updatedTrace = addOadTrace(traceData, "path/to/old.json", "path/to/new.json");

    expect(updatedTrace.traces).toHaveLength(1);
    expect(updatedTrace.traces[0]).toEqual({
      old: "path/to/old.json",
      new: "path/to/new.json",
    });
  });

  it("should set base branch", () => {
    const traceData = createOadTrace(mockContext);
    const updatedTrace = setOadBaseBranch(traceData, "feature-branch");

    expect(updatedTrace.baseBranch).toBe("feature-branch");
  });

  it("should generate empty markdown when no traces", async () => {
    const traceData = createOadTrace(mockContext);
    const markdown = await generateOadMarkdown(traceData);

    expect(markdown).toBe("");
  });

  it("should generate markdown table when traces exist", async () => {
    let traceData = createOadTrace(mockContext);
    traceData = addOadTrace(
      traceData,
      "specification/storage/resource-manager/Microsoft.Storage/stable/2021-09-01/storage.json",
      "specification/storage/resource-manager/Microsoft.Storage/stable/2021-09-01/storage.json",
    );

    const markdown = await generateOadMarkdown(traceData);

    expect(markdown).toContain("| Compared specs");
    expect(markdown).toContain("storage.json");
    expect(markdown).toContain("2021-09-01");
    expect(markdown).toContain("abc123");
    expect(markdown).toContain("main");
  });

  it("should accumulate multiple traces", () => {
    let traceData = createOadTrace(mockContext);
    traceData = addOadTrace(traceData, "path/to/old1.json", "path/to/new1.json");
    traceData = addOadTrace(traceData, "path/to/old2.json", "path/to/new2.json");

    expect(traceData.traces).toHaveLength(2);
    expect(traceData.traces[0].old).toBe("path/to/old1.json");
    expect(traceData.traces[1].old).toBe("path/to/old2.json");
  });
});
