// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as assert from 'assert'
import * as path from 'path'
import { describe, it } from 'vitest'
import * as error from '../errors.js'
import * as avocado from '../index.js'

describe('avocado', () => {
  it('avocado validation folder', async () => {
    const r = await avocado
      .avocado({ cwd: 'src/test/no_file_found', env: {}, args: { dir: 'specification' } })
      .toArray()
    const expected = [
      {
        code: 'NO_JSON_FILE_FOUND',
        message: 'The JSON file is not found but it is referenced from the readme file.',
        readMeUrl: path.resolve('src/test/no_file_found/specification/readme.md'),
        level: 'Error',
        path: path.resolve('src/test/no_file_found/specification/specs/some.json'),
        jsonUrl: path.resolve('src/test/no_file_found/specification/specs/some.json'),
      },
    ]
    assert.deepStrictEqual(r, expected)
  })
  it('not autorest markdown', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/not_autorest_markdown', env: {} }).toArray()
    const expected = [
      {
        code: 'NOT_AUTOREST_MARKDOWN',
        message: 'The `readme.md` is not an AutoRest markdown file.',
        readMeUrl: path.resolve('src/test/not_autorest_markdown/specification/readme.md'),
        path: path.resolve('src/test/not_autorest_markdown/specification/readme.md'),
        helpUrl: 'http://azure.github.io/autorest/user/literate-file-formats/configuration.html#the-file-format',
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, expected)
  })

  it('no file found', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/no_file_found', env: {} }).toArray()
    const r0 = r[0]
    if (r0.code === 'JSON_PARSE') {
      assert.fail()
    }
    const e = [
      {
        code: 'NO_JSON_FILE_FOUND',
        message: r0.message,
        readMeUrl: path.resolve('src/test/no_file_found/specification/readme.md'),
        jsonUrl: path.resolve('src/test/no_file_found/specification/specs/some.json'),
        path: path.resolve('src/test/no_file_found/specification/specs/some.json'),
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, e)
  })

  it('unreferenced example file', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/unreferenced_example', env: {} }).toArray()
    const e: ReadonlyArray<error.Error> = [
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The example JSON file is not referenced from the swagger file.',
        readMeUrl: path.resolve('src/test/unreferenced_example/specification/testRP/readme.md'),
        jsonUrl: path.resolve('src/test/unreferenced_example/specification/testRP/specs/examples/orphan_example.json'),
        path: path.resolve('src/test/unreferenced_example/specification/testRP/specs/examples/orphan_example.json'),
        level: 'Error',
      },
    ]
    assert.deepStrictEqual(r, e)
  })

  it('unreferenced spec file', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/unreferenced_spec', env: {} }).toArray()
    const e = [
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The swagger JSON file is not referenced from the readme file.',
        readMeUrl: path.resolve('src/test/unreferenced_spec/specification/testRP/readme.md'),
        jsonUrl: path.resolve('src/test/unreferenced_spec/specification/testRP/specs/some.json'),
        path: path.resolve('src/test/unreferenced_spec/specification/testRP/specs/some.json'),
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, e)
  })

  it('unreferenced spec file with referenced examples', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/unreferenced_spec_with_examples', env: {} }).toArray()
    const e = [
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The example JSON file is not referenced from the swagger file.',
        readMeUrl: path.resolve('src/test/unreferenced_spec_with_examples/specification/testRP/readme.md'),
        jsonUrl: path.resolve(
          'src/test/unreferenced_spec_with_examples/specification/testRP/specs/examples/referenced_example.json',
        ),
        path: path.resolve(
          'src/test/unreferenced_spec_with_examples/specification/testRP/specs/examples/referenced_example.json',
        ),
        level: 'Error',
      },
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The swagger JSON file is not referenced from the readme file.',
        readMeUrl: path.resolve('src/test/unreferenced_spec_with_examples/specification/testRP/readme.md'),
        jsonUrl: path.resolve('src/test/unreferenced_spec_with_examples/specification/testRP/specs/orphan_spec.json'),
        path: path.resolve('src/test/unreferenced_spec_with_examples/specification/testRP/specs/orphan_spec.json'),
        level: 'Error',
      },
    ] as const

    assert.deepStrictEqual(r, e)
  })

  it('invalid JSON', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/invalid_json_trailing_comma', env: {} }).toArray()
    assert.deepStrictEqual(r, [
      {
        code: 'JSON_PARSE',
        message: 'The file is not a valid JSON file.',
        path: path.resolve('src/test/invalid_json_trailing_comma/specification/testRP/specs/some.json'),
        error: {
          code: 'unexpected token',
          kind: 'structure',
          message: 'unexpected token, token: }, line: 3, column: 1',
          position: {
            column: 1,
            line: 3,
          },
          token: '}',
          url: path.resolve('src/test/invalid_json_trailing_comma/specification/testRP/specs/some.json'),
        },
        level: 'Error',
      },
    ])
  })

  it('invalid JSON with BOM', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/invalid_json_with_bom', env: {} }).toArray()
    assert.deepStrictEqual(r, [
      {
        code: 'JSON_PARSE',
        message: 'The file is not a valid JSON file.',
        path: path.resolve('src/test/invalid_json_with_bom/specification/testRP/specs/some.json'),
        error: {
          code: 'invalid symbol',
          kind: 'syntax',
          message: 'invalid symbol, token: \uFEFF, line: 1, column: 1',
          position: {
            column: 1,
            line: 1,
          },
          token: '\uFEFF',
          url: path.resolve('src/test/invalid_json_with_bom/specification/testRP/specs/some.json'),
        },
        level: 'Error',
      },
    ])
  })

  it('invalid ref', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/invalid_ref', env: {} }).toArray()
    const expected = [
      {
        code: 'NO_JSON_FILE_FOUND',
        message: r[0].message,
        jsonUrl: path.resolve('src/test/invalid_ref/specification/testRP/specs/a.json'),
        path: path.resolve('src/test/invalid_ref/specification/testRP/specs/a.json'),
        readMeUrl: path.resolve('src/test/invalid_ref/specification/testRP/readme.md'),
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, expected)
  })

  it('backslash', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/backslash', env: {} }).toArray()
    const expected = [] as const
    assert.deepStrictEqual(r, expected)
  })

  it('diamond dependencies', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/diamond_dependencies', env: {} }).toArray()
    // we expect only one error for `common.json` even if the file is referenced multiple times.
    const expected = [
      {
        code: 'JSON_PARSE',
        path: path.resolve('src/test/diamond_dependencies/specification/testRP/specs/common.json'),
        error: {
          code: 'unexpected end of file',
          kind: 'structure',
          message: 'unexpected end of file, token: , line: 1, column: 1',
          position: { column: 1, line: 1 },
          token: '',
          url: path.resolve('src/test/diamond_dependencies/specification/testRP/specs/common.json'),
        },
        message: 'The file is not a valid JSON file.',
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, expected)
  })

  it('circular reference', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/circular_reference', env: {} }).toArray()
    const expected = [
      {
        code: 'CIRCULAR_REFERENCE',
        message: 'The JSON file has a circular reference.',
        readMeUrl: path.resolve('src/test/circular_reference/specification/testRP/readme.md'),
        jsonUrl: path.resolve('src/test/circular_reference/specification/testRP/specs/c.json'),
        path: path.resolve('src/test/circular_reference/specification/testRP/specs/c.json'),
        level: 'Warning',
      },
    ] as const
    assert.deepStrictEqual(r, expected)
  })

  it('analyze globally', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/referenced_common_spec', env: {} }).toArray()
    const expected = [
      {
        code: 'NO_JSON_FILE_FOUND',
        message: 'The JSON file is not found but it is referenced from the readme file.',
        readMeUrl: path.resolve('src/test/referenced_common_spec/specification/service/readme.md'),
        jsonUrl: path.resolve('src/test/referenced_common_spec/specification/common/specs/no_such_file.json'),
        path: path.resolve('src/test/referenced_common_spec/specification/common/specs/no_such_file.json'),
        level: 'Error',
      },
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The swagger JSON file is not referenced from the readme file.',
        readMeUrl: path.resolve('src/test/referenced_common_spec/specification/common/readme.md'),
        jsonUrl: path.resolve('src/test/referenced_common_spec/specification/common/specs/orphan.json'),
        path: path.resolve('src/test/referenced_common_spec/specification/common/specs/orphan.json'),
        level: 'Error',
      },
    ] as const
    assert.deepStrictEqual(r, expected)
  })

  it('ignore example file $ref', async () => {
    // Test distinguishing between example file and swagger file and ignore $ref in example file
    const r = await avocado.avocado({ cwd: 'src/test/example_file_ignored_reference', env: {} }).toArray()
    assert.strictEqual(r.length, 0)
  })

  it('parse $(this-folder)', async () => {
    // Test $(this-folder) feature. this-folder will be parsed to current directory.
    const r = await avocado.avocado({ cwd: 'src/test/parse_this_folder', env: {} }).toArray()
    assert.strictEqual(r.length, 0)
  })

  it('no readme file', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/no_readme', env: {} }).toArray()
    const expected = [
      {
        level: 'Error',
        code: 'MISSING_README',
        message: 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.',
        folderUrl: path.resolve('src/test/no_readme/specification/resource-provider-A/resource-manager'),
        path: path.resolve('src/test/no_readme/specification/resource-provider-A/resource-manager'),
      },
    ] as const
    assert.deepStrictEqual(expected, r)
  })

  it('api version inconsistent', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/api_version_inconsistent', env: {} }).toArray()
    const expected = [
      {
        code: 'INCONSISTENT_API_VERSION',
        level: 'Error',
        message: 'The API version of the swagger is inconsistent with its file path.',
        jsonUrl: path.resolve('src/test/api_version_inconsistent/specification/testRP/specs/2020-05-01/b.json'),
        path: path.resolve('src/test/api_version_inconsistent/specification/testRP/specs/2020-05-01/b.json'),
        readMeUrl: path.resolve('src/test/api_version_inconsistent/specification/testRP/readme.md'),
      },
    ] as const
    assert.deepStrictEqual(expected, r)
  })

  it('multi api version in default tag', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/multi_api_version', env: {} }).toArray()
    const expected = [
      {
        code: 'MULTIPLE_API_VERSION',
        level: 'Error',
        message: 'The default tag contains multiple API versions swaggers.',
        tag: 'package-2019-01-01',
        readMeUrl: path.resolve('src/test/multi_api_version/specification/testRP/readme.md'),
        path: path.resolve('src/test/multi_api_version/specification/testRP/readme.md'),
      },
    ] as const
    assert.deepStrictEqual(expected, r)
  })

  it('invalid file location', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/invalid_file_location', env: {} }).toArray()
    const expected = [
      {
        code: 'INVALID_FILE_LOCATION',
        level: 'Warning',
        message:
          'The management plane swagger JSON file does not match its folder path. Make sure management plane swagger located in resource-manager folder',
        jsonUrl: path.resolve('src/test/invalid_file_location/specification/testRP/specs/2020-05-01/b.json'),
        path: path.resolve('src/test/invalid_file_location/specification/testRP/specs/2020-05-01/b.json'),
        readMeUrl: path.resolve('src/test/invalid_file_location/specification/testRP/readme.md'),
      },
    ] as const
    assert.deepStrictEqual(expected, r)
  })

  it('avocado with exclude option', async () => {
    const r = await avocado
      .avocado({
        cwd: 'src/test/invlid_file_location',
        env: {},
        args: { excludePaths: ['specification/testRP', ['specification/testRP1']] },
      })
      .toArray()
    assert.deepStrictEqual(r, [])
  })

  it('avocado with include option', async () => {
    const r = await avocado
      .avocado({
        cwd: 'src/test/invalid_file_location',
        env: {},
        args: { includePaths: ['data-plane', 'resource-manager'] },
      })
      .toArray()
    assert.deepStrictEqual(r, [])
  })

  it('avocado check default tag should contains latest api version', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/default_tag_latest_swaggers', env: {} }).toArray()
    assert.deepStrictEqual(r.length > 0, true)
    assert.deepStrictEqual(
      r.some((it) => it.code === 'MISSING_APIS_IN_DEFAULT_TAG'),
      true,
    )
    assert.deepStrictEqual(
      r.some((it) => it.code === 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG'),
      true,
    )
  })

  it('avocado check multi default tag', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/multi_default_tag', env: {} }).toArray()
    assert.deepStrictEqual(r.length > 0, true)
    assert.deepStrictEqual(
      r.some((it) => it.code === 'MISSING_APIS_IN_DEFAULT_TAG'),
      false,
    )
    assert.deepStrictEqual(
      r.some((it) => it.code === 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG'),
      false,
    )
    assert.deepStrictEqual(
      r.some((it) => it.code === 'MULTIPLE_DEFAULT_TAGS'),
      true,
    )
  })

  it('avocado check illegal file, like cadl', async () => {
    const r = await avocado.avocado({ cwd: 'src/test/contain_cadl_folder', env: {} }).toArray()
    assert.deepStrictEqual(r.length > 0, true)
    assert.deepStrictEqual(
      r.some((it) => it.code === 'INVALID_TYPESPEC_LOCATION'),
      true,
    )
    assert.deepStrictEqual(
      r.some((it) => it.path.includes('/cadl/')),
      false,
    )
  })
})
