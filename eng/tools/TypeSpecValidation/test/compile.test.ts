import { CompileRule } from "../src/rules/compile.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { strict as assert } from "node:assert";
describe("compile", function () {
  it("should succeed if project can compile", async function () {
    const result = await new CompileRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(result.success);
  });

  it("should fail if no emitter was configured", async function () {
    let host = new TsvTestHost();
    host.runCmd = async (cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      if (cmd.includes("tsp compile .")) {
        return [null, "no emitter was configured", ""];
      } else {
        return [null, "", ""];
      }
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });

  it("should fail if no output was generated", async function () {
    let host = new TsvTestHost();
    host.runCmd = async (cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      if (cmd.includes("tsp compile .")) {
        return [null, "no output was generated", ""];
      } else {
        return [null, "", ""];
      }
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });
});
