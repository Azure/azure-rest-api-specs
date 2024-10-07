using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Sovereign;

@removed(Versions.Preview20241031)
@doc("The properties of the Landing Zone registration resource type.")
model LandingZoneRegistrationProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the Landing Zone registration resource type.")
  provisioningState?: ResourceProvisioningState;

  @doc("The resource id of the top level management group")
  existingTopLevelMgId: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The resource id of the associated landing zone configuration.")
  existingLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneConfigurations";
    }
  ]>;
}
