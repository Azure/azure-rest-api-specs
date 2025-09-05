import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Hybrid configuration group value resource.
 */
model ConfigurationGroupValue
  is Azure.ResourceManager.TrackedResource<ConfigurationGroupValuePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ConfigurationGroupValue,
    KeyName = "configurationGroupValueName",
    SegmentName = "configurationGroupValues",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationGroupValue>;

  /**
   * Updates a hybrid configuration group tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ConfigurationGroupValue,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified hybrid configuration group value.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationGroupValue,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Lists all the hybrid network configurationGroupValues in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ConfigurationGroupValue>;

  /**
   * Lists all sites in the configuration group value in a subscription.
   */
  listBySubscription is ArmListBySubscription<ConfigurationGroupValue>;
}

@@maxLength(ConfigurationGroupValue.name, 64);
@@doc(ConfigurationGroupValue.name,
  "The name of the configuration group value."
);
@@doc(ConfigurationGroupValue.properties,
  "Hybrid configuration group value properties."
);
@@doc(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group value resource."
);
@@doc(ConfigurationGroupValues.updateTags::parameters.properties,
  "Parameters supplied to update configuration group values tags."
);
