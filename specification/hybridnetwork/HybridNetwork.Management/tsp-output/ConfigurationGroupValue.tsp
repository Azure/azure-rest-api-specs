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

namespace Microsoft.HybridNetwork;
/**
 * Hybrid configuration group value resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ConfigurationGroupValuePropertiesFormat
)
model ConfigurationGroupValue extends TrackedResourceBase {
  /**
   * The name of the configuration group value.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("configurationGroupValueName")
  @segment("configurationGroupValues")
  @visibility("read")
  name: string;

  /**
   * Hybrid configuration group value properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationGroupValuePropertiesFormat;
}

@armResourceOperations
interface ConfigurationGroupValues {
  /**
   * Gets information about the specified hybrid configuration group values.
   */
  get is ArmResourceRead<ConfigurationGroupValue>;

  /**
   * Creates or updates a hybrid configuration group value.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConfigurationGroupValue,
    BaseParameters<ConfigurationGroupValue>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a hybrid configuration group tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<ConfigurationGroupValue, TagsObject>;

  /**
   * Deletes the specified hybrid configuration group value.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationGroupValue,
    BaseParameters<ConfigurationGroupValue>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the hybrid network configurationGroupValues in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationGroupValues_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ConfigurationGroupValue>;

  /**
   * Lists all sites in the configuration group value in a subscription.
   */
  listBySubscription is ArmListBySubscription<ConfigurationGroupValue>;
}

@@projectedName(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group value resource."
);
@@projectedName(ConfigurationGroupValues.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(ConfigurationGroupValues.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ConfigurationGroupValues.updateTags::parameters.properties,
  "Parameters supplied to update configuration group values tags."
);
