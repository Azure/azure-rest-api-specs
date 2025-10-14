// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as stringMap from '@ts-common/string-map'
import * as childProcess from './child-process.js'

export type GenericCommand = stringMap.StringMap<readonly string[]>

export type Command =
  | { readonly config: readonly ['user.email' | 'user.name', string] }
  | { readonly init: readonly [] }
  | { readonly add: readonly [string] }
  | { readonly commit: readonly ['-m', string, '--no-gpg-sign'] }
  | { readonly checkout: readonly ['-b', string] | readonly [string] }
  | { readonly branch: readonly [string] | readonly [string, string] }
  | { readonly remote: readonly ['add', string, string] }
  | { readonly clone: readonly [string, string] }
  | { readonly diff: readonly ['--name-status' | '--name-only', '--no-renames', string, string] }
  | { readonly show: readonly [string] }

export type RunCommand = (command: Command) => Promise<childProcess.ExecResult>

export const repository =
  (repositoryPath: string): RunCommand =>
  async (command: Command) => {
    const g: GenericCommand = command
    const [cmd, args] = stringMap.entries(g).toArray()[0]
    const options = {
      cwd: repositoryPath,
      env: {
        // switch off Git interactive login window pop up.
        GCM_INTERACTIVE: 'never',
        // switch off Git terminal prompt.
        GIT_TERMINAL_PROMPT: '0',
      },
    }
    return childProcess.exec(`git ${cmd} ${args.join(' ')}`, options)
  }
