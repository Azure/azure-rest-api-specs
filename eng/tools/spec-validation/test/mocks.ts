import { vi } from "vitest";

export const mockFolder = "specification/foo/Foo";

export function mockFsPromises() {
  vi.mock("fs/promises", () => ({
    readFile: vi.fn().mockResolvedValue('{"info": {"x-typespec-generated": true}}'),
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
      revparse: vi.fn().mockResolvedValue("/gitroot"),
      status: vi.fn().mockResolvedValue({
        modified: [],
        not_added: [],
        isClean: () => true,
      }),
      branch: vi.fn().mockImplementation((args) => {
        if (args && args[0] === "-vv") {
          return Promise.resolve({
            current: "main",
            all: ["main", "feature-branch"],
            branches: {
              main: { current: true, name: "main", commit: "abcd1234", label: "main" },
            },
          });
        }
        return Promise.resolve({
          current: "main",
          all: ["main", "feature-branch"],
          branches: {
            main: { current: true, name: "main" },
          },
        });
      }),
      raw: vi.fn().mockImplementation((args) => {
        if (args.includes("config") && args.includes("remote.origin.url")) {
          return Promise.resolve("https://github.com/Azure/azure-rest-api-specs.git");
        }
        if (args.includes("merge-base")) {
          return Promise.resolve("abcd1234");
        }
        if (args.includes("ls-tree")) {
          return Promise.resolve("");
        }
        return Promise.resolve("");
      }),
    }),
  }));

  // Mock the GitHub CLI commands to avoid actual API calls
  vi.mock("child_process", async (importOriginal) => {
    const actual = await importOriginal() as any;
    return {
      ...actual,
      spawn: vi.fn().mockImplementation(() => ({
        stdout: {
          on: vi.fn((event, callback) => {
            if (event === "data") {
              callback("main");
            }
          }),
        },
        stderr: {
          on: vi.fn(),
        },
        on: vi.fn((event, callback) => {
          if (event === "close") {
            callback(0);
          }
        }),
      })),
    };
  });
}

export function mockAll() {
  mockFsPromises();
  mockGlobby();
  mockSimpleGit();
}
