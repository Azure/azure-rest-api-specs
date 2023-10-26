import { GitDiffRule } from "../src/rules/git-diff.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("git-diff", function () {
  it("should fail if git diff produces output", async function () {
    const result = await new GitDiffRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(!result.success);
  });
});
