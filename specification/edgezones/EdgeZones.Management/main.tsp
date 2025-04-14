import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.EdgeZones")
@service(#{ title: "Microsoft.EdgeZones" })
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Microsoft.EdgeZones;

/** Api versions */
enum Versions {
  /** 2024-04-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-04-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Provisioning State")
  Provisioning: "Provisioning",

  @doc("Updating State")
  Updating: "Updating",

  @doc("Deleting State")
  Deleting: "Deleting",

  @doc("Accepted State")
  Accepted: "Accepted",
}

@doc("The Azure Extended Zone registration status for a subscription")
union RegistrationState {
  string,

  @doc("Subscription not registered for the Azure Extended Zone")
  NotRegistered: "NotRegistered",

  @doc("Subscription pending registration for the Azure Extended Zone")
  PendingRegister: "PendingRegister",

  @doc("Subscription is registered for the Azure Extended Zone")
  Registered: "Registered",

  @doc("Subscription is pending unregistering for the Azure Extended Zone")
  PendingUnregister: "PendingUnregister",
}

@doc("The properties of an Extended Zone resource.")
model ExtendedZoneProperties {
  @visibility(Lifecycle.Read)
  @doc("Status of the last operation performed by the subscription on the Edge Zone resource")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Indicates the Azure Extended Zone registration’s approval status.")
  registrationState?: RegistrationState;

  @visibility(Lifecycle.Read)
  @doc("Display name of the Azure Extended Zone.")
  displayName: string;

  @visibility(Lifecycle.Read)
  @doc("Regional display name of the Azure Extended Zone.")
  regionalDisplayName: string;

  @visibility(Lifecycle.Read)
  @doc("Type of region for the Azure Extended Zone.")
  regionType: string;

  @visibility(Lifecycle.Read)
  @doc("Category of region for the Azure Extended Zone.")
  regionCategory: string;

  @visibility(Lifecycle.Read)
  @doc("Geography of the Azure Extended Zone.")
  geography: string;

  @visibility(Lifecycle.Read)
  @doc("The Geography Group of the Azure Extended Zone.")
  geographyGroup: string;

  @visibility(Lifecycle.Read)
  @doc("The Longitude of the Azure Extended Zone.")
  longitude: string;

  @visibility(Lifecycle.Read)
  @doc("The Latitude of the Azure Extended Zone.")
  latitude: string;

  @visibility(Lifecycle.Read)
  @doc("The Home Location of the Azure Extended Zone.")
  homeLocation: string;
}

@doc("Resource that represents an Azure Extended Zone available to a subscription for registering and unregistering.")
@subscriptionResource
model ExtendedZone is ProxyResource<ExtendedZoneProperties> {
  @doc("The name of the ExtendedZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("extendedZoneName")
  @segment("extendedZones")
  @path
  name: string;
}

@doc("ExtendedZone operations")
@armResourceOperations
interface ExtendedZones {
  @doc("Gets an Azure Extended Zone for a subscription")
  get is ArmResourceRead<ExtendedZone>;

  @doc("Lists the Azure Extended Zones available to a subscription")
  listBySubscription is ArmListBySubscription<ExtendedZone>;

  @doc("Registers a subscription for an Extended Zone")
  register is ArmResourceActionSync<ExtendedZone, void, ExtendedZone>;

  @doc("Unregisters a subscription for an Extended Zone")
  unregister is ArmResourceActionSync<ExtendedZone, void, ExtendedZone>;
}
