// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./operations.tsp";
import "../common/models-suiteoffers.tsp";
import "../common/models-providers.tsp";

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
    @added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
    listQuotaUsages is CustomListOperation<
      Resource = QuotaUsageData,
      Response = PagedQuotaUsageData,
      Parameters = {
        /** The Azure subscription ID. */
        @path
        @segment("subscriptions")
        subscriptionId: SubscriptionId;

        /** The Azure Quantum resource provider. */
        @path
        @segment("providers")
        provider: ResourceProviderName;

        /** The unique identifier for the provider. */
        @path
        @segment("suiteOffers")
        providerId: string;
      }
    >;

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

    /** Get the provider status, including target statuses, for the given suite offer provider in the subscription. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Subscription-scoped custom route not covered by the standard workspace resource operations."
    @added(QuantumWorkspaceAPIVersion.v2026_01_15_preview)
    @get
    @route("subscriptions/{subscriptionId}/providers/Microsoft.Quantum/suiteOffers/{providerId}/providerStatus")
    getProviderStatus is Azure.Core.Foundations.Operation<
      {
        /** The Azure subscription ID. */
        @path
        subscriptionId: SubscriptionId;

        /** The unique identifier for the provider. */
        @path
        providerId: string;
      },
      ProviderStatus
    >;
  }
}
