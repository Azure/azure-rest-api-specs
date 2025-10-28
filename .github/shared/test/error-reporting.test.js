// @ts-check

import fs from "fs/promises";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { annotateFileError, setOutput, setSummary } from "../src/error-reporting.js";

describe("ErrorReporting", () => {
  let logSpy;

  beforeEach(() => {
    logSpy = vi.spyOn(console, "log").mockImplementation(() => {});
    // ensure that on test runs GITHUB_STEP_SUMMARY is not set in my current env by default
    // this gives us a clean slate for each test
    delete process.env.GITHUB_STEP_SUMMARY;
    delete process.env.GITHUB_OUTPUT;
  });

  afterEach(() => {
    logSpy.mockRestore();
  });

  it("should warn when calling setOutput when GITHUB_OUTPUT is unset", () => {
    setOutput("test", "value");
    expect(logSpy).toHaveBeenCalledWith(
      "GITHUB_OUTPUT is not set. Skipping test update with value 'value.'",
    );
  });

  it("should warn when calling setSummary when GITHUB_STEP_SUMMARY is unset", () => {
    setSummary("hello");
    expect(logSpy).toHaveBeenCalledWith("GITHUB_STEP_SUMMARY is not set. Skipping summary update.");
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

  it("should write an output when GITHUB_OUTPUT is set", async () => {
    process.env.GITHUB_OUTPUT = `${__dirname}/tmp-output.txt`;

    setOutput("test", "value");

    expect(logSpy).not.toHaveBeenCalledWith(
      "GITHUB_OUTPUT is not set. Skipping test update with value 'value.'",
    );

    const content = await fs.readFile(process.env.GITHUB_OUTPUT, "utf-8");
    expect(content).toBe("test=value\n");

    // cleanup after the test so nothing is left behind
    await fs.unlink(process.env.GITHUB_OUTPUT);
  });

  it("should emit a GitHub-style error annotation", () => {
    annotateFileError("src/foo.js", "Something broke", 42, 7);
    expect(logSpy).toHaveBeenCalledWith("::error file=src/foo.js,line=42,col=7::Something broke");
  });
});
