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
  update is ArmCustomPatchAsync<Extension, PatchExtension>;

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
}
