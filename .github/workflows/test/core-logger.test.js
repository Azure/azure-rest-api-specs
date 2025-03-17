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
});
