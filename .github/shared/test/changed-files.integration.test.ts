import { copyFile, mkdir, mkdtemp, rename, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { simpleGit } from "simple-git";
import { afterEach, beforeEach, expect, it } from "vitest";
import { getChangedFiles, getChangedFilesStatuses } from "../src/changed-files.ts";

let root: string;

beforeEach(async () => {
  root = await mkdtemp(join(tmpdir(), "changed-files-"));
  await mkdir(join(root, "specification"));
  await simpleGit(root)
    .init()
    .addConfig("user.name", "Test")
    .addConfig("user.email", "test@example.com")
    .addConfig("commit.gpgsign", "false");
});

afterEach(async () => {
  await rm(root, { recursive: true, force: true });
});

it.each(["true", "false"])(
  "reads real Git paths and statuses independently of core.quotepath=%s",
  async (quotePath) => {
    const git = simpleGit(root);
    await git.addConfig("core.quotepath", quotePath);
    const modified = "specification/caf\u00e9.json";
    const deleted = "specification/deleted.json";
    const from = "specification/rename-from.json";
    const to = "specification/renamed \u00e9.json";
    const copySource = "specification/copy-source.json";
    const copyTarget = "specification/copied \u00e9.json";
    for (const file of [modified, deleted, from, copySource]) {
      await writeFile(join(root, file), `Original unique content of ${file}\n`);
    }
    await git.add(".").commit("Base");

    await writeFile(join(root, modified), "Updated content\n");
    await rm(join(root, deleted));
    await rename(join(root, from), join(root, to));
    await copyFile(join(root, copySource), join(root, copyTarget));
    const names = [" leading.json", "space in name.json"];
    if (process.platform !== "win32") {
      names.push(
        "trailing.json ",
        "tab\tname.json",
        "line\nname.json",
        'quote".json',
        "back\\slash.json",
      );
    }
    const added = names.map((name) => `specification/${name}`);
    for (const file of added) {
      await writeFile(join(root, file), `New unique content of ${file}\n`);
    }
    await writeFile(join(root, "outside.txt"), "Excluded by the path filter\n");
    await git.add(".").commit("Changes");

    const paths = ["specification"];
    const options = { cwd: root, paths };
    const files = await getChangedFiles({ ...options, gitOptions: ["--no-renames"] });
    expect(files.toSorted()).toEqual([modified, deleted, from, to, copyTarget, ...added].sort());

    const statuses = await getChangedFilesStatuses({
      ...options,
      gitOptions: ["--find-renames", "--find-copies-harder"],
    });
    expect(statuses).toEqual({
      additions: [...added, copyTarget].sort(),
      modifications: [modified],
      deletions: [deleted],
      renames: [{ from, to }],
      total: added.length + 4,
    });
    expect(paths).toEqual(["specification"]);
    expect((await git.getConfig("core.quotepath")).value).toBe(quotePath);

    await expect(getChangedFiles({ ...options, baseCommitish: "HEAD" })).resolves.toEqual([]);
    await expect(getChangedFilesStatuses({ ...options, baseCommitish: "HEAD" })).resolves.toEqual({
      additions: [],
      modifications: [],
      deletions: [],
      renames: [],
      total: 0,
    });
  },
);
