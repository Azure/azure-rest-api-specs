import { existsSync, mkdirSync } from "node:fs";
import path from "node:path";
import { simpleGit } from "simple-git";
import { logError, logMessage } from "../log.js";
import { Context } from "../types/breaking-change.js";

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
  readonly tempRepoFolder: string;

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
  // Helper function to safely create a branch if it doesn't exist
  const createBranchIfNotExists = async (branchName: string, startPoint?: string) => {
    try {
      // Get fresh branch list to avoid stale data
      const currentBranches = await originGitRepository.branch();
      if (!currentBranches.all.includes(branchName)) {
        const branchArgs = startPoint ? [branchName, startPoint] : [branchName];
        await originGitRepository.branch(branchArgs);
        logMessage(`Created branch ${branchName}${startPoint ? ` from ${startPoint}` : ""}`);
      } else {
        logMessage(`Branch ${branchName} already exists, skipping creation`);
      }
    } catch (error: any) {
      // If the error is about branch already existing, that's fine - continue
      if (
        error.message?.includes("already exists") ||
        error.message?.includes("fatal: a branch named")
      ) {
        logMessage(`Branch ${branchName} already exists (caught during creation), continuing`);
      } else {
        logError(`Failed to create branch ${branchName}: ${error.message}`);
        throw error;
      }
    }
  };

  // Create branches if they don't exist
  await createBranchIfNotExists(sourceBranch);

  if (!skipInitializeBase) {
    await createBranchIfNotExists(baseBranch, `remotes/origin/${baseBranch}`);
  }

  await createBranchIfNotExists(context.prTargetBranch, `remotes/origin/${context.prTargetBranch}`);

  // we have to clone the repository because we need to switch branches.
  // Switching branches in the current repository can be dangerous because Avocado
  // may be running from it.
  const tempRepoFolder = path.resolve(
    path.join(process.cwd(), "..", `${prefix}-c93b354fd9c14905bb574a8834c4d69b`),
  );
  if (!existsSync(tempRepoFolder)) {
    mkdirSync(tempRepoFolder);
  }
  const workingGitRepository = simpleGit({ ...options, baseDir: tempRepoFolder });
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
  logMessage(`checking out target branch ${context.prTargetBranch} in ${tempRepoFolder}`);
  await workingGitRepository.checkout(context.prTargetBranch);
  logMessage(`Current working directory: ${process.cwd()}`);

  return {
    baseBranch: context.prTargetBranch,
    targetBranch: context.prTargetBranch,
    sourceBranch,
    tempRepoFolder,
    checkout: async function (this: any, branch: string) {
      if (this.currentBranch !== branch) {
        await workingGitRepository.checkout([branch]);
        logMessage(
          `checkout to ${branch} in ${tempRepoFolder}\n Current working directory: ${process.cwd()}`,
        );
        this.currentBranch = branch;
      }
    },
    currentBranch: context.prTargetBranch,
  };
};
