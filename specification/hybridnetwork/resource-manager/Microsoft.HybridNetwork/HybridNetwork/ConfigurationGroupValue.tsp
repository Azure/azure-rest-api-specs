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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model configurationGroupValue
  is Azure.ResourceManager.TrackedResource<configurationGroupValuePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = configurationGroupValue,
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
  get is ArmResourceRead<configurationGroupValue>;

  /**
   * Creates or updates a hybrid configuration group value.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    configurationGroupValue,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a hybrid configuration group tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    configurationGroupValue,
    PatchModel = TagsObject
  >;

  /**
   * Deletes the specified hybrid configuration group value.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    configurationGroupValue,
    LroHeaders = ArmLroLocationHeader,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets 'Deleting' provisioningState until the operation completes. Returns an operation URI that can be queried to find the current state of the operation.",
      ArmLroLocationHeader
    > | ArmNoContentResponse<"Request successful. Resource does not exist.">
  >;

  /**
   * Lists all the hybrid network configurationGroupValues in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<configurationGroupValue>;

  /**
   * Lists all sites in the configuration group value in a subscription.
   */
  listBySubscription is ArmListBySubscription<configurationGroupValue>;
}

@@maxLength(configurationGroupValue.name, 64);
@@doc(configurationGroupValue.name,
  "The name of the configuration group value."
);
@@doc(configurationGroupValue.properties,
  "Hybrid configuration group value properties."
);
@@doc(ConfigurationGroupValues.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update configuration group value resource."
);
@@doc(ConfigurationGroupValues.updateTags::parameters.properties,
  "Parameters supplied to update configuration group values tags."
);
