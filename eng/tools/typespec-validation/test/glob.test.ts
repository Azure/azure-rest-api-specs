import { mkdir, mkdtemp, rm, symlink, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join, normalize, sep } from "node:path";
import { afterEach, beforeEach, describe, expect, it } from "vitest";
import { globFiles } from "../src/glob.ts";

describe("globFiles", () => {
  let folder: string;

  beforeEach(async () => {
    folder = await mkdtemp(join(tmpdir(), "tsv-glob-"));
  });

  afterEach(async () => {
    await rm(folder, { recursive: true, force: true });
  });

  it("finds nested files, excluding matching directories and hidden entries", async () => {
    await mkdir(join(folder, "nested", "directory.tsp"), { recursive: true });
    await mkdir(join(folder, ".hidden"));
    for (const file of [
      "main.tsp",
      "nested/model.tsp",
      "nested/directory.tsp/inside.tsp",
      ".hidden.tsp",
      ".hidden/ignored.tsp",
      "other.json",
    ]) {
      await writeFile(join(folder, file), "");
    }

    expect((await globFiles("**/*.tsp", { cwd: folder })).map(normalize).sort()).toEqual(
      ["main.tsp", "nested/model.tsp", "nested/directory.tsp/inside.tsp"].map(normalize).sort(),
    );
  });

  it("checks config filenames only in the requested folder", async () => {
    await mkdir(join(folder, "tspconfig.yml"));
    await mkdir(join(folder, "nested"));
    for (const file of ["tspconfig.yaml", "bad-tspconfig.json", "nested/tspconfig.yml"]) {
      await writeFile(join(folder, file), "");
    }

    const pattern = join(folder, "**tspconfig.*").split(sep).join("/");
    expect((await globFiles([pattern])).map(normalize).sort()).toEqual(
      [join(folder, "tspconfig.yaml"), join(folder, "bad-tspconfig.json")].sort(),
    );
  });

  it("excludes examples while retaining matching swagger files in every version", async () => {
    for (const directory of [
      "stable/v1",
      "preview/v2",
      "stable/v1/examples",
      "directory/foo.json",
    ]) {
      await mkdir(join(folder, directory), { recursive: true });
    }
    for (const file of [
      "stable/v1/foo.json",
      "preview/v2/foo.json",
      "stable/v1/examples/foo.json",
      "stable/v1/bar.json",
    ]) {
      await writeFile(join(folder, file), "{}");
    }

    const pattern = join(folder, "**", "foo.json").split(sep).join("/");
    expect(
      (await globFiles(pattern, { exclude: ["**/examples/**"] })).map(normalize).sort(),
    ).toEqual([join(folder, "stable/v1/foo.json"), join(folder, "preview/v2/foo.json")].sort());
  });

  it.skipIf(process.platform === "win32")(
    "includes file symlinks without traversing directory symlinks",
    async () => {
      await mkdir(join(folder, "source"));
      await writeFile(join(folder, "source", "model.tsp"), "");
      await symlink("source/model.tsp", join(folder, "link.tsp"));
      await symlink("source", join(folder, "linked"));

      expect((await globFiles("**/*.tsp", { cwd: folder })).map(normalize).sort()).toEqual(
        ["link.tsp", "source/model.tsp"].map(normalize).sort(),
      );
    },
  );
});
