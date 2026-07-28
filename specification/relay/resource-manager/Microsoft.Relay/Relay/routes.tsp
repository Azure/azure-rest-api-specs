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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface exposes the implemented Relay cluster long-running operation polling route."
@added(Versions.v2026_07_01_preview)
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface ClusterOperationResults {
  /**
   * Gets the status of a Relay cluster long-running operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Relay/locations/{location}/clusterOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The ID of the Relay cluster operation.
     */
    @path
    operationId: string,

    /**
     * Indicates that the response uses the Azure asynchronous operation status shape.
     */
    @query
    isAsyncHeader: true,

    /**
     * The Relay cluster name.
     */
    @query
    resourceName: string,

    /**
     * The resource type used by the Relay cluster operation coordinator.
     */
    @query
    resourceType: "cluster",

    /**
     * The resource group containing the Relay cluster.
     */
    @query
    resourceGroupName: string,
  ):
    | ArmResponse<Azure.ResourceManager.CommonTypes.OperationStatusResult>
    | Azure.ResourceManager.CommonTypes.ErrorResponse;
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
