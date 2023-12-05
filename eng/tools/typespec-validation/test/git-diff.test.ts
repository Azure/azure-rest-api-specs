import { GitDiffRule } from "../src/rules/git-diff.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("git-diff", function () {
  it("should succeed if git diff produces no output", async function () {
    const result = await new GitDiffRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(result.success);
  });
});
