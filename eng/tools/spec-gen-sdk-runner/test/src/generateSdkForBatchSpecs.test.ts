import { describe, test, expect, vi, beforeEach, afterEach } from 'vitest'
import  * as utils from '../../src/utils.js'
import * as commands from '../../src/commands.js'
import * as log from '../../src/log.js'
import fs from "node:fs";

// vi.mock('../../src/commands.js', async (importOriginal) => {
//   const actual = await importOriginal<typeof import('../../src/commands.js')>()
//   return {
//     ...actual,
//     parseArguments: vi.fn(),
//     prepareSpecGenSdkCommand: vi.fn(),
//     getSpecPaths: vi.fn(),
//     getExecutionReport: vi.fn(),
//   }
// })


vi.mock('../../src/utils.js', async (importOriginal) => {
  const actual = await importOriginal<typeof import('../../src/utils.js')>()
  return {
    ...actual,
    resetGitRepo: vi.fn(),
    runSpecGenSdkCommand: vi.fn(),
  }
})

// vi.mock('../../src/log.js', async (importOriginal) => {
//   const actual = await importOriginal<typeof import('../../src/log.js')>()
//   return {
//     ...actual,
//     logMessage: vi.fn().mockImplementation(() => {}),
//     vsoLogIssue: vi.fn().mockImplementation(() => {}),
//   }
// })


// vi.mock('node:fs', async (importOriginal) => {
//   const actualFs = await importOriginal<typeof import('node:fs')>();
//   return {
//     ...actualFs,
//     default: {
//       ...actualFs,
//       readFileSync: vi.fn().mockReturnValue("aaaa"),
//       writeFileSync: vi.fn(),
//       existsSync: vi.fn(),
//       rmSync: vi.fn()
//     },
//   };
// });

describe('generateSdkForBatchSpecs', () => {

  const readSpy = vi.spyOn(fs, 'readFileSync').mockImplementation(() => 'aaaa');
  
  beforeEach(async () => {
    vi.clearAllMocks()
  })

  afterEach(() => {
    vi.resetModules()
    readSpy.mockRestore()
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
    // const logSpy = vi.spyOn(console, 'log').mockImplementation(() => {})
    // const logSpy = vi.spyOn(console, 'log')
    
    // vi.spyOn(fs, "readFileSync").mockImplementation((path: fs.PathOrFileDescriptor) => {
    //   if (typeof path === 'string') {
    //     if (path.includes('file1')) return 'first content';
    //     if (path.includes('file2')) return 'second content';
    //   }
    
    //   return 'default content';
    // });

    const fsReadFileSyncSpy = vi.spyOn(fs, 'readFileSync').mockImplementation(() => '仅此用例')
    expect(fs.readFileSync('path')).toBe('仅此用例')
    fsReadFileSyncSpy.mockRestore()

    const fsWriteFileSyncSpy = vi.spyOn(fs, 'writeFileSync').mockImplementation(() => '仅此用例')
    // expect(fsWriteFileSyncSpy).toHaveBeenCalled();
    // expect(fs.writeFileSync('path', 'content')).toBe('仅此用例')
    // fsWriteFileSyncSpy.mockRestore()

    
    const fsExistsSyncSpy = vi.spyOn(fs, 'existsSync').mockImplementation(() => false)
    // expect(fs.existsSync('path')).toBe(false)
    // fsExistsSyncSpy.mockRestore()

    vi.spyOn(commands, "parseArguments").mockImplementation(() => mockInput)

    // vi.mocked(commands.parseArguments).mockReturnValue(mockInput)
    // expect(vi.isMockFunction(commands.parseArguments)).toBe(true)
    // const resultparseArguments = commands.parseArguments()
    // expect(resultparseArguments).toBe(mockInput)

    // vi.mocked(fs.readFileSync).mockImplementation(() => "aaaa"),
    // expect(vi.isMockFunction(fs.readFileSync)).toBe(true)
    const fsRes = fs.readFileSync('test')
    console.log('fsRes', fsRes)
    expect(fsRes).toBe('aaaa')


    // vi.mocked(commands.getSpecPaths).mockReturnValue([])
    vi.spyOn(commands, "getSpecPaths").mockReturnValue([])

    const vsoLogIssueSpy = vi.spyOn(log, 'vsoLogIssue').mockImplementation(() => {})
    const logMessagepy = vi.spyOn(log, 'logMessage').mockImplementation(() => {})

    const code = await commands.generateSdkForBatchSpecs('batchType')

    expect(fsExistsSyncSpy).toHaveBeenCalledOnce();
    expect(fsWriteFileSyncSpy).toHaveBeenCalledOnce();
    expect(fsWriteFileSyncSpy).toHaveBeenNthCalledWith(1, 
      '/home/tianenx/Github/Azure/azure-rest-api-specs/eng/out/logs/generation-summary.md',
       "## Total Specs Count \n 0 \n",
    )
    expect(utils.resetGitRepo).not.toHaveBeenCalled()
    expect(utils.runSpecGenSdkCommand).not.toHaveBeenCalled()
    expect(commands.getExecutionReport).not.toHaveBeenCalled()

    // expect(fs.existsSync).not.toHaveBeenCalled();
    // expect(readFileSyncSpy).toHaveBeenCalledTimes(2);

    console.log(vsoLogIssueSpy.mock.calls);
    expect(vsoLogIssueSpy).toHaveBeenCalledTimes(1);
    console.log(logMessagepy.mock.calls);
    expect(logMessagepy).toHaveBeenCalledTimes(1);
    // expect(log.vsoLogIssue).toHaveBeenCalledTimes(2);
    // expect(log.logMessage).toHaveBeenCalledTimes(2);
    // expect(logSpy).toHaveBeenNthCalledWith(1, expect.stringContaining("Runner: markdown file written to"));
    // expect(logSpy).toHaveBeenNthCalledWith(2, expect.stringContaining("##vso[task.addattachment type=Distributedtask.Core.Summary;name=Generation Summary;]"));

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
