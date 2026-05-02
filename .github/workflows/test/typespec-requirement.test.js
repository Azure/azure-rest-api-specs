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

    return await typespecRequirement({ core });
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
      expected: true,
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
      expected: true,
    },
    {
      name: "blocks swaggers in new api versions",
      options: {
        existingApiVersion: false,
        changedFiles: {
          modifications: ["specification/bar/data-plane/Microsoft.Bar/stable/2024-01-01/bar.json"],
        },
      },
      expected: false,
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
      expected: true,
    },
    {
      name: "ignores non-swagger files",
      options: {
        changedFiles: { additions: ["specification/baz/main.tsp"] },
      },
      expected: true,
    },
  ])("$name", async ({ options, expected }) => {
    const actual = await runTest(options);
    expect(actual).toBe(expected);
  });
});
