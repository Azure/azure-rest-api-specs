import { simpleGit } from "simple-git";
import { describe, expect, it, vi } from "vitest";
import typespecRequirementSrc from "../src/typespec-requirement.js";
import { createMockCore } from "./mocks.js";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    catFile: vi.fn().mockResolvedValue(""),
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
        catFile: vi.fn().mockImplementation(async (/** @type {string[]} */ args) => {
          await Promise.resolve();
          if (args[1].includes("data-plane")) {
            throw new Error();
          }
          return "";
        }),
        diff: vi
          .fn()
          .mockResolvedValue(
            [
              "A\tspecification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json",
              "A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json",
              "A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
              "M\tspecification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json",
              "A\tspecification/baz/main.tsp",
            ].join("\n"),
          ),
        show: vi.fn().mockImplementation(async (/** @type {string[]} */ args) => {
          await Promise.resolve();
          if (args[0].includes("qux.json")) {
            return JSON.stringify({ info: { "x-typespec-generated": [{}] } });
          }
          return "{}";
        }),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
      "changed files count: 5
      changed swaggers:
        specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
        specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
        specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
      specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
        swaggerText length: 38
        typespecGenerated: true
      specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
        swaggerText length: 2
        typespecGenerated: false
        existingApiVersion: true
      specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
        swaggerText length: 2
        typespecGenerated: false
        existingApiVersion: false
        NEW API VERSION MUST USE TYPESPEC"
    `);
  });
});
