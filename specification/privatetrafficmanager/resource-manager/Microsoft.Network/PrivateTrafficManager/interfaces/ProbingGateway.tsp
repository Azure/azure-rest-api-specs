import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "../models/ProbingGatewayModels.tsp";
import "./Profile.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Network;

@@doc(
  ProfileProbingGateway.name,
  "The name of the probing gateway association."
);
@@doc(
  ProfileProbingGateway.properties,
  "The properties of the probing gateway association."
);

@doc("Class representing a probing gateway associated with a Private Traffic Manager profile. This resource is only available when the parent profile has `customTopologyMapMode` set to `Disabled` (Basic experience).")
@parentResource(PrivateTrafficManagerProfile)
model ProfileProbingGateway is ProxyResource<ProfileProbingGatewayProperties> {
  ...ResourceNameParameter<
    ProfileProbingGateway,
    SegmentName = "probingGateways"
  >;
}

@armResourceOperations
interface ProfileProbingGateways {
  @doc("Gets a probing gateway associated with a Private Traffic Manager profile. Only available when the parent profile has `customTopologyMapMode` set to `Disabled`.")
  get is ArmResourceRead<ProfileProbingGateway>;

  @doc("Creates or updates a probing gateway association with a Private Traffic Manager profile. Only available when the parent profile has `customTopologyMapMode` set to `Disabled`.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ProfileProbingGateway>;

  @doc("Updates a probing gateway association with a Private Traffic Manager profile. Only available when the parent profile has `customTopologyMapMode` set to `Disabled`.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ProfileProbingGateway,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ProfileProbingGateway,
      ProfileProbingGatewayProperties
    >
  >;

  @doc("Deletes a probing gateway association from a Private Traffic Manager profile. Only available when the parent profile has `customTopologyMapMode` set to `Disabled`.")
  delete is ArmResourceDeleteWithoutOkAsync<ProfileProbingGateway>;

  @doc("Lists all probing gateways associated with a Private Traffic Manager profile. Only available when the parent profile has `customTopologyMapMode` set to `Disabled`.")
  listByParent is ArmResourceListByParent<ProfileProbingGateway>;
}
