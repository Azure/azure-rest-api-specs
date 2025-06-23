import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { simpleGit } from "simple-git";
import { Context } from "../types/breaking-change.js";
import { logError, logMessage } from "../log.js";

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

const options = {
  baseDir: process.cwd(),
  binary: "git",
  maxConcurrentProcesses: 1,
};

/**
 * It creates a clone of the Git repository and returns properties of the Pull Request, such as
 * `targetBranch` and `sourceBranch`.
 * the `cwd` should point to the source Git repository.
 */
export const createPullRequestProperties = async (
  context: Context,
  prefix: string,
  skipInitializeBase: boolean = false,
): Promise<PullRequestProperties | undefined> => {
  const baseBranch = context.baseBranch;
  if (baseBranch === undefined) {
    return undefined;
  }
  const originGitRepository = simpleGit({ ...options, baseDir: context.localSpecRepoPath });
  const branches = await originGitRepository.branch();

  try {
    if (!branches.all.includes(sourceBranch)) {
      await originGitRepository.branch([sourceBranch]);
      logMessage(`finish creating source branch ${sourceBranch}`);
    }
    if (!skipInitializeBase && !branches.all.includes(baseBranch)) {
      await originGitRepository.branch([baseBranch, `remotes/origin/${baseBranch}`]);
      logMessage(`finish creating base branch ${baseBranch}`);
    }

    if (!branches.all.includes(context.prTargetBranch)) {
      await originGitRepository.branch([
        context.prTargetBranch,
        `remotes/origin/${context.prTargetBranch}`,
      ]);
      logMessage(`finish creating target branch ${context.prTargetBranch}`);
    }
  } catch (error: any) {
    logError(`Failed to create branch: ${error.message}`);
    throw error;
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

  // Check if origin remote already exists, if not add it
  try {
    const remotes = await workingGitRepository.getRemotes();
    const originExists = remotes.some((remote: any) => remote.name === "origin");
    if (!originExists) {
      await workingGitRepository.addRemote("origin", context.localSpecRepoPath);
    }
  } catch (error) {
    // If getting remotes fails, try to add origin anyway and catch the error
    try {
      await workingGitRepository.addRemote("origin", context.localSpecRepoPath);
    } catch (addRemoteError: any) {
      // Ignore the error if remote already exists
      if (!addRemoteError?.message?.includes("remote origin already exists")) {
        throw addRemoteError;
      }
    }
  }
  await workingGitRepository.pull("origin", context.prTargetBranch);
  await workingGitRepository.fetch("origin", `${sourceBranch}`);
  if (!skipInitializeBase) {
    await workingGitRepository.fetch("origin", `${baseBranch}`);
  }
  await workingGitRepository.checkout(context.prTargetBranch);

  return {
    baseBranch: context.prTargetBranch,
    targetBranch: context.prTargetBranch,
    sourceBranch,
    workingDir,
    checkout: async function (this: any, branch: string) {
      if (this.currentBranch !== branch) {
        await workingGitRepository.checkout([branch]);
        logMessage(`checkout to ${branch} in ${workingDir}`);
        this.currentBranch = branch;
      }
    },
    currentBranch: context.prTargetBranch,
  };
};
