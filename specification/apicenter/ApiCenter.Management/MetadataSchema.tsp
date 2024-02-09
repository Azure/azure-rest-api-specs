import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;
@doc("Metadata schema entity. Used to define metadata for the entities in API catalog.")
@parentResource(Service)
model MetadataSchema is ProxyResource<MetadataSchemaProperties> {
  @doc("The name of the metadata schema.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("metadataSchemaName")
  @segment("metadataSchemas")
  name: string;
}

@armResourceOperations
interface MetadataSchemas {
  @doc("Returns details of the metadata schema.")
  get is ArmResourceRead<MetadataSchema>;
  @doc("Checks if specified metadata schema exists.")
  @head
  head(
    ...ResourceInstanceParameters<
      MetadataSchema,
      BaseParameters<MetadataSchema>
    >,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing metadata schema.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MetadataSchema>;
  @doc("Deletes specified metadata schema.")
  delete is ArmResourceDeleteSync<MetadataSchema>;
  @doc("Returns a collection of metadata schemas.")
  list is ArmResourceListByParent<MetadataSchema>;
}
