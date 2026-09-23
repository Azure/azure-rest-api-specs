import { access, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { beforeEach, describe, expect, it, vi } from "vitest";
import { execNodeBin } from "../src/exec.ts";
import { debugLogger, type ILogger } from "../src/logger.ts";
import { generateTypeSpecMetadata } from "../src/typespec-metadata.ts";

vi.mock("../src/exec.ts", async (importOriginal) => ({
  ...(await importOriginal()),
  execNodeBin: vi.fn(),
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

function getMetadataFile(args: string[]): string {
  const outputOption = args.find((arg) => arg.includes(".outputFile="));
  if (!outputOption) throw new Error("Metadata output option was not provided");
  return outputOption.split("=").slice(1).join("=");
}

async function expectMetadataDirectoryRemoved(file: string | undefined) {
  if (!file) throw new Error("Metadata output path was not captured");
  await expect(access(dirname(file))).rejects.toThrow();
}

describe("generateTypeSpecMetadata", () => {
  let metadataFile: string | undefined;

  beforeEach(() => {
    metadataFile = undefined;
    vi.mocked(execNodeBin).mockReset();
  });

  it("generates, validates, and cleans up TypeSpec metadata", async () => {
    vi.mocked(execNodeBin).mockImplementation(async (packageName, args, options) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify(validMetadata));

      expect(args).toContain("@azure-tools/typespec-metadata");
      expect(packageName).toBe("@typespec/compiler");
      expect(options?.cwd).toMatch(/contoso$/);
      expect(options?.maxBuffer).toBe(64 * 1024 * 1024);
      expect(options?.timeout).toBeUndefined();
      expect(args[2]).toBe(resolve("contoso"));
      return { stdout: "", stderr: "" };
    });

    await expect(generateTypeSpecMetadata("contoso")).resolves.toEqual(validMetadata);
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("passes the logger to command execution", async () => {
    vi.mocked(execNodeBin).mockImplementation(async (_packageName, args, options) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify(validMetadata));
      expect(options?.logger).toBe(debugLogger);
      return { stdout: "", stderr: "" };
    });

    await generateTypeSpecMetadata("contoso", { logger: debugLogger });
  });

  it("uses client.tsp as the compile target when main.tsp is absent", async () => {
    const projectDirectory = await mkdtemp(join(tmpdir(), "typespec-client-project-"));
    const clientTspPath = join(projectDirectory, "client.tsp");
    await writeFile(clientTspPath, "namespace Contoso;");

    try {
      vi.mocked(execNodeBin).mockImplementation(async (_packageName, args) => {
        metadataFile = getMetadataFile(args);
        await writeFile(metadataFile, JSON.stringify(validMetadata));
        expect(args[2]).toBe(clientTspPath);
        return { stdout: "", stderr: "" };
      });

      await expect(generateTypeSpecMetadata(projectDirectory)).resolves.toEqual(validMetadata);
    } finally {
      await rm(projectDirectory, { recursive: true, force: true });
    }
  });

  it("keeps the project target when both main.tsp and client.tsp exist", async () => {
    const projectDirectory = await mkdtemp(join(tmpdir(), "typespec-main-project-"));
    try {
      await writeFile(join(projectDirectory, "main.tsp"), "");
      await writeFile(join(projectDirectory, "client.tsp"), "");
      vi.mocked(execNodeBin).mockImplementation(async (_packageName, args) => {
        metadataFile = getMetadataFile(args);
        await writeFile(metadataFile, JSON.stringify(validMetadata));
        expect(args[2]).toBe(projectDirectory);
        return { stdout: "", stderr: "" };
      });
      await generateTypeSpecMetadata(projectDirectory);
    } finally {
      await rm(projectDirectory, { recursive: true, force: true });
    }
  });

  it.each(["custom.tsp", resolve("contoso/custom.tsp")])(
    "honors an explicit entrypoint and timeout (%s)",
    async (entrypoint) => {
      vi.mocked(execNodeBin).mockImplementation(async (_packageName, args, options) => {
        metadataFile = getMetadataFile(args);
        await writeFile(metadataFile, JSON.stringify(validMetadata));
        expect(args[2]).toBe(resolve("contoso/custom.tsp"));
        expect(options?.cwd).toBe(resolve("contoso"));
        expect(options?.timeout).toBe(120_000);
        return { stdout: "", stderr: "" };
      });
      await generateTypeSpecMetadata("contoso", { entrypoint, timeout: 120_000 });
      await expectMetadataDirectoryRemoved(metadataFile);
    },
  );

  it("does not infer warning or error severity from successful stderr", async () => {
    const logger: ILogger = {
      debug: vi.fn(),
      info: vi.fn(),
      error: vi.fn(),
      warning: vi.fn(),
      isDebug: () => false,
    };
    vi.mocked(execNodeBin).mockImplementation(async (_packageName, args) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify(validMetadata));
      return { stdout: "", stderr: "compiler progress" };
    });
    await expect(generateTypeSpecMetadata("contoso", { logger })).resolves.toEqual(validMetadata);
    expect(logger.warning).not.toHaveBeenCalled();
    expect(logger.error).not.toHaveBeenCalled();
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("rejects invalid metadata and cleans up", async () => {
    vi.mocked(execNodeBin).mockImplementation(async (_packageName, args) => {
      metadataFile = getMetadataFile(args);
      await writeFile(metadataFile, JSON.stringify({ languages: [] }));
      return { stdout: "", stderr: "" };
    });

    await expect(generateTypeSpecMetadata("contoso")).rejects.toThrow("unexpected format");
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("wraps execution errors and cleans up", async () => {
    vi.mocked(execNodeBin).mockImplementation((_packageName, args) => {
      metadataFile = getMetadataFile(args);
      return Promise.reject(new Error("compile failed"));
    });

    await expect(generateTypeSpecMetadata("contoso")).rejects.toThrow(
      "Failed to generate TypeSpec metadata: Error: compile failed",
    );
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("includes failed compiler output from both streams", async () => {
    vi.mocked(execNodeBin).mockImplementation((_packageName, args) => {
      metadataFile = getMetadataFile(args);

      const error = Object.assign(new Error("Command failed: tsp compile"), {
        stdout: "error file-not-found: File main.tsp not found.",
        stderr: "compiler progress",
      });
      return Promise.reject(error);
    });

    const result = generateTypeSpecMetadata("contoso");
    await expect(result).rejects.toThrow("file-not-found");
    await expect(result).rejects.toThrow("compiler progress");
    await expectMetadataDirectoryRemoved(metadataFile);
  });

  it("preserves timeout errors and their cause even with partial diagnostics", async () => {
    const error = Object.assign(new Error("compiler timed out"), {
      stdout: "partial diagnostics",
      stderr: "",
      killed: true,
    });
    vi.mocked(execNodeBin).mockImplementation((_packageName, args) => {
      metadataFile = getMetadataFile(args);
      return Promise.reject(error);
    });
    const result = generateTypeSpecMetadata("contoso", { timeout: 100 });
    await expect(result).rejects.toThrow("compiler timed out");
    await expect(result).rejects.toHaveProperty("cause", error);
    await expectMetadataDirectoryRemoved(metadataFile);
  });
});
