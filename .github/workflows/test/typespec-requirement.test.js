import { simpleGit } from "simple-git";
import { describe, expect, it, vi } from "vitest";
import typespecRequirementSrc from "../src/typespec-requirement.js";
import { createMockCore } from "./mocks.js";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: vi.fn().mockResolvedValue(""),
  }),
}));

/**
 * @param {unknown} asyncFunctionArgs
 */
function typespecRequirement(asyncFunctionArgs) {
  return typespecRequirementSrc(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (asyncFunctionArgs),
  );
}

describe("typespecRequirement", () => {
  it("counts changed files", async () => {
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        diff: vi
          .fn()
          .mockResolvedValue(
            [
              "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json",
              "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
              "specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json",
              "specification/baz/main.tsp",
            ].join("\n"),
          ),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.info).toHaveBeenCalledWith("changed files count: 4");
    expect(core.info).toHaveBeenCalledWith("changed swaggers count: 2");
  });
});
