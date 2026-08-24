// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Relay;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface contains a provider-level action rather than resource operations."
@added(Versions.v2026_07_01_preview)
interface ClustersOperationGroup {
  /**
   * Lists regions containing available pre-provisioned Relay clusters.
   */
  @autoRoute
  @get
  @action("availableClusterRegions")
  listAvailableClusterRegion is ArmProviderActionSync<
    Response = AvailableRelayClustersList,
    Scope = SubscriptionActionScope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NamespacesOperationGroup {
  /**
   * Check the specified namespace name availability.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailability,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
