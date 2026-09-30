// Operations in this file are non-standard resource operations confirmed from the original OpenAPI specification.

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains non-standard operations that are not detected as resource operations from the original OpenAPI specification."
interface ClustersOperationGroup {
  /**
   * List the quantity of available pre-provisioned Event Hubs Clusters, indexed by Azure region.
   */
  @autoRoute
  @get
  @action("availableClusterRegions")
  listAvailableClusterRegion is ArmProviderActionSync<
    Response = AvailableClustersList,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains non-standard operations that are not detected as resource operations from the original OpenAPI specification."
interface NamespacesOperationGroup {
  /**
   * Check the give Namespace name availability.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameter,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
}
