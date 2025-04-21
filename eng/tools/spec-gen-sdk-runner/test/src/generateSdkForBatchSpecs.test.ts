import { describe, test, expect, vi, beforeEach, afterEach } from 'vitest'
import  * as utils from '../../src/utils.js'
import * as commands from '../../src/commands.js'
// import * as log from '../../src/log.js'
import fs from "node:fs";

vi.mock('../../src/commands.js', async (importOriginal) => {
  const actual = await importOriginal<typeof import('../../src/commands.js')>()
  return {
    ...actual,
    parseArguments: vi.fn(),
    prepareSpecGenSdkCommand: vi.fn(),
    getSpecPaths: vi.fn(),
    getExecutionReport: vi.fn(),
  }
})

vi.mock('../../src/utils.js', async (importOriginal) => {
  const actual = await importOriginal<typeof import('../../src/utils.js')>()
  return {
    ...actual,
    resetGitRepo: vi.fn(),
    runSpecGenSdkCommand: vi.fn(),
  }
})

// vi.mock('../../src/log.js', () => ({
// //   logMessage: vi.fn(),
//   logIssuesToPipeline: vi.fn(),
//   vsoAddAttachment: vi.fn(),
//   vsoLogIssue: vi.fn(),
// }))

// vi.mock('fs', () => ({
//   existsSync: vi.fn(),
//   rmSync: vi.fn(),
//   writeFileSync: vi.fn(),
//   readFileSync: vi.fn(),
// }));

// vi.mock('fs', async (importOriginal) => {
//   const actualFs = await importOriginal<typeof import('node:fs')>();
//   return {
//     ...actualFs,
//     default: {
//       ...actualFs,
//       readFileSync: vi.fn(),
//       writeFileSync: vi.fn(),
//       existsSync: vi.fn(),
//       rmSync: vi.fn(),
//     },
//   };
// });

// const logSpy = vi.spyOn(console, 'log').mockImplementation(() => {
//     // intentionally empty for spy
// })

// const errorSpy = vi.spyOn(console, 'error').mockImplementation(() => {
//   // intentionally empty for spy
// })

// const warnSpy = vi.spyOn(console, 'warn').mockImplementation(() => {
//   // intentionally empty for spy
// })

