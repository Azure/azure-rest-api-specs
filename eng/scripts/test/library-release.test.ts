import { execFileSync } from "node:child_process";
import type { SpawnSyncReturns } from "node:child_process";
import { mkdtemp, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  checkRelease,
  isPackagePublished,
  preparePrerelease,
  prereleaseVersion,
} from "../library-release.ts";

const commit = "a".repeat(40);
const name = "@azure-tools/typespec-foundry-core";
const folders: string[] = [];
const npm = vi.hoisted(() => vi.fn<() => SpawnSyncReturns<string>>());

vi.mock("node:child_process", async () => ({
  ...(await vi.importActual<typeof import("node:child_process")>("node:child_process")),
  spawnSync: npm,
}));

function npmResult(status: number, metadata: unknown): void {
  const stdout = JSON.stringify(metadata);
  npm.mockReturnValue({
    pid: 1,
    output: [null, stdout, ""],
    stdout,
    stderr: "",
    status,
    signal: null,
  });
}

async function temporaryDirectory(): Promise<string> {
  const directory = await mkdtemp(join(tmpdir(), "library-release-"));
  folders.push(directory);
  return directory;
}

afterEach(async () => {
  vi.restoreAllMocks();
  npm.mockReset();
  await Promise.all(folders.splice(0).map((folder) => rm(folder, { recursive: true })));
});

describe("automatic library prereleases", () => {
  it.each(["0.1.0-beta.1", "0.1.0", "0.1.0+build"])(
    "derives a deterministic development version from %s",
    (version) => {
      expect(prereleaseVersion(version, commit, "1791219000")).toBe(
        "0.1.0-dev.1791219000.gaaaaaaaaaaaa",
      );
    },
  );

  it.each([
    ["invalid", commit, "1791219000"],
    ["0.1.0", "abc", "1791219000"],
    ["0.1.0", commit, "not-a-timestamp"],
  ])("rejects invalid release identity inputs", (version, sha, timestamp) => {
    expect(() => prereleaseVersion(version, sha, timestamp)).toThrow("valid package version");
  });

  it("keeps the same version across reruns and unrelated commits", async () => {
    const root = await temporaryDirectory();
    const library = join(root, "libs", "example");
    await mkdir(library, { recursive: true });
    const manifest = JSON.stringify({ name, version: "0.1.0-beta.1", exports: "./index.js" });
    const manifestPath = join(library, "package.json");
    await writeFile(manifestPath, manifest);
    const git = (...args: string[]) =>
      execFileSync("git", ["-c", "user.name=Test", "-c", "user.email=test@example.test", ...args], {
        cwd: root,
        encoding: "utf8",
      }).trim();
    git("init", "--quiet");
    git("add", ".");
    git("commit", "--quiet", "-m", "Add library");
    await preparePrerelease(library);
    const first = await readFile(manifestPath, "utf8");
    expect(JSON.parse(first)).toMatchObject({ name, exports: "./index.js" });
    await preparePrerelease(library);
    expect(await readFile(manifestPath, "utf8")).toBe(first);
    await writeFile(manifestPath, manifest);
    await writeFile(join(root, "unrelated.txt"), "unrelated");
    git("add", "unrelated.txt");
    git("commit", "--quiet", "-m", "Unrelated change");
    await preparePrerelease(library);
    expect(await readFile(manifestPath, "utf8")).toBe(first);
    await writeFile(manifestPath, manifest);
    await writeFile(join(library, "README.md"), "Library change");
    git("add", "libs");
    git("commit", "--quiet", "-m", "Change library");
    await preparePrerelease(library);
    expect(await readFile(manifestPath, "utf8")).not.toBe(first);
  });
});

describe("release preflight", () => {
  it.each([true, false])("checks the exact version, published=%s", (published) => {
    npmResult(0, ["0.1.0", ...(published ? ["0.1.0-dev.1.gabc"] : [])]);
    expect(isPackagePublished(name, "0.1.0-dev.1.gabc")).toBe(published);
    expect(npm).toHaveBeenCalledWith(
      "npm",
      ["view", name, "versions", "--json", "--prefer-online"],
      { encoding: "utf8", shell: process.platform === "win32", timeout: 120_000 },
    );
  });

  it("allows a package that has never been published", () => {
    npmResult(1, { error: { code: "E404" } });
    expect(isPackagePublished(name, "0.1.0")).toBe(false);
  });

  it.each(["E401", "E403", "E429", "E500"])("fails closed on registry %s", (code) => {
    npmResult(1, { error: { code } });
    expect(() => isPackagePublished(name, "0.1.0")).toThrow(code);
  });

  it.each([{}, null, [1]])("fails closed on malformed metadata", (metadata) => {
    npmResult(0, metadata);
    expect(() => isPackagePublished(name, "0.1.0")).toThrow("invalid npm registry metadata");
  });

  it("does not turn process failures into permission to publish", () => {
    npmResult(1, {});
    const result = npm();
    npm.mockReturnValue({ ...result, error: new Error("npm unavailable") });
    expect(() => isPackagePublished(name, "0.1.0")).toThrow("npm unavailable");
  });

  it.each([true, false])(
    "gates publishing using the packed manifest, published=%s",
    async (published) => {
      const root = await temporaryDirectory();
      await mkdir(join(root, "package"));
      await writeFile(
        join(root, "package/package.json"),
        JSON.stringify({ name, version: "0.1.0" }),
      );
      execFileSync("tar", ["-czf", join(root, "library.tgz"), "-C", root, "package"]);
      npmResult(0, published ? ["0.1.0"] : []);
      const log = vi.spyOn(console, "log").mockImplementation(() => {});
      expect(await checkRelease(root)).toBe(!published);
      expect(log).toHaveBeenCalledWith(
        `##vso[task.setvariable variable=ShouldPublish;isOutput=true]${!published}`,
      );
    },
  );

  it("fails rather than releasing an empty artifact", async () => {
    await expect(checkRelease(await temporaryDirectory())).rejects.toThrow(
      "Expected exactly one library package",
    );
  });
});
