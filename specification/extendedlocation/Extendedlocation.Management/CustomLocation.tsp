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
model CustomLocation
  is Azure.ResourceManager.TrackedResource<CustomLocationProperties> {
  ...ResourceNameParameter<
    Resource = CustomLocation,
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

@armResourceOperations
interface CustomLocations {
  /**
   * Gets the details of the customLocation with a specified resource group and name.
   */
  get is ArmResourceRead<CustomLocation>;

  /**
   * Creates or updates a Custom Location in the specified Subscription and Resource Group
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CustomLocation>;

  /**
   * Updates a Custom Location with the specified Resource Name in the specified Resource Group and Subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    CustomLocation,
    PatchModel = PatchableCustomLocations
  >;

  /**
   * Deletes the Custom Location with the specified Resource Name, Resource Group, and Subscription Id.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    CustomLocation,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of Custom Locations in the specified subscription and resource group. The operation returns properties of each Custom Location.
   */
  listByResourceGroup is ArmResourceListByParent<CustomLocation>;

  /**
   * Gets a list of Custom Locations in the specified subscription. The operation returns properties of each Custom Location
   */
  listBySubscription is ArmListBySubscription<CustomLocation>;

  /**
   * Gets the list of the Enabled Resource Types.
   */
  @get
  @action("enabledResourceTypes")
  listEnabledResourceTypes is ArmResourceActionSync<
    CustomLocation,
    void,
    ArmResponse<ResourceListResult<EnabledResourceType>>
  >;

  /**
   * Returns the target resource group associated with the resource sync rules of the Custom Location that match the rules passed in with the Find Target Resource Group Request.
   */
  findTargetResourceGroup is ArmResourceActionSync<
    CustomLocation,
    CustomLocationFindTargetResourceGroupProperties,
    ArmResponse<CustomLocationFindTargetResourceGroupResult> | NoContentResponse
  >;
}

@@maxLength(CustomLocation.name, 63);
@@minLength(CustomLocation.name, 1);
@@doc(CustomLocation.name, "Custom Locations name.");
@@doc(CustomLocation.properties,
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
@@summary(CustomLocations.update, "Updates a Custom Location.");
@@summary(CustomLocations.findTargetResourceGroup,
  "Gets matching target resource group for resource sync."
);
@@summary(CustomLocations.listByResourceGroup,
  "Gets a list of Custom Locations in the specified subscription and resource group."
);
@@summary(CustomLocations.listBySubscription,
  "Gets a list of Custom Locations in a subscription."
);
@@summary(CustomLocations.get, "Gets a Custom Location.");
@@summary(CustomLocations.createOrUpdate,
  "Creates or updates a Custom Location."
);
@@summary(CustomLocations.delete, "Deletes a Custom Location.");
@@summary(CustomLocations.listEnabledResourceTypes,
  "Gets the list of Enabled Resource Types."
);
