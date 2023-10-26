import { GitDiffRule } from "../src/rules/git-diff.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("#GitDiff", function () {
  it("Should fail if git diff produces output.", async function () {
    const result = await new GitDiffRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(result.errorOutput);
    assert(result.errorOutput.length !== 0);
  });
});
