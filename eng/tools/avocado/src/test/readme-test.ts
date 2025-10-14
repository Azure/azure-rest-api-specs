// Copyright (c) 2022 Microsoft Corporation
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
import { parse } from '@ts-common/commonmark-to-markdown'
import * as assert from 'assert'
import * as fs from 'fs'
import { describe, it } from 'vitest'
import * as readme from '../readme.js'

describe('readme test', () => {
  it('getTagsToSwaggerFilesMapping', () => {
    let readmePath = 'src/test/readmes/signalr.md'
    let ret = readme.getTagsToSwaggerFilesMapping(readmePath)
    let expectedKeys = [
      'package-2022-08-01-preview',
      'package-2022-02-01',
      'package-2021-09-01-preview',
      'package-2021-10-01',
      'package-2021-06-01-preview',
      'package-2021-04-01-preview',
      'package-2020-07-01-preview',
      'package-2020-05-01',
      'package-2018-10-01',
      'package-2018-03-01-preview',
    ]
    assert.deepStrictEqual(Array.from(ret.keys()), expectedKeys)

    readmePath = 'src/test/readmes/cognitiveservice-language.md'
    ret = readme.getTagsToSwaggerFilesMapping(readmePath)
    expectedKeys = [
      'release_2022_10_01_preview',
      'release_2022_07_01_preview',
      'release_2022_05_15_preview',
      'release_2022_05_01',
      'release_2022_03_01_preview',
      'release_2022_02_01_preview',
      'release_2021_11_01_preview',
      'release_2021_10_01',
      'release_2021_07_15_preview',
      'release_2021_05_01_preview',
    ]
    assert.deepStrictEqual(Array.from(ret.keys()), expectedKeys)
  })

  it('Test get default tag', () => {
    const readmePath = 'src/test/readmes/signalr.md'
    const readmeContent = fs.readFileSync(readmePath, 'utf-8')
    const readmeFile = parse(readmeContent)
    const defaultTag = readme.getDefaultTag(readmeFile.markDown)
    assert.deepStrictEqual(defaultTag, 'package-2022-08-01-preview')
  })

  it('Test sort api version with yyyy-mm-dd format', () => {
    const versions = ['2021-03-01', '2020-05-01', '2021-09-01', '2021-06-01']
    const ret = readme.sortByApiVersion(versions)
    const expected = ['2020-05-01', '2021-03-01', '2021-06-01', '2021-09-01']
    assert.deepStrictEqual(ret, expected)
  })

  it('Test sort api version with yyyy_mm_dd format for cognitive service', () => {
    const input = [
      'release_2021_05_01_preview',
      'release_2022_10_01_preview',
      'release_2022_07_01_preview',
      'release_2022_05_15_preview',
      'release_2022_05_01',
      'release_2022_03_01_preview',
      'release_2021_07_15_preview',
      'release_2022_02_01_preview',
      'release_2021_11_01_preview',
      'release_2021_10_01',
    ]
    const ret = readme.sortByApiVersion(input)
    const expected = [
      'release_2021_05_01_preview',
      'release_2021_07_15_preview',
      'release_2021_10_01',
      'release_2021_11_01_preview',
      'release_2022_02_01_preview',
      'release_2022_03_01_preview',
      'release_2022_05_01',
      'release_2022_05_15_preview',
      'release_2022_07_01_preview',
      'release_2022_10_01_preview',
    ]
    assert.deepStrictEqual(ret, expected)
  })

  it('Test get latest tag', () => {
    const input = [
      'package-2022-08-01-preview',
      'package-2022-02-01',
      'package-2021-09-01-preview',
      'package-2021-10-01',
      'package-2021-06-01-preview',
      'package-2021-04-01-preview',
      'package-2020-07-01-preview',
      'package-2020-05-01',
      'package-2018-10-01',
      'package-2018-03-01-preview',
    ]

    let ret = readme.getLatestTag(input, 'preview')
    assert.deepStrictEqual(ret, 'package-2022-08-01-preview')

    ret = readme.getLatestTag(input, 'stable')
    assert.deepStrictEqual(ret, 'package-2022-02-01')
  })

  it('Test get latest tag for cognitiveservice', () => {
    const input = [
      'release_2022_10_01_preview',
      'release_2022_07_01_preview',
      'release_2022_05_15_preview',
      'release_2022_05_01',
      'release_2022_03_01_preview',
      'release_2022_02_01_preview',
      'release_2021_11_01_preview',
      'release_2021_10_01',
      'release_2021_07_15_preview',
      'release_2021_05_01_preview',
    ]
    let ret = readme.getLatestTag(input, 'preview')
    assert.deepStrictEqual(ret, 'release_2022_10_01_preview')

    ret = readme.getLatestTag(input, 'stable')
    assert.deepStrictEqual(ret, 'release_2022_05_01')
  })

  it('Test get latest tag if the day is missing', () => {
    const input = [
      'package-2022-08-01-preview',
      'package-2022-02-01',
      'package-2021-09-01-preview',
      'package-2021-10-01',
      'package-2021-06-01-preview',
      'package-2021-04-01-preview',
      'package-2020-07-01-preview',
      'package-2020-05-01',
      'package-2018-10-01',
      'package-2018-03-01-preview',
      'package-2022-12',
      'package-2022-11-preview',
    ]

    let ret = readme.getLatestTag(input, 'preview')
    assert.deepStrictEqual(ret, 'package-2022-11-preview')

    ret = readme.getLatestTag(input, 'stable')
    assert.deepStrictEqual(ret, 'package-2022-12')
  })
})
