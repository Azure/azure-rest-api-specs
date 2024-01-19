import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
@doc("Configuration group schema resource.")
@parentResource(Publisher)
model ConfigurationGroupSchema
  is TrackedResource<ConfigurationGroupSchemaPropertiesFormat> {
  @doc("The name of the configuration group schema.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("configurationGroupSchemaName")
  @segment("configurationGroupSchemas")
  name: string;
}

@armResourceOperations
interface ConfigurationGroupSchemas {
  @doc("Gets information about the specified configuration group schema.")
  get is ArmResourceRead<ConfigurationGroupSchema>;

  @doc("Creates or updates a configuration group schema.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ConfigurationGroupSchema,
    BaseParameters<ConfigurationGroupSchema>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates a configuration group schema resource.")
  update is ArmCustomPatchSync<ConfigurationGroupSchema, TagsObject>;

  @doc("Deletes a specified configuration group schema.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationGroupSchema,
    BaseParameters<ConfigurationGroupSchema>,
    ArmLroLocationHeader
  >;

  @doc("Gets information of the configuration group schemas under a publisher.")
  listByPublisher is ArmResourceListByParent<ConfigurationGroupSchema>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update configuration group schema state.")
  @operationId("ConfigurationGroupSchemas_updateState")
  updateState is ArmResourceActionAsync<
    ConfigurationGroupSchema,
    ConfigurationGroupSchemaVersionUpdateState,
    ConfigurationGroupSchemaVersionUpdateState,
    BaseParameters<ConfigurationGroupSchema>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ConfigurationGroupSchemas.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupSchemas.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupSchemas.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group schema resource."
);
@@projectedName(ConfigurationGroupSchemas.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupSchemas.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupSchemas.update::parameters.properties,
  "Parameters supplied to the create or update network service design version operation."
);
@@projectedName(ConfigurationGroupSchemas.updateState::parameters.body,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupSchemas.updateState::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupSchemas.updateState::parameters.body,
  "Parameters supplied to update the state of configuration group schema."
);
