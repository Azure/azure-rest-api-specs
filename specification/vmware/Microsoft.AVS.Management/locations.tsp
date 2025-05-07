namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

@armResourceOperations
interface Locations {
  @doc("Return trial status for subscription by region")
  @armResourceAction(Location)
  checkTrialAvailability(
    ...ResourceInstanceParameters<Location>,

    @doc("Optionally, check for a specific SKU")
    @bodyRoot
    sku?: Foundations.Sku,
  ): ArmResponse<Trial> | ErrorResponse;

  @doc("Return quota for subscription by region")
  @armResourceAction(Location)
  @post
  checkQuotaAvailability(
    ...ResourceInstanceParameters<Location>,
  ): ArmResponse<Quota> | ErrorResponse;
}

@doc("trial status")
union TrialStatus {
  string,

  @doc("is available")
  TrialAvailable: "TrialAvailable",

  @doc("is used")
  TrialUsed: "TrialUsed",

  @doc("is disabled")
  TrialDisabled: "TrialDisabled",
}

@doc("quota enabled")
union QuotaEnabled {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Subscription trial availability")
model Trial {
  @doc("Trial status")
  @visibility(Lifecycle.Read)
  status?: TrialStatus;

  @doc("Number of trial hosts available")
  @visibility(Lifecycle.Read)
  availableHosts?: int32;
}

@doc("Subscription quotas")
model Quota {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Remaining hosts quota by sku type")
  @visibility(Lifecycle.Read)
  hostsRemaining?: Record<int32>;

  @doc("Host quota is active for current subscription")
  @visibility(Lifecycle.Read)
  quotaEnabled?: QuotaEnabled;
}

@doc("A location resource")
@subscriptionResource
model Location is ProxyResource<LocationProperties> {
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
  @doc("A location in a subscription")
  @pattern("^[-\\w\\._]+$")
  @key("location")
  @path
  @segment("locations")
  @Azure.ResourceManager.CommonTypes.Private.armCommonParameter(
    "LocationParameter",
    Azure.ResourceManager.CommonTypes.Versions.v5
  )
  name: string;
}

@doc("location provisioning state")
union LocationProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a location resource")
model LocationProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: LocationProvisioningState;
}
