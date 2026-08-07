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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConfigurationGroupSchema,
    LroHeaders = ArmAsyncOperationHeader
  >;

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
    LroHeaders = ArmLroLocationHeader,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">
  >;

  /**
   * Gets information of the configuration group schemas under a publisher.
   */
  listByPublisher is ArmResourceListByParent<ConfigurationGroupSchema>;

  /**
   * Update configuration group schema state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ConfigurationGroupSchemas_updateState")
  updateState is ArmResourceActionAsyncBase<
    ConfigurationGroupSchema,
    ConfigurationGroupSchemaVersionUpdateState,
    ArmResponse<ConfigurationGroupSchemaVersionUpdateState> | ArmAcceptedLroResponse<
      "The request of updating configuration group schema state is accepted.",
      ArmLroLocationHeader<FinalResult = ConfigurationGroupSchemaVersionUpdateState>
    >,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<ConfigurationGroupSchema>
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
