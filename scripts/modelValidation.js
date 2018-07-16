// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.
'use strict';

const utils = require('../test/util/utils')
const oav = require('oav');

async function main() {
  const swaggersToProcess = utils.getFilesChangedInPR();
  // Useful when debugging a test for a particular swagger.
  // Just update the regex. That will return an array of filtered items.
  // swaggersToProcess = swaggersToProcess.filter(function(item) {
  //   return (item.match(/.*Microsoft.Logic.*2016-06-01.*/ig) !== null);
  // });
  for (const swagger of swaggersToProcess) {
    await oav.validateExamples(swagger, null, {consoleLogLevel: 'error', pretty: true});
  }
}

main()