import { describe, it } from "vitest";
import { LinterRulesetRule } from "../src/rules/linter-ruleset.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";

describe("linter-ruleset", function () {
  it("succeeds with default config", async function () {
    let host = new TsvTestHost();

    const result = await new LinterRulesetRule().execute(host, TsvTestHost.folder);

    assert(result.success);
  });
});
