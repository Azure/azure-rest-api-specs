import { afterEach, beforeEach, describe, expect, test, vi } from "vitest";
import {
  LogIssueType,
  LogLevel,
  logMessage,
  setVsoVariable,
  vsoAddAttachment,
  vsoLogIssue,
} from "../src/log.ts";

const logSpy = vi.spyOn(console, "log").mockImplementation(() => {
  // mock implementation intentionally left blank
});

const errorSpy = vi.spyOn(console, "error").mockImplementation(() => {
  // mock implementation intentionally left blank
});

const warnSpy = vi.spyOn(console, "warn").mockImplementation(() => {
  // mock implementation intentionally left blank
});

describe("logMessage", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  test("logs a normal message", () => {
    logMessage("Hello");
    expect(logSpy).toHaveBeenCalledWith("Hello");
  });

  test("logs a group message", () => {
    logMessage("Group", LogLevel.Group);
    expect(logSpy).toHaveBeenCalledWith("##[group]Group");
  });

  test("logs an endgroup message", () => {
    logMessage("End", LogLevel.EndGroup);
    expect(logSpy).toHaveBeenCalledWith("##[endgroup]");
  });

  test("logs a debug message", () => {
    logMessage("Debug", LogLevel.Debug);
    expect(logSpy).toHaveBeenCalledWith("[debug]Debug");
  });

  test("logs a warning", () => {
    logMessage("Warning", LogLevel.Warn);
    expect(warnSpy).toHaveBeenCalledWith("Warning");
  });

  test("logs an error", () => {
    logMessage("Error", LogLevel.Error);
    expect(errorSpy).toHaveBeenCalledWith("Error");
  });
});

describe("vso helpers", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  test("vsoAddAttachment should log correct format", () => {
    vsoAddAttachment("MyReport", "/path/to/report.md");
    expect(logSpy).toHaveBeenCalledWith(
      "##vso[task.addattachment type=Distributedtask.Core.Summary;name=MyReport;]/path/to/report.md",
    );
  });

  test("vsoLogIssue should default to error type", () => {
    vsoLogIssue("Something went wrong");
    expect(logSpy).toHaveBeenCalledWith("##vso[task.logissue type=error]Something went wrong");
  });

  test("vsoLogIssue should support custom type", () => {
    vsoLogIssue("Just a warning", LogIssueType.Warning);
    expect(logSpy).toHaveBeenCalledWith("##vso[task.logissue type=warning]Just a warning");
  });

  test("setVsoVariable should set regular variable", () => {
    setVsoVariable("buildNumber", "1234");
    expect(logSpy).toHaveBeenCalledWith("##vso[task.setVariable variable=buildNumber]1234");
  });

  test("setVsoVariable should set output variable", () => {
    setVsoVariable("result", "OK", true);
    expect(logSpy).toHaveBeenCalledWith("##vso[task.setVariable variable=result;isoutput=true]OK");
  });

  test.each([
    ["", ""],
    ["100%", "100%AZP25"],
    ["line1\rline2", "line1%0Dline2"],
    ["line1\nline2", "line1%0Aline2"],
    ["line1\r\nline2", "line1%0D%0Aline2"],
    ["literal %0A and %AZP25", "literal %AZP250A and %AZP25AZP25"],
  ])("setVsoVariable escapes raw value %j", (value, escapedValue) => {
    setVsoVariable("result", value);
    expect(logSpy).toHaveBeenCalledExactlyOnceWith(
      `##vso[task.setVariable variable=result]${escapedValue}`,
    );
  });

  test("setVsoVariable escapes output variables using the same rules", () => {
    setVsoVariable("result", "100%\r\nline2", true);
    expect(logSpy).toHaveBeenCalledExactlyOnceWith(
      "##vso[task.setVariable variable=result;isoutput=true]100%AZP25%0D%0Aline2",
    );
  });
});
