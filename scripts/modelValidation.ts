// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import { devOps, cli } from '@azure/avocado'
import { utils } from '@azure/rest-api-specs-scripts'
import * as cp from 'child_process'

const exec = (cmd: string, options?: cp.SpawnSyncOptions) => {
  const result = cp.spawnSync(
    cmd,
    {
      ...options,
      shell: true,
      stdio: [process.stdin, process.stdout, process.stderr]
    }
  )
  return result.status
}

async function main() {
  const pr = await devOps.createPullRequestProperties(cli.defaultConfig())
  const swaggersToProcess = await utils.getFilesChangedInPR(pr);
  let result = 0
  for (const swagger of swaggersToProcess) {
    try {
      // await oav.validateExamples(swagger, null, {consoleLogLevel: 'error', pretty: true});
      // run OAV as a separate process to avoid memory issues.
      const r = exec(`node node_modules/oav/dist/cli.js validate-example ${swagger} --pretty`)
      if (result === 0) {
        result = r
      }
    } catch (e) {
      console.error("error: ")
      console.error(e)
      result = 1
    }
  }
  process.exitCode = result
}

main().catch(e => { console.log(e); process.exit(1); })
