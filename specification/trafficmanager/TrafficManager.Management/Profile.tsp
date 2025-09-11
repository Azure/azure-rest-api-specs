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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
model Profile extends TrackedResource {
  properties: ProfileProperties;
}

alias ProfileOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Profile>;
  },
  {
    /**
     * The name of the Profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    @key("profileName")
    profileName: string;
  },
  ErrorType = CloudError
>;

alias ProfileSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider<Profile>;
  },
  {
    /**
     * The name of the Profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    @key("profileName")
    profileName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface Profiles {
  /**
   * Gets a Traffic Manager profile.
   */
  get is ProfileOps.Read<Profile>;
  // get is ArmResourceRead<Profile, Error = CloudError>;

  /**
   * Create or update a Traffic Manager profile.
   */
  createOrUpdate is ProfileOps.CreateOrUpdateSync<Profile>;
  // createOrUpdate is ArmResourceCreateOrReplaceSync<Profile, Error = CloudError>;

  /**
   * Update a Traffic Manager profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ProfileOps.CustomPatchSync<Profile, PatchModel = Profile>;
  // update is ArmCustomPatchSync<
  //   Profile,
  //   PatchModel = Profile,
  //   Error = CloudError
  // >;

  /**
   * Deletes a Traffic Manager profile.
   */
  delete is ProfileOps.DeleteSync<
    Profile,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;
  // delete is ArmResourceDeleteSync<
  //   Profile,
  //   Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse,
  //   Error = CloudError
  // >;

  /**
   * Lists all Traffic Manager profiles within a resource group.
   */
  listByResourceGroup is ProfileOps.List<Profile>;
  // listByResourceGroup is ArmResourceListByParent<
  //   Profile,
  //   Response = ArmResponse<ProfileListResult>,
  //   Error = CloudError
  // >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  listBySubscription is ProfileSubscriptionOps.List<Profile>;
  // listBySubscription is ArmListBySubscription<
  //   Profile,
  //   Response = ArmResponse<ProfileListResult>,
  //   Error = CloudError
  // >;
}

// @@doc(Profile.name, "The name of the Traffic Manager profile.");
@@doc(Profile.properties, "The properties of the Traffic Manager profile.");
// @@doc(Profiles.createOrUpdate::parameters.resource,
//   "The Traffic Manager profile parameters supplied to the CreateOrUpdate operation."
// );
@@doc(Profiles.update::parameters.properties,
  "The Traffic Manager profile parameters supplied to the Update operation."
);
