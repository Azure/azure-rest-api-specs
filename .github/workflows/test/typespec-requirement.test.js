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
  it("allows typespec-generated swaggers", async () => {
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        catFile: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          return "";
        }),
        diff: vi.fn().mockResolvedValue("A\tspecification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json"),
        show: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          return JSON.stringify({ info: { "x-typespec-generated": [{}] } });
        }),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
      specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
        swaggerText length: 38
        typespecGenerated: true"
    `);
  });

  it("allows swaggers in existing api versions", async () => {
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        catFile: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          return "";
        }),
        diff: vi.fn().mockResolvedValue("A\tspecification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json"),
        show: vi.fn().mockResolvedValue("{}"),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
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
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        catFile: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          throw new Error();
        }),
        diff: vi.fn().mockResolvedValue("M\tspecification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json"),
        show: vi.fn().mockResolvedValue("{}"),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
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
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        diff: vi
          .fn()
          .mockResolvedValue(
            [
              "R100",
              "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/old_foo.json",
              "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
            ].join("\t"),
          ),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        "
    `);
  });

  it("ignores non-swagger files", async () => {
    const core = createMockCore();
    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        diff: vi.fn().mockResolvedValue("A\tspecification/baz/main.tsp"),
      }),
    );

    await expect(typespecRequirement({ core })).resolves.toBe(true);

    expect(core.debug.mock.calls.map((c) => String(c[0])).join("\n")).toMatchInlineSnapshot(`
      "changed files count: 1
      changed swaggers:
        "
    `);
  });
});
