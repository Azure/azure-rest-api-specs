import { describe, expect, it } from "vitest";
import typespecRequirementSrc from "../src/typespec-requirement.js";
import { createMockCore } from "./mocks.js";

/**
 * @param {unknown} asyncFunctionArgs
 */
function typespecRequirement(asyncFunctionArgs) {
  return typespecRequirementSrc(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (asyncFunctionArgs),
  );
}

describe("typespecRequirement", () => {
  it("runs without error", async () => {
    const core = createMockCore();

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.info).toHaveBeenCalled();
  });
});
