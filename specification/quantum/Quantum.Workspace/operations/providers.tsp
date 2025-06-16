// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-providers.tsp";

namespace Quantum.Workspace.Services {
  interface Providers {
    /** List all providers in the workspace with their respective status. */
    list is ListOperation<ProviderStatus>;
  }
}
