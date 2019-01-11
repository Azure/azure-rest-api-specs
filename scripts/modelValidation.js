// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.
'use strict';

const utils = require('../test/util/utils')
const cp = require("child_process")

const exec = (cmd, options) => {
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
  const swaggersToProcess = utils.getFilesChangedInPR();
  let result = 0
  for (const swagger of swaggersToProcess) {
    try {
      // await oav.validateExamples(swagger, null, {consoleLogLevel: 'error', pretty: true});
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
  return result
}

main()
