import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevHub;
/**
 * Resource representation of a IacProfile.
 */
model IacProfile
  is Azure.ResourceManager.TrackedResource<IacProfileProperties> {
  ...ResourceNameParameter<
    Resource = IacProfile,
    KeyName = "iacProfileName",
    SegmentName = "iacProfiles",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface IacProfiles {
  /**
   * Gets a IacProfile.
   */
  get is ArmResourceRead<IacProfile>;

  /**
   * Creates or updates a IacProfile
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IacProfile>;

  /**
   * Updates tags on a IacProfile.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<IacProfile, PatchModel = TagsObject>;

  /**
   * Deletes a IacProfile
   */
  delete is ArmResourceDeleteSync<IacProfile>;

  /**
   * Gets a list of iacProfiles within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<IacProfile>;

  /**
   * Gets a list of IacProfiles associated with the specified subscription.
   */
  list is ArmListBySubscription<IacProfile>;

  /**
   * Export a template
   */
  export is ArmResourceActionSync<
    IacProfile,
    ExportTemplateRequest,
    ArmResponse<PrLinkResponse>
  >;

  /**
   * Scale by template
   */
  scale is ArmResourceActionSync<
    IacProfile,
    ScaleTemplateRequest,
    ArmResponse<PrLinkResponse>
  >;

  /**
   * Sync template
   */
  sync is ArmResourceActionSync<IacProfile, void, OkResponse>;
}

@@maxLength(IacProfile.name, 63);
@@minLength(IacProfile.name, 1);
@@doc(IacProfile.name, "The name of the IacProfile.");
@@doc(IacProfile.properties, "Properties of a IacProfile.");
@@doc(IacProfiles.createOrUpdate::parameters.resource, "");
@@doc(IacProfiles.updateTags::parameters.properties,
  "Parameters supplied to the Update TagsObject Tags operation."
);
@@doc(IacProfiles.export::parameters.body, "");
@@doc(IacProfiles.scale::parameters.body, "");
