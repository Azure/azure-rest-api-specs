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
 * Customer creates a spacecraft resource to schedule a contact.
 */
model Spacecraft
  is Azure.ResourceManager.TrackedResource<SpacecraftsProperties, false> {
  ...ResourceNameParameter<
    Resource = Spacecraft,
    KeyName = "spacecraftName",
    SegmentName = "spacecrafts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Spacecrafts {
  /**
   * Gets the specified spacecraft in a specified resource group.
   */
  get is ArmResourceRead<Spacecraft>;

  /**
   * Creates or updates a spacecraft resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Spacecraft>;

  /**
   * Updates the specified spacecraft tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<Spacecraft, PatchModel = TagsObject>;

  /**
   * Deletes a specified spacecraft resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Spacecraft,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns list of spacecrafts by resource group.
   */
  list is ArmResourceListByParent<
    Spacecraft,
    Parameters = {
      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Returns list of spacecrafts by subscription.
   */
  listBySubscription is ArmListBySubscription<
    Spacecraft,
    Parameters = {
      /**
       * An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * Returns list of available contacts. A contact is available if the spacecraft is visible from the ground station for more than the minimum viable contact duration provided in the contact profile.
   */
  listAvailableContacts is ArmResourceActionAsync<
    Spacecraft,
    ContactParameters,
    ArmResponse<AvailableContactsListResult>
  >;
}

@@doc(Spacecraft.name, "Spacecraft ID.");
@@doc(Spacecraft.properties, "Spacecraft Properties");
@@doc(Spacecrafts.createOrUpdate::parameters.resource,
  "The parameters to provide for the created spacecraft."
);
@@doc(Spacecrafts.updateTags::parameters.properties,
  "Parameters supplied to update spacecraft tags."
);
@@doc(Spacecrafts.listAvailableContacts::parameters.body,
  "The parameters to provide for the contacts."
);
