import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * The Footprint profile resource.
 */
model Profile is Azure.ResourceManager.TrackedResource<ProfileProperties> {
  ...ResourceNameParameter<
    Resource = Profile,
    KeyName = "profileName",
    SegmentName = "profiles",
    NamePattern = "^[a-zA-Z0-9]"
  >;
}

@armResourceOperations
interface Profiles {
  /**
   * Retrieves the information about a single Footprint profile.
   */
  get is ArmResourceRead<Profile>;

  /**
   * Creates or updates a Footprint profile with the specified properties.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Profile>;

  /**
   * Updates an existing Footprint profile resource.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Profile, ProfilePatch>;

  /**
   * Deletes an existing Footprint profile.
   */
  delete is ArmResourceDeleteSync<Profile>;

  /**
   * Retrieves the information about all Footprint profiles under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Profile>;

  /**
   * Retrieves the information about all Footprint profiles under a subscription.
   */
  listBySubscription is ArmListBySubscription<Profile>;
}

@@maxLength(Profile.name, 64);
@@minLength(Profile.name, 3);
@@doc(Profile.name, "Name of the Footprint profile resource.");
@@doc(Profiles.createOrUpdate::parameters.resource,
  "Footprint profile creation or update parameters."
);
@@doc(Profiles.update::parameters.properties,
  "Footprint profile update parameters."
);
