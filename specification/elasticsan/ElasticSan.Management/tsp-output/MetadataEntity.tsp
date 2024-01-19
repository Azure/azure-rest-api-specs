import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of metadata entities.")
  @operationId("Metadata_GetEntity")
  getEntity is ArmResourceRead<MetadataEntity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of metadata entities.")
  @operationId("Metadata_List")
  list is ArmResourceListByParent<MetadataEntity>;
}
