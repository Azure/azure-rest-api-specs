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
 * Class representing a Traffic Manager profile.
 */
model Profile
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ProfileProperties> {
  ...ResourceNameParameter<
    Resource = Profile,
    KeyName = "profileName",
    SegmentName = "trafficmanagerprofiles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Profiles {
  /**
   * Gets a Traffic Manager profile.
   */
  get is ArmResourceRead<Profile>;

  /**
   * Create or update a Traffic Manager profile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Profile>;

  /**
   * Update a Traffic Manager profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Profile, PatchModel = Profile>;

  /**
   * Deletes a Traffic Manager profile.
   */
  delete is ArmResourceDeleteSync<
    Profile,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Traffic Manager profiles within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Profile,
    Response = ArmResponse<Azure.Core.Page<ProfileListResult>>
  >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Profile,
    Response = ArmResponse<Azure.Core.Page<ProfileListResult>>
  >;
}

@@doc(Profile.name, "The name of the Traffic Manager profile.");
@@doc(Profile.properties, "The properties of the Traffic Manager profile.");
@@doc(Profiles.createOrUpdate::parameters.resource,
  "The Traffic Manager profile parameters supplied to the CreateOrUpdate operation."
);
@@doc(Profiles.update::parameters.properties,
  "The Traffic Manager profile parameters supplied to the Update operation."
);
