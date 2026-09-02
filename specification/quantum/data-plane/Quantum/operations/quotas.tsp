// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-quota.tsp";

namespace Quantum.Workspace.Services {
  interface Quotas {
    /** List quotas for the given workspace. */
    list is ListOperation<Quota>;
  }
}
