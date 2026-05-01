import { describe, expect, it } from "vitest";
import typespecRequirementSrc, { isTypeSpecPath } from "../src/typespec-requirement.js";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

/**
 * @param {unknown} asyncFunctionArgs
 */
function typespecRequirement(asyncFunctionArgs) {
  return typespecRequirementSrc(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (asyncFunctionArgs),
  );
}

describe("isTypeSpecPath", () => {
  it("returns true for .tsp files", () => {
    expect(isTypeSpecPath("specification/foo/Foo.tsp")).toBe(true);
  });

  it("returns true for tspconfig.yaml", () => {
    expect(isTypeSpecPath("specification/foo/tspconfig.yaml")).toBe(true);
  });

  it("returns false for other files", () => {
    expect(isTypeSpecPath("specification/foo/openapi.json")).toBe(false);
  });
});

describe("typespecRequirement", () => {
  it("runs without error", async () => {
    const core = createMockCore();
    const github = createMockGithub();
    const context = createMockContext();

    await expect(typespecRequirement({ github, context, core })).resolves.toBeUndefined();

    expect(core.info).toHaveBeenCalled();
  });
});
