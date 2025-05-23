import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ServiceFabric;
/**
 * The result of the Service Fabric runtime versions
 */
model ManagedClusterCodeVersionResult {
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
  properties?: ManagedClusterVersionDetails;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Needed to avoid standard routing"
interface ManagedClusterVersion {
  /**
   * Gets information about an available Service Fabric managed cluster code version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  @summary("Gets information about a Service Fabric managed cluster code version available in the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions/{clusterVersion}")
  @get
  @tag("ManagedClusterVersion")
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,

    /**
     * The cluster code version.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    clusterVersion: string,
  ): ArmResponse<ManagedClusterCodeVersionResult> | ErrorResponse;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions")
  @get
  @tag("ManagedClusterVersion")
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,
  ): ArmResponse<ManagedClusterCodeVersionListResult> | ErrorResponse;

  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions/{clusterVersion}")
  @get
  @tag("ManagedClusterVersion")
  getByEnvironment(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,

    /**
     * The operating system of the cluster.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    environment: ManagedClusterVersionEnvironment,

    /**
     * The cluster code version.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    clusterVersion: string,
  ): ArmResponse<ManagedClusterCodeVersionResult> | ErrorResponse;

  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Necessary to avoid standard routing"
  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions")
  @get
  @tag("ManagedClusterVersion")
  listByEnvironment(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The location for the cluster code versions. This is different from cluster location.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    location: string,

    /**
     * The operating system of the cluster.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
    @OpenAPI.extension("x-ms-parameter-location", "method")
    @path
    environment: ManagedClusterVersionEnvironment,
  ): ArmResponse<ManagedClusterCodeVersionListResult> | ErrorResponse;
}

/**
 * The detail of the Service Fabric runtime version result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource, no provisioning"
model ManagedClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  clusterCodeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  supportExpiryUtc?: utcDateTime;

  /**
   * Cluster operating system, the default will be Windows
   */
  osType?: OsType;
}

/**
 * The list results of the Service Fabric runtime versions.
 */
model ManagedClusterCodeVersionListResult {
  /**
   *  The list results of the Service Fabric runtime versions.
   */
  @body body: ManagedClusterCodeVersionResult[];
}

/**
 * The operating system of the cluster. The default means all.
 */
union ManagedClusterVersionEnvironment {
  string,

  /**
   * Indicates os is Windows.
   */
  Windows: "Windows",
}

/**
 * Cluster operating system, the default will be Windows
 */
union OsType {
  string,

  /**
   * Indicates os is Windows.
   */
  Windows: "Windows",
}
