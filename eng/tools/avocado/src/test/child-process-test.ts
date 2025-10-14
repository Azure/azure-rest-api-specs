// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as assert from 'assert'
import { describe, it } from 'vitest'
import { childProcess } from '../index.js'
import { generate } from './generate-stdout.js'

describe('child-process', () => {
  it('exec maxBuffer', async () => {
    // call `generate-stdout.print()` as a separate process.
    const { stdout } = await childProcess.exec(
      'node -e "import { print } from \'./dist/test/generate-stdout.js\'; print();"',
      {},
    )
    const expected = generate()
      .map((v) => `${v}\n`)
      .reduce((a, b) => a + b)
    assert.deepStrictEqual(expected, stdout)
  })
})
