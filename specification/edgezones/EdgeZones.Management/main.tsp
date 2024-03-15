import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.EdgeZones")
@service({
  title: "Microsoft.EdgeZones",
})
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
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Provisioning State")
  Provisioning,

  @doc("Updating State")
  Updating,

  @doc("Deleting State")
  Deleting,

  @doc("Accepted State")
  Accepted,
}

@doc("The ExtendedZone registration status for a subscription.")
enum RegistrationState {
  @doc("Not Registered State")
  NotRegistered,

  @doc("Pending Register State")
  PendingRegister,

  @doc("Registered State")
  Registered,

  @doc("Pending Unregister State")
  PendingUnregister,
}

@doc("The properties of an ExtendedZone Resource")
model ExtendedZoneProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("ExtendedZone registration approved or not")
  registrationState?: RegistrationState;

  @visibility("read")
  @doc("ExtendedZone displayName")
  displayName: string;

  @visibility("read")
  @doc("ExtendedZone regionalDisplayName")
  regionalDisplayName: string;

  @visibility("read")
  @doc("ExtendedZone regionType")
  regionType: string;

  @visibility("read")
  @doc("ExtendedZone regionCategory")
  regionCategory: string;

  @visibility("read")
  @doc("ExtendedZone geography")
  geography: string;

  @visibility("read")
  @doc("ExtendedZone geographyGroup")
  geographyGroup: string;

  @visibility("read")
  @doc("ExtendedZone longitude")
  longitude: string;

  @visibility("read")
  @doc("ExtendedZone latitude")
  latitude: string;

  @visibility("read")
  @doc("ExtendedZone homeLocation")
  homeLocation: string;
}

@doc("An ExtendedZone resource")
@subscriptionResource
model ExtendedZone is ProxyResource<ExtendedZoneProperties> {
  @doc("The name of the ExtendedZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("extendedZoneName")
  @segment("extendedZones")
  @path
  name: string;
}

// We will use this in an interface
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "All operations must be inside an interface declaration."
@autoRoute
@armResourceAction(TResource)
@post
@doc("Arm Resource Action Taking no request body object and returning result object")
op ArmResourceActionNoBodySync<
  TResource extends ArmResource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<TResource> | ErrorResponse;

@doc("ExtendedZone operations")
@armResourceOperations
interface ExtendedZones {
  @doc("Get an Extended Zone for a subscription")
  get is ArmResourceRead<ExtendedZone>;

  @doc("Lists the Extended Zones for a subscription")
  listBySubscription is ArmListBySubscription<ExtendedZone>;

  @doc("Registers a subscription for an Extended Zone")
  register is ArmResourceActionNoBodySync<ExtendedZone>;

  @doc("Unregisters a subscription for an Extended Zone")
  unregister is ArmResourceActionNoBodySync<ExtendedZone>;
}
