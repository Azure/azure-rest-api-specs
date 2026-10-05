import { execFileSync } from "node:child_process";
import { mkdtemp, mkdir, readFile, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { afterEach, describe, expect, it } from "vitest";
import { preparePrerelease, prereleaseVersion } from "../library-release.ts";

const name = "@azure-tools/typespec-foundry-core";
const folders: string[] = [];

afterEach(async () => {
  await Promise.all(folders.splice(0).map((folder) => rm(folder, { recursive: true })));
});

describe("automatic library prereleases", () => {
  it.each(["0.1.0-beta.1", "0.1.0", "0.1.0+build"])(
    "derives a development version from %s and the Git change count",
    (version) => {
      expect(prereleaseVersion(version, "12")).toBe("0.1.0-dev.12");
    },
  );

  it("counts first-parent library changes and keeps reruns stable", async () => {
    const root = await mkdtemp(join(tmpdir(), "library-release-"));
    folders.push(root);
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
    git("init", "--quiet", "--initial-branch=main");
    git("add", ".");
    git("commit", "--quiet", "-m", "Add library");

    await preparePrerelease(library);
    const first = await readFile(manifestPath, "utf8");
    expect(JSON.parse(first)).toMatchObject({
      name,
      version: "0.1.0-dev.1",
      exports: "./index.js",
    });
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
    expect(JSON.parse(await readFile(manifestPath, "utf8"))).toMatchObject({
      version: "0.1.0-dev.2",
    });

    await writeFile(manifestPath, manifest);
    git("checkout", "--quiet", "-b", "library-feature");
    for (const change of ["First feature change", "Second feature change"]) {
      await writeFile(join(library, "README.md"), change);
      git("add", "libs");
      git("commit", "--quiet", "-m", change);
    }
    git("checkout", "--quiet", "main");
    git("merge", "--quiet", "--no-ff", "library-feature", "-m", "Merge library changes");
    await preparePrerelease(library);
    expect(JSON.parse(await readFile(manifestPath, "utf8"))).toMatchObject({
      version: "0.1.0-dev.3",
    });
  });
});