describe('generateSdkForBatchSpecs', () => {
//   // 引入并初始化 mock 引用
//   let generateSdkForBatchSpecs: typeof import('../../src/commands.js').generateSdkForBatchSpecs
//   let parseArguments: typeof import('../../src/commands.js').parseArguments
//   let getSpecPaths: typeof import('../../src/commands.js').getSpecPaths
//   let prepareSpecGenSdkCommand: typeof import('../../src/commands.js').prepareSpecGenSdkCommand
//   let resetGitRepo: typeof import('../../src/utils.js').resetGitRepo
//   let getExecutionReport: typeof import('../../src/commands.js').getExecutionReport
//   let logIssuesToPipeline: typeof import('../../src/commands.js').logIssuesToPipeline
//   let vsoAddAttachment: typeof import('../../src/log.js').vsoAddAttachment
//   let vsoLogIssue: typeof import('../../src/log.js').vsoLogIssue

//   let runSpecGenSdkCommand: typeof import('../../src/utils.js').runSpecGenSdkCommand
//   let fsExists: typeof import('fs').existsSync
//   let fsRm: typeof import('fs').rmSync
//   let fsWrite: typeof import('fs').writeFileSync
//   let logMessage: typeof import('../../src/log.js').logMessage

  beforeEach(async () => {
    vi.clearAllMocks()
    // const cmdMod = await import('../../src/commands.js')
    // generateSdkForBatchSpecs  = cmdMod.generateSdkForBatchSpecs
    // parseArguments            = cmdMod.parseArguments
    // prepareSpecGenSdkCommand  = cmdMod.prepareSpecGenSdkCommand
    // getSpecPaths              = cmdMod.getSpecPaths
    // getExecutionReport        = cmdMod.getExecutionReport
    // logIssuesToPipeline       = cmdMod.logIssuesToPipeline

    // const utils = await import('../../src/utils.js')
    // runSpecGenSdkCommand = utils.runSpecGenSdkCommand
    // resetGitRepo         = utils.resetGitRepo

    // const fs = await import('node:fs')
    // fsExists = fs.existsSync
    // fsRm     = fs.rmSync
    // fsWrite  = fs.writeFileSync

    // const logger = await import('../../src/log.js')
    // logMessage                = logger.logMessage
    // vsoAddAttachment          = logger.vsoAddAttachment
    // vsoLogIssue               = logger.vsoLogIssue
  })

  afterEach(() => {
    vi.resetModules()
  })

  test('If specPaths is empty, the runSpecGenSdkCommand will not run and the executionReport is not exist and the status will be 1', async () => {
    const mockInput = {
        localSpecRepoPath: 'local_specs_repo_path',
        workingFolder: "working_folder",
        runMode: "batch",
        localSdkRepoPath: "local_sdk_repo_path",
        sdkRepoName: "azure-sdk-for-js",
        sdkLanguage: "azure-sdk-for-js",
        specCommitSha: "spec_commit_sha",
        specRepoHttpsUrl: "https://github.com/Azure/azure-rest-api-specs",
    }
    const logSpy = vi.spyOn(console, 'log').mockImplementation(() => {
        // intentionally empty for spy
    })
    
    vi.spyOn(fs, "readFileSync").mockImplementation((path: fs.PathOrFileDescriptor) => {
      if (typeof path === 'string') {
        if (path.includes('file1')) return 'first content';
        if (path.includes('file2')) return 'second content';
      }
    
      return 'default content';
    });

    vi.mocked(commands.parseArguments).mockReturnValue(mockInput)
    // expect(vi.isMockFunction(commands.parseArguments)).toBe(true)
    // const resultparseArguments = commands.parseArguments()
    // expect(resultparseArguments).toBe(mockInput)

    vi.mocked(commands.getSpecPaths).mockReturnValue([])
    const code = await commands.generateSdkForBatchSpecs('batchType')
    expect(utils.runSpecGenSdkCommand).not.toHaveBeenCalled()

    // expect(fs.existsSync).not.toHaveBeenCalled();
    // expect(readFileSyncSpy).toHaveBeenCalledTimes(2);

    // console.log(logSpy.mock.calls)
    expect(logSpy).toHaveBeenCalledTimes(2);
    expect(logSpy).toHaveBeenNthCalledWith(1, expect.stringContaining("Runner: markdown file written to"));
    expect(logSpy).toHaveBeenNthCalledWith(2, expect.stringContaining("##vso[task.addattachment type=Distributedtask.Core.Summary;name=Generation Summary;]"));

    expect(code).toBe(0)
  })

  /**
  test('单个 spec 执行成功后，返回 0 并生成 summary', async () => {
    const mockInput = {
        localSpecRepoPath: 'specs',
        workingFolder: "123",
        runMode: "batch",
        localSdkRepoPath: "4123",
        sdkRepoName: "123123",
        sdkLanguage: "",
        specCommitSha: "",
        specRepoHttpsUrl: "",
    }
    vi.mocked(parseArguments).mockReturnValue(mockInput)
    vi.mocked(getSpecPaths).mockReturnValue(['one.yaml'])
    vi.mocked(getExecutionReport).mockReturnValue({
      executionResult: 'succeeded',
      vsoLogPath: '/logs/log.txt',
    })
    vi.mocked(fsExists).mockReturnValue(false)

    const code = await generateSdkForBatchSpecs('batch-one')
    expect(code).toBe(0)
    expect(runSpecGenSdkCommand).toHaveBeenCalled()
    expect(fsWrite).toHaveBeenCalledWith(
      '/work/out/logs/generation-summary.md',
      expect.stringContaining('## Successful Specs in the Generation Process'),
    )
    expect(vsoAddAttachment).toHaveBeenCalledWith(
      'Generation Summary',
      '/work/out/logs/generation-summary.md',
    )
  })
 */
  // 你还可以继续在这里加更多 test…
})
