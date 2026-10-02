import { mockFolder } from "./mocks.ts";
import { ConsoleLogger, defaultLogger } from "@azure-tools/specs-shared/logger";

import { afterEach, beforeEach, describe, expect, it, type MockInstance, vi } from "vitest";

import * as fsPromises from "node:fs/promises";
import path from "node:path";
import * as nativeGlob from "../src/glob.ts";
import { CompileRule } from "../src/rules/compile.ts";
import * as compiler from "../src/typespec-compiler.ts";
import type { CompileResult } from "../src/typespec-compiler.ts";
import { diagnosticDetails } from "./diagnostics.ts";

import * as utils from "../src/utils.ts";

vi.mock("../src/typespec-compiler.ts", () => ({
  compileTypeSpec: vi.fn(),
}));

const swaggerPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";
const handwrittenSwaggerPath = "data-plane/Azure.Foo/preview/2021-11-01-preview/foo.json";

const compileResult = (
  output: CompileResult["output"] = [null, "", ""],
  emittedFiles: string[] = [],
): CompileResult => ({ output, emittedFiles });

describe("compile", function () {
  let gitDiffTopSpecFolderSpy: MockInstance;
  let compileTypeSpecSpy: MockInstance;

  beforeEach(() => {
    vi.spyOn(utils, "fileExists").mockResolvedValue(true);
    vi.spyOn(utils, "getSuppressions").mockResolvedValue([]);
    gitDiffTopSpecFolderSpy = vi
      .spyOn(utils, "gitDiffTopSpecFolder")
      .mockResolvedValue({ success: true, files: [] });
    compileTypeSpecSpy = vi.mocked(compiler.compileTypeSpec).mockResolvedValue(compileResult());
  });

  afterEach(() => {
    vi.clearAllMocks();
  });

  it.each([false, true])(
    "hides routine output but retains stale-file validation with verbose=%s",
    async (verbose) => {
      const logger = new ConsoleLogger(verbose);
      const debug = vi.spyOn(console, "debug").mockImplementation(() => {});
      try {
        // Only main.tsp exists so the fixture compiles once.
        vi.mocked(utils.fileExists).mockImplementation((file) =>
          Promise.resolve(file.endsWith("main.tsp")),
        );
        compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));
        vi.mocked(nativeGlob.globFiles).mockResolvedValue([swaggerPath, handwrittenSwaggerPath]);
        vi.mocked(fsPromises.readFile).mockResolvedValue('{"info":{"x-typespec-generated":true}}');
        const result = await new CompileRule().execute(mockFolder, logger);
        expect(result.success).toBe(true); // Older preview is allowed.
        expect(result.diagnostics).toEqual([]);
        expect(compiler.compileTypeSpec).toHaveBeenCalledExactlyOnceWith(
          path.join(mockFolder, "main.tsp"),
        );
        expect(nativeGlob.globFiles).toHaveBeenCalled();
        if (verbose)
          expect(debug).toHaveBeenCalledWith(expect.stringContaining("Generated Swaggers:"));
        else expect(debug).not.toHaveBeenCalled();
      } finally {
        debug.mockRestore();
      }
    },
  );

  it("retains main and imported client failures without compiling client again", async () => {
    compileTypeSpecSpy.mockResolvedValueOnce(
      compileResult([
        new Error("main failed"),
        "main.tsp:1:1 - error first: message",
        "client.tsp:1:1 - error second: message",
      ]),
    );
    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(result.diagnostics?.map(diagnosticDetails)).toEqual([
      "main.tsp:1:1 - error first: message\nclient.tsp:1:1 - error second: message",
    ]);
    expect(gitDiffTopSpecFolderSpy).not.toHaveBeenCalled();
    expect(compiler.compileTypeSpec).toHaveBeenCalledExactlyOnceWith(
      path.join(mockFolder, "main.tsp"),
    );
  });

  it("compiles only main when both main and client exist", async function () {
    compileTypeSpecSpy.mockResolvedValue(
      compileResult(
        [null, "", ""],
        [
          swaggerPath,
          path.normalize(swaggerPath),
          "data-plane/readme.md",
          swaggerPath.replace("foo.json", "examples/example.json"),
        ],
      ),
    );

    // ensure handwritten swaggers are ignored
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([swaggerPath, handwrittenSwaggerPath]),
    );
    vi.mocked(fsPromises.readFile).mockImplementation((path) =>
      Promise.resolve(path === swaggerPath ? '{"info": {"x-typespec-generated": true}}' : "{}"),
    );

    const logger = new ConsoleLogger(true);
    await expect(new CompileRule().execute(mockFolder, logger)).resolves.toMatchObject({
      success: true,
    });
    expect(compiler.compileTypeSpec).toHaveBeenCalledExactlyOnceWith(
      path.join(mockFolder, "main.tsp"),
    );
    expect(gitDiffTopSpecFolderSpy).toHaveBeenCalledExactlyOnceWith(mockFolder, logger);
  });

  it.each([false, true])(
    "compiles client-only projects without emitting (failure=%s)",
    async (failure) => {
      const clientTsp = path.join(mockFolder, "client.tsp");
      vi.mocked(utils.fileExists).mockImplementation((file) => Promise.resolve(file === clientTsp));
      const nativeDiagnostic = "client.tsp:1:1 - error test-code: client failure";
      if (failure) {
        compileTypeSpecSpy.mockResolvedValueOnce(
          compileResult([new Error("client failed"), "", nativeDiagnostic]),
        );
      }

      const result = await new CompileRule().execute(mockFolder, defaultLogger);

      expect(result.success).toBe(!failure);
      expect(compiler.compileTypeSpec).toHaveBeenCalledExactlyOnceWith(clientTsp, { noEmit: true });
      expect(nativeGlob.globFiles).not.toHaveBeenCalled();
      if (failure) {
        expect(result.diagnostics?.map(diagnosticDetails)).toEqual([nativeDiagnostic]);
        expect(gitDiffTopSpecFolderSpy).not.toHaveBeenCalled();
      } else {
        expect(result.diagnostics).toEqual([]);
        expect(gitDiffTopSpecFolderSpy).toHaveBeenCalledExactlyOnceWith(mockFolder, defaultLogger);
      }
    },
  );

  it("should succeed if output has no generated swaggers", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], ["data-plane/readme.md"]));

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: true,
    });
  });

  it("should fail if extra swaggers", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));

    // Simulate extra swagger
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
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

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(
      diagnosticDetails(
        result.diagnostics?.find((diagnostic) => diagnostic.code === "extra-swagger"),
      ),
    ).toBe(`  ${swaggerPath.replace("2022", "2023")}`);
  });

  it("should succeed if extra swaggers are only older preview versions", async function () {
    // Latest preview is 2024-03-01-preview, extra swagger is from 2022-11-01-preview
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreviewPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [latestPreviewPath]));

    // Simulate extra older preview swagger (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, olderPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result).toMatchObject({
      success: true,
    });
  });

  it("should fail if extra swaggers include latest preview version", async function () {
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const anotherLatestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/bar.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [latestPreviewPath]));

    // Simulate extra swagger from the latest preview (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, anotherLatestPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: false,
      diagnostics: expect.arrayContaining([
        expect.objectContaining({ code: "extra-swagger" }),
      ]) as unknown,
    });
  });

  it("should fail if extra swaggers include stable versions", async function () {
    const previewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const stablePath = "data-plane/Azure.Foo/stable/2023-01-01/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [previewPath]));

    // Simulate extra stable swagger (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([previewPath, stablePath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: false,
      diagnostics: expect.arrayContaining([
        expect.objectContaining({ code: "extra-swagger" }),
      ]) as unknown,
    });
  });

  it("should succeed if an older preview is superseded by a later stable version", async function () {
    // Current TypeSpec only generates the stable 2024-03-01 version, but the older
    // preview swagger is left in place. This should be allowed.
    const stablePath = "data-plane/Azure.Foo/stable/2024-03-01/foo.json";
    const olderPreviewPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [stablePath]));

    // Simulate extra older preview swagger (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([stablePath, olderPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result).toMatchObject({
      success: true,
    });
  });

  it("should fail if a preview is newer than the latest stable version", async function () {
    // Current TypeSpec only generates the stable 2023-01-01 version, but a *newer*
    // preview swagger is left in place. This is a genuine mismatch and should fail.
    const stablePath = "data-plane/Azure.Foo/stable/2023-01-01/foo.json";
    const newerPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [stablePath]));

    // Simulate extra newer preview swagger (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([stablePath, newerPreviewPath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: false,
      diagnostics: expect.arrayContaining([
        expect.objectContaining({ code: "extra-swagger" }),
      ]) as unknown,
    });
  });

  it("should succeed with multiple older preview versions", async function () {
    const latestPreviewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreview1Path = "data-plane/Azure.Foo/preview/2023-01-01-preview/foo.json";
    const olderPreview2Path = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [latestPreviewPath]));

    // Simulate multiple extra older preview swaggers (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([latestPreviewPath, olderPreview1Path, olderPreview2Path]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result).toMatchObject({
      success: true,
    });
  });

  it("should fail if extra swaggers mix preview and stable versions", async function () {
    const previewPath = "data-plane/Azure.Foo/preview/2024-03-01-preview/foo.json";
    const olderPreviewPath = "data-plane/Azure.Foo/preview/2022-11-01-preview/foo.json";
    const stablePath = "data-plane/Azure.Foo/stable/2023-01-01/foo.json";

    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [previewPath]));

    // Simulate extra swaggers with mix of preview and stable (using POSIX paths)
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
      Promise.resolve([previewPath, olderPreviewPath, stablePath]),
    );

    vi.mocked(fsPromises.readFile).mockImplementation(() =>
      Promise.resolve('{"info": {"x-typespec-generated": true}}'),
    );

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: false,
      diagnostics: expect.arrayContaining([
        expect.objectContaining({ code: "extra-swagger" }),
      ]) as unknown,
    });
  });

  it("supports suppressions", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));

    // Simulate extra swagger
    vi.mocked(nativeGlob.globFiles).mockImplementation(() =>
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

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: true,
    });
  });

  it("throws on invalid suppressions", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));

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

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).rejects.toThrow(
      "Invalid path",
    );
  });

  it("should skip git diff check if compile fails", async function () {
    compileTypeSpecSpy.mockResolvedValue(
      compileResult([
        { name: "compilation_error", message: "compilation error" },
        "running TypeSpec compile",
        "compilation failure",
      ]),
    );

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    expect(
      diagnosticDetails(result.diagnostics?.find((diagnostic) => diagnostic.code === "compile")),
    ).toBe("running TypeSpec compile\ncompilation failure");
    expect(gitDiffTopSpecFolderSpy).not.toHaveBeenCalled();
  });

  it("reports files changed by compilation with fix guidance", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));

    vi.mocked(nativeGlob.globFiles).mockImplementation(() => Promise.resolve([swaggerPath]));

    const files = [`${mockFolder}/foo.json`, `${mockFolder}/bar.json`];
    const diff = "diff --git a/foo.json b/foo.json\n-old\n+new\n";
    gitDiffTopSpecFolderSpy.mockResolvedValue({
      success: false,
      files,
      diff,
    });

    const result = await new CompileRule().execute(mockFolder, defaultLogger);
    expect(result.success).toBe(false);
    const diagnostic = result.diagnostics?.find(
      (diagnostic) => diagnostic.code === "generated-files-changed",
    );
    expect(diagnostic).toMatchObject({
      severity: "error",
      code: "generated-files-changed",
      message: "Files changed after TypeSpec compilation:",
      path: mockFolder,
      help: "Run `pnpm exec tsp compile .` from the project folder and include the generated files in your change.",
    });
    expect(diagnosticDetails(diagnostic)).toBe(
      `  ${mockFolder}/foo.json\n  ${mockFolder}/bar.json\n\n${diff}`,
    );
    expect(gitDiffTopSpecFolderSpy).toHaveBeenCalledWith(mockFolder, defaultLogger);
  });

  it("should succeed if git diff succeeds", async function () {
    compileTypeSpecSpy.mockResolvedValue(compileResult([null, "", ""], [swaggerPath]));

    vi.mocked(nativeGlob.globFiles).mockImplementation(() => Promise.resolve([swaggerPath]));

    gitDiffTopSpecFolderSpy.mockResolvedValue({ success: true, files: [] });

    await expect(new CompileRule().execute(mockFolder, defaultLogger)).resolves.toMatchObject({
      success: true,
    });
  });
});
