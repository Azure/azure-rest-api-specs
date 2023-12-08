import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KubernetesConfiguration;
@doc("The Extension object.")
model KubernetesClusterExtension is ProxyResource<ExtensionProperties> {
  @doc("Name of the Extension.")
  @path
  @key("extensionName")
  @segment("extensions")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourcePlan;
}

@armResourceOperations
interface KubernetesClusterExtensions {
  @doc("Gets Kubernetes Cluster Extension.")
  get is ArmResourceRead<KubernetesClusterExtension>;
  @doc("Create a new Kubernetes Cluster Extension.")
  create is ArmResourceCreateOrUpdateAsync<KubernetesClusterExtension>;
  @doc("Patch an existing Kubernetes Cluster Extension.")
  update is ArmResourcePatchAsync<
    KubernetesClusterExtension,
    ExtensionProperties
  >;
  @doc("Delete a Kubernetes Cluster Extension. This will cause the Agent to Uninstall the extension from the cluster.")
  delete is ArmResourceDeleteAsync<
    KubernetesClusterExtension,
    {
      ...BaseParameters<KubernetesClusterExtension>;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all Extensions in the cluster.")
  list is ArmResourceListByParent<KubernetesClusterExtension>;
}
