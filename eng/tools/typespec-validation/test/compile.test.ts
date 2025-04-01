import { describe, expect, it } from "vitest";
import { RuleResult } from "../src/rule-result.js";
import { CompileRule } from "../src/rules/compile.js";
import { TsvHost } from "../src/tsv-host.js";
import { TsvTestHost } from "./tsv-test-host.js";

const swaggerPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

describe("compile", function () {
  it("should succeed if project can compile", async function () {
    const host = new TsvTestHost();

    host.runCmd = async (_cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, "version\n" + swaggerPath + "\nsuccess", ""];
    };

    host.globby = async () => [swaggerPath];

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: true,
    });
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

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
    });
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

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
    });
  });

  it("should throw if output has no generated swaggers", async function () {
    let host = new TsvTestHost();
    host.runCmd = async (_cmd: string, _cwd: string): Promise<[Error | null, string, string]> => [
      null,
      "not-swagger",
      "",
    ];

    await expect(
      new CompileRule().execute(host, TsvTestHost.folder),
    ).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: No generated swaggers found in output of 'tsp compile']`,
    );
  });

  it("should fail if extra swaggers", async function () {
    const host = new TsvTestHost();

    const tspCompileOutput = swaggerPath;

    host.runCmd = async (_cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, tspCompileOutput, ""];
    };

    // Simulate extra swagger
    host.globby = async () => [swaggerPath, swaggerPath.replace("2022", "2023")];

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current"),
    });
  });

  // TODO: Add tests for all other branches of extra swaggers

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

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
      stdOutput: expect.not.stringContaining("Running git diff"),
    });
  });

  it("should fail if git diff fails", async function () {
    let host = new TsvTestHost();

    host.runCmd = async (_cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, "version\n" + swaggerPath + "\nsuccess", ""];
    };

    host.globby = async () => [swaggerPath];

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

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
      stdOutput: expect.stringContaining("Running git diff"),
    });
  });

  it("should succeed if git diff succeeds", async function () {
    let host = new TsvTestHost();

    host.runCmd = async (_cmd: string, _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, "version\n" + swaggerPath + "\nsuccess", ""];
    };

    host.globby = async () => [swaggerPath];

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

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: true,
      stdOutput: expect.stringContaining("Running git diff"),
    });
  });
});
