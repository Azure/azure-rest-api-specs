// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.

import * as scripts from '@xiaoxu_dev/rest-api-specs-scripts'

// magic starts here
scripts.momentOfTruth().then(() => {
  process.exit(0);
}).catch(() => {
  process.exit(1);
})