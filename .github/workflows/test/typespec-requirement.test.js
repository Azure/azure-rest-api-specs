import { simpleGit } from "simple-git";
import { describe, expect, it, vi } from "vitest";
import typespecRequirementSrc from "../src/typespec-requirement.js";
import { createMockCore } from "./mocks.js";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    diff: vi.fn().mockResolvedValue(""),
    show: vi.fn().mockResolvedValue(""),
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
              "A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json",
              "A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
              "M\tspecification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json",
              "A\tspecification/baz/main.tsp",
            ].join("\n"),
          ),
        show: vi.fn().mockResolvedValue("{}"),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
      "changed files count: 4
      changed swaggers:
        specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
        specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
      swagger length: 2
      swagger length: 2"
    `);
  });
});
