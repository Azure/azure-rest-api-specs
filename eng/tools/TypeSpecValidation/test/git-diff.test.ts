import { GitDiffRule } from "../src/rules/git-diff.js";
import { DefaultTsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("#GitDiff", function () {
  it("Should fail if git diff produces output.", async function () {
    let gitDiffRule = new GitDiffRule();
    const result = await gitDiffRule.execute(DefaultTsvTestHost, "mockFolder");
    assert(result.errorOutput);
    assert(result.errorOutput.length !== 0);
  });
});
