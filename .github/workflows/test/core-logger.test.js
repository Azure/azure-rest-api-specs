import { describe, expect, it } from "vitest";
import { CoreLogger } from "../src/core-logger.js";
import { createMockCore } from "./mocks.js";

describe("CoreLogger", () => {
  it("debug", async () => {
    const core = createMockCore();
    const logger = new CoreLogger(core);

    logger.debug("test debug");

    expect(core.debug).toBeCalledWith("test debug");
  });

  it("info", async () => {
    const core = createMockCore();
    const logger = new CoreLogger(core);

    logger.info("test info");

    expect(core.info).toBeCalledWith("test info");
  });

  it("isDebug", async () => {
    const core = createMockCore();
    core.isDebug.mockReturnValue(true);

    const logger = new CoreLogger(core);

    expect(logger.isDebug()).toBe(true);

    expect(core.isDebug).toBeCalled();
  });
});
