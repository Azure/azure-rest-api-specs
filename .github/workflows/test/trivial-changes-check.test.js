import { afterEach, describe, expect, it, vi } from "vitest";

vi.mock("simple-git", () => ({
  simpleGit: vi.fn().mockReturnValue({
    show: vi.fn().mockResolvedValue(""),
  }),
}));

import * as simpleGit from "simple-git";
import * as changedFiles from "../../shared/src/changed-files.js";
import checkTrivialChangesImpl from "../src/trivial-changes-check.js";
import { createMockCore } from "./mocks.js";

const core = createMockCore();

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

    const result = await checkTrivialChanges({ core });

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("returns documentation only changes for .md files", async () => {
    const mdFiles = [
      "specification/someservice/README.md",
      "documentation/some-doc.md",
      "docs/api-guide.md"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mdFiles);

    const result = await checkTrivialChanges({ core });

    expect(result).toEqual({
      documentationOnlyChanges: true,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: true,
    });
  });

  it("returns examples only changes for example files", async () => {
    const exampleFiles = [
      "specification/someservice/examples/Get.json",
      "specification/anotherservice/examples/Create.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(exampleFiles);

    const result = await checkTrivialChanges({ core });

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: true,
      nonFunctionalChanges: false,
      anyTrivialChanges: true,
    });
  });

  it("returns non-functional changes for JSON files with only non-functional properties", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
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
    
    const showSpy = vi.mocked(simpleGit.simpleGit().show)
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

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: true,
      anyTrivialChanges: true,
    });

    expect(showSpy).toHaveBeenCalledWith([`HEAD^:${jsonFiles[0]}`]);
    expect(showSpy).toHaveBeenCalledWith([`HEAD:${jsonFiles[0]}`]);
  });

  it("returns false for functional changes in JSON files", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
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

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles mixed trivial and non-trivial changes", async () => {
    const mixedFiles = [
      "specification/someservice/README.md", // Documentation (trivial)
      "specification/someservice/examples/Get.json", // Examples (trivial)
      "specification/someservice/stable/2021-01-01/service.json" // Functional change (non-trivial)
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
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.includes("service.json")) {
            if (ref.startsWith("HEAD^:")) {
              return Promise.resolve(oldJson);
            } else if (ref.startsWith("HEAD:")) {
              return Promise.resolve(newJson);
            }
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core });

    // Should detect functional changes, so overall not trivial
    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles JSON parsing errors gracefully", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockImplementation((args) => {
        if (Array.isArray(args)) {
          const ref = args[0];
          if (ref.startsWith("HEAD^:")) {
            return Promise.resolve("{ invalid json");
          } else if (ref.startsWith("HEAD:")) {
            return Promise.resolve("{ also invalid }");
          }
        }
        return Promise.reject(new Error("does not exist"));
      });

    const result = await checkTrivialChanges({ core });

    // Should treat JSON parsing errors as non-trivial changes
    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles git show errors gracefully", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(jsonFiles);
    
    vi.mocked(simpleGit.simpleGit().show)
      .mockRejectedValue(new Error("Git operation failed"));

    const result = await checkTrivialChanges({ core });

    // Should treat git errors as non-trivial changes  
    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles nested non-functional property changes", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
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

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: true,
      anyTrivialChanges: true,
    });
  });

  it("detects functional changes in nested properties", async () => {
    const jsonFiles = [
      "specification/someservice/stable/2021-01-01/service.json"
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

    expect(result).toEqual({
      documentationOnlyChanges: false,
      examplesOnlyChanges: false,
      nonFunctionalChanges: false,
      anyTrivialChanges: false,
    });
  });

  it("handles mixed documentation and examples correctly", async () => {
    const mixedTrivialFiles = [
      "specification/someservice/README.md",
      "docs/changelog.md",
      "specification/someservice/examples/Get.json",
      "specification/anotherservice/examples/Create.json"
    ];

    vi.spyOn(changedFiles, "getChangedFiles").mockResolvedValue(mixedTrivialFiles);

    const result = await checkTrivialChanges({ core });

    expect(result).toEqual({
      documentationOnlyChanges: false, // Not ONLY documentation
      examplesOnlyChanges: false, // Not ONLY examples
      nonFunctionalChanges: false, // No JSON analysis needed
      anyTrivialChanges: true, // But it IS all trivial
    });
  });
});