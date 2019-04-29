// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import * as scripts from '@azure/rest-api-specs-scripts'

// magic starts here
scripts.breakingChange().then(() => {
  console.log(`Thanks for using breaking change tool to review.`);
  console.log(`If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues .`);
}).catch(err => {
  console.log(err);
  process.exitCode = 1;
})
