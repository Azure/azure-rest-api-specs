import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ResourceHealth;
@doc("The metadata entity contract.")
@tenantResource
model MetadataEntity is ProxyResource<MetadataEntityProperties> {
  @doc("Name of metadata entity.")
  @key("name")
  @segment("metadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "Metadata")
interface MetadataEntities_Metadata {
  @doc("Gets the list of metadata entities.")
  getEntity is ArmResourceRead<MetadataEntity>;

  @doc("Gets the list of metadata entities.")
  list is ArmResourceListByParent<MetadataEntity>;
}
