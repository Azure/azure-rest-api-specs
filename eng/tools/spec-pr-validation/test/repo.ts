import { execa } from "execa";
import { mkdir, mkdtemp, realpath, rm, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import { dirname, join, resolve } from "pathe";
import { afterEach } from "vitest";

const directories: string[] = [];
afterEach(async () => {
  await Promise.all(
    directories.splice(0).map((directory) => rm(directory, { recursive: true, force: true })),
  );
});

export async function createRepo(
  initial: Record<string, string>,
  changes: Record<string, string | null>,
) {
  const root = resolve(await realpath(await mkdtemp(join(tmpdir(), "spec-pr-validation-"))));
  directories.push(root);
  const git = async (...args: string[]) =>
    execa(
      "git",
      [
        "-c",
        "user.name=Test",
        "-c",
        "user.email=test@example.com",
        "-c",
        "commit.gpgsign=false",
        ...args,
      ],
      { cwd: root },
    );
  const write = async (files: Record<string, string | null>) => {
    for (const [path, content] of Object.entries(files)) {
      const file = join(root, path);
      if (content === null) {
        await rm(file);
      } else {
        await mkdir(dirname(file), { recursive: true });
        await writeFile(file, content);
      }
    }
  };
  await git("init", "--quiet");
  await write({ "initial.txt": "", ...initial });
  await git("add", ".");
  await git("commit", "--quiet", "-m", "Base");
  await write(changes);
  await git("add", ".");
  await git("commit", "--quiet", "--allow-empty", "-m", "Head");
  return { root, git, write };
}
