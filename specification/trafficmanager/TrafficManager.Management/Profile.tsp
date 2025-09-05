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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Profile is Azure.ResourceManager.TrackedResource<ProfileProperties> {
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
  get is ArmResourceRead<Profile, Error = CloudError>;

  /**
   * Create or update a Traffic Manager profile.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Profile, Error = CloudError>;

  /**
   * Update a Traffic Manager profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Profile, PatchModel = Profile, Error = CloudError>;

  /**
   * Deletes a Traffic Manager profile.
   */
  delete is ArmResourceDeleteSync<
    Profile,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Traffic Manager profiles within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Profile,
    Response = ArmResponse<ProfileListResult>,
    Error = CloudError
  >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Profile,
    Response = ArmResponse<ProfileListResult>,
    Error = CloudError
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
