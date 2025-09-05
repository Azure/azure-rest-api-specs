import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Configuration group schema resource.
 */
@parentResource(Publisher)
model ConfigurationGroupSchema
  is Azure.ResourceManager.TrackedResource<ConfigurationGroupSchemaPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ConfigurationGroupSchema,
    KeyName = "configurationGroupSchemaName",
    SegmentName = "configurationGroupSchemas",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface ConfigurationGroupSchemas {
  /**
   * Gets information about the specified configuration group schema.
   */
  get is ArmResourceRead<ConfigurationGroupSchema>;

  /**
   * Creates or updates a configuration group schema.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationGroupSchema>;

  /**
   * Updates a configuration group schema resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ConfigurationGroupSchema,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a specified configuration group schema.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationGroupSchema,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Gets information of the configuration group schemas under a publisher.
   */
  listByPublisher is ArmResourceListByParent<ConfigurationGroupSchema>;

  /**
   * Update configuration group schema state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationGroupSchemas_updateState")
  updateState is ArmResourceActionAsync<
    ConfigurationGroupSchema,
    ConfigurationGroupSchemaVersionUpdateState,
    ArmResponse<ConfigurationGroupSchemaVersionUpdateState>,
    LroHeaders = ArmLroLocationHeader
  >;
}

@@maxLength(ConfigurationGroupSchema.name, 64);
@@doc(ConfigurationGroupSchema.name,
  "The name of the configuration group schema."
);
@@doc(ConfigurationGroupSchema.properties,
  "Configuration group schema properties."
);
@@doc(ConfigurationGroupSchemas.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group schema resource."
);
@@doc(ConfigurationGroupSchemas.update::parameters.properties,
  "Parameters supplied to the create or update network service design version operation."
);
@@doc(ConfigurationGroupSchemas.updateState::parameters.body,
  "Parameters supplied to update the state of configuration group schema."
);
