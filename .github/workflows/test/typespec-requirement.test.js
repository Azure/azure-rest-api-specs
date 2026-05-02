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
  /**
   * @param {{ diff: string, existingApiVersion?: boolean, typespecGenerated?: boolean }} options
   */
  async function runTest(options) {
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        catFile: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          if (options.existingApiVersion === false) {
            throw new Error();
          }
          return "";
        }),
        diff: vi.fn().mockResolvedValue(options.diff),
        show: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          return options.typespecGenerated
            ? JSON.stringify({ info: { "x-typespec-generated": [{}] } })
            : "{}";
        }),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    return core.debug.mock.calls.map((c) => String(c[0])).join("\n");
  }

  it("allows typespec-generated swaggers", async () => {
    const actual = await runTest({
      diff: "A\tspecification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json",
      typespecGenerated: true,
    });

    expect(actual).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
      specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
        swaggerText length: 38
        typespecGenerated: true"
    `);
  });

  it("allows swaggers in existing api versions", async () => {
    const actual = await runTest({
      diff: "A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json",
    });

    expect(actual).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
      specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
        swaggerText length: 2
        typespecGenerated: false
        existingApiVersion: true"
    `);
  });

  it("blocks swaggers in new api versions", async () => {
    const actual = await runTest({
      existingApiVersion: false,
      diff: "M\tspecification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json",
    });

    expect(actual).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
      specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
        swaggerText length: 2
        typespecGenerated: false
        existingApiVersion: false
        NEW API VERSION MUST USE TYPESPEC"
    `);
  });

  it("ignores examples", async () => {
    const actual = await runTest({
      diff: [
        "R100",
        "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/old_foo.json",
        "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
      ].join("\t"),
    });

    expect(actual).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        "
    `);
  });

  it("ignores non-swagger files", async () => {
    const actual = await runTest({
      diff: "A\tspecification/baz/main.tsp",
    });

    expect(actual).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        "
    `);
  });
});
