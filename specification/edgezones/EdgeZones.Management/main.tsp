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

@doc("The Azure Extended Zone registration status for a subscription.")
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

@doc("The properties of an AzureExtendedZone Resource")
model AzureExtendedZoneProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("AzureExtendedZone registration approved or not")
  registrationState?: RegistrationState;

  @doc("AzureExtendedZone displayName")
  displayName: string;

  @doc("AzureExtendedZone regionalDisplayName")
  regionalDisplayName: string;

  @doc("AzureExtendedZone regionType")
  regionType: string;

  @doc("AzureExtendedZone regionCategory")
  regionCategory: string;

  @doc("AzureExtendedZone geography")
  geography: string;

  @doc("AzureExtendedZone geographyGroup")
  geographyGroup: string;

  @doc("AzureExtendedZone longitude")
  longitude: string;

  @doc("AzureExtendedZone latitude")
  latitude: string;

  @doc("AzureExtendedZone homeLocation")
  homeLocation: string;
}

@doc("An AzureExtendedZone resource")
@subscriptionResource
model AzureExtendedZone is ProxyResource<AzureExtendedZoneProperties> {
  @doc("The name of the AzureExtendedZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("azureExtendedZoneName")
  @segment("azureExtendedZones")
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

@doc("AzureExtendedZone operations")
@armResourceOperations
interface AzureExtendedZones {
  @doc("Get an Azure Extended Zone for a subscription")
  get is ArmResourceRead<AzureExtendedZone>;

  @doc("Lists the Azure Extended Zones for a subscription")
  listBySubscription is ArmListBySubscription<AzureExtendedZone>;

  @doc("Registers a subscription for an Azure Extended Zone")
  register is ArmResourceActionNoBodySync<AzureExtendedZone>;

  @doc("Unregisters a subscription for an Azure Extended Zone")
  unregister is ArmResourceActionNoBodySync<AzureExtendedZone>;
}
