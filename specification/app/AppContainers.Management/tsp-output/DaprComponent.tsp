import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Dapr Component.")
@parentResource(ConnectedEnvironment)
model DaprComponent is ProxyResource<DaprComponentProperties> {
  @doc("Name of the Dapr Component.")
  @key("componentName")
  @segment("daprComponents")
  name: string;
}

@armResourceOperations
interface ConnectedEnvironmentsDaprComponents {
  @doc("Get a dapr component.")
  get is ArmResourceRead<DaprComponent>;
  @doc("Creates or updates a Dapr Component in a connected environment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DaprComponent>;
  @doc("Delete a Dapr Component from a connected environment.")
  delete is ArmResourceDeleteSync<DaprComponent>;
  @doc("Get the Dapr Components for a connected environment.")
  list is ArmResourceListByParent<DaprComponent>;
  @doc("List secrets for a dapr component")
  listSecrets is ArmResourceActionSync<
    DaprComponent,
    void,
    DaprSecretsCollection
  >;
}
