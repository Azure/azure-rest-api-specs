// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ClustersOperationGroup {
  /**
   * List the quantity of available pre-provisioned Event Hubs Clusters, indexed by Azure region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Clusters_ListAvailableClusterRegion")
  @autoRoute
  @get
  @action("availableClusterRegions")
  listAvailableClusterRegion is ArmProviderActionSync<
    Response = AvailableClustersList,
    Scope = SubscriptionActionScope
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NamespacesOperationGroup {
  /**
   * Check the give Namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameter,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope
  >;
}
