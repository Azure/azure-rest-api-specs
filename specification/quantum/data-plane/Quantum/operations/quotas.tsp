// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-quota.tsp";
import "../common/models-suiteoffers.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Quantum.Workspace.Services {
  interface Quotas {
    /** List quotas for the given workspace. */
    list is ListOperation<Quota>;

    /** List quota usages for the given workspace. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Workspace-scoped custom route not covered by the standard workspace resource operations."
    @added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
    listWorkspaceQuotaUsages is CustomListOperation<
      Resource = QuotaUsageData,
      Response = PagedQuotaUsageData,
      Parameters = {
        ...CommonParams;

        /** The unique identifier for the provider to get quota usages for. */
        @query
        providerId: string;
      }
    >;
  }
}
