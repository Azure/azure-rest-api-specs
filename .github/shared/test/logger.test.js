// @ts-check

import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { ConsoleLogger, debugLogger, defaultLogger } from "../src/logger";

describe("logger", () => {
  let debugSpy, errorSpy, logSpy;

  beforeEach(() => {
    debugSpy = vi.spyOn(console, "debug");
    errorSpy = vi.spyOn(console, "error");
    logSpy = vi.spyOn(console, "log");
  });

  afterEach(() => {
    debugSpy.mockRestore();
    errorSpy.mockRestore();
    logSpy.mockRestore();
  });

  it.each([
    ["defaultLogger", defaultLogger, false],
    ["debugLogger", debugLogger, true],
    ["new ConsoleLogger(isDebug: false)", new ConsoleLogger(false), false],
    ["new ConsoleLogger(isDebug: true)", new ConsoleLogger(true), true],
  ])("%s", (_name, logger, isDebug) => {
    expect(logger.isDebug()).toBe(isDebug);

    logger.info("test info");
    expect(logSpy).toBeCalledWith("test info");

    logger.error("test error");
    expect(errorSpy).toBeCalledWith("test error");

    logger.debug("test debug");
    if (isDebug) {
      expect(debugSpy).toBeCalledWith("test debug");
    } else {
      expect(debugSpy).toBeCalledTimes(0);
    }
  });
});
