// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as asyncIt from '@ts-common/async-iterator'
import * as fs from '@ts-common/fs'
import * as path from 'path'
import * as cli from './cli.js'
import * as err from './errors.js'
import * as git from './git.js'

export type FileChangeKind = 'Added' | 'Deleted' | 'Modified'

export type FileChange = {
  /**
   * A kind of file change.
   */
  readonly kind: FileChangeKind
  /**
   * A path to the file.
   */
  readonly path: string
}

/**
 * Properties of Pull Request in Azure DevOps CI.
 */
export type PullRequestProperties = {
  /**
   * Target Branch, for example `master`.
   */
  readonly targetBranch: string

  /**
   * Source Branch, for example `myname/newchanges`.
   */
  readonly sourceBranch: string

  /**
   * Working folder for a cloned directory. We can't switch branches in the original Git repository
   * so we use cloned repository.
   */
  readonly workingDir: string

  /**
   * Checkout Git branch, for example, it can be `targetBranch` or `sourceBranch`.
   */
  readonly checkout: (branch: string) => Promise<void>

  /**
   * The method returns a set of changes between `targetBranch` and `sourceBranch`.
   */
  readonly diff: () => Promise<readonly FileChange[]>

  /**
   * The method returns a set of json files with structural changes between `targetBranch` and `sourceBranch`.
   */
  readonly structuralDiff: () => asyncIt.AsyncIterableEx<string>
}

const sourceBranch = 'source-b6791c5f-e0a5-49b1-9175-d7fd3e341cb8'

const parseGitFileChangeKind = (line: string) => {
  switch (line[0]) {
    case 'A':
      return 'Added'
    case 'D':
      return 'Deleted'
    default:
      return 'Modified'
  }
}

export const hasCommonRPFolder = (pathA: string, pathB: string) => {
  const regex = new RegExp(/specification\/(\w)+\//)
  const matchA = pathA.match(regex)
  const matchB = pathB.match(regex)
  return matchA !== null && matchB !== null && matchA[0] === matchB[0]
}

export const isPRRelatedError = (fileChanges: readonly FileChange[], error: err.Error): boolean => {
  if (error.code === 'MISSING_README') {
    return fileChanges.some((item) => hasCommonRPFolder(item.path, error.folderUrl))
  }
  if (error.code === 'MULTIPLE_API_VERSION') {
    return fileChanges.some((item) => hasCommonRPFolder(item.path, error.readMeUrl))
  }
  return false
}

/**
 * If the function is called in Azure DevOps CI for a Pull Request, it creates a
 * clone of the Git repository and returns properties of the Pull Request, such as
 * `targetBranch` and `sourceBranch`.
 *
 * The function returns `undefined` if it's not Azure DevOps CI for a Pull Request.
 *
 * Currently, the algorithm is recognizing Azure Dev Ops Pull Request if the `env` has
 * `SYSTEM_PULLREQUEST_TARGETBRANCH`. `cwd` should point to the source Git repository.
 */
export const createPullRequestProperties = async (config: cli.Config): Promise<PullRequestProperties | undefined> => {
  const targetBranch = config.env.SYSTEM_PULLREQUEST_TARGETBRANCH
  if (targetBranch === undefined) {
    return undefined
  }
  const originGitRepository = git.repository(config.cwd)
  await originGitRepository({ branch: [sourceBranch] })
  await originGitRepository({
    branch: [targetBranch, `remotes/origin/${targetBranch}`],
  })

  // we have to clone the repository because we need to switch branches.
  // Switching branches in the current repository can be dangerous because Avocado
  // may be running from it.
  const workingDir = path.resolve(path.join(config.cwd, '..', 'c93b354fd9c14905bb574a8834c4d69b'))
  await fs.mkdir(workingDir)
  const workingGitRepository = git.repository(workingDir)
  await workingGitRepository({ clone: [config.cwd, '.'] })
  const diff: () => Promise<readonly FileChange[]> = async () => {
    const { stdout } = await originGitRepository({
      diff: ['--name-status', '--no-renames', targetBranch, sourceBranch],
    })

    return stdout
      .split('\n')
      .filter((v) => v !== '')
      .map((line) => ({
        kind: parseGitFileChangeKind(line),
        path: line.substr(2),
      }))
  }

  const getJsonString = async (filePath: string, branch: string) => {
    try {
      const { stdout } = await originGitRepository({
        show: [`${branch}:${filePath}`],
      })
      return JSON.stringify(JSON.parse(stdout))
    } catch {
      return filePath
    }
  }

  return {
    targetBranch,
    sourceBranch,
    workingDir,
    checkout: async (branch: string) => {
      await workingGitRepository({ checkout: [branch] })
    },
    diff,
    structuralDiff: (): asyncIt.AsyncIterableEx<string> =>
      asyncIt
        .fromPromise(diff())
        .map((x) => x.path)
        .filter(
          async (filePath) =>
            !filePath.endsWith('.json') ||
            (await getJsonString(filePath, sourceBranch)) !== (await getJsonString(filePath, targetBranch)),
        ),
  }
}
