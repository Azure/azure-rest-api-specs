import yaml from "js-yaml";
import { mkdir, mkdtemp, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, relative } from "node:path";
import { setImmediate } from "node:timers/promises";
import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { diffSuppression, getAllApiVersionFromRPFolder, processPrChanges } from "../src/impact.ts";
import { PRContext } from "../src/PRContext.ts";

describe("native impact utilities", () => {
  let folder: string;

  beforeEach(async () => {
    folder = await mkdtemp(join(tmpdir(), "impact-native-"));
  });

  afterEach(async () => {
    vi.restoreAllMocks();
    await rm(folder, { recursive: true, force: true });
  });

  function createContext() {
    const context = new PRContext(
      folder,
      folder,
      { present: new Set(), toAdd: new Set(), toRemove: new Set() },
      {
        sourceBranch: "feature",
        targetBranch: "main",
        sha: "head",
        repo: "azure-rest-api-specs",
        owner: "Azure",
        prNumber: "1",
        isDraft: false,
        fileList: {
          additions: ["first.tsp", "second.tsp"],
          modifications: [],
          deletions: [],
          renames: [],
          total: 2,
        },
      },
    );
    vi.spyOn(context, "getReadmeDiffs").mockResolvedValue({});
    return context;
  }

  it("awaits change handlers in file and handler order", async () => {
    const events: string[] = [];
    await processPrChanges(createContext(), [
      {
        TypeSpecFile: async ({ filePath }) => {
          events.push(`start:${filePath}`);
          await setImmediate();
          events.push(`end:${filePath}`);
        },
      },
      {
        TypeSpecFile: ({ filePath }) => {
          events.push(`next:${filePath}`);
        },
      },
    ]);

    expect(events).toEqual([
      "start:first.tsp",
      "end:first.tsp",
      "next:first.tsp",
      "start:second.tsp",
      "end:second.tsp",
      "next:second.tsp",
    ]);
  });

  it("propagates handler failures without running later handlers", async () => {
    const error = new Error("handler failed");
    const nextHandler = vi.fn<() => void>();

    await expect(
      processPrChanges(createContext(), [
        { TypeSpecFile: () => Promise.reject(error) },
        { TypeSpecFile: nextHandler },
      ]),
    ).rejects.toBe(error);
    expect(nextHandler).not.toHaveBeenCalled();
  });

  it("finds unique versions recursively and ignores examples and hidden files", async () => {
    for (const directory of ["stable/v1", "preview/v2", "stable/v1/examples", ".hidden"]) {
      await mkdir(join(folder, directory), { recursive: true });
    }
    for (const [file, version] of [
      ["stable/v1/foo.json", "2024-01-01"],
      ["stable/v1/bar.json", "2024-01-01"],
      ["preview/v2/foo.json", "2025-01-01-preview"],
      ["stable/v1/examples/example.json", "ignored-example"],
      [".hidden/ignored.json", "ignored-hidden"],
    ]) {
      await writeFile(join(folder, file), JSON.stringify({ info: { version } }));
    }

    for (const root of [folder, relative(process.cwd(), folder)]) {
      expect(getAllApiVersionFromRPFolder(root).sort()).toEqual([
        "2024-01-01",
        "2025-01-01-preview",
      ]);
    }
  });

  it("compares nested suppression values independently of object key order", async () => {
    const before = join(folder, "before.md");
    const after = join(folder, "after.md");
    const original = {
      suppress: "Rule",
      where: { paths: ["a", "b"], options: { enabled: true, count: 2 } },
    };
    const reordered = {
      where: { options: { count: 2, enabled: true }, paths: ["a", "b"] },
      suppress: "Rule",
    };
    await writeFile(before, "```yaml\n" + yaml.dump({ suppressions: [original] }) + "```\n");
    await writeFile(after, "```yaml\n" + yaml.dump({ suppressions: [reordered] }) + "```\n");

    expect(diffSuppression(before, after)).toEqual([]);

    const changed = { ...reordered, where: { ...reordered.where, paths: ["b", "a"] } };
    await writeFile(after, "```yaml\n" + yaml.dump({ suppressions: [changed] }) + "```\n");

    expect(diffSuppression(before, after)).toEqual([changed]);
  });

  it.each(["directive", "suppressions"])(
    "warns about non-object %s entries without discarding valid suppressions",
    async (key) => {
      const warn = vi.spyOn(console, "warn").mockImplementation(() => {});
      const before = join(folder, "before.md");
      const after = join(folder, "after.md");
      const suppression = { suppress: "Rule", where: { paths: ["a", "b"] } };
      await writeFile(before, "");
      await writeFile(after, "```yaml\n" + yaml.dump({ [key]: [null, 42, suppression] }) + "```\n");

      expect(diffSuppression(before, after)).toEqual([suppression]);
      expect(warn).toHaveBeenCalledExactlyOnceWith(
        `Ignoring non-object suppression entries in ${after}`,
      );
    },
  );
});
