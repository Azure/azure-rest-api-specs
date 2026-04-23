import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/ProfileModels.tsp";

using Azure.ResourceManager;
namespace Microsoft.Network;

@@doc(PrivateTrafficManagerProfile.name,
  "The name of the Private Traffic Manager profile."
);
@@doc(PrivateTrafficManagerProfile.properties,
  "The properties of the Private Traffic Manager profile."
);
@doc("Class representing a Private Traffic Manager profile.")
model PrivateTrafficManagerProfile is TrackedResource<ProfileProperties> {
  ...ResourceNameParameter<
    PrivateTrafficManagerProfile,
    SegmentName = "privateTrafficManagerProfiles"
  >;
}

@@doc(Profiles.createOrUpdate::parameters.resource,
  "The Private Traffic Manager profile parameters supplied to the CreateOrUpdate operation."
);
@armResourceOperations
interface Profiles {
  @doc("Gets a Private Traffic Manager profile.")
  get is ArmResourceRead<PrivateTrafficManagerProfile>;

  @doc("Create or update a Private Traffic Manager profile.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateTrafficManagerProfile>;

  @doc("Deletes a Private Traffic Manager profile.")
  delete is ArmResourceDeleteWithoutOkAsync<PrivateTrafficManagerProfile>;

  @doc("Updates a Traffic Manager profile.")
  update is ArmResourcePatchAsync<
    PrivateTrafficManagerProfile,
    ProfileProperties
  >;

  @doc("Lists all Private Traffic Manager profiles within a resource group.")
  listByResourceGroup is ArmResourceListByParent<PrivateTrafficManagerProfile>;

  @doc("Lists all Private Traffic Manager profiles within a subscription.")
  listBySubscription is ArmListBySubscription<PrivateTrafficManagerProfile>;
}
