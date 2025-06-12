// @ts-check

import { describe, it, expect, vi, beforeEach, afterEach } from "vitest";
import { setSummary, annotateFileError } from "../src/error-reporting.js";
import fs from "fs/promises";

describe("ErrorReporting", () => {
  let logSpy;

  beforeEach(() => {
    logSpy = vi.spyOn(console, "log").mockImplementation(() => {});
    // ensure that on test runs GITHUB_STEP_SUMMARY is not set in my current env by default
    // this gives us a clean slate for each test
    delete process.env.GITHUB_STEP_SUMMARY;
  });

  afterEach(() => {
    logSpy.mockRestore();
  });

  it("should warn when GITHUB_STEP_SUMMARY is unset", () => {
    setSummary("hello");
    expect(logSpy).toHaveBeenCalledWith(
      "GITHUB_STEP_SUMMARY is not set. Skipping summary update.",
    );
  });

  it("should write to the summary file when GITHUB_STEP_SUMMARY is set", async () => {
    process.env.GITHUB_STEP_SUMMARY = `${__dirname}/tmp-summary.md`;

    await fs.rm(process.env.GITHUB_STEP_SUMMARY, { force: true });

    setSummary("# Title");

    expect(logSpy).not.toHaveBeenCalledWith(
      "GITHUB_STEP_SUMMARY is not set. Skipping summary update.",
    );

    const content = await fs.readFile(process.env.GITHUB_STEP_SUMMARY, "utf-8");

    // cleanup after the test so nothing is left behi
    await fs.rm(process.env.GITHUB_STEP_SUMMARY, { force: true });

    expect(content).toBe("# Title");
  });

  it("should emit a GitHub-style error annotation", () => {
    annotateFileError("src/foo.js", "Something broke", 42, 7);
    expect(logSpy).toHaveBeenCalledWith(
      "::error file=src/foo.js,line=42,col=7::Something broke",
    );
  });
});
