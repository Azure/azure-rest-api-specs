import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceLinker;
@doc("Linker of source and target resource")
model LinkerResource is ExtensionResource<LinkerProperties> {
  @doc("The name Linker resource.")
  @path
  @key("linkerName")
  @segment("linkers")
  name: string;
}

@armResourceOperations
interface LinkerResources {
  @doc("Returns Linker resource for a given name.")
  get is ArmResourceRead<LinkerResource>;
  @doc("Create or update linker resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LinkerResource>;
  @doc("Operation to update an existing link.")
  update is ArmResourcePatchAsync<LinkerResource, LinkerProperties>;
  @doc("Delete a link.")
  delete is ArmResourceDeleteAsync<LinkerResource>;
  @doc("Returns list of Linkers which connects to the resource.")
  list is ArmResourceListByParent<LinkerResource>;
  @doc("Validate a link.")
  validate is ArmResourceActionAsync<
    LinkerResource,
    {},
    ValidateOperationResult
  >;
  @doc("list source configurations for a linker.")
  listConfigurations is ArmResourceActionSync<
    LinkerResource,
    {},
    SourceConfigurationResult
  >;
}
