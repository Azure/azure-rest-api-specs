// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-suiteoffers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Quantum.Workspace;

/** A paged list of quota usage data. */
alias PagedQuotaUsageData = Azure.Core.Page<QuotaUsageData>;

namespace Quantum.Workspace.Services {
  interface SuiteOffers {
    /** List quota usages for the given suite offer provider in the subscription. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Subscription-scoped custom route not covered by the standard workspace resource operations."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation returns a paged list of quota usages, so the 'list' prefix is correct."
    @added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
    @get
    @route("subscriptions/{subscriptionId}/providers/Microsoft.Quantum/suiteOffers/{providerId}/quotaUsages")
    listQuotaUsages is Azure.Core.Foundations.Operation<
      {
        /** The Azure subscription ID. */
        @path
        subscriptionId: SubscriptionId;

        /** The unique identifier for the provider. */
        @path
        providerId: string;
      },
      PagedQuotaUsageData
    >;
  }
}
