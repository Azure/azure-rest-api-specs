import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.ServiceFabric;

interface ClusterVersionsOperations {
  @summary("Gets information about a Service Fabric cluster code version available in the specified location.")
  @doc("Gets information about an available Service Fabric cluster code version.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions/{clusterVersion}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The cluster code version.")
      @path
      clusterVersion: string;
    },
    ClusterCodeVersionsListResult
  >;

  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @doc("Gets information about an available Service Fabric cluster code version by environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}")
  @get
  GetByEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The operating system of the cluster. The default means all.")
      @path
      environment: ClusterVersionsEnvironment;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The cluster code version.")
      @path
      clusterVersion: string;
    },
    ClusterCodeVersionsListResult
  >;

  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @doc("Gets all available code versions for Service Fabric cluster resources by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/clusterVersions")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;
    },
    ClusterCodeVersionsListResult
  >;

  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @doc("Gets all available code versions for Service Fabric cluster resources by environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions")
  @get
  ListByEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The operating system of the cluster. The default means all.")
      @path
      environment: ClusterVersionsEnvironment;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;
    },
    ClusterCodeVersionsListResult
  >;
}
