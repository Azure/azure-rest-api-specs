import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    show: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import * as changedFiles from "../../shared/src/changed-files.js";
import checkTrivialChangesImpl from "../src/arm-auto-signoff/trivial-changes-check.js";
import { createMockCore, createMockContext } from "./mocks.js";

const core = createMockCore();
const context = createMockContext();

/**
 * @param {unknown} asyncFunctionArgs
 */
function checkTrivialChanges(asyncFunctionArgs) {
  return checkTrivialChangesImpl(
    /** @type {import("@actions/github-script").AsyncFunctionArguments} */ (asyncFunctionArgs),
  );
}

describe("checkTrivialChanges", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("throws if inputs null", async () => {
    await expect(checkTrivialChanges({})).rejects.toThrow();
  });

  it("returns all false if no changed files", async () => {
    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([]);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: [], deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("returns documentation only changes for .md files", async () => {
    const mdFiles = [
      "specification/someservice/resource-manager/readme.md",
      "specification/someservice/resource-manager/Microsoft.Service/preview/2021-01-01/README.md"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mdFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: mdFiles, deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: true,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: true,
    });
  });

  it("returns examples only changes for example files", async () => {
    const exampleFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Create.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(exampleFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: exampleFiles, deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: true,
      nonFunctionalChanges: false,
      anyTrivialChanges: true,
    });
  });

  it("returns non-functional changes for JSON files with only non-functional properties", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { "/test": { get: { summary: "Test endpoint" } } }
    });

    const newJson = JSON.stringify({
      info: { 
        title: "Service API", 
        version: "1.0",
        description: "New description" // Non-functional change
      },
      paths: { "/test": { get: { summary: "Test endpoint" } } }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    const showSpy = vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.includes("origin/main:")) {
            return Promise.resolve(oldJson);
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve(newJson);
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: true,
      anyTrivialChanges: true,
    });

    expect(showSpy).toHaveBeenCalled();
  });

  it("returns false for functional changes in JSON files", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { "/test": { get: { summary: "Test endpoint" } } }
    });

    const newJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { 
        "/test": { get: { summary: "Test endpoint" } },
        "/new": { post: { summary: "New endpoint" } } // Functional change
      }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({});
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.startsWith("HEAD^:")) {
            return Promise.resolve(oldJson);
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve(newJson);
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles mixed trivial and non-trivial changes", async () => {
    const mixedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/README.md", // Documentation (trivial)
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json", // Examples (trivial)
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json" // Functional change (non-trivial)
    ];

    const oldJson = JSON.stringify({
      paths: { "/test": { get: { summary: "Test endpoint" } } }
    });

    const newJson = JSON.stringify({
      paths: { 
        "/test": { get: { summary: "Test endpoint" } },
        "/new": { post: { summary: "New endpoint" } } // Functional change
      }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mixedFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: mixedFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.includes("service.json")) {
            if (ref.includes("origin/main:")) {
              return Promise.resolve(oldJson);
            } else if (ref.startsWith("HEAD:")) {
              return Promise.resolve(newJson);
            }
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    // Should detect functional changes, so overall not trivial
    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles JSON parsing errors gracefully", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.includes("origin/main:")) {
            return Promise.resolve("{ invalid json");
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve("{ also invalid }");
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    // Should treat JSON parsing errors as non-trivial changes
    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles git show errors gracefully", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockRejectedValue(new Error("Git operation failed"));

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    // Should treat git errors as non-trivial changes  
    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles nested non-functional property changes", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { 
        "/test": { 
          get: { 
            summary: "Test endpoint",
            operationId: "Test_Get"
          } 
        } 
      }
    });

    const newJson = JSON.stringify({
      info: { 
        title: "Service API", 
        version: "1.0",
        description: "API description" // Non-functional change
      },
      paths: { 
        "/test": { 
          get: { 
            summary: "Updated test endpoint", // Non-functional change
            description: "Gets test data", // Non-functional change
            operationId: "Test_Get"
          } 
        } 
      }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({});
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.startsWith("HEAD^:")) {
            return Promise.resolve(oldJson);
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve(newJson);
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: true,
      anyTrivialChanges: true,
    });
  });

  it("detects functional changes in nested properties", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { 
        "/test": { 
          get: { 
            parameters: [
              { name: "id", in: "path", required: true, type: "string" }
            ]
          } 
        } 
      }
    });

    const newJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { 
        "/test": { 
          get: { 
            parameters: [
              { name: "id", in: "path", required: true, type: "string" },
              { name: "filter", in: "query", required: false, type: "string" } // Functional change
            ]
          } 
        } 
      }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({});
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.startsWith("HEAD^:")) {
            return Promise.resolve(oldJson);
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve(newJson);
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles mixed documentation and examples correctly", async () => {
    const mixedTrivialFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/README.md",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Get.json",
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/examples/Create.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mixedTrivialFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: mixedTrivialFiles, deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentationOnlyChanges: false, // Not ONLY documentation
      examplesOnlyChanges: false, // Not ONLY examples
      nonFunctionalChanges: false, // No JSON analysis needed
      anyTrivialChanges: true, // But it IS all trivial
    });
  });
});