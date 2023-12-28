import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.HybridNetwork;
@doc("Configuration group schema resource.")
@parentResource(Publisher)
model ConfigurationGroupSchema
  is TrackedResource<ConfigurationGroupSchemaPropertiesFormat> {
  @doc("The name of the configuration group schema.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("configurationGroupSchemaName")
  @segment("configurationGroupSchemas")
  name: string;
}

@armResourceOperations
interface ConfigurationGroupSchemas {
  @doc("Gets information about the specified configuration group schema.")
  get is ArmResourceRead<ConfigurationGroupSchema>;
  @doc("Creates or updates a configuration group schema.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConfigurationGroupSchema>;
  @doc("Updates a configuration group schema resource.")
  update is ArmCustomPatchSync<ConfigurationGroupSchema, TagsObject>;
  @doc("Deletes a specified configuration group schema.")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigurationGroupSchema>;
  @doc("Gets information of the configuration group schemas under a publisher.")
  listByPublisher is ArmResourceListByParent<ConfigurationGroupSchema>;
  @doc("Update configuration group schema state.")
  updateState is ArmResourceActionAsync<
    ConfigurationGroupSchema,
    ConfigurationGroupSchemaVersionUpdateState,
    ConfigurationGroupSchemaVersionUpdateState
  >;
}
