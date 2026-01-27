import { afterEach, describe, expect, it, vi } from "vitest";
import * as changedFiles from "../../../shared/src/changed-files.js";
import { checkTrivialChanges } from "../../src/arm-auto-signoff/trivial-changes-check.js";
import { createMockCore } from "../mocks.js";

/** @type {import("vitest").Mock<(args: string[]) => Promise<string>>} */
const mockShow = vi.hoisted(() => vi.fn().mockResolvedValue(""));

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    show: mockShow,
  }),
}));

const core = createMockCore();

/** @typedef {import("../../src/arm-auto-signoff/pr-changes.js").PullRequestChanges} PullRequestChanges */

/**
 * The tests mock `simple-git` to return a minimal object with only `show`.
 * Return that mock with a precise type so ESLint doesn't treat it as an unbound method.
 * @returns {{ show: import("vitest").Mock<(args: string[]) => Promise<string>> }}
 */
function getMockGit() {
  return { show: mockShow };
}

describe("checkTrivialChanges", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("returns empty change flags when no files are changed", async () => {
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: [],
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);

    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("marks PR as 'other' when non-resource-manager files are changed", async () => {
    const mixedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
      "specification/someservice/data-plane/Service/stable/2021-01-01/service.json", // data-plane (non-RM)
      "README.md", // root level file (non-RM)
      ".github/workflows/ci.yml", // workflow file (non-RM)
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: mixedFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);

    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: true,
    });
  });

  it("marks PR as 'other' when only non-resource-manager files are changed", async () => {
    const nonRmFiles = [
      "specification/someservice/data-plane/Service/stable/2021-01-01/service.json",
      "package.json",
      "tsconfig.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: nonRmFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: true, // Non-RM changes block ARM auto-signoff even when there are no RM changes
    });
  });

  it("detects functional changes when new spec files are added", async () => {
    const filesWithAdditions = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/newservice.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: filesWithAdditions, // New spec file
      modifications: [],
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true, // New spec files are functional
      rmOther: false,
      other: false,
    });
  });

  it("detects functional changes when spec files are deleted", async () => {
    const deletedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/oldservice.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: [],
      deletions: deletedFiles, // Deleted spec file
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true, // Deleted spec files are functional
      rmOther: false,
      other: false,
    });
  });

  it("detects functional changes when spec files are renamed", async () => {
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: [],
      deletions: [],
      renames: [
        {
          from: "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/oldname.json",
          to: "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/newname.json",
        },
      ],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true, // Renamed spec files are functional
      rmOther: false,
      other: false,
    });
  });

  it("detects documentation-only changes when only .md files are modified", async () => {
    const mdFiles = [
      "specification/someservice/resource-manager/readme.md",
      "specification/someservice/resource-manager/Microsoft.Service/preview/2021-01-01/README.md",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: mdFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: true,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("detects examples-only changes when only example JSON files are modified", async () => {
    const exampleFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Create.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: exampleFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: true,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("marks rmOther when other resource-manager files are changed", async () => {
    const rmOtherFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/readme.md",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/notes.txt",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: rmOtherFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: true,
      rmExamples: false,
      rmFunctional: false,
      rmOther: true,
      other: false,
    });
  });

  it("identifies non-functional changes when only description and summary properties are modified", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { "/test": { get: { summary: "Test endpoint" } } },
    });

    const newJson = JSON.stringify({
      info: {
        title: "Service API",
        version: "1.0",
        description: "New description", // Non-functional change
      },
      paths: { "/test": { get: { summary: "Test endpoint updated" } } }, // Non-functional change
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const showSpy = getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });

    expect(showSpy).toHaveBeenCalled();
  });

  it("detects functional changes when new API endpoints are added", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { "/test": { get: { summary: "Test endpoint" } } },
    });

    const newJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: {
        "/test": { get: { summary: "Test endpoint" } },
        "/new": { post: { summary: "New endpoint" } }, // Functional change
      },
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("detects functional changes even when mixed with documentation and example changes", async () => {
    const mixedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/README.md", // Documentation (trivial)
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json", // Examples (trivial)
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json", // Functional change (non-trivial)
    ];

    const oldJson = JSON.stringify({
      paths: { "/test": { get: { summary: "Test endpoint" } } },
    });

    const newJson = JSON.stringify({
      paths: {
        "/test": { get: { summary: "Test endpoint" } },
        "/new": { post: { summary: "New endpoint" } }, // Functional change
      },
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: mixedFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.includes("service.json")) {
        if (ref.startsWith("HEAD^:")) {
          return Promise.resolve(oldJson);
        }
        if (ref.startsWith("HEAD:")) {
          return Promise.resolve(newJson);
        }
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    // Should detect functional changes, so overall not trivial
    expect(result).toMatchObject({
      rmDocumentation: true,
      rmExamples: true,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("treats JSON parsing errors as functional changes to be conservative", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve("{ invalid json");
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve("{ also invalid }");
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    // Should treat JSON parsing errors as non-trivial changes
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("treats git operation errors as functional changes to be conservative", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockRejectedValue(new Error("Git operation failed"));

    const result = await checkTrivialChanges(core);
    // Should treat git errors as non-trivial changes
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("correctly identifies non-functional changes in nested object properties", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: {
        "/test": {
          get: {
            summary: "Test endpoint",
            description: "Gets test data",
            operationId: "Test_Get",
          },
        },
      },
    });

    const newJson = JSON.stringify({
      info: {
        title: "Service API",
        version: "1.0",
        description: "API description", // Non-functional change
      },
      paths: {
        "/test": {
          get: {
            summary: "Updated test endpoint", // Non-functional change
            description: "Gets test data",
            operationId: "Test_Get",
          },
        },
      },
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("detects functional changes when parameters are added to API operations", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: {
        "/test": {
          get: {
            parameters: [{ name: "id", in: "path", required: true, type: "string" }],
          },
        },
      },
    });

    const newJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: {
        "/test": {
          get: {
            parameters: [
              { name: "id", in: "path", required: true, type: "string" },
              { name: "filter", in: "query", required: false, type: "string" }, // Functional change
            ],
          },
        },
      },
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("correctly identifies multiple trivial change types together (documentation + examples)", async () => {
    const mixedTrivialFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/README.md",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Create.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: mixedTrivialFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: true,
      rmExamples: true,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("ignores empty/invalid changed file entries", async () => {
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [""],
      modifications: /** @type {any} */ ([null]),
      deletions: /** @type {any} */ ([undefined]),
      renames: [],
      total: 0,
    });

    const result = await checkTrivialChanges(core);

    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("treats missing base content for a modified spec file as functional", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.reject(new Error("does not exist"));
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(JSON.stringify({ openapi: "3.0.0", info: { title: "t" } }));
      }
      return Promise.reject(new Error("unexpected ref"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("treats missing head content for a modified spec file as functional", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(JSON.stringify({ openapi: "3.0.0", info: { title: "t" } }));
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.reject(new Error("does not exist"));
      }
      return Promise.reject(new Error("unexpected ref"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });

  it("treats array length changes under non-functional properties (tags) as non-functional", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      openapi: "3.0.0",
      info: { title: "Service API", version: "1.0" },
      tags: ["a"],
    });

    const newJson = JSON.stringify({
      openapi: "3.0.0",
      info: { title: "Service API", version: "1.0" },
      tags: ["a", "b"],
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("treats type changes under non-functional properties (description) as non-functional", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify({
      openapi: "3.0.0",
      info: { title: "Service API", version: "1.0" },
      description: "old",
    });

    const newJson = JSON.stringify({
      openapi: "3.0.0",
      info: { title: "Service API", version: "1.0" },
      description: 123,
    });

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: false,
      rmOther: false,
      other: false,
    });
  });

  it("treats a root array length change as functional (conservative)", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
    ];

    const oldJson = JSON.stringify([]);
    const newJson = JSON.stringify([1]);

    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: jsonFiles,
      deletions: [],
      renames: [],
      total: 0,
    });

    getMockGit().show.mockImplementation((args) => {
      const ref = args[0];
      if (typeof ref === "string" && ref.startsWith("HEAD^:")) {
        return Promise.resolve(oldJson);
      }
      if (typeof ref === "string" && ref.startsWith("HEAD:")) {
        return Promise.resolve(newJson);
      }
      return Promise.reject(new Error("does not exist"));
    });

    const result = await checkTrivialChanges(core);
    expect(result).toMatchObject({
      rmDocumentation: false,
      rmExamples: false,
      rmFunctional: true,
      rmOther: false,
      other: false,
    });
  });
});
