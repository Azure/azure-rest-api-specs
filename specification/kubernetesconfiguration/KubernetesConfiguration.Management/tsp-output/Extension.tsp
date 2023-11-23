import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.KubernetesConfiguration;
@doc("The Extension object.")
model Extension is ProxyResource<ExtensionProperties> {
  @doc("Name of the Extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface Extensions {
  @doc("Gets Kubernetes Cluster Extension.")
  get is ArmResourceRead<Extension>;
  @doc("Create a new Kubernetes Cluster Extension.")
  create is ArmResourceCreateOrUpdateAsync<Extension>;
  @doc("Patch an existing Kubernetes Cluster Extension.")
  update is ArmResourcePatchAsync<Extension, ExtensionProperties>;
  @doc("Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.")
  delete is ArmResourceDeleteAsync<
    Extension,
    {
      ...BaseParameters<Extension>;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all Extensions in the cluster.")
  list is ArmResourceListByParent<Extension>;
  @doc("Get Async Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{clusterRp}/{clusterResourceName}/{clusterName}/providers/Microsoft.KubernetesConfiguration/extensions/{extensionName}/operations/{operationId}")
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

      @doc("Name of the Extension.")
      @path
      extensionName: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatusResult
  >;
}
