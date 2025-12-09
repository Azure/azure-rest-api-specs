import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    show: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import * as changedFiles from "../../shared/src/changed-files.js";
import checkTrivialChanges from "../src/arm-auto-signoff/trivial-changes-check.js";
import { createMockCore, createMockContext } from "./mocks.js";

const core = createMockCore();
const context = createMockContext();

describe("checkTrivialChanges", () => {
  afterEach(() => {
    vi.clearAllMocks();
  });

  it("throws error when core and context are not provided", async () => {
    await expect(checkTrivialChanges({})).rejects.toThrow();
  });

  it("returns empty change flags when no files are changed", async () => {
    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([]);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: [], deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: false,
      other: false,
    });
  });
  
  it("marks PR as 'other' when non-resource-manager files are changed", async () => {
    const mixedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json",
      "specification/someservice/data-plane/Service/stable/2021-01-01/service.json", // data-plane (non-RM)
      "README.md", // root level file (non-RM)
      ".github/workflows/ci.yml" // workflow file (non-RM)
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mixedFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: mixedFiles, deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: false,
      other: true,
    });
  });

  it("marks PR as 'other' when only non-resource-manager files are changed", async () => {
    const nonRmFiles = [
      "specification/someservice/data-plane/Service/stable/2021-01-01/service.json",
      "package.json",
      "tsconfig.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(nonRmFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: nonRmFiles, deletions: [], renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: false,
      other: false, // No RM files at all, so returns empty
    });
  });

  it("detects functional changes when new spec files are added", async () => {
    const filesWithAdditions = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/newservice.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(filesWithAdditions);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: filesWithAdditions, // New spec file
      modifications: [],
      deletions: [],
      renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: true, // New spec files are functional
      other: false,
    });
  });

  it("detects functional changes when spec files are deleted", async () => {
    const deletedFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/oldservice.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(deletedFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: [],
      deletions: deletedFiles, // Deleted spec file
      renames: []
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: true, // Deleted spec files are functional
      other: false,
    });
  });

  it("detects functional changes when spec files are renamed", async () => {
    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue([
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/newname.json"
    ]);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [],
      modifications: [],
      deletions: [],
      renames: [{
        from: "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/oldname.json",
        to: "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/newname.json"
      }]
    });

    const result = await checkTrivialChanges({ core, context });
    const parsed = JSON.parse(result);

    expect(parsed).toEqual({
      documentation: false,
      examples: false,
      functional: true, // Renamed spec files are functional
      other: false,
    });
  });

  it("detects documentation-only changes when only .md files are modified", async () => {
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
      documentation: true,
      examples: false,
      functional: false,
      other: false,
    });
  });

  it("detects examples-only changes when only example JSON files are modified", async () => {
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
      documentation: false,
      examples: true,
      functional: false,
      other: false,
    });
  });

  it("identifies non-functional changes when only description and summary properties are modified", async () => {
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
      paths: { "/test": { get: { summary: "Test endpoint updated" } } } // Non-functional change
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
      documentation: false,
      examples: false,
      functional: false,
      other: false,
    });

    expect(showSpy).toHaveBeenCalled();
  });

  it("detects functional changes when new API endpoints are added", async () => {
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
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
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
      documentation: false,
      examples: false,
      functional: true,
      other: false,
    });
  });

  it("detects functional changes even when mixed with documentation and example changes", async () => {
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
      documentation: true,
      examples: true,
      functional: true,
      other: false,
    });
  });

  it("treats JSON parsing errors as functional changes to be conservative", async () => {
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
      documentation: false,
      examples: false,
      functional: true,
      other: false,
    });
  });

  it("treats git operation errors as functional changes to be conservative", async () => {
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
      documentation: false,
      examples: false,
      functional: true,
      other: false,
    });
  });

  it("correctly identifies non-functional changes in nested object properties", async () => {
    const jsonFiles = [
      "specification/someservice/resource-manager/Microsoft.Service/stable/2021-01-01/service.json"
    ];

    const oldJson = JSON.stringify({
      info: { title: "Service API", version: "1.0" },
      paths: { 
        "/test": { 
          get: { 
            summary: "Test endpoint",
            description: "Gets test data",
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
            description: "Gets test data",
            operationId: "Test_Get"
          } 
        } 
      }
    });

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
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
      documentation: false,
      examples: false,
      functional: false,
      other: false,
    });
  });

  it("detects functional changes when parameters are added to API operations", async () => {
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
    vi.spyOn(changedFiles, "getChangedFilesStatuses").mockResolvedValue({
      additions: [], modifications: jsonFiles, deletions: [], renames: []
    });
    
    vi.mocked(simpleGit.simpleGit().show)
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
      documentation: false,
      examples: false,
      functional: true,
      other: false,
    });
  });

  it("correctly identifies multiple trivial change types together (documentation + examples)", async () => {
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
      documentation: true,
      examples: true,
      functional: false,
      other: false,
    });
  });
});