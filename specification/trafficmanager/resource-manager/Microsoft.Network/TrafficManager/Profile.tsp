import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Network;
/**
 * Class representing a Traffic Manager profile.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Profile extends TrackedResource {
  properties?: ProfileProperties;
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

  /**
   * Create or update a Traffic Manager profile.
   */
  createOrUpdate is ProfileOps.CreateOrUpdateSync<Profile>;

  /**
   * Update a Traffic Manager profile.
   */
  @sharedRoute
  @removed(Versions.v2024_04_01_preview)
  @patch(#{ implicitOptionality: false })
  update is ProfileOps.CustomPatchSync<Profile, PatchModel = Profile>;

  /**
   * Update a Traffic Manager profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId needed to match stable version"
  @sharedRoute
  @added(Versions.v2024_04_01_preview)
  @operationId("Profiles_Update")
  @patch(#{ implicitOptionality: false })
  updateV2 is ProfileOps.CustomPatchSync<Profile, PatchModel = ProfileUpdate>;

  /**
   * Deletes a Traffic Manager profile.
   */
  delete is ProfileOps.DeleteSync<
    Profile,
    Response = ArmResponse<DeleteOperationResult> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  @action("trafficmanagerprofiles")
  listBySubscription is ArmResourceListByParent<
    Profile,
    BaseParameters = {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    },
    Error = CloudError
  >;

  /**
   * Lists all Traffic Manager profiles within a resource group.
   */
  @action("trafficmanagerprofiles")
  listByResourceGroup is ArmResourceListByParent<
    Profile,
    BaseParameters = {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
    },
    Error = CloudError
  >;
}

@@doc(Profile.properties, "The properties of the Traffic Manager profile.");
@@doc(Profiles.createOrUpdate::parameters.resource,
  "The Traffic Manager profile parameters supplied to the CreateOrUpdate operation."
);
@@doc(Profiles.update::parameters.properties,
  "The Traffic Manager profile parameters supplied to the Update operation."
);
@@doc(Profiles.updateV2::parameters.properties,
  "The Traffic Manager profile parameters supplied to the Update operation."
);
