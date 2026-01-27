import { mockAll, mockFolder } from "./mocks.js";
mockAll();

import { afterEach, beforeEach, describe, expect, it, MockInstance, vi } from "vitest";

import * as fsPromises from "fs/promises";
import * as globby from "globby";
import path from "path";
import { RuleResult } from "../src/rule-result.js";
import { CompileRule } from "../src/rules/compile.js";

import * as utils from "../src/utils.js";

const swaggerPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";
const handwrittenSwaggerPath = "data-plane/Azure.Foo/preview/2021-11-01-preview/foo.json";

describe("compile", function () {
  let gitDiffTopSpecFolderSpy: MockInstance;
  let runNpmSpy: MockInstance;

  beforeEach(() => {
    vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);
    gitDiffTopSpecFolderSpy = vi.spyOn(utils, "gitDiffTopSpecFolder").mockImplementation((folder) =>
      Promise.resolve({
        success: true,
        stdOutput: `Running git diff on folder ${folder}}`,
        errorOutput: "",
      }),
    );
    runNpmSpy = vi
      .spyOn(utils, "runNpm")
      .mockImplementation((args, cwd) =>
        Promise.resolve([null, `runNpm ${args.join(" ")} at ${cwd}`, ""]),
      );
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it("should succeed if project can compile", async function () {
    const compileOutput =
      // header, not a filename
      "header\n" +
      // windows line endings
      "\r\n" +
      // ensure paths are trimmed
      `\t${swaggerPath} \n` +
      // ensure paths are normalized
      `${path.normalize(swaggerPath)}\n` +
      // ensure filtered to JSON files
      "data-plane/readme.md\n" +
      // ensure examples are skipped
      `${swaggerPath.replace("foo.json", "examples/example.json")}\n`;

    runNpmSpy.mockImplementation(
      (): Promise<[Error | null, string, string]> => Promise.resolve([null, compileOutput, ""]),
    );

    // ensure handwritten swaggers are ignored
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([swaggerPath, handwrittenSwaggerPath]),
    );
    vi.mocked(fsPromises.readFile).mockImplementation((path) =>
      Promise.resolve(path === swaggerPath ? '{"info": {"x-typespec-generated": true}}' : "{}"),
    );

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: true,
    });
  });

  it("should fail if no emitter was configured", async function () {
    runNpmSpy.mockImplementation((args: string[]): Promise<[Error | null, string, string]> => {
      if (args.join(" ").includes("tsp compile")) {
        return Promise.resolve([null, "no emitter was configured", ""]);
      } else {
        return Promise.resolve([null, "", ""]);
      }
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
    });
  });

  it("should fail if no output was generated", async function () {
    runNpmSpy.mockImplementation((args: string[]): Promise<[Error | null, string, string]> => {
      if (args.join(" ").includes("tsp compile")) {
        return Promise.resolve([null, "no output was generated", ""]);
      } else {
        return Promise.resolve([null, "", ""]);
      }
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
    });
  });

  it("should throw if output has no generated swaggers", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> =>
        Promise.resolve([null, "not-swagger", ""]),
    );

    await expect(new CompileRule().execute(mockFolder)).rejects.toThrowErrorMatchingInlineSnapshot(
      `[Error: No generated swaggers found in output of 'tsp compile']`,
    );
  });

  it("should fail if extra swaggers", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, swaggerPath, ""]),
    );

    // Simulate extra swagger
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([
        swaggerPath,
        swaggerPath.replace("2022", "2023"),
        swaggerPath.replace("2023", "2024"),
      ]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation((path) => {
      return (path as string).includes("2024")
        ? Promise.resolve('{"info": {"x-typespec-generated": true}}')
        : Promise.resolve('{"info": {"x-cadl-generated": true}}');
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current") as unknown,
    });
  });

  it("should succeed if extra swaggers are only older preview versions", async function () {
    // Latest preview is 2024-03-01-preview, extra swagger is from 2022-11-01-preview
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreviewPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> =>
        Promise.resolve([null, latestPreviewPath, ""]),
    );

    // Simulate extra older preview swagger (globby always returns posix paths)
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, olderPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    const result = await new CompileRule().execute(mockFolder);
    expect(result).toMatchObject({
      success: true,
      stdOutput: expect.stringContaining("older versions") as unknown,
    });
  });

  it("should fail if extra swaggers include latest preview version", async function () {
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const anotherLatestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/bar.json";

    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> =>
        Promise.resolve([null, latestPreviewPath, ""]),
    );

    // Simulate extra swagger from the latest preview (globby always returns posix paths)
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, anotherLatestPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current") as unknown,
    });
  });

  it("should fail if extra swaggers include stable versions", async function () {
    const previewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const stablePath = "data-plane/Azure.Foo/stable/2023-01-01/foo.json";

    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, previewPath, ""]),
    );

    // Simulate extra stable swagger (globby always returns posix paths)
    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([previewPath, stablePath]));

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current") as unknown,
    });
  });

  it("should succeed with multiple older preview versions", async function () {
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreview1Path = "data-plane/Azure.Foo/preview/2023-01-01-preview/foo.json";
    const olderPreview2Path = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> =>
        Promise.resolve([null, latestPreviewPath, ""]),
    );

    // Simulate multiple extra older preview swaggers (globby always returns posix paths)
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, olderPreview1Path, olderPreview2Path]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    const result = await new CompileRule().execute(mockFolder);
    expect(result).toMatchObject({
      success: true,
      stdOutput: expect.stringContaining("older versions") as unknown,
    });
  });

  it("should fail if extra swaggers mix preview and stable versions", async function () {
    const previewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreviewPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";
    const stablePath = "data-plane/Azure.Foo/stable/2023-01-01/foo.json";

    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, previewPath, ""]),
    );

    // Simulate extra swaggers with mix of preview and stable (globby always returns posix paths)
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([previewPath, olderPreviewPath, stablePath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      errorOutput: expect.stringContaining("not generated from the current") as unknown,
    });
  });

  it("supports suppressions", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, swaggerPath, ""]),
    );

    // Simulate extra swagger
    vi.mocked(globby.globby).mockImplementation(() =>
      Promise.resolve([
        swaggerPath,
        swaggerPath.replace("2022", "2023"),
        swaggerPath.replace("2023", "2024"),
      ]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation((path) => {
      return (path as string).includes("2024")
        ? Promise.resolve('{"info": {"x-typespec-generated": true}}')
        : Promise.resolve('{"info": {"x-cadl-generated": true}}');
    });

    vi.spyOn(utils, "getSuppressions").mockImplementation((path) => {
      return path.includes("2023") || path.includes("2024")
        ? Promise.resolve([
            {
              tool: "TypeSpecValidation",
              rules: ["Compile"],
              subRules: ["ExtraSwagger"],
              paths: [swaggerPath.replace("2022", "2023"), swaggerPath.replace("2023", "2024")],
              reason: "test reason",
            },
          ])
        : Promise.resolve([]);
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: true,
    });
  });

  it("throws on invalid suppressions", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, swaggerPath, ""]),
    );

    vi.spyOn(utils, "getSuppressions").mockImplementation(() =>
      Promise.resolve([
        {
          tool: "TypeSpecValidation",
          rules: ["Compile"],
          subRules: ["ExtraSwagger"],
          paths: ["**/*"],
          reason: "test reason",
        },
      ]),
    );

    await expect(new CompileRule().execute(mockFolder)).rejects.toThrow("Invalid path");
  });

  it("should skip git diff check if compile fails", async function () {
    runNpmSpy.mockImplementation(
      async (args: string[]): Promise<[Error | null, string, string]> => {
        if (args.join(" ").includes("tsp compile")) {
          return Promise.resolve([
            { name: "compilation_error", message: "compilation error" },
            "running tsp compile",
            "compilation failure",
          ]);
        }
        return Promise.resolve([null, "", ""]);
      },
    );

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      stdOutput: expect.not.stringContaining("Running git diff") as unknown,
    });
  });

  it("should fail if git diff fails", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, swaggerPath, ""]),
    );

    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([swaggerPath]));

    gitDiffTopSpecFolderSpy.mockImplementation((folder: string): Promise<RuleResult> => {
      const stdOut = `Running git diff on folder ${folder}`;

      return Promise.resolve({
        success: false,
        stdOutput: stdOut,
        errorOutput: `Files generated: ${folder}/bar`,
      });
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: false,
      stdOutput: expect.stringContaining("Running git diff") as unknown,
    });
  });

  it("should succeed if git diff succeeds", async function () {
    runNpmSpy.mockImplementation(
      async (): Promise<[Error | null, string, string]> => Promise.resolve([null, swaggerPath, ""]),
    );

    vi.mocked(globby.globby).mockImplementation(() => Promise.resolve([swaggerPath]));

    gitDiffTopSpecFolderSpy.mockImplementation((folder: string): Promise<RuleResult> => {
      const stdOut = `Running git diff on folder ${folder}`;
      return Promise.resolve({
        success: true,
        stdOutput: stdOut,
      });
    });

    await expect(new CompileRule().execute(mockFolder)).resolves.toMatchObject({
      success: true,
      stdOutput: expect.stringContaining("Running git diff") as unknown,
    });
  });
});
