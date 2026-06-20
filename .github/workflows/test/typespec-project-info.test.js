import { existsSync } from "fs";
import { readFile } from "fs/promises";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { createMockContext, createMockCore, createMockGithub } from "./mocks.js";

// Mock fs and fs/promises
vi.mock("fs", () => ({
  existsSync: vi.fn(),
}));

vi.mock("fs/promises", () => ({
  readFile: vi.fn(),
}));

const { getTypeSpecProjectInfo, findTspConfigDir, detectApiVersions } =
  await import("../src/typespec-project-info.js");

describe("getTypeSpecProjectInfo", () => {
  /** @type {ReturnType<typeof createMockCore>} */
  let core;
  /** @type {ReturnType<typeof createMockGithub>} */
  let github;
  /** @type {ReturnType<typeof createMockContext>} */
  let context;

  beforeEach(() => {
    core = createMockCore();
    github = createMockGithub();
    context = createMockContext();
    context.payload = {
      pull_request: {
        number: 42,
        html_url: "https://github.com/Azure/azure-rest-api-specs/pull/42",
      },
    };
    github.rest.pulls.listFiles = vi.fn().mockResolvedValue({ data: [] });
    vi.mocked(existsSync).mockReturnValue(false);
    vi.mocked(readFile).mockRejectedValue(new Error("not found"));
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  /** @param {Array<string | { filename: string, status?: string }>} files */
  function mockPrFiles(files) {
    github.rest.pulls.listFiles = vi.fn().mockResolvedValue({
      data: files.map((f) =>
        typeof f === "string" ? { filename: f, status: "modified" } : { status: "modified", ...f },
      ),
    });
  }

  it("returns empty when no specification files changed", async () => {
    mockPrFiles([]);

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toEqual([]);
    expect(result.apiVersions).toEqual([]);
    expect(result.isPreview).toBe(false);
  });

  it("returns empty when no tspconfig.yaml found", async () => {
    mockPrFiles(["specification/foo/resource-manager/readme.md"]);

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toEqual([]);
  });

  it("returns multiple project paths when multiple projects found", async () => {
    mockPrFiles([
      "specification/foo/Microsoft.Foo/Service1/main.tsp",
      "specification/bar/Microsoft.Bar/Service2/main.tsp",
    ]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      const path = String(p);
      return path.includes("Service1/tspconfig.yaml") || path.includes("Service2/tspconfig.yaml");
    });

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toHaveLength(2);
    expect(result.tspProjectPaths).toContain("specification/foo/Microsoft.Foo/Service1");
    expect(result.tspProjectPaths).toContain("specification/bar/Microsoft.Bar/Service2");
  });

  it("uses single changed tspconfig.yaml as authoritative project path even with other changed directories", async () => {
    mockPrFiles([
      { filename: "specification/dell/resource-manager/Dell.Storage/Dell/tspconfig.yaml", status: "modified" },
      "specification/other/serviceA/main.tsp",
      "specification/other/serviceB/models/foo.tsp",
    ]);
    vi.mocked(existsSync).mockReturnValue(false);

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toEqual(["specification/dell/resource-manager/Dell.Storage/Dell"]);
    expect(result.tspProjectUrls).toEqual([
      "https://github.com/Azure/azure-rest-api-specs/specification/dell/resource-manager/Dell.Storage/Dell",
    ]);
  });

  it("ignores removed tspconfig.yaml when selecting authoritative changed tspconfig file", async () => {
    mockPrFiles([
      { filename: "specification/foo/Microsoft.Foo/Service/tspconfig.yaml", status: "removed" },
      { filename: "specification/bar/Microsoft.Bar/Service/tspconfig.yaml", status: "added" },
    ]);

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toEqual(["specification/bar/Microsoft.Bar/Service"]);
  });

  it("detects preview from file path pattern", async () => {
    mockPrFiles(["specification/foo/Microsoft.Foo/Service/preview/2025-06-01-preview/foo.json"]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p).includes("Service/tspconfig.yaml");
    });

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.tspProjectPaths).toEqual(["specification/foo/Microsoft.Foo/Service"]);
    expect(result.apiVersions).toEqual(["2025-06-01-preview"]);
    expect(result.isPreview).toBe(true);
  });

  it("detects GA from file path pattern", async () => {
    mockPrFiles(["specification/foo/Microsoft.Foo/Service/stable/2025-06-01/foo.json"]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p).includes("Service/tspconfig.yaml");
    });

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.apiVersions).toEqual(["2025-06-01"]);
    expect(result.isPreview).toBe(false);
  });

  it("falls back to main.tsp for version detection when single project", async () => {
    mockPrFiles(["specification/foo/Microsoft.Foo/Service/main.tsp"]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p).includes("Service/tspconfig.yaml");
    });
    vi.mocked(readFile).mockResolvedValue(
      `enum Versions {\n  v2025_06_01_preview: "2025-06-01-preview",\n}`,
    );

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.apiVersions).toEqual(["2025-06-01-preview"]);
    expect(result.isPreview).toBe(true);
  });

  it("detects multiple API versions from file paths", async () => {
    mockPrFiles([
      "specification/foo/Microsoft.Foo/Service/stable/2025-01-01/foo.json",
      "specification/foo/Microsoft.Foo/Service/preview/2025-06-01-preview/bar.json",
    ]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p).includes("Service/tspconfig.yaml");
    });

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.apiVersions).toHaveLength(2);
    expect(result.apiVersions).toContain("2025-01-01");
    expect(result.apiVersions).toContain("2025-06-01-preview");
    expect(result.isPreview).toBe(true);
  });

  it("detects multiple API versions from main.tsp", async () => {
    mockPrFiles(["specification/foo/Microsoft.Foo/Service/models.tsp"]);
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p).includes("Service/tspconfig.yaml");
    });
    vi.mocked(readFile).mockResolvedValue(
      `enum Versions {\n  v2025_01_01: "2025-01-01",\n  v2025_06_01_preview: "2025-06-01-preview",\n}`,
    );

    const result = await getTypeSpecProjectInfo(github, context, core);

    expect(result.apiVersions).toHaveLength(2);
    expect(result.apiVersions).toContain("2025-01-01");
    expect(result.apiVersions).toContain("2025-06-01-preview");
    expect(result.isPreview).toBe(true);
  });
});

