import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KubernetesConfiguration;
@doc("The Flux Configuration object returned in Get & Put response.")
model FluxConfiguration is ProxyResource<FluxConfigurationProperties> {
  @doc("Name of the Flux Configuration.")
  @path
  @key("fluxConfigurationName")
  @segment("fluxConfigurations")
  name: string;
}

@armResourceOperations
interface FluxConfigurations {
  @doc("Gets details of the Flux Configuration.")
  get is ArmResourceRead<FluxConfiguration>;
  @doc("Create a new Kubernetes Flux Configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FluxConfiguration>;
  @doc("Update an existing Kubernetes Flux Configuration.")
  update is ArmResourcePatchAsync<
    FluxConfiguration,
    FluxConfigurationProperties
  >;
  @doc("This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.")
  delete is ArmResourceDeleteAsync<
    FluxConfiguration,
    {
      ...BaseParameters<FluxConfiguration>;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all Flux Configurations.")
  list is ArmResourceListByParent<FluxConfiguration>;
  @doc("Get Async Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/fluxConfigurations/{fluxConfigurationName}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Kubernetes cluster RP - i.e. Microsoft.ContainerService, Microsoft.Kubernetes, Microsoft.HybridContainerService.")
      @path
      clusterRp: string;

      @doc("The Kubernetes cluster resource name - i.e. managedClusters, connectedClusters, provisionedClusters.")
      @path
      clusterResourceName: string;

      @doc("The name of the kubernetes cluster.")
      @path
      clusterName: string;

      @doc("Name of the Flux Configuration.")
      @path
      fluxConfigurationName: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatusResult
  >;
}
