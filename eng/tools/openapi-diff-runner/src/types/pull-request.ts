import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { simpleGit, SimpleGitOptions } from "simple-git";
import { Context } from "./breaking-change-check.js";

/**
 * Properties of Pull Request in Azure DevOps CI.
 */
export type PullRequestProperties = {
  /**
   * Target Branch, for example `main`.
   */
  readonly targetBranch: string;

  /**
   * Source Branch, for example `myname/newchanges`.
   */
  readonly sourceBranch: string;

  /**
   * Base Branch for breaking change detection, for example `main`.
   */
  baseBranch: string;

  /**
   * the PR repo current branch.
   */
  currentBranch: string;

  /**
   * Working folder for a cloned directory. We can't switch branches in the original Git repository
   * so we use cloned repository.
   */
  readonly workingDir: string;

  /**
   * Checkout Git branch, for example, it can be `targetBranch` or `sourceBranch`.
   */
  readonly checkout: (branch: string) => Promise<void>;
};

const sourceBranch = "source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8";

const options: SimpleGitOptions = {
  baseDir: process.cwd(),
  binary: "git",
  maxConcurrentProcesses: 1,
} as SimpleGitOptions;

/**
 * It creates a clone of the Git repository and returns properties of the Pull Request, such as
 * `targetBranch` and `sourceBranch`.
 * the `cwd` should point to the source Git repository.
 */
export const createPullRequestProperties = async (
  Context: Context,
  prefix: string,
  skipInitializeBase: boolean = false,
): Promise<PullRequestProperties | undefined> => {
  const baseBranch = Context.baseBranch;
  if (baseBranch === undefined) {
    return undefined;
  }
  const originGitRepository = simpleGit({ ...options, baseDir: Context.localSpecRepoPath });
  const branches = await originGitRepository.branch();

  if (!branches.all.includes(sourceBranch)) {
    await originGitRepository.branch([sourceBranch]);
  }
  if (!skipInitializeBase && !branches.all.includes(baseBranch)) {
    await originGitRepository.branch([baseBranch, `remotes/origin/${baseBranch}`]);
  }

  if (!branches.all.includes(Context.prTargetBranch)) {
    await originGitRepository.branch([
      Context.prTargetBranch,
      `remotes/origin/${Context.prTargetBranch}`,
    ]);
  }

  // we have to clone the repository because we need to switch branches.
  // Switching branches in the current repository can be dangerous because Avocado
  // may be running from it.
  const workingDir = path.resolve(
    path.join(process.cwd(), "..", `${prefix}-c93b354fd9c14905bb574a8834c4d69b`),
  );
  if (!existsSync(workingDir)) {
    mkdirSync(workingDir);
  }
  const workingGitRepository = simpleGit({ ...options, baseDir: workingDir });
  await workingGitRepository.init();
  await workingGitRepository.addRemote("origin", Context.localSpecRepoPath);
  await workingGitRepository.pull("origin", Context.prTargetBranch);
  await workingGitRepository.fetch("origin", `${sourceBranch}`);
  if (!skipInitializeBase) {
    await workingGitRepository.fetch("origin", `${baseBranch}`);
  }
  await workingGitRepository.checkout(Context.prTargetBranch);

  return {
    baseBranch: Context.prTargetBranch,
    targetBranch: Context.prTargetBranch,
    sourceBranch,
    workingDir,
    checkout: async function (this: any, branch: string) {
      if (this.currentBranch !== branch) {
        await workingGitRepository.checkout([branch]);
        console.log(`checkout to ${branch} in ${workingDir}`);
        this.currentBranch = branch;
      }
    },
    currentBranch: Context.prTargetBranch,
  };
};
