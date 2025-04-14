import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";

vi.mock("fs/promises", () => ({
  readFile: vi.fn().mockResolvedValue('{"info": {"x-typespec-generated": true}}'),
}));

import * as fsPromises from "fs/promises";
import path from "path";
import { RuleResult } from "../src/rule-result.js";
import { CompileRule } from "../src/rules/compile.js";
import { TsvHost } from "../src/tsv-host.js";
import { TsvTestHost } from "./tsv-test-host.js";

import * as utils from "../src/utils.js";

const swaggerPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";
const handwrittenSwaggerPath = "data-plane/Azure.Foo/preview/2021-11-01-preview/foo.json";

describe("compile", function () {
  beforeEach(() => {
    vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should succeed if project can compile", async function () {
    const host = new TsvTestHost();

    const compileOutput =
      // header, not a filename
      "header\n" +
      // windows line endings
      "\r\n" +
      // ensure paths are trimmed
      `\t${swaggerPath} \n` +
      // ensure paths are normalized
      `${path.win32.normalize(swaggerPath)}\n` +
      // ensure filtered to JSON files
      "data-plane/readme.md\n" +
      // ensure examples are skipped
      `${swaggerPath.replace("foo.json", "examples/example.json")}\n`;

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, compileOutput, ""];
    };

    // ensure handwritten swaggers are ignored
    host.globby = async () => [swaggerPath, handwrittenSwaggerPath];
    vi.mocked(fsPromises.readFile).mockImplementation(async (path) =>
      path === swaggerPath ? '{"info": {"x-typespec-generated": true}}' : "{}",
    );

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: true,
    });
  });

  it("should fail if no emitter was configured", async function () {
    let host = new TsvTestHost();
    host.runFile = async (file: string, args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      if ([file, ...args].join(' ').includes("tsp compile")) {
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
    host.runFile = async (file: string, args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      if ([file, ...args].join(' ').includes("tsp compile")) {
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
    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => [
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

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, swaggerPath, ""];
    };

    // Simulate extra swagger
    host.globby = async () => [
      swaggerPath,
      swaggerPath.replace("2022", "2023"),
      swaggerPath.replace("2023", "2024"),
    ];

    vi.mocked(fsPromises.readFile).mockImplementation(async (path) => {
      return path.toString().includes("2024")
        ? '{"info": {"x-typespec-generated": true}}'
        : '{"info": {"x-cadl-generated": true}}';
    });

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current"),
    });
  });

  it("supports suppressions", async function () {
    const host = new TsvTestHost();

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, swaggerPath, ""];
    };

    // Simulate extra swagger
    host.globby = async () => [
      swaggerPath,
      swaggerPath.replace("2022", "2023"),
      swaggerPath.replace("2023", "2024"),
    ];

    vi.mocked(fsPromises.readFile).mockImplementation(async (path) => {
      return path.toString().includes("2024")
        ? '{"info": {"x-typespec-generated": true}}'
        : '{"info": {"x-cadl-generated": true}}';
    });

    vi.spyOn(utils, "getSuppressions").mockImplementation(async (path) => {
      return path.includes("2023") || path.includes("2024")
        ? [
            {
              tool: "TypeSpecValidation",
              rules: ["Compile"],
              subRules: ["ExtraSwagger"],
              paths: [swaggerPath.replace("2022", "2023"), swaggerPath.replace("2023", "2024")],
              reason: "test reason",
            },
          ]
        : [];
    });

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).resolves.toMatchObject({
      success: true,
    });
  });

  it("throws on invalid suppressions", async function () {
    const host = new TsvTestHost();

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, swaggerPath, ""];
    };

    vi.spyOn(utils, "getSuppressions").mockImplementation(async () => [
      {
        tool: "TypeSpecValidation",
        rules: ["Compile"],
        subRules: ["ExtraSwagger"],
        paths: ["**/*"],
        reason: "test reason",
      },
    ]);

    await expect(new CompileRule().execute(host, TsvTestHost.folder)).rejects.toThrow(
      "Invalid path",
    );
  });

  it("should skip git diff check if compile fails", async function () {
    let host = new TsvTestHost();
    host.runFile = async (file: string, args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      if ([file, ...args].join(' ').includes("tsp compile")) {
        return [
          { name: "compilation_error", message: "compilation error" },
          "running tsp compile",
          "compilation failure",
        ];
      }
      return [null, "", ""];
    };
    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runFile(
        "",
        [],
        ""
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

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, swaggerPath, ""];
    };

    host.globby = async () => [swaggerPath];

    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runFile(
        "",
        [],
        ""
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

    host.runFile = async (_file: string, _args: string[], _cwd: string): Promise<[Error | null, string, string]> => {
      return [null, swaggerPath, ""];
    };

    host.globby = async () => [swaggerPath];

    host.gitDiffTopSpecFolder = async (host: TsvHost, folder: string): Promise<RuleResult> => {
      let stdOut = `Running git diff on folder ${folder}, running default cmd ${host.runFile(
        "",
        [],
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
