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
      revparse: vi.fn().mockResolvedValue(""),
      status: vi.fn().mockResolvedValue({
        modified: [],
        not_added: [],
        isClean: () => true,
      }),
    }),
  }));
}

export function mockAll() {
  mockFsPromises();
  mockGlobby();
  mockSimpleGit();
}
