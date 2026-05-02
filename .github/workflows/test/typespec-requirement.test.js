import { simpleGit } from "simple-git";
import { describe, expect, it, vi } from "vitest";
import { getChangedFilesStatuses } from "../../shared/src/changed-files.js";
import typespecRequirementSrc from "../src/typespec-requirement.js";
import { createMockCore } from "./mocks.js";

vi.mock("../../shared/src/changed-files.js", async (importOriginal) => {
  const mod = await importOriginal();
  return {
    .../** @type {typeof import("../../shared/src/changed-files.js")} */ (mod),
    getChangedFilesStatuses: vi.fn(),
  };
});

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    catFile: vi.fn().mockResolvedValue(""),
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
   * @param {{ changedFiles?: Partial<import("../../shared/src/changed-files.js").ChangedFilesStatuses>, existingApiVersion?: boolean, typespecGenerated?: boolean }} options
   */
  async function runTest(options) {
    const core = createMockCore();

    vi.mocked(getChangedFilesStatuses).mockResolvedValue(
      /** @type {import("../../shared/src/changed-files.js").ChangedFilesStatuses} */ ({
        additions: [],
        modifications: [],
        deletions: [],
        renames: [],
        total: 1,
        ...options.changedFiles,
      }),
    );

    vi.mocked(simpleGit).mockReturnValue(
      /** @type {any} */ ({
        catFile: vi.fn().mockImplementation(async () => {
          await Promise.resolve();
          if (options.existingApiVersion === false) {
            throw new Error();
          }
          return "";
        }),
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

  it.each([
    {
      name: "allows typespec-generated swaggers",
      options: {
        changedFiles: {
          additions: [
            "specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json",
          ],
        },
        typespecGenerated: true,
      },
      expected: `changed files count: 1
changed swaggers:
  specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
specification/qux/resource-manager/Microsoft.Qux/stable/2024-01-01/qux.json
  swaggerText length: 38
  typespecGenerated: true`,
    },
    {
      name: "allows swaggers in existing api versions",
      options: {
        changedFiles: {
          additions: [
            "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json",
          ],
        },
      },
      expected: `changed files count: 1
changed swaggers:
  specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/foo.json
  swaggerText length: 2
  typespecGenerated: false
  existingApiVersion: true`,
    },
    {
      name: "blocks swaggers in new api versions",
      options: {
        existingApiVersion: false,
        changedFiles: {
          modifications: ["specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json"],
        },
      },
      expected: `changed files count: 1
changed swaggers:
  specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json
  swaggerText length: 2
  typespecGenerated: false
  existingApiVersion: false
  NEW API VERSION MUST USE TYPESPEC`,
    },
    {
      name: "ignores examples",
      options: {
        changedFiles: {
          renames: [
            {
              from: "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/old_foo.json",
              to: "specification/foo/resource-manager/Microsoft.Foo/stable/2024-01-01/examples/foo.json",
            },
          ],
        },
      },
      expected: `changed files count: 1
changed swaggers:
  `,
    },
    {
      name: "ignores non-swagger files",
      options: {
        changedFiles: { additions: ["specification/baz/main.tsp"] },
      },
      expected: `changed files count: 1
changed swaggers:
  `,
    },
  ])("$name", async ({ options, expected }) => {
    const actual = await runTest(options);
    expect(actual).toEqual(expected);
  });
});
