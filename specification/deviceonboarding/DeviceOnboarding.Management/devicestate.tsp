import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;

// ------------------------------------------------------------------
// Section 4: Extension resource: device state
// ------------------------------------------------------------------
@singleton
@doc("The provisioning state of a device.")
model DeviceState
  is Azure.ResourceManager.ExtensionResource<DeviceStateProperties> {
  @doc("The default DeviceState, singleton extension resource used to represent the state of the device it extends.")
  @segment("deviceStates")
  @key
  @path
  @pattern("^[a-zA-Z0-9-]{3,127}[a-zA-Z0-9]$")
  name: string;
}

scalar PolicyResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.DeviceOnboarding/onboardingServices/policies",
    }
  ]>;

@doc("Representation of a previously allocated endpoint")
@removed(Versions.v2025_05_01_preview)
model AllocatedEndpoint {
  @doc("Name of the endpoint.")
  name: string;

  @doc("Type of the endpoint.")
  endpointType: EndpointType;

  @doc("Hostname of the endpoint.")
  hostName: string;
}

@doc("Details of the DeviceState")
model DeviceStateProperties {
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Unique identifier for the device. Allow alphanumeric and '-', '.', '_', ':' only. Last character can only be alphanumeric and '-'")
  @maxLength(128)
  @pattern("^([a-z0-9-._:]{0,127}[a-z0-9-])$")
  registrationId: string;

  @doc("Indicates if the device is enabled for discovery")
  discoveryEnabled?: DiscoveryOptions;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("Onboarding status of the resource this DeviceState extends")
  onboardingStatus: OnboardingStatus;

  @doc("The onboarding policy resource id")
  policyResourceId: PolicyResourceId;

  @doc("Array of previously allocated endpoints")
  @removed(Versions.v2025_05_01_preview)
  @maxItems(1)
  @identifiers(#["name"])
  allocatedEndpoints?: Array<AllocatedEndpoint>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @added(Versions.v2024_12_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Indicates the maximum date and time by which a device can be onboarded, in utcDateTime format")
  onboardUntilDate?: utcDateTime;
}

@doc("Options for enabling or disabling devices for discovery.")
union DiscoveryOptions {
  string,

  @doc("Value indicating the device is enabled for discovery")
  True: "True",

  @doc("Value indicating the device is disabled for discovery")
  False: "False",
}

@doc("The current onboarding status.")
union OnboardingStatus {
  string,

  @doc("Onboarding is still pending")
  Pending: "Pending",

  @doc("The resource has been onboarded")
  Provisioned: "Provisioned",

  @doc("Onboarding has failed")
  Failed: "Failed",
}

@doc("The properties passed in the prepareForOnboarding POST request.")
@added(Versions.v2024_12_01_preview)
model PrepareForOnboardingProperties {
  @doc("Desired maximum duration by which a device can be onboarded")
  ttl: duration; // TODO, determine min/max enforcement, correct format here
}

@armResourceOperations
interface DeviceStates {
  get is ArmResourceRead<DeviceState>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DeviceState>;
  delete is ArmResourceDeleteSync<DeviceState>;
  update is ArmResourcePatchSync<DeviceState, DeviceStateProperties>;
  listByParent is ArmResourceListByParent<DeviceState>;
  @added(Versions.v2024_12_01_preview)
  prepareForOnboarding is ArmResourceActionNoResponseContentAsync<
    DeviceState,
    PrepareForOnboardingProperties
  >; // TODO: revisit error response body after private RP testing if needed
}
