import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ServiceFabric;

interface ClusterVersionsOperations {
  /**
   * Gets information about an available Service Fabric cluster code version.
   */
  @summary("Gets information about a Service Fabric cluster code version available in the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The location for the cluster code versions. This is different from cluster location.
       */
      @path
      location: string;

      /**
       * The customer subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The cluster code version.
       */
      @path
      clusterVersion: string;
    },
    ClusterCodeVersionsListResult
  >;

  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}")
  @get
  getByEnvironment is Azure.Core.Foundations.Operation<
    {
      /**
       * The location for the cluster code versions. This is different from cluster location.
       */
      @path
      location: string;

      /**
       * The operating system of the cluster. The default means all.
       */
      @path
      environment: ClusterVersionsEnvironment;

      /**
       * The customer subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The cluster code version.
       */
      @path
      clusterVersion: string;
    },
    ClusterCodeVersionsListResult
  >;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The location for the cluster code versions. This is different from cluster location.
       */
      @path
      location: string;

      /**
       * The customer subscription identifier.
       */
      @path
      subscriptionId: string;
    },
    ClusterCodeVersionsListResult
  >;

  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions")
  @get
  listByEnvironment is Azure.Core.Foundations.Operation<
    {
      /**
       * The location for the cluster code versions. This is different from cluster location.
       */
      @path
      location: string;

      /**
       * The operating system of the cluster. The default means all.
       */
      @path
      environment: ClusterVersionsEnvironment;

      /**
       * The customer subscription identifier.
       */
      @path
      subscriptionId: string;
    },
    ClusterCodeVersionsListResult
  >;
}
