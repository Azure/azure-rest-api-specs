import * as assert from 'assert'
import { describe, it } from 'vitest'
import { Error, getPathInfoFromError } from './../errors.js'

describe('errors', () => {
  it('test get path info from error', () => {
    const input = [
      {
        code: 'NOT_AUTOREST_MARKDOWN',
        message: 'The `readme.md` is not an AutoRest markdown file.',
        readMeUrl: 'src/test/not_autorest_markdown/specification/readme.md',
        helpUrl: 'http://azure.github.io/autorest/user/literate-file-formats/configuration.html#the-file-format',
        level: 'Error',
      },
      {
        code: 'NO_JSON_FILE_FOUND',
        message: 'no_json_file_found',
        readMeUrl: 'src/test/no_file_found/specification/readme.md',
        jsonUrl: 'src/test/no_file_found/specification/specs/some.json',
        level: 'Error',
      },
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The example JSON file is not referenced from the swagger file.',
        readMeUrl: 'src/test/unreferenced_example/specification/testRP/readme.md',
        jsonUrl: 'src/test/unreferenced_example/specification/testRP/specs/examples/orphan_example.json',
        level: 'Error',
      },
      {
        code: 'JSON_PARSE',
        message: 'The file is not a valid JSON file.',
        error: {
          code: 'unexpected token',
          kind: 'structure',
          message: 'unexpected token, token: }, line: 3, column: 1',
          position: {
            column: 1,
            line: 3,
          },
          token: '}',
          url: 'src/test/invalid_json_trailing_comma/specification/testRP/specs/some.json',
        },
        level: 'Error',
      },
      {
        code: 'CIRCULAR_REFERENCE',
        message: 'The JSON file has a circular reference.',
        readMeUrl: 'src/test/circular_reference/specification/testRP/readme.md',
        jsonUrl: 'src/test/circular_reference/specification/testRP/specs/c.json',
        level: 'Warning',
      },
      {
        level: 'Error',
        code: 'MISSING_README',
        message: 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.',
        folderUrl: 'src/test/no_readme/specification/resource-provider-A/resource-manager',
      },
      {
        code: 'INCONSISTENT_API_VERSION',
        level: 'Error',
        message: 'The API version of the swagger is inconsistent with its file path.',
        jsonUrl: 'src/test/api_version_inconsistent/specification/testRP/specs/2020-05-01/b.json',
        readMeUrl: 'src/test/api_version_inconsistent/specification/testRP/readme.md',
      },
      {
        code: 'MULTIPLE_API_VERSION',
        level: 'Error',
        message: 'The default tag contains multiple API versions swaggers.',
        readMeUrl: 'src/test/api_version_inconsistent/specification/testRP/readme.md',
        tag: 'package-2020-01-01',
      },
      {
        code: 'UNKNOWN_ERROR',
        level: 'Error',
        message: 'The API version of the swagger is inconsistent with its file path.',
      },
      {
        level: 'Error',
        code: 'MISSING_APIS_IN_DEFAULT_TAG',
        message:
          'The default tag does not contain all APIs in this RP. Please make sure the missing API swaggers are in the default tag.',
        tag: 'default',
        readMeUrl:
          '/work/avocado/src/test/default_tag_latest_swaggers/specification/securityinsights/resource-manager/readme.md',
        jsonUrl:
          '/work/avocado/src/test/default_tag_latest_swaggers/specification/securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/Watchlists.json',
        path: '/work/avocado/src/test/default_tag_latest_swaggers/specification/securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/Watchlists.json',
        apiPath:
          '/subscriptions/{}/resourceGroups/{}/providers/{}/workspaces/{}/providers/Microsoft.SecurityInsights/watchlists/{}/watchlistItems/{}',
      },
      {
        level: 'Error',
        code: 'NOT_LATEST_API_VERSION_IN_DEFAULT_TAG',
        message:
          'The default tag does not contains the latest API version. Please make sure the latest api version swaggers are in the default tag.',
        tag: 'default',
        readMeUrl:
          '/work/avocado/src/test/default_tag_latest_swaggers/specification/securityinsights/resource-manager/readme.md',
        jsonUrl:
          '/work/avocado/src/test/default_tag_latest_swaggers/specification/securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/operations.json',
        path: '/providers/Microsoft.SecurityInsights/operations',
      },
    ]
    const res = input.map((it) => getPathInfoFromError(it as Error))
    const expected = [
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/readme.md',
        },
        {
          tag: 'helpUrl',
          path: 'http://azure.github.io/autorest/user/literate-file-formats/configuration.html#the-file-format',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/specs/some.json',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/specs/examples/orphan_example.json',
        },
      ],
      [
        {
          tag: 'json',
          path: '{"code":"unexpected token","kind":"structure","message":"unexpected token, token: }, line: 3, column: 1","position":{"column":1,"line":3},"token":"}","url":"src/test/invalid_json_trailing_comma/specification/testRP/specs/some.json"}',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/specs/c.json',
        },
      ],
      [
        {
          tag: 'folder',
          path: 'https://github.com/undefined/blob/undefined/specification/resource-provider-A/resource-manager',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/specs/2020-05-01/b.json',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/readme.md',
        },
        {
          tag: 'tag',
          path: 'https://github.com/undefined/blob/undefined/specification/testRP/readme.md#tag-package-2020-01-01',
        },
      ],
      [],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/securityinsights/resource-manager/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/Watchlists.json',
        },
      ],
      [
        {
          tag: 'readme',
          path: 'https://github.com/undefined/blob/undefined/specification/securityinsights/resource-manager/readme.md',
        },
        {
          tag: 'json',
          path: 'https://github.com/undefined/blob/undefined/specification/securityinsights/resource-manager/Microsoft.SecurityInsights/stable/2021-04-01/operations.json',
        },
      ],
    ]
    assert.deepStrictEqual(res, expected)
  })
})
