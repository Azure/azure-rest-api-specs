import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;

interface ManagedClusterVersionOperations {
  @summary("Gets information about a Service Fabric managed cluster code version available in the specified location.")
  @doc("Gets information about an available Service Fabric managed cluster code version.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions/{clusterVersion}")
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
    ManagedClusterCodeVersionResult
  >;

  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @doc("Gets information about an available Service Fabric cluster code version by environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions/{clusterVersion}")
  @get
  GetByEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The operating system of the cluster. The default means all.")
      @path
      environment: ManagedClusterVersionEnvironment;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The cluster code version.")
      @path
      clusterVersion: string;
    },
    ManagedClusterCodeVersionResult
  >;

  @summary("Gets the list of Service Fabric cluster code versions available for the specified location.")
  @doc("Gets all available code versions for Service Fabric cluster resources by location.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterVersions")
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
    void
  >;

  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @doc("Gets all available code versions for Service Fabric cluster resources by environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions")
  @get
  ListByEnvironment is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The operating system of the cluster. The default means all.")
      @path
      environment: ManagedClusterVersionEnvironment;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface managedUnsupportedVMSizesOperations {
  @summary("Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.")
  @doc("Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes")
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
    ManagedVMSizesResult
  >;

  @summary("Get unsupported vm size for Service Fabric Managed Clusters.")
  @doc("Get unsupported vm size for Service Fabric Managed Clusters.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedUnsupportedVMSizes/{vmSize}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The location for the cluster code versions. This is different from cluster location.")
      @path
      location: string;

      @doc("The customer subscription identifier.")
      @path
      subscriptionId: string;

      @doc("VM Size name.")
      @path
      vmSize: string;
    },
    ManagedVMSize
  >;
}
