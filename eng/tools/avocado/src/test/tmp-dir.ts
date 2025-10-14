// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as pfs from '@ts-common/fs'
import * as path from 'path'

export const getTmpRoot = () => path.resolve(path.join('..', 'avocado-tmp'))
/**
 * Create a temporary directory for a unit test.
 *
 * @param name a name of the unit test.
 */
export const create = async (name: string) => {
  const tmpRoot = getTmpRoot()
  if (!(await pfs.exists(tmpRoot))) {
    await pfs.mkdir(tmpRoot)
  }
  const tmp = path.join(tmpRoot, name)

  if (await pfs.exists(tmp)) {
    await pfs.recursiveRmdir(tmp)
  }

  await pfs.mkdir(tmp)
  return tmp
}
