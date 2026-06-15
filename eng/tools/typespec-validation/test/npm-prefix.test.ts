import { mockFolder, mockSimpleGit } from "./mocks.ts";
mockSimpleGit();

import * as simpleGit from "simple-git";

import { strict as assert } from "node:assert";
import path from "path";
import { afterEach, describe, it, vi } from "vitest";
import { NpmPrefixRule } from "../src/rules/npm-prefix.ts";

import * as utils from "../src/utils.ts";

vi.mock("package-directory", () => ({
  packageDirectory: vi.fn(),
}));

import { packageDirectory } from "package-directory";

describe("npm-prefix", function () {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it("should succeed if node returns inconsistent drive letter capitalization", async function () {
    vi.mocked(packageDirectory).mockResolvedValue(
      `C:${path.sep}Git${path.sep}azure-rest-api-specs`,
    );

    // eslint-disable-next-line @typescript-eslint/unbound-method
    vi.mocked(simpleGit.simpleGit().revparse).mockResolvedValue("c:/Git/azure-rest-api-specs");

    vi.spyOn(utils, "normalizePath").mockImplementation((folder) =>
      utils.normalizePathImpl(folder, path.win32),
    );

    const result = await new NpmPrefixRule().execute(mockFolder);

    assert(result.success);
  });

  it("should fail if npm prefix mismatch", async function () {
    vi.mocked(packageDirectory).mockResolvedValue("/Git/azure-rest-api-specs/specification/foo");
    // eslint-disable-next-line @typescript-eslint/unbound-method
    vi.mocked(simpleGit.simpleGit().revparse).mockResolvedValue("/Git/azure-rest-api-specs");

    const result = await new NpmPrefixRule().execute(mockFolder);

    assert(!result.success);
  });
});
