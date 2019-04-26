// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import { devOps, cli } from '@azure/avocado'
import { utils } from '@azure/rest-api-specs-scripts'
import * as oav from 'oav'

async function main() {
  const pr = await devOps.createPullRequestProperties(cli.defaultConfig())
  const swaggersToProcess = await utils.getFilesChangedInPR(pr);
  // Useful when debugging a test for a particular swagger.
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.*Microsoft.Logic.*2016-06-01.*/ig) !== null);
  // });
  for (const swagger of swaggersToProcess) {
    try {
      await oav.validateSpec(swagger, {consoleLogLevel: 'error', pretty: true});
    } catch (e) {
      console.error("error: ")
      console.error(e)
      process.exitCode = 1
    }
  }
}

main().catch(e => { console.log(e); process.exit(1); })