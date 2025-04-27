import { vi } from "vitest";

export const mockFolder = "specification/foo/Foo";

export function mockFsPromises() {
  vi.mock("fs/promises", () => ({
    readFile: vi.fn().mockImplementation((filePath) => {
      if (filePath.includes("tspconfig.yaml")) {
        return Promise.resolve('{"info": {"x-typespec-generated": true}}');
      }
      // Mock as if file doesn't exist for files we don't explicitly handle
      return Promise.reject(new Error(`ENOENT: no such file or directory, open '${filePath}'`));
    }),
    access: vi.fn().mockResolvedValue(undefined),
  }));
}

export function mockGlobby() {
  vi.mock("globby", () => ({
    globby: vi.fn().mockResolvedValue([]),
  }));
}

export function mockSimpleGit() {
  vi.mock("simple-git", () => ({
    simpleGit: vi.fn().mockReturnValue({
      revparse: vi.fn().mockResolvedValue(""),
      status: vi.fn().mockResolvedValue({
        modified: [],
        not_added: [],
        isClean: () => true,
      }),
    }),
  }));
}

export function mockUtils() {
  vi.mock("../src/utils.js", async () => {
    const actual = await vi.importActual("../src/utils.js");
    return {
      ...actual,
      fileExists: vi.fn().mockResolvedValue(true),
      normalizePath: vi.fn().mockReturnValue("/gitroot"),
      readTspConfig: vi.fn().mockResolvedValue(`
options:
  "@azure-tools/typespec-autorest":
    azure-resource-provider-folder: "resource-manager"
`),
    };
  });
}

export function mockPath() {
  vi.mock("path", async () => {
    const actual = await vi.importActual("path");
    interface MockPath {
      sep: string;
      join: (...parts: string[]) => string;
      [key: string]: unknown;
    }
    return {
      ...actual,
      sep: "/" as MockPath["sep"],
      join: (...parts: string[]): string => parts.join("/"),
    } as MockPath;
  });
}

export function mockAll() {
  mockFsPromises();
  mockGlobby();
  mockSimpleGit();
  mockUtils();
  mockPath();
}
