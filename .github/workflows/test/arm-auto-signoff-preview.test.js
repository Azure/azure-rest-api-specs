import { describe, expect, it } from "vitest";
import { createMockCore } from "../../test/mocks.js";
import armAutoSignoffPreview from "../src/arm-auto-signoff-preview.js";

describe("armAutoSignoffPreview", () => {
  it("logs hello", async () => {
    const core = createMockCore();

    await expect(
      armAutoSignoffPreview({
        github: null,
        context: null,
        core: core,
      }),
    ).resolves.toBeUndefined();

    expect(core.info).toBeCalledWith("Hello world!");
  });
});
