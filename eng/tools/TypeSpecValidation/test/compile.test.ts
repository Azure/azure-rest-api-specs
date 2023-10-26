import { CompileRule } from "../src/rules/compile.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";
describe("compile", function () {
  it("should succeed if project can compile", async function () {
    const result = await new CompileRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(result.success);
  });
});
