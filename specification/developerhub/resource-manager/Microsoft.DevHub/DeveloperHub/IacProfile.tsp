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
@summary("IacProfile")
model IacProfile
  is Azure.ResourceManager.TrackedResource<IacProfileProperties> {
  ...ResourceNameParameter<
    Resource = IacProfile,
    KeyName = "iacProfileName",
    SegmentName = "iacProfiles",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations(#{ omitTags: true })
interface IacProfiles {
  /**
   * Gets a IacProfile.
   */
  @summary("Gets a IacProfile.")
  @tag("IacProfile")
  get is ArmResourceRead<IacProfile>;

  /**
   * Creates or updates a IacProfile
   */
  @summary("Creates or updates a IacProfile")
  @tag("IacProfile")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IacProfile>;

  /**
   * Updates tags on a IacProfile.
   */
  @summary("Updates tags on a IacProfile.")
  @tag("IacProfile")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<IacProfile, PatchModel = TagsObject>;

  /**
   * Deletes a IacProfile
   */
  @summary("Deletes a IacProfile")
  @tag("IacProfile")
  delete is ArmResourceDeleteSync<IacProfile>;

  /**
   * Gets a list of iacProfiles within a resource group.
   */
  @summary("Gets a list of iacProfiles within a resource group.")
  @tag("IacProfile")
  listByResourceGroup is ArmResourceListByParent<IacProfile>;

  /**
   * Gets a list of IacProfiles associated with the specified subscription.
   */
  @summary("Gets a list of IacProfiles associated with the specified subscription.")
  @tag("IacProfile")
  list is ArmListBySubscription<IacProfile>;

  /**
   * Export a template
   */
  @summary("Export a template")
  @tag("IacProfile")
  export is ArmResourceActionSync<
    IacProfile,
    ExportTemplateRequest,
    ArmResponse<PrLinkResponse>
  >;

  /**
   * Scale by template
   */
  @summary("Scale by template")
  @tag("IacProfile")
  scale is ArmResourceActionSync<
    IacProfile,
    ScaleTemplateRequest,
    ArmResponse<PrLinkResponse>
  >;

  /**
   * Sync template
   */
  @summary("Sync template")
  @tag("IacProfile")
  sync is ArmResourceActionSync<IacProfile, void, OkResponse>;
}

@@maxLength(IacProfile.name, 63);
@@minLength(IacProfile.name, 1);
@@doc(IacProfile.name, "The name of the IacProfile.");
@@doc(IacProfile.properties, "Properties of a IacProfile.");
@@doc(IacProfiles.createOrUpdate::parameters.resource, "");
@@doc(
  IacProfiles.updateTags::parameters.properties,
  "Parameters supplied to the Update TagsObject Tags operation."
);
@@doc(IacProfiles.export::parameters.body, "");
@@doc(IacProfiles.scale::parameters.body, "");
@@doc(
  Azure.ResourceManager.Legacy.EntityTagProperty.etag,
  "A unique read-only string that changes whenever the resource is updated."
);
