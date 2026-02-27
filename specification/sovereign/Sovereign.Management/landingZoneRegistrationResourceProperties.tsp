using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20241031)
@doc("The properties of landing zone registration resource type.")
model LandingZoneRegistrationResourceProperties {
  @visibility(Lifecycle.Read)
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

@added(Versions.Preview20241031)
@doc("Structure of each JSON object for Drift API call.")
model DriftedItems {
  @doc("The name of the affected rule.")
  ruleName: string;

  @doc("The category of the rule.")
  category: string;

  @doc("The severity of the drift.")
  priority: string;

  @doc("The details of the rule.")
  detail: string;

  @doc("The identifier of the item.")
  identifier: string;
}

@added(Versions.Preview20241031)
@doc("The JSON response of the drift API call.")
model DriftResponseArray {
  @doc("The time when the drift analysis was run.")
  reportRuntime: string;

  @doc("The resource id of landing zone account, landing zone registration is part of.")
  landingZoneAccountId: string;

  @doc("The resource id of landing zone registration where drift operation was triggered from.")
  landingZoneRegistrationId: string;

  @doc("The resource id of the associated landing zone configuration.")
  landingZoneConfigurationId: string;

  @doc("The resource id of the associated management group id.")
  managementGroupId: string;

  @doc("The count of drift rules.")
  totalEvaluatedRules: int32;

  @doc("The count of items analyzed.")
  totalAnalyzedItems: int32;

  @doc("The count of drifted items.")
  totalDriftedItems: int32;

  @doc("Array of Drift JSON response.")
  @identifiers(#["ruleName", "category", "priority", "detail", "identifier"])
  driftedItems: DriftedItems[];
}
