import { vi } from "vitest";

export const mockFolder = "specification/foo/Foo";

vi.mock("fs/promises", () => ({
  readFile: vi.fn().mockResolvedValue('{"info": {"x-typespec-generated": true}}'),
}));

vi.mock("../src/glob.ts", () => ({
  globFiles: vi.fn().mockResolvedValue([]),
}));

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
