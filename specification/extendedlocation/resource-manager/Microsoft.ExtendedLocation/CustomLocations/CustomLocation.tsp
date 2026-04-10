import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ExtendedLocation;
/**
 * Custom Locations definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing swagger uses camelCase"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Existing swagger uses camelCase"
model customLocation
  is Azure.ResourceManager.TrackedResource<customLocationProperties> {
  ...ResourceNameParameter<
    Resource = customLocation,
    KeyName = "resourceName",
    SegmentName = "customLocations",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations(#{ omitTags: true })
interface CustomLocations {
  /**
   * Gets the details of the customLocation with a specified resource group and name.
   */
  @summary("Gets a Custom Location.")
  @tag("customLocations")
  get is ArmResourceRead<customLocation>;

  /**
   * Creates or updates a Custom Location in the specified Subscription and Resource Group
   */
  @summary("Creates or updates a Custom Location.")
  @tag("customLocations")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<customLocation>;

  /**
   * Updates a Custom Location with the specified Resource Name in the specified Resource Group and Subscription.
   */
  @summary("Updates a Custom Location.")
  @tag("customLocations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    customLocation,
    PatchModel = patchableCustomLocations
  >;

  /**
   * Deletes the Custom Location with the specified Resource Name, Resource Group, and Subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @summary("Deletes a Custom Location.")
  @tag("customLocations")
  delete is ArmResourceDeleteWithoutOkAsync<
    customLocation,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of Custom Locations in the specified subscription and resource group. The operation returns properties of each Custom Location.
   */
  @summary("Gets a list of Custom Locations in the specified subscription and resource group.")
  @tag("customLocations")
  listByResourceGroup is ArmResourceListByParent<
    customLocation,
    Response = ArmResponse<customLocationListResult>
  >;

  /**
   * Gets a list of Custom Locations in the specified subscription. The operation returns properties of each Custom Location
   */
  @summary("Gets a list of Custom Locations in a subscription.")
  @tag("customLocations")
  listBySubscription is ArmListBySubscription<
    customLocation,
    Response = ArmResponse<customLocationListResult>
  >;

  /**
   * Gets the list of the Enabled Resource Types.
   */
  @summary("Gets the list of Enabled Resource Types.")
  @tag("customLocations")
  @list
  @get
  @action("enabledResourceTypes")
  listEnabledResourceTypes is ArmResourceActionSync<
    customLocation,
    void,
    ArmResponse<EnabledResourceTypesListResult>
  >;

  /**
   * Returns the target resource group associated with the resource sync rules of the Custom Location that match the rules passed in with the Find Target Resource Group Request.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  @summary("Gets matching target resource group for resource sync.")
  @tag("customLocations")
  findTargetResourceGroup is ArmResourceActionSync<
    customLocation,
    customLocationFindTargetResourceGroupProperties,
    ArmResponse<customLocationFindTargetResourceGroupResult> | NoContentResponse
  >;
}

@@maxLength(customLocation.name, 63);
@@minLength(customLocation.name, 1);
@@doc(customLocation.name, "Custom Locations name.");
@@doc(customLocation.properties,
  "The set of properties specific to a Custom Location"
);
@@doc(CustomLocations.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update a Custom Location."
);
@@doc(CustomLocations.update::parameters.properties,
  "The updatable fields of an existing Custom Location."
);
@@doc(CustomLocations.findTargetResourceGroup::parameters.body,
  "Parameters of the find target resource group request."
);
