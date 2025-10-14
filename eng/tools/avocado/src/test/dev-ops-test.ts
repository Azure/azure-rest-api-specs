import { FileChange, isPRRelatedError } from './../dev-ops.js'
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.

import * as pfs from '@ts-common/fs'
import * as assert from 'assert'
import * as path from 'path'
import { describe, it } from 'vitest'
import { hasCommonRPFolder } from '../dev-ops.js'
import * as err from '../errors.js'
import { avocado, cli, devOps, git } from '../index.js'
import * as tmpDir from './tmp-dir.js'

type MockAction = 'remove readme' | 'modify json' | 'add file' | 'update readme' | 'update .github' | 'remove file'

/**
 * Create Azure DevOps environment for testing.
 *
 * @param name an environment name. It's used as a unique directory suffix.
 */
const createDevOpsEnv = async (name: string, action: readonly MockAction[]): Promise<cli.Config> => {
  const tmp = await tmpDir.create(name)

  // Create '"${tmp}/remote"' folder.
  const remote = path.join(tmp, 'remote')
  await pfs.mkdir(remote)

  const gitRemote = git.repository(remote)

  // create a Git repository
  await gitRemote({ init: [] })
  await gitRemote({ config: ['user.email', 'test@example.com'] })
  await gitRemote({ config: ['user.name', 'test'] })

  // commit invalid 'specification/readme.md' to 'master'.
  const specification = path.join(remote, 'specification')
  const resourceProviderFolder = path.join(specification, 'testRP')
  const resourceManagerFolder = path.join(resourceProviderFolder, 'resource-manager')
  const dotGithubFolder = path.join(remote, '.github')
  await pfs.mkdir(specification)
  await pfs.mkdir(resourceProviderFolder)
  await pfs.mkdir(resourceManagerFolder)
  await pfs.mkdir(dotGithubFolder)

  await pfs.writeFile(
    path.join(resourceManagerFolder, 'readme.md'),
    `
# Test RP

> see https://aka.ms/autorest

### Tag: package-2020-07-01

\`\`\` yaml $(tag)=='package-2020-07-01'
input-file:
- $(this-folder)/file1.json
- $(this-folder)/file2.json
- $(this-folder)/file3.json
    
\`\`\`
`,
  )
  await pfs.writeFile(
    path.join(resourceManagerFolder, 'file1.json'),
    `
  {
    "a": "foo",
    "b": [
      "bar1",
      "bar2",
      "bar3"
    ]
  }
  `,
  )

  await pfs.writeFile(
    path.join(resourceManagerFolder, 'file2.json'),
    `
  {
    "a": "foo"
  }
  `,
  )

  await pfs.writeFile(
    path.join(resourceManagerFolder, 'file3.json'),
    `
  {
    "a": "foo"
  }
  `,
  )

  await pfs.writeFile(path.join(remote, 'license'), '')
  await gitRemote({ add: ['.'] })
  await gitRemote({ commit: ['-m', '"initial commit"', '--no-gpg-sign'] })

  await gitRemote({ checkout: ['-b', 'source'] })
  if (action.includes('remove readme')) {
    // commit removing 'specification/readme.md' to 'source'.
    await pfs.unlink(path.join(resourceManagerFolder, 'readme.md'))
  }

  if (action.includes('update readme')) {
    await pfs.writeFile(
      path.join(resourceManagerFolder, 'readme.md'),
      `
# Test RP

> see https://aka.ms/autorest

### Tag: package-2020-07-01

\`\`\`yaml $(tag)='package-2020-07-01'

input-file:
- $(this-folder)/file2.json
- $(this-folder)/file3.json
\`\`\`
`,
    )
  }

  if (action.includes('modify json')) {
    await pfs.writeFile(
      path.join(resourceManagerFolder, 'file1.json'),
      `
    {
      "a": "foo",
      "b": ["bar1","bar2","bar3"]
    }
    `,
    )

    await pfs.writeFile(
      path.join(resourceManagerFolder, 'file2.json'),
      `
    {
      "a": "foo",
      "b": "bar"
    }
    `,
    )

    // file with invalid JSON
    await pfs.writeFile(path.join(resourceManagerFolder, 'file3.json'), `random string`)
  }

  if (action.includes('add file')) {
    // json file that did not exist
    await pfs.writeFile(path.join(resourceManagerFolder, 'file4.json'), `{"foo":"bar"}`)

    await pfs.writeFile(path.join(remote, 'textfile.txt'), '')
    await pfs.writeFile(path.join(remote, 'license'), 'MIT')
  }

  if (action.includes('update .github')) {
    await pfs.writeFile(path.join(dotGithubFolder, 'file4.json'), `{"foo":"bar"}`)
  }
  if (action.includes('remove file')) {
    await pfs.unlink(path.join(resourceManagerFolder, 'file1.json'))
  }

  await pfs.writeFile(path.join(remote, 'license'), 'MIT')
  await gitRemote({ add: ['.'] })
  await gitRemote({
    commit: ['-m', '"second commit"', '--no-gpg-sign'],
  })

  // create local Git repository
  const local = path.join(tmp, 'local')
  await pfs.mkdir(local)
  const gitLocal = git.repository(local)
  await gitLocal({ clone: ['../remote', '.'] })

  return {
    cwd: local,
    args: {
      excludePaths: ['common-types', '.github'],
    },
    env: {
      SYSTEM_PULLREQUEST_TARGETBRANCH: 'master',
    },
  }
}

