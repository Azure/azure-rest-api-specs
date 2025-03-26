import { describe, it } from "vitest";
import { CompileRule } from "../src/rules/compile.js";
import { TsvTestHost } from "./tsv-test-host.js";
import { TsvHost } from "../src/tsv-host.js";
import { RuleResult } from "../src/rule-result.js";
import { strict as assert } from "node:assert";
describe("compile", function () {
  it("should succeed if project can compile", async function () {
    const result = await new CompileRule().execute(new TsvTestHost(), TsvTestHost.folder);

    assert(result.success);
  });

  it("should fail if no emitter was configured", async function () {
    let host = new TsvTestHost();
    host.runCmd = async (cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      if (cmd.includes("tsp compile")) {
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
      if (cmd.includes("tsp compile")) {
        return [null, "no output was generated", ""];
      } else {
        return [null, "", ""];
      }
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);

    assert(!result.success);
  });

  it("should skip git diff check if compile fails", async function () {
    let host = new TsvTestHost();
    host.runCmd = async (cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      if (cmd.includes("tsp compile")) {
        return [
          { name: "compilation_error", message: "compilation error" },
          "running tsp compile",
          "compilation failure",
        ];
      }
      return [null, "", ""];
    };
    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runCmd(
        "",
        "",
      )}`;
      return {
        success: true,
        stdOutput: stdOut,
      };
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);
    assert(result.stdOutput);
    assert(!result.stdOutput.includes("Running git diff"));
  });

  it("should fail if git diff fails", async function () {
    let host = new TsvTestHost();
    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runCmd(
        "",
        "",
      )}`;
      return {
        success: false,
        stdOutput: stdOut,
        errorOutput: `Files generated: ${folder}/bar`,
      };
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);
    assert(result.stdOutput);
    assert(result.stdOutput.includes("Running git diff"));
    assert(!result.success);
  });

  it("should succeed if git diff succeeds", async function () {
    let host = new TsvTestHost();
    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runCmd(
        "",
        "",
      )}`;
      return {
        success: true,
        stdOutput: stdOut,
      };
    };

    const result = await new CompileRule().execute(host, TsvTestHost.folder);
    assert(result.stdOutput);
    assert(result.stdOutput.includes("Running git diff"));
    assert(result.success);
  });
});
