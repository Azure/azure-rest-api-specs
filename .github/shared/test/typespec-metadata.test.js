import { access, writeFile } from "node:fs/promises";
import { dirname } from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { execNpmExec } from "../src/exec.js";
import { debugLogger } from "../src/logger.js";
import { generateTypeSpecMetadata } from "../src/typespec-metadata.js";

vi.mock("../src/exec.js", async (importOriginal) => ({
  .../** @type {object} */ (await importOriginal()),
  execNpmExec: vi.fn(),
}));

const validMetadata = {
  emitterVersion: "0.3.0",
  generatedAt: "2026-08-18T00:00:00.000Z",
  typespec: {
    namespace: "Contoso.Management",
    documentation: "Contoso service",
    type: "management",
  },
  languages: {
    python: [
      {
        emitterName: "@azure-tools/typespec-python",
        packageName: "azure-mgmt-contoso",
        namespace: "azure.mgmt.contoso",
        outputDir: "{output-dir}/sdk/contoso/azure-mgmt-contoso",
        flavor: "azure",
        serviceDir: "sdk/contoso",
        apiVersion: "2026-01-01",
        sdkType: "stable",
      },
    ],
  },
  sourceConfigPath: "specification/contoso/tspconfig.yaml",
};

/**
 * @param {string[]} args
 * @returns {string}
 */
function getMetadataFile(args) {
  const outputOption = args.find((arg) => arg.includes(".outputFile="));
  if (!outputOption) throw new Error("Metadata output option was not provided");
  return outputOption.split("=").slice(1).join("=");
}

/** @param {string | undefined} file */
async function expectMetadataDirectoryRemoved(file) {
  if (!file) throw new Error("Metadata output path was not captured");
  await expect(access(dirname(file))).rejects.toThrow();
}

describe("generateTypeSpecMetadata", () => {
  /** @type {string | undefined} */
  let metadataFile;

  beforeEach(() => {
    metadataFile = undefined;
    vi.mocked(execNpmExec).mockReset();
  });

  it("generates, validates, and cleans up TypeSpec metadata", async () => {
    vi.mocked(execNpmExec).mockImplementation(async (args, options) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify(validMetadata));

      expect(args).toContain("@azure-tools/typespec-metadata");
      expect(options?.cwd).toMatch(/contoso$/);
      expect(options?.maxBuffer).toBe(64 * 1024 * 1024);
      return { stdout: "", stderr: "" };
    });

    await expect(generateTypeSpecMetadata("contoso")).resolves.toEqual(validMetadata);
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("passes the logger to command execution", async () => {
    vi.mocked(execNpmExec).mockImplementation(async (args, options) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify(validMetadata));
      expect(options?.logger).toBe(debugLogger);
      return { stdout: "", stderr: "" };
    });

    await generateTypeSpecMetadata("contoso", { logger: debugLogger });
  });

  it("rejects invalid metadata and cleans up", async () => {
    vi.mocked(execNpmExec).mockImplementation(async (args) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify({ languages: [] }));
      return { stdout: "", stderr: "" };
    });

    await expect(generateTypeSpecMetadata("contoso")).rejects.toThrow("unexpected format");
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("wraps execution errors and cleans up", async () => {
    vi.mocked(execNpmExec).mockImplementation((args) => {
      metadataFile = getMetadataFile(args);
      return Promise.reject(new Error("compile failed"));
    });

    await expect(generateTypeSpecMetadata("contoso")).rejects.toThrow(
      "Failed to generate TypeSpec metadata: Error: compile failed",
    );
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("includes compiler diagnostics written to stdout", async () => {
    vi.mocked(execNpmExec).mockImplementation((args) => {
      metadataFile = getMetadataFile(args);

      const error = Object.assign(new Error("Command failed: tsp compile"), {
        stdout: "error file-not-found: File main.tsp not found.",
        stderr: "",
      });
      return Promise.reject(error);
    });

    await expect(generateTypeSpecMetadata("contoso")).rejects.toThrow("file-not-found");
    await expectMetadataDirectoryRemoved(metadataFile);
  });
});
