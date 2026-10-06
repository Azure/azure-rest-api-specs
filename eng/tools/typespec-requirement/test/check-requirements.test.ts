import { access, mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  checkRequirements,
  type RequirementOptions,
  type RequirementReporter,
} from "../src/check-requirements.ts";

const root = resolve(import.meta.dirname, "../../../..");
const version = "hand-written/resource-manager/Microsoft.HandWritten/HandWritten/stable/2026-01-01";
const url = `https://github.com/Azure/azure-rest-api-specs/tree/main/specification/${version}`;
const fixture = resolve(import.meta.dirname, `specification/${version}`);
const directories: string[] = [];

function reporter() {
  return {
    info: vi.fn<(message: string) => void>(),
    warning: vi.fn<(message: string) => void>(),
    warningForFile: vi.fn<(file: string, message: string) => void>(),
    error: vi.fn<(message: string) => void>(),
    errorForFile: vi.fn<(file: string, message: string) => void>(),
    jobFailure: vi.fn<() => void>(),
  } satisfies RequirementReporter;
}

function options(status: number): RequirementOptions {
  return {
    repoRoot: root,
    baseCommitish: "HEAD^",
    headCommitish: "HEAD",
    checkAllUnder: fixture,
    responseCache: { [url]: status },
  };
}

afterEach(async () => {
  vi.restoreAllMocks();
  vi.unstubAllEnvs();
  await Promise.all(
    directories.splice(0).map((directory) => rm(directory, { recursive: true, force: true })),
  );
});

describe("importable Requirement policy engine", () => {
  it("returns brownfield without writing CI output or logging through the CLI", async () => {
    const directory = await mkdtemp(join(tmpdir(), "requirement-engine-"));
    directories.push(directory);
    const output = join(directory, "github-output");
    vi.stubEnv("GITHUB_OUTPUT", output);
    const stdout = vi.spyOn(console, "log").mockImplementation(() => {});
    const sink = reporter();
    expect(await checkRequirements(options(200), sink)).toEqual({ brownfield: true, exitCode: 0 });
    expect(sink.warningForFile).toHaveBeenCalledOnce();
    expect(stdout).not.toHaveBeenCalled();
    await expect(access(output)).rejects.toMatchObject({ code: "ENOENT" });
  });

  it("reports a new handwritten API version through the injected reporter", async () => {
    const sink = reporter();
    expect(await checkRequirements(options(404), sink)).toEqual({ brownfield: false, exitCode: 1 });
    expect(sink.jobFailure).toHaveBeenCalledOnce();
    expect(sink.errorForFile).toHaveBeenCalledExactlyOnceWith(
      `specification/${version}/hand-written.json`,
      "OpenAPI was not generated from TypeSpec, and API version appears to be new",
    );
  });

  it("preserves the fail-fast operational error result", async () => {
    const sink = reporter();
    expect(await checkRequirements(options(519), sink)).toEqual({ brownfield: false, exitCode: 1 });
    expect(sink.error).toHaveBeenCalledExactlyOnceWith(
      `Unexpected response from ${url.replace(/^https:\/\//, "")}: 519`,
    );
  });

  it("reports brownfield incrementally before an unexpected later file failure", async () => {
    const directory = await mkdtemp(join(tmpdir(), "requirement-engine-"));
    directories.push(directory);
    const first = join(directory, "specification/foo/data-plane/Foo/stable/2025-01-01/a.json");
    const second = join(directory, "specification/foo/data-plane/Foo/stable/2025-01-01/b.json");
    await mkdir(dirname(first), { recursive: true });
    await Promise.all([writeFile(first, "{}"), writeFile(second, "{}")]);
    const brownfield = vi.fn<() => Promise<void>>().mockImplementation(async () => {
      await Promise.all([rm(first), rm(second)]);
    });
    await expect(
      checkRequirements(
        {
          ...options(200),
          checkAllUnder: directory,
          responseCache: {
            "https://github.com/Azure/azure-rest-api-specs/tree/main/specification/foo/data-plane/Foo/stable/2025-01-01": 200,
          },
        },
        { ...reporter(), brownfield },
      ),
    ).rejects.toMatchObject({ code: "ENOENT" });
    expect(brownfield).toHaveBeenCalledOnce();
  });
});
