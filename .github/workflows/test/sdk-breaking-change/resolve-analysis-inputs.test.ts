import { mkdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  resolveChangedTypeSpecConfigPaths,
  resolveChangedTypeSpecProjects,
  resolveSdkLanguageConfig,
} from "../../src/sdk-breaking-change/resolve-analysis-inputs.ts";
import { createMockContext, createMockCore, createMockGithub } from "../mocks.ts";

const temporaryDirectories: string[] = [];

function createRepository(): string {
  const repositoryPath = join(import.meta.dirname, `repo-${crypto.randomUUID()}`);
  temporaryDirectories.push(repositoryPath);
  mkdirSync(join(repositoryPath, "specification", "service", "Widget.Service", "models"), {
    recursive: true,
  });
  mkdirSync(join(repositoryPath, "specification", "other", "Other.Service"), {
    recursive: true,
  });
  writeFileSync(
    join(repositoryPath, "specification", "service", "Widget.Service", "tspconfig.yaml"),
    "emit: []\n",
  );
  writeFileSync(
    join(repositoryPath, "specification", "other", "Other.Service", "tspconfig.yaml"),
    "emit: []\n",
  );
  return repositoryPath;
}

afterEach(async () => {
  const { rm } = await import("node:fs/promises");
  await Promise.all(temporaryDirectories.splice(0).map((path) => rm(path, { recursive: true })));
  vi.unstubAllEnvs();
});

describe("resolveSdkLanguageConfig", () => {
  it.each([
    ["cpp", "Cpp", "azure-sdk-for-cpp"],
    [" CSharp ", "DotNet", "azure-sdk-for-net"],
    [".net", "DotNet", "azure-sdk-for-net"],
    ["go", "Go", "azure-sdk-for-go"],
    ["java", "Java", "azure-sdk-for-java"],
    ["typescript", "JavaScript", "azure-sdk-for-js"],
    ["js", "JavaScript", "azure-sdk-for-js"],
    ["python", "Python", "azure-sdk-for-python"],
    ["rust", "Rust", "azure-sdk-for-rust"],
  ] as const)("resolves %s", (input, language, repository) => {
    expect(resolveSdkLanguageConfig(input)).toEqual({ language, repository });
  });

  it("rejects an unsupported language", () => {
    expect(() => resolveSdkLanguageConfig("ruby")).toThrow("Unsupported SDK language: ruby");
  });
});

describe("resolveChangedTypeSpecConfigPaths", () => {
  it("returns sorted, deduplicated config paths for the nearest owning projects", () => {
    const repositoryPath = createRepository();

    expect(
      resolveChangedTypeSpecConfigPaths(repositoryPath, [
        "README.md",
        "specification/service/Widget.Service/main.tsp",
        "specification/service/Widget.Service/models/widget.tsp",
        "specification/other/Other.Service/tspconfig.yaml",
      ]),
    ).toEqual([
      "specification/other/Other.Service/tspconfig.yaml",
      "specification/service/Widget.Service/tspconfig.yaml",
    ]);
  });

  it("rejects a TypeSpec path that can escape the specification directory", () => {
    const repositoryPath = createRepository();

    expect(() =>
      resolveChangedTypeSpecConfigPaths(repositoryPath, [
        "specification/service/../outside/main.tsp",
      ]),
    ).toThrow("Invalid changed TypeSpec file path");
  });
});

describe("resolveChangedTypeSpecProjects", () => {
  it("reads all pull request files and sets the config path output", async () => {
    const repositoryPath = createRepository();
    const github = createMockGithub();
    const context = createMockContext();
    const core = createMockCore();
    vi.stubEnv("PR_NUMBER", "42");
    vi.stubEnv("SPEC_REPOSITORY_PATH", repositoryPath);
    const listFiles = vi.fn().mockResolvedValue({
      data: [
        {
          filename: "specification/service/Widget.Service/new/main.tsp",
          previous_filename: "specification/service/Widget.Service/main.tsp",
        },
      ],
    });
    Object.assign(github.rest.pulls, { listFiles });

    await expect(resolveChangedTypeSpecProjects({ github, context, core })).resolves.toEqual([
      "specification/service/Widget.Service/tspconfig.yaml",
    ]);
    expect(listFiles).toHaveBeenCalledWith({
      owner: "owner",
      repo: "repo",
      pull_number: 42,
      per_page: 100,
    });
    expect(core.setOutput).toHaveBeenCalledWith(
      "tsp-config-paths",
      '["specification/service/Widget.Service/tspconfig.yaml"]',
    );
  });
});
