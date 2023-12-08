import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.KubernetesConfiguration;
@doc("The Flux Configuration object returned in Get & Put response.")
model KubernetesFluxConfiguration
  is ProxyResource<FluxConfigurationProperties> {
  @doc("Name of the Flux Configuration.")
  @path
  @key("fluxConfigurationName")
  @segment("fluxConfigurations")
  name: string;
}

@armResourceOperations
interface KubernetesFluxConfigurations {
  @doc("Gets details of the Flux Configuration.")
  get is ArmResourceRead<KubernetesFluxConfiguration>;
  @doc("Create a new Kubernetes Flux Configuration.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KubernetesFluxConfiguration>;
  @doc("Update an existing Kubernetes Flux Configuration.")
  update is ArmResourcePatchAsync<
    KubernetesFluxConfiguration,
    FluxConfigurationProperties
  >;
  @doc("This will delete the YAML file used to set up the Flux Configuration, thus stopping future sync from the source repo.")
  delete is ArmResourceDeleteAsync<
    KubernetesFluxConfiguration,
    {
      ...BaseParameters<KubernetesFluxConfiguration>;

      @doc("Delete the extension resource in Azure - not the normal asynchronous delete.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("List all Flux Configurations.")
  list is ArmResourceListByParent<KubernetesFluxConfiguration>;
}
