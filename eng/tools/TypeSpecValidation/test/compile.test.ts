import { CompileRule } from "../src/rules/compile.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";
describe("#Compile", function () {
  it("Should succeed if project can compile.", async function () {
    class Host extends TsvTestHost {}

    let host = new TsvTestHost();
    host.runCmd = async (_cmd: string, _cwd: string) => [null, "success", "success"];

    const result = await new CompileRule().execute(new Host(), TsvTestHost.folder);

    assert(result.success);
    assert(result.stdOutput === "successsuccess");
  });
});
