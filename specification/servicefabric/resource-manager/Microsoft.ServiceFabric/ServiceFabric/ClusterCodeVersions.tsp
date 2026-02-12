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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Necessary to avoid standard routing"
interface ClusterVersionsOperationGroup {
  /**
   * Gets information about an available Service Fabric cluster code version.
   */
  @tag("ClusterVersion")
  @summary("Gets information about a Service Fabric cluster code version available in the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}")
  get(
    ...ApiVersionParameter,
    ...LocationResourceParameter,
    ...SubscriptionIdParameter,

    /**
     * The cluster code version.
     */
    @path
    clusterVersion: string,
  ): ArmResponse<ResourceListResult<ClusterCodeVersions>> | ErrorModel;

  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  @tag("ClusterVersion")
  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
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
  ): ArmResponse<ResourceListResult<ClusterCodeVersions>> | ErrorModel;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  @tag("ClusterVersion")
  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @autoRoute
  @get
  @action("clusterVersions")
  list is ArmProviderActionSync<
    Response = ResourceListResult<ClusterCodeVersions>,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ErrorModel
  >;
  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  @tag("ClusterVersion")
  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @autoRoute
  @get
  @action("clusterVersions")
  listByEnvironment is ArmProviderActionSync<
    Response = ResourceListResult<ClusterCodeVersions>,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The operating system of the cluster. The default means all.
       */
      @path
      @segment("environments")
      environment: ClusterVersionsEnvironment;
    },
    Error = ErrorModel
  >;
}

/**
 * The result of the Service Fabric runtime versions
 */
model ClusterCodeVersions {
  /**
   * The identification of the result
   */
  id?: string;

  /**
   * The name of the result
   */
  name?: string;

  /**
   * The result resource type
   */
  type?: string;

  /**
   * The detail of the Service Fabric runtime version result
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "x-ms-client-flatten requires exact property name"
  properties?: ClusterVersionDetails;
}

/**
 * The operating system or environment of the cluster version.
 */
union ClusterVersionsEnvironment {
  string,

  /**
   * Windows operating system
   */
  Windows: "Windows",

  /**
   * Linux operating system
   */
  Linux: "Linux",
}

/**
 * The detail of the Service Fabric runtime version result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Brownfield resource that cannot be created/updated, no provisioning state"
model ClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  codeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  supportExpiryUtc?: string;

  /**
   * Indicates if this version is for Windows or Linux operating system.
   */
  environment?: ClusterEnvironment;
}
