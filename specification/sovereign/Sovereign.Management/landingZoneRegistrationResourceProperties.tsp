using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20241031)
@doc("The properties of landing zone registration resource type.")
model LandingZoneRegistrationResourceProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing Zone registration resource type.")
  provisioningState?: provisioningState;

  @doc("The resource id of the top level management group")
  existingTopLevelMgId: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  //need to check if landingZoneAccount name is needed
  @doc("The resource id of the associated landing zone configuration.")
  existingLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneAccounts/landingZoneConfigurations";
    }
  ]>;
}
