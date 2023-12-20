import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerAppConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Dapr Component.")
@parentResource(ContainerAppConnectedEnvironment)
model ContainerAppConnectedEnvironmentDaprComponent
  is ProxyResource<DaprComponentProperties> {
  @doc("Name of the Dapr Component.")
  @path
  @key("componentName")
  @segment("daprComponents")
  name: string;
}

@armResourceOperations
interface ContainerAppConnectedEnvironmentDaprComponents {
  @doc("Get a dapr component.")
  get is ArmResourceRead<ContainerAppConnectedEnvironmentDaprComponent>;
  @doc("Creates or updates a Dapr Component in a connected environment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContainerAppConnectedEnvironmentDaprComponent>;
  @doc("Delete a Dapr Component from a connected environment.")
  delete is ArmResourceDeleteSync<ContainerAppConnectedEnvironmentDaprComponent>;
  @doc("Get the Dapr Components for a connected environment.")
  list is ArmResourceListByParent<ContainerAppConnectedEnvironmentDaprComponent>;
  @doc("List secrets for a dapr component")
  listSecrets is ArmResourceActionSync<
    ContainerAppConnectedEnvironmentDaprComponent,
    void,
    DaprSecretsCollection
  >;
}
