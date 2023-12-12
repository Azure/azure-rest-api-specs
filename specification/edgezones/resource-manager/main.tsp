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
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeZones;

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

@doc("The status of the subscription's' Microsoft EdgeZone registration.")
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

@doc("The properties of a MicrosoftEdgeZone Resource")
model MicrosoftEdgeZoneProperties {
  @visibility("read")
  @doc("The status of the last operation. required property on a resource https://stackoverflow.microsoft.com/questions/327894")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("MicrosoftEdgeZone registration approved or not")
  registrationState?: RegistrationState;

  @doc("MicrosoftEdgeZone display name")
  displayName: string;
}

@doc("The properties of a PublicMecEdgeZone Resource")
model PublicMecEdgeZoneProperties {
  @visibility("read")
  @doc("The status of the last operation. required property on a resource https://stackoverflow.microsoft.com/questions/327894")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("PublicMecEdgeZone registration approved or not")
  registrationState?: RegistrationState;

  @doc("PublicMecEdgeZone display name")
  displayName: string;
}

@doc("A MicrosoftEdgeZone resource")
@subscriptionResource
model MicrosoftEdgeZone is ProxyResource<MicrosoftEdgeZoneProperties> {
  @doc("The name of the MicrosoftEdgeZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("microsoftEdgeZoneName")
  @segment("microsoftEdgeZones")
  @path
  name: string;
}

@doc("A PublicMecEdgeZone resource")
@subscriptionResource
model PublicMecEdgeZone is ProxyResource<PublicMecEdgeZoneProperties> {
  @doc("The name of the PublicMecEdgeZone")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("publicMecEdgeZoneName")
  @segment("publicMecEdgeZones")
  @path
  name: string;
}

@doc("A MicrosoftEdgeZone register request body")
model RegisterMicrosoftEdgeZoneRequest {
  @doc("Organization Name for the Microsoft Edge Zone registration")
  organizationName: string;

  @doc("Organization Contact Name for the Microsoft Edge Zone registration")
  organizationContactName: string;

  @doc("Organization Contact Email Address for the Microsoft Edge Zone registration")
  organizationContactEmailAddress: string;

  @doc("Azure services needed by organization of the Microsoft Edge Zone registration")
  organizationAzureServicesNeeded: string;

  @doc("Azure resource capacity needed by organization of the Microsoft Edge Zone registration")
  organizationAzureResourceCapacityNeeded: string;
}

@doc("A PublicMecEdgeZone register request body")
model RegisterPublicMecEdgeZoneRequest {
  @doc("Organization Name for the Public MEC Edge Zone registration")
  organizationName: string;

  @doc("Organization Contact Name for the Public MEC Edge Zone registration")
  organizationContactName: string;

  @doc("Organization Contact Email Address for the Public MEC Edge Zone registration")
  organizationContactEmailAddress: string;

  @doc("Organization telecommunication partners and partners of interest")
  organizationPartners: string;

  @doc("Organization cloud ready application ready for onboarding")
  organizationApplicationOnboarding: string;

  @doc("Organization scenario or industry")
  organizationScenarioIndustry: string;

  @doc("Azure services needed by organization of the Public MEC Edge Zone registration")
  organizationAzureServicesNeeded: string;

  @doc("Azure resource capacity needed by organization of the Public MEC Edge Zone registration")
  organizationAzureResourceCapacityNeeded: string;
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

@doc("MicrosoftEdgeZone operations")
@armResourceOperations
interface MicrosoftEdgeZones {
  @doc("Get a Microsoft Edge Zone in the subscription")
  get is ArmResourceRead<MicrosoftEdgeZone>;

  @doc("Lists the Microsoft Edge Zones for a subscription")
  listBySubscription is ArmListBySubscription<MicrosoftEdgeZone>;

  @doc("Registers a subscription for a Microsoft Edge Zone")
  register is ArmResourceActionSync<
    MicrosoftEdgeZone,
    RegisterMicrosoftEdgeZoneRequest,
    MicrosoftEdgeZone
  >;

  @doc("Unregisters a subscription for a Microsoft Edge Zone")
  unregister is ArmResourceActionNoBodySync<MicrosoftEdgeZone>;
}

@doc("PublicMecEdgeZone operations")
@armResourceOperations
interface PublicMecEdgeZones {
  @doc("Get a Public MEC Edge Zone in the subscription")
  get is ArmResourceRead<PublicMecEdgeZone>;

  @doc("Lists the Public MEC Edge Zones for a subscription")
  listBySubscription is ArmListBySubscription<PublicMecEdgeZone>;

  @doc("Registers a subscription for a Public MEC Edge Zone")
  register is ArmResourceActionSync<
    PublicMecEdgeZone,
    RegisterPublicMecEdgeZoneRequest,
    MicrosoftEdgeZone
  >;

  @doc("Unregisters a subscription for a Public MEC Edge Zone")
  unregister is ArmResourceActionNoBodySync<PublicMecEdgeZone>;
}
