// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License in the project root for license information.

import { semanticValidation } from '@azure/rest-api-specs-scripts'

semanticValidation.main().catch(e => { console.log(e); process.exit(1); })
