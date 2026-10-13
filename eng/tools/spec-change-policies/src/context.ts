import { getChangedFilesStatuses } from "@azure-tools/specs-shared/changed-files";
import type { ILogger } from "@azure-tools/specs-shared/logger";
import { getRootFolder } from "@azure-tools/specs-shared/simple-git";
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
