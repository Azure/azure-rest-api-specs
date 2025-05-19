import { mockFolder, mockSimpleGit } from "./mocks.js";
mockSimpleGit();

import * as simpleGit from "simple-git";

import { strict as assert } from "node:assert";
import path from "path";
import { afterEach, beforeEach, describe, it, MockInstance, vi } from "vitest";
import { NpmPrefixRule } from "../src/rules/npm-prefix.js";

import * as utils from "../src/utils.js";

describe("npm-prefix", function () {
  let runNpmSpy: MockInstance;

  beforeEach(() => {
    runNpmSpy = vi
      .spyOn(utils, "runNpm")
      .mockImplementation(async (args, cwd) => [null, `runNpm ${args.join(" ")} at ${cwd}`, ""]);
  });

  afterEach(() => {
    runNpmSpy.mockReset();
  });

  it("should succeed if node returns inconsistent drive letter capitalization", async function () {
    runNpmSpy.mockImplementation(
      async (args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
        if (args.includes("prefix")) {
          return [null, `C:${path.sep}Git${path.sep}azure-rest-api-specs`, ""];
        } else {
          return [null, "", ""];
        }
      },
    );

    vi.mocked(simpleGit.simpleGit().revparse).mockResolvedValue("c:/Git/azure-rest-api-specs");

    vi.spyOn(utils, "normalizePath").mockImplementation((folder) =>
      utils.normalizePathImpl(folder, path.win32),
    );

    const result = await new NpmPrefixRule().execute(mockFolder);

    assert(result.success);
  });

  it("should fail if npm prefix mismatch", async function () {
    runNpmSpy.mockImplementation(
      async (args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
        if (args.includes("prefix")) {
          return [null, "/Git/azure-rest-api-specs/specification/foo", ""];
        } else {
          return [null, "", ""];
        }
      },
    );
    vi.mocked(simpleGit.simpleGit().revparse).mockResolvedValue("/Git/azure-rest-api-specs");

    const result = await new NpmPrefixRule().execute(mockFolder);

    assert(!result.success);
  });
});
