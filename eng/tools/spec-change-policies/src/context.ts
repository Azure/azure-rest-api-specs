import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
import { findTypeSpecProjectsInChangedServices } from "@azure-tools/specs-shared/typespec-projects";
import { resolve } from "pathe";
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
  const baseCommitish = (
    await git.revparse(["--verify", "--end-of-options", `${base}^{commit}`])
  ).trim();
  const headCommitish = (
    await git.revparse(["--verify", "--end-of-options", `${head}^{commit}`])
  ).trim();
  const changes = await getChangedFilesStatuses({
    cwd: root,
    baseCommitish,
    headCommitish,
    gitOptions: ["--find-renames"],
    logger,
  });
  return { root, baseCommitish, headCommitish, changes, logger };
}

export function findChangedProjects(context: PrContext): Promise<string[]> {
  const { changes, root } = context;
  const files = [
    ...changes.additions,
    ...changes.modifications,
    ...changes.deletions,
    ...changes.renames.flatMap(({ from, to }) => [from, to]),
  ];
  return findTypeSpecProjectsInChangedServices(root, files, context.logger);
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
