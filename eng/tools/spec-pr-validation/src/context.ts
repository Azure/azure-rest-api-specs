import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { glob, stat } from "node:fs/promises";
import { dirname, resolve } from "pathe";
import { simpleGit } from "simple-git";

export interface PrContext {
  readonly root: string;
  readonly baseCommitish: string;
  readonly headCommitish: string;
  readonly changes: Awaited<ReturnType<typeof getChangedFilesStatuses>>;
  readonly logger: ILogger;
}

export async function createContext(
  cwd: string,
  base: string,
  head: string,
  logger: ILogger,
): Promise<PrContext> {
  const root = resolve(await getRootFolder(cwd));
  const git = simpleGit(root);
  const [baseCommitish, headCommitish] = await Promise.all(
    [base, head].map(async (revision) =>
      (await git.revparse(["--verify", "--end-of-options", `${revision}^{commit}`])).trim(),
    ),
  );
  const changes = await getChangedFilesStatuses({
    cwd: root,
    baseCommitish,
    headCommitish,
    gitOptions: ["--find-renames"],
    logger,
  });
  return { root, baseCommitish, headCommitish, changes, logger };
}

export async function findChangedProjects(context: PrContext): Promise<string[]> {
  const { changes, root } = context;
  const files = [
    ...changes.additions,
    ...changes.modifications,
    ...changes.deletions,
    ...changes.renames.flatMap(({ from, to }) => [from, to]),
  ];
  const services = new Set(
    files.flatMap((file) => {
      const match = /^specification\/[^/]+\//.exec(file);
      return match ? [match[0]] : [];
    }),
  );
  const projects = new Set<string>();
  for (const service of [...services].sort()) {
    const folder = resolve(root, service);
    try {
      if (!(await stat(folder)).isDirectory()) continue;
    } catch (error) {
      if (error instanceof Error && "code" in error && error.code === "ENOENT") continue;
      throw error;
    }
    for await (const file of glob("**/tspconfig.*", {
      cwd: folder,
      exclude: ["**/node_modules/**"],
    })) {
      if ((await stat(resolve(folder, file))).isFile()) {
        projects.add(resolve(folder, dirname(file)));
      }
    }
  }
  return [...projects].sort();
}

export async function readFileAtCommit(
  context: PrContext,
  commitish: string,
  repositoryPath: string,
): Promise<string | undefined> {
  const git = simpleGit(context.root);
  const paths = await git.raw(["ls-tree", "-z", "--name-only", commitish, "--", repositoryPath]);
  if (!paths.split("\0").includes(repositoryPath)) return undefined;
  return git.show([`${commitish}:${repositoryPath}`]);
}
