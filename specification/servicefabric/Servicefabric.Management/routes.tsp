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

namespace Microsoft.ServiceFabric;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ClusterVersionsOperationGroup {
  /**
   * Gets information about an available Service Fabric cluster code version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets information about a Service Fabric cluster code version available in the specified location.")
  @operationId("ClusterVersions_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}")
  @get
  get(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
    ...SubscriptionIdParameter,

    /**
     * The cluster code version.
     */
    @path
    clusterVersion: string,
  ): ArmResponse<ResourceListResult<ClusterCodeVersionsResult>> | ErrorResponse;

  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @operationId("ClusterVersions_GetByEnvironment")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}")
  @get
  getByEnvironment(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The operating system of the cluster. The default means all.
     */
    @path
    environment: ClusterVersionsEnvironment,

    ...SubscriptionIdParameter,

    /**
     * The cluster code version.
     */
    @path
    clusterVersion: string,
  ): ArmResponse<ResourceListResult<ClusterCodeVersionsResult>> | ErrorResponse;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @operationId("ClusterVersions_List")
  @autoRoute
  @get
  @action("clusterVersions")
  list is ArmProviderActionSync<
    Response = ResourceListResult<ClusterCodeVersionsResult>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @operationId("ClusterVersions_ListByEnvironment")
  @autoRoute
  @get
  @action("clusterVersions")
  listByEnvironment is ArmProviderActionSync<
    Response = ResourceListResult<ClusterCodeVersionsResult>,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The operating system of the cluster. The default means all.
       */
      @path
      @segment("environments")
      environment: ClusterVersionsEnvironment;
    }
  >;
}
