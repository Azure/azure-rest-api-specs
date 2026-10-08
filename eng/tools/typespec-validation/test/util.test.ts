import { mockFolder } from "./mocks.ts";
import { defaultLogger } from "@azure-tools/specs-shared/logger";

import { strict as assert } from "node:assert";
import { simpleGit } from "simple-git";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { gitDiffTopSpecFolder } from "../src/utils.ts";

describe("util", function () {
  let revparseMock = vi.fn();
  let showMock = vi.fn();
  let statusMock = vi.fn();

  beforeEach(() => {
    revparseMock = vi.fn().mockResolvedValueOnce("abc123").mockResolvedValueOnce("C:/repo\n");
    showMock = vi.fn().mockResolvedValue("versions: []\n");
    statusMock = vi.fn().mockResolvedValue({
      files: [],
      modified: [],
      not_added: [],
      isClean: () => true,
    });
    vi.mocked(simpleGit).mockReturnValue({
      revparse: revparseMock,
      show: showMock,
      status: statusMock,
    } as never);
  });

  describe("gitDiff", function () {
    it("should succeed if git diff produces no output", async function () {
      const result = await gitDiffTopSpecFolder(mockFolder, defaultLogger);
      assert(result.success);
    });

    it("uses normalized drive paths when selecting the service folder", async () => {
      const result = await gitDiffTopSpecFolder(
        "c:\\repo\\specification\\foo\\Project",
        defaultLogger,
      );
      expect(result.success).toBe(true);
      expect(statusMock).toHaveBeenCalledExactlyOnceWith([
        "--porcelain",
        "--untracked-files=all",
        "--",
        "C:/repo/specification/foo",
      ]);
    });
  });
});
