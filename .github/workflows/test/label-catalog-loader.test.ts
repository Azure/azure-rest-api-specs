import { describe, expect, it, vi } from "vitest";
import { stringify } from "yaml";
import { mkdtemp, mkdir, writeFile, symlink, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { loadLabelCatalog, resolveLabelCatalog } from "../src/label-catalog-loader.ts";

const canonical = { name: "canonical", color: "123456", description: "Marker" };
const bug = { name: "bug", color: "abcdef", description: "Bug" };
const root = ".github/labels.yaml";
function files(documents: Record<string, unknown>) {
  const contents = new Map(
    Object.entries(documents).map(([path, value]) => [path, stringify(value)]),
  );
  const read = vi.fn((path: string) => {
    const content = contents.get(path);
    if (content === undefined) throw new Error(`Missing file: ${path}`);
    return Promise.resolve(content);
  });
  return { read, contents, load: () => resolveLabelCatalog(read) };
}

describe("label catalog inheritance", () => {
  it("supports existing single-file catalogs", async () => {
    const catalog = { unconfiguredLabels: "archive", labels: [canonical, bug] };
    expect((await files({ [root]: catalog }).load()).catalog).toEqual(catalog);
  });
  it("resolves nested relative paths and overrides inherited fields by case-insensitive name", async () => {
    const f = files({
      [root]: {
        unconfiguredLabels: "archive",
        extends: ["./labels/team/local.yaml"],
        labels: [{ name: "BUG", description: "Local" }],
      },
      ".github/labels/team/local.yaml": {
        extends: ["../base.yaml"],
        labels: [{ name: "bug", color: "654321" }],
      },
      ".github/labels/base.yaml": { labels: [canonical, bug] },
    });
    const result = await f.load();
    expect(result.catalog.labels).toEqual([
      canonical,
      { name: "BUG", color: "654321", description: "Local" },
    ]);
    expect(result.sources).toHaveLength(3);
  });
  it("loads a diamond dependency once", async () => {
    const f = files({
      [root]: { unconfiguredLabels: "preserve", extends: ["./labels/a.yaml", "./labels/b.yaml"] },
      ".github/labels/a.yaml": { extends: ["./common.yaml"] },
      ".github/labels/b.yaml": { extends: ["./common.yaml"] },
      ".github/labels/common.yaml": { labels: [canonical, bug] },
    });
    expect((await f.load()).catalog.labels).toEqual([canonical, bug]);
    expect(f.read.mock.calls.filter(([path]) => path.endsWith("common.yaml"))).toHaveLength(1);
  });
  it("rejects conflicting sibling bases unless the extending file overrides the conflicting field", async () => {
    const f = files({
      [root]: { unconfiguredLabels: "archive", extends: ["./labels/a.yaml", "./labels/b.yaml"] },
      ".github/labels/a.yaml": { labels: [canonical, bug] },
      ".github/labels/b.yaml": { labels: [{ ...bug, color: "654321" }] },
    });
    await expect(f.load()).rejects.toThrow("Conflicting inherited color");
    f.contents.set(
      root,
      stringify({
        unconfiguredLabels: "archive",
        extends: ["./labels/a.yaml", "./labels/b.yaml"],
        labels: [{ name: "bug", color: "123456" }],
      }),
    );
    expect((await f.load()).catalog.labels.find((l) => l.name === "bug")?.color).toBe("123456");
  });
  it.each([
    "../outside.yaml",
    "/absolute.yaml",
    "https://example.com/a.yaml",
    "C:\\a.yaml",
    "./labels/../../outside.yaml",
  ])("rejects unsafe reference %s", async (reference) => {
    const f = files({ [root]: { unconfiguredLabels: "archive", extends: [reference] } });
    await expect(f.load()).rejects.toThrow();
    expect(f.read).toHaveBeenCalledTimes(1);
  });
  it("rejects cycles with the dependency chain", async () => {
    const f = files({
      [root]: { unconfiguredLabels: "archive", extends: ["./labels/a.yaml"] },
      ".github/labels/a.yaml": { extends: ["../labels.yaml"] },
    });
    await expect(f.load()).rejects.toThrow("inheritance cycle");
  });
  it.each([
    { labels: [canonical, bug, { ...bug, name: "BUG" }] },
    { labels: [canonical], unconfiguredLabels: "archive" },
    { labels: [{ name: "new" }] },
  ])("rejects invalid fragment %j", async (base) => {
    await expect(
      files({
        [root]: { unconfiguredLabels: "archive", extends: ["./labels/base.yaml"] },
        ".github/labels/base.yaml": base,
      }).load(),
    ).rejects.toThrow();
  });
  it("does not turn a missing file into an empty catalog", async () => {
    await expect(
      files({
        [root]: {
          unconfiguredLabels: "archive",
          extends: ["./labels/missing.yaml"],
          labels: [canonical],
        },
      }).load(),
    ).rejects.toThrow("Missing file");
  });
  it("changes the audit hash when only an inherited source changes", async () => {
    const f = files({
      [root]: { unconfiguredLabels: "archive", extends: ["./labels/base.yaml"] },
      ".github/labels/base.yaml": { labels: [canonical] },
    });
    const before = await f.load();
    f.contents.set(
      ".github/labels/base.yaml",
      stringify({ labels: [{ ...canonical, description: "Updated" }] }),
    );
    expect((await f.load()).hash).not.toBe(before.hash);
  });
  it("rejects invalid YAML without duplicate-key fallback", async () => {
    const f = files({});
    f.contents.set(root, "labels: []\nlabels: []");
    await expect(f.load()).rejects.toThrow("Invalid label YAML");
  });
  it("loads real local fragments and rejects symlinks escaping the repository", async () => {
    const directory = await mkdtemp(join(tmpdir(), "catalog-loader-"));
    try {
      const repo = join(directory, "repo");
      await mkdir(join(repo, ".github", "labels"), { recursive: true });
      const path = join(repo, root);
      await writeFile(
        path,
        stringify({ unconfiguredLabels: "archive", extends: ["./labels/base.yaml"] }),
      );
      await writeFile(join(directory, "outside.yaml"), stringify({ labels: [canonical] }));
      await symlink(join(directory, "outside.yaml"), join(repo, ".github/labels/base.yaml"));
      await expect(loadLabelCatalog(path)).rejects.toThrow("escapes");
      await rm(join(repo, ".github/labels/base.yaml"));
      await writeFile(join(repo, ".github/labels/base.yaml"), stringify({ labels: [canonical] }));
      expect((await loadLabelCatalog(path)).catalog.labels).toEqual([canonical]);
    } finally {
      await rm(directory, { recursive: true, force: true });
    }
  });
});
