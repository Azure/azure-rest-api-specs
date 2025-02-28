using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20250227)
@doc("The properties of landing zone registration resource type.")
model LandingZoneRegistrationResourceProperties {
  @visibility("read")
  @doc("The state that reflects the current stage in the creation, updating, or deletion process of the landing zone registration resource type.")
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

  @doc("The managed identity to be assigned to this landing zone registration.")
  managedIdentity?: ManagedIdentityProperties;
}
