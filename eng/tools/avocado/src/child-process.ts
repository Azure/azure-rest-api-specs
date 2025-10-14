// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as childProcess from 'child_process'
import * as util from 'util'

const nodeJsExec = util.promisify(childProcess.exec)

export type ExecResult = {
  /**
   * Standard Output
   */
  readonly stdout: string
  /**
   * Standard Error
   */
  readonly stderr: string
}

export const exec = (command: string, options: childProcess.ExecOptionsWithStringEncoding): Promise<ExecResult> =>
  nodeJsExec(command, { maxBuffer: Infinity, ...options })
