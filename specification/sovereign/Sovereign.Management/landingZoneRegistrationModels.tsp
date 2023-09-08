using Azure.ResourceManager;

namespace Microsoft.Sovereign;

@doc("The properties of the Landing Zone registration resource type.")
model LandingZoneRegistrationProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the Landing Zone registration resource type.")
  provisioningState?: ResourceProvisioningState;

  @doc("The resource id of the top level management group")
  existingTopLevelManagementGroupId: ResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The resource id of the associated landing zone configuration.")
  existingLandingZoneConfigurationId: ResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneConfigurations";
    }
  ]>;
}
