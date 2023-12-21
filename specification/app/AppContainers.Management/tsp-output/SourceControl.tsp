import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppContainers;
@doc("Container App SourceControl.")
@parentResource(ContainerApp)
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("Name of the Container App SourceControl.")
  @path
  @key("sourceControlName")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface ContainerAppsSourceControls {
  @doc("Get a SourceControl of a Container App.")
  get is ArmResourceRead<SourceControl>;
  @doc("Create or update the SourceControl for a Container App.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SourceControl>;
  @doc("Delete a Container App SourceControl.")
  delete is ArmResourceDeleteAsync<SourceControl>;
  @doc("Get the Container App SourceControls in a given resource group.")
  listByContainerApp is ArmResourceListByParent<SourceControl>;
}
