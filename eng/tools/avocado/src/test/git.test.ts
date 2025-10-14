// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import { describe, it } from 'vitest'
import { git } from '../index.js'
import * as tmpDir from './tmp-dir.js'

describe('git', () => {
  it('git should not ask for credentials', async () => {
    const dir = await tmpDir.create('git-credentials')
    const repo = git.repository(dir)
    try {
      await repo({ clone: ['https://github.com/Azure/fake1b68e2d1771e4f2b9fc8ea287e46cd56', '.'] })
    } catch {
      // as expected
    }
  })
})