describe('Azure DevOps', () => {
  it('Azure DevOps and Avocado', async () => {
    const cfg = await createDevOpsEnv('devops', [])

    // run avocado as AzureDevOps pull request.
    const errors = await avocado(cfg).toArray()
    assert.deepStrictEqual(errors, [])
  })

  it('Azure DevOps and Avocado add file', async () => {
    const cfg = await createDevOpsEnv('devops-pr-add-file', ['add file', 'modify json'])
    const errors = await avocado(cfg).toArray()
    assert.deepStrictEqual(errors, [
      {
        code: 'JSON_PARSE',
        message: 'The file is not a valid JSON file.',
        path: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file3.json',
        ),
        error: {
          kind: 'syntax',
          code: 'invalid token',
          position: {
            column: 1,
            line: 1,
          },
          token: 'random',
          message: 'invalid token, token: random, line: 1, column: 1',
          url: path.resolve(
            tmpDir.getTmpRoot(),
            'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file3.json',
          ),
        },
        level: 'Error',
      },
      {
        code: 'JSON_PARSE',
        message: 'The file is not a valid JSON file.',
        path: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file3.json',
        ),
        error: {
          kind: 'structure',
          code: 'unexpected token',
          position: {
            column: 8,
            line: 1,
          },
          token: '"string"',
          message: 'unexpected token, token: "string", line: 1, column: 8',
          url: path.resolve(
            tmpDir.getTmpRoot(),
            'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file3.json',
          ),
        },
        level: 'Error',
      },
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The swagger JSON file is not referenced from the readme file.',
        path: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file4.json',
        ),
        level: 'Error',
        readMeUrl: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/readme.md',
        ),
        jsonUrl: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-pr-add-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file4.json',
        ),
      },
    ])
  })

  it('PR diff', async () => {
    const cfg = await createDevOpsEnv('devops-pr-diff', ['remove readme', 'add file', 'modify json'])
    const pr = await devOps.createPullRequestProperties(cfg)
    if (pr === undefined) {
      throw new Error('pr === undefined')
    }
    const files = await pr.diff()
    const expected = [
      { kind: 'Modified', path: 'license' },
      { kind: 'Modified', path: 'specification/testRP/resource-manager/file1.json' },
      { kind: 'Modified', path: 'specification/testRP/resource-manager/file2.json' },
      { kind: 'Modified', path: 'specification/testRP/resource-manager/file3.json' },
      { kind: 'Added', path: 'specification/testRP/resource-manager/file4.json' },
      { kind: 'Deleted', path: 'specification/testRP/resource-manager/readme.md' },
      { kind: 'Added', path: 'textfile.txt' },
    ] as const
    assert.deepStrictEqual(files, expected)
  })

  it('PR structural diff', async () => {
    const cfg = await createDevOpsEnv('devops-pr-diff', ['remove readme', 'add file', 'modify json'])
    const pr = await devOps.createPullRequestProperties(cfg)
    if (pr === undefined) {
      throw new Error('pr === undefined')
    }
    const files = await pr.structuralDiff().toArray()
    const expected = [
      'license',
      'specification/testRP/resource-manager/file2.json',
      'specification/testRP/resource-manager/file3.json',
      'specification/testRP/resource-manager/file4.json',
      'specification/testRP/resource-manager/readme.md',
      'textfile.txt',
    ] as const
    assert.deepStrictEqual(files, expected)
  })

  it('PR with no specifications folder', async () => {
    const tmp = await tmpDir.create('no-specifications')

    // Create '"${tmp}/remote"' folder.
    const remote = path.join(tmp, 'remote')
    await pfs.mkdir(remote)
    const gitRemote = git.repository(remote)

    // create a Git repository
    await gitRemote({ init: [] })
    await gitRemote({ config: ['user.email', 'test@example.com'] })
    await gitRemote({ config: ['user.name', 'test'] })

    await pfs.writeFile(path.join(remote, 'license'), '')
    await gitRemote({ add: ['.'] })
    await gitRemote({ commit: ['-m', '"initial commit"', '--no-gpg-sign'] })

    // commit removing 'specification/readme.md' to 'source'.
    await gitRemote({ checkout: ['-b', 'source'] })

    // create local Git repository
    const local = path.join(tmp, 'local')
    await pfs.mkdir(local)
    const gitLocal = git.repository(local)
    await gitLocal({ clone: ['../remote', '.'] })

    const errors = await avocado({ cwd: local, env: { SYSTEM_PULLREQUEST_TARGETBRANCH: 'master' } }).toArray()
    assert.deepStrictEqual(errors, [])
  })

  it('PR with missing readme.md error', async () => {
    const cfg = await createDevOpsEnv('devops-no-readme', ['remove readme'])
    const errors = await avocado(cfg).toArray()
    assert.deepStrictEqual(errors, [
      {
        level: 'Error',
        code: 'MISSING_README',
        message: 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.',
        path: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-no-readme/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager',
        ),
        folderUrl: path.resolve(
          tmpDir.getTmpRoot(),
          'devops-no-readme/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager',
        ),
      },
    ])
  })

  it('PR with remove input file from readme', async () => {
    const cfg = await createDevOpsEnv('remove-input-file', ['update readme'])
    const errors = await avocado(cfg).toArray()
    assert.deepStrictEqual(errors, [
      {
        code: 'UNREFERENCED_JSON_FILE',
        message: 'The swagger JSON file is not referenced from the readme file.',
        level: 'Error',
        path: path.resolve(
          tmpDir.getTmpRoot(),
          'remove-input-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file1.json',
        ),
        readMeUrl: path.resolve(
          tmpDir.getTmpRoot(),
          'remove-input-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/readme.md',
        ),
        jsonUrl: path.resolve(
          tmpDir.getTmpRoot(),
          'remove-input-file/c93b354fd9c14905bb574a8834c4d69b/specification/testRP/resource-manager/file1.json',
        ),
      },
    ])
  })

  it('PR add .github file', async () => {
    const cfg = await createDevOpsEnv('add-github-file', ['update .github'])
    const errors = await avocado(cfg).toArray()
    assert.ok(errors.length === 0)
  })

  it('remove swagger file', async () => {
    const cfg = await createDevOpsEnv('remove-json-file', ['remove file', 'update readme', 'remove readme'])
    const errors = await avocado(cfg).toArray()
    assert.ok(errors.length === 0)
  })

  it('File changes has common RP folder', () => {
    assert.ok(hasCommonRPFolder('a/b/c/specification/rp1/sssss', 'a/b/c/specification/rp1/sssss'))
    assert.ok(hasCommonRPFolder('a/b/c/specification/network/sssss/a.json', 'tmp/a/b/c/specification/network/sssss'))

    assert.deepStrictEqual(
      hasCommonRPFolder('a/b/c/specification/network/sssss/a.json', 'tmp/a/b/c/specification/computer/sssss'),
      false,
    )
    assert.deepStrictEqual(
      hasCommonRPFolder('a/b/c/network/sssss/a.json', 'tmp/a/b/c/specification/computer/sssss'),
      false,
    )
  })

  it('Is PR related changes', () => {
    const fileChanges: readonly FileChange[] = [
      {
        kind: 'Modified',
        path: 'specification/network/resource-manager/dns.json',
      },
      {
        kind: 'Added',
        path: 'specification/network/data-plane/2019-01-01/a.json',
      },
    ]

    const networkError: err.Error = {
      code: 'MISSING_README',
      message: 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.',
      level: 'Error',
      path: 'x',
      folderUrl: 'specification/network/data-plane',
    }

    const computeError: err.Error = {
      code: 'MISSING_README',
      message: 'Can not find readme.md in the folder. If no readme.md file, it will block SDK generation.',
      level: 'Error',
      path: 'x',
      folderUrl: 'specification/compute/data-plane',
    }

    const jsonReferenceError: err.Error = {
      code: 'UNREFERENCED_JSON_FILE',
      message: 'The JSON file is not found but it is referenced from the readme file.',
      level: 'Error',
      readMeUrl: 'specification/compute/resource-manager/readme.md',
      path: 'x',
      jsonUrl: 'specification/compute/resource-manager/2019-01-01/compute.json',
    }
    assert.ok(isPRRelatedError(fileChanges, networkError))
    assert.deepStrictEqual(isPRRelatedError(fileChanges, computeError), false)
    assert.deepStrictEqual(isPRRelatedError(fileChanges, jsonReferenceError), false)
  })

  it('Is PR related changes : multiple api version', () => {
    const fileChanges: readonly FileChange[] = [
      {
        kind: 'Modified',
        path: 'specification/network/resource-manager/dns.json',
      },
    ]
    const readmeError: err.Error = {
      code: 'MULTIPLE_API_VERSION',
      message: 'The default tag contains multiple API versions swaggers.',
      level: 'Error',
      readMeUrl: 'specification/network/resource-manager/readme.md',
      path: 'x',
      tag: '2020-09-01',
    }
    assert.deepStrictEqual(isPRRelatedError(fileChanges, readmeError), true)
  })
})