describe("findTspConfigDir", () => {
  beforeEach(() => {
    vi.mocked(existsSync).mockReturnValue(false);
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("returns null when no tspconfig.yaml found", () => {
    const result = findTspConfigDir("specification/foo/bar/main.tsp", "/workspace");

    expect(result).toBeNull();
  });

  it("finds tspconfig.yaml in parent directory", () => {
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p) === "/workspace/specification/foo/bar/tspconfig.yaml";
    });

    const result = findTspConfigDir("specification/foo/bar/models/model.tsp", "/workspace");

    expect(result).toBe("specification/foo/bar");
  });

  it("walks up multiple levels", () => {
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      return String(p) === "/workspace/specification/foo/tspconfig.yaml";
    });

    const result = findTspConfigDir(
      "specification/foo/resource-manager/stable/2025-01-01/foo.json",
      "/workspace",
    );

    expect(result).toBe("specification/foo");
  });

  it("stops at specification boundary", () => {
    vi.mocked(existsSync).mockImplementation((/** @type {string} */ p) => {
      // tspconfig.yaml only exists above specification/
      return String(p) === "/workspace/tspconfig.yaml";
    });

    const result = findTspConfigDir("specification/foo/main.tsp", "/workspace");

    expect(result).toBeNull();
  });
});

describe("detectApiVersions", () => {
  /** @type {ReturnType<typeof createMockCore>} */
  let core;

  beforeEach(() => {
    core = createMockCore();
    vi.mocked(readFile).mockRejectedValue(new Error("not found"));
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("detects versions from file paths first", async () => {
    const files = [
      "specification/foo/stable/2025-06-01/foo.json",
      "specification/foo/preview/2025-09-01-preview/bar.json",
    ];

    const result = await detectApiVersions(files, "specification/foo", "/workspace", core);

    expect(result.apiVersions).toContain("2025-06-01");
    expect(result.apiVersions).toContain("2025-09-01-preview");
    expect(result.isPreview).toBe(true);
  });

  it("sorts multiple API versions with latest first", async () => {
    const files = [
      "specification/foo/stable/2025-06-01/foo.json",
      "specification/foo/preview/2025-09-01-preview/bar.json",
      "specification/foo/stable/2025-09-01/baz.json",
      "specification/foo/stable/2024-12-01/qux.json",
    ];

    const result = await detectApiVersions(files, "specification/foo", "/workspace", core);

    expect(result.apiVersions).toEqual([
      "2025-09-01",
      "2025-09-01-preview",
      "2025-06-01",
      "2024-12-01",
    ]);
  });

  it("falls back to main.tsp when no versions in file paths", async () => {
    vi.mocked(readFile).mockResolvedValue(`enum Versions {\n  v2025_01_01: "2025-01-01",\n}`);

    const files = ["specification/foo/main.tsp"];

    const result = await detectApiVersions(files, "specification/foo", "/workspace", core);

    expect(result.apiVersions).toEqual(["2025-01-01"]);
    expect(result.isPreview).toBe(false);
  });

  it("skips main.tsp fallback when tspProjectPath is null", async () => {
    vi.mocked(readFile).mockResolvedValue(`"2025-01-01"`);

    const files = ["specification/foo/main.tsp"];

    const result = await detectApiVersions(files, null, "/workspace", core);

    expect(result.apiVersions).toEqual([]);
    expect(result.isPreview).toBe(false);
  });

  it("returns empty when no versions detected anywhere", async () => {
    const files = ["specification/foo/models.tsp"];

    const result = await detectApiVersions(files, "specification/foo", "/workspace", core);

    expect(result.apiVersions).toEqual([]);
    expect(result.isPreview).toBe(false);
  });
});
