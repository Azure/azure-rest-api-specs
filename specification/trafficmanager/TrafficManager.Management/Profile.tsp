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
  update is ArmCustomPatchSync<
    Profile,
    PatchModel = Profile,
    Error = CloudError
  >;

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
    BaseParameters = {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
    },
    Error = CloudError
  >;

  /**
   * Lists all Traffic Manager profiles within a subscription.
   */
  listBySubscription is ArmResourceListByParent<
    Profile,
    BaseParameters = {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    },
    Error = CloudError
  >;

  /**
   * Checks the availability of a Traffic Manager Relative DNS name.
   */
  @action("checkTrafficManagerNameAvailability")
  checkTrafficManagerRelativeDnsNameAvailability is ArmProviderActionSync<
    Request = CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
    Response = TrafficManagerNameAvailability,
    Error = CloudError
  >;

  /**
   * Checks the availability of a Traffic Manager Relative DNS name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Profiles_checkTrafficManagerNameAvailabilityV2")
  checkTrafficManagerNameAvailabilityV2 is ArmProviderActionSync<
    Request = CheckTrafficManagerRelativeDnsNameAvailabilityParameters,
    Response = TrafficManagerNameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = {},
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
@@doc(Profiles.checkTrafficManagerRelativeDnsNameAvailability::parameters.body,
  "The Traffic Manager name parameters supplied to the CheckTrafficManagerNameAvailability operation."
);
@@doc(Profiles.checkTrafficManagerNameAvailabilityV2::parameters.body,
  "The Traffic Manager name parameters supplied to the CheckTrafficManagerNameAvailability operation."
);
