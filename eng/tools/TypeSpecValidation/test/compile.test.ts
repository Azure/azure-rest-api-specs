// import { error } from "node:console";
import { CompileRule } from "../src/rules/compile.js";
import { TsvTestHostGenerator } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";
describe("#Compile", function () {
  it("Should fail if project cannot compile.", async function () {
    let compileRule = new CompileRule();
    let TsvTestHost = TsvTestHostGenerator({
      runCmd: Promise.resolve([null, "success", "success"]),
    });
    const result = await compileRule.execute(TsvTestHost, "mockFolder");
    assert(result.success);
    assert(result.stdOutput === "successsuccess");
  });
});
