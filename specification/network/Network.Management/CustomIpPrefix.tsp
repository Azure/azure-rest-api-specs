import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Custom IP prefix resource.
 */
model CustomIpPrefix
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<CustomIpPrefixPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = CustomIpPrefix,
    KeyName = "customIpPrefixName",
    SegmentName = "customIpPrefixes",
    NamePattern = ""
  >;

  /**
   * The extended location of the custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@armResourceOperations
interface CustomIpPrefixes {
  /**
   * Gets the specified custom IP prefix in a specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomIPPrefixes_Get")
  get is ArmResourceRead<
    CustomIpPrefix,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomIPPrefixes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomIpPrefix,
    LroHeaders = ArmLroLocationHeader<FinalResult = CustomIpPrefix> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates custom IP prefix tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomIPPrefixes_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    CustomIpPrefix,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified custom IP prefix.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("CustomIPPrefixes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomIpPrefix,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all custom IP prefixes in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomIPPrefixes_List")
  list is ArmResourceListByParent<CustomIpPrefix, Error = CloudError>;

  /**
   * Gets all the custom IP prefixes in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CustomIPPrefixes_ListAll")
  listAll is ArmListBySubscription<CustomIpPrefix, Error = CloudError>;
}

@@doc(CustomIpPrefix.name, "The name of the custom IP prefix.");
@@doc(CustomIpPrefix.properties, "Custom IP prefix properties.");
@@doc(CustomIpPrefixes.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update custom IP prefix operation."
);
@@doc(CustomIpPrefixes.updateTags::parameters.properties,
  "Parameters supplied to update custom IP prefix tags."
);
