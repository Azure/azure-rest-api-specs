import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Advisor;
@doc("The metadata entity contract.")
@tenantResource
model MetadataEntity is ProxyResource<MetadataEntityProperties> {
  @doc("Name of metadata entity.")
  @path
  @key("name")
  @segment("metadata")
  name: string;
}

@armResourceOperations
interface MetadataEntities {
  @doc("Gets the metadata entity.")
  get is ArmResourceRead<MetadataEntity>;
  @doc("Gets the list of metadata entities.")
  list is ArmResourceListByParent<MetadataEntity>;
}
