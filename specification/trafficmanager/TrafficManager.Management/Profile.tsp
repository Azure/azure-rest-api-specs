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

alias ProfileOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Profile>;
  },
  {
    /**
     * The name of the Traffic Manager profile.
     */
    @path
    @segment("trafficmanagerprofiles")
    @key
    profileName: string;
  },
  ErrorType = CloudError
>;

alias ProfileResourceGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<Profile>;
  },
  {},
  ErrorType = CloudError
>;

alias ProfileSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...Azure.ResourceManager.Legacy.Provider<Profile>;
  },
  {},
  ErrorType = CloudError
>;

@armResourceOperations
interface Profiles {
  /**
   * Gets a Traffic Manager profile.
   */
  get is ProfileOps.Read<Profile>;

  /**
   * Create or update a Traffic Manager profile.
   */
  createOrUpdate is ProfileOps.CreateOrUpdateSync<Profile>;

  /**
   * Update a Traffic Manager profile.
   */
  @patch(#{ implicitOptionality: false })
  update is ProfileOps.CustomPatchSync<Profile, PatchModel = Profile>;

  /**
   * Deletes a Traffic Manager profile.
   */
  delete is ProfileOps.DeleteSync<
    Profile,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Traffic Manager profiles within a resource group.
   */
  listByResourceGroup is ProfileResourceGroupOps.List<
    Profile,
    Response = ArmResponse<ProfileListResult>
  >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  listBySubscription is ProfileSubscriptionOps.List<
    Profile,
    Response = ArmResponse<ProfileListResult>
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
