// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

import * as scripts from '@azure/rest-api-specs-scripts'

// magic starts here
scripts.momentOfTruth().then(_ => {
  process.exit(0);
}).catch(_ => {
  process.exit(1);
})