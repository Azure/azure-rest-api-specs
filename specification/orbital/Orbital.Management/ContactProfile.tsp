import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Orbital;
/**
 * Customer creates a Contact Profile Resource, which will contain all of the configurations required for scheduling a contact.
 */
model ContactProfile
  is Azure.ResourceManager.TrackedResource<ContactProfilesProperties, false> {
  ...ResourceNameParameter<
    Resource = ContactProfile,
    KeyName = "contactProfileName",
    SegmentName = "contactProfiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContactProfiles {
  /**
   * Gets the specified contact Profile in a specified resource group.
   */
  get is ArmResourceRead<ContactProfile>;

  /**
   * Creates or updates a contact profile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContactProfile>;

  /**
   * Updates the specified contact profile tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<ContactProfile, PatchModel = TagsObject>;

  /**
   * Deletes a specified contact profile resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ContactProfile,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of contact profiles by Resource Group.
   */
  list is ArmResourceListByParent<
    ContactProfile,
    Parameters = {
      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Returns list of contact profiles by Subscription.
   */
  listBySubscription is ArmListBySubscription<
    ContactProfile,
    Parameters = {
      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@doc(ContactProfile.name, "Contact Profile name.");
@@doc(ContactProfile.properties, "Properties of the contact profile resource.");
@@doc(ContactProfiles.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Contact Profile."
);
@@doc(ContactProfiles.updateTags::parameters.properties,
  "Parameters supplied to update contact profile tags."
);
