import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@doc("AO5GC Network Function Resource")
model NetworkFunctionResource
  is TrackedResource<NetworkFunctionResourceProperties> {
  @doc("The name of the network function")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(63)
  @key("networkFunctionName")
  @path
  @segment("networkFunctions")
  @visibility("create", "read")
  name: string;
}

@doc("Network Function Properties.")
model NetworkFunctionResourceProperties {
  @doc("Provisioned SKU Value.")
  @visibility("create", "read")
  sku: SkuDefinitions;

  @doc("Type of network function")
  @visibility("create", "read")
  networkFunctionType: NetworkFunctionType;

  @doc("Administrative state of the network function")
  networkFunctionAdministrativeState: NetworkFunctionAdministrativeState;

  @doc("Operational state of the network function")
  @visibility("read")
  networkFunctionOperationalStatus?: NetworkFunctionOperationalStatus;

  @doc("Count of infrastructure elements used by this network function (vCPUs, in units of 8)")
  @visibility("read")
  infrastructureElementCount?: int32;

  @doc("Capacity of the network function in units of 10000.  This represents the session count or the Simultaneously Attached Users (SAU) count as applicable")
  @visibility("create", "read")
  capacity?: int32;

  @doc("User provided description")
  userDescription?: string;

  @doc("User provided deployment notes.  This is used to optionally provide details about the NF deployment")
  deploymentNotes?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponse<TResource>;

@armResourceOperations(NetworkFunctionResource)
interface NetworkFunctions {
  get is ArmResourceRead<NetworkFunctionResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NetworkFunctionResource>;
  updateTags is ArmTagsPatchSync<NetworkFunctionResource>;
  delete is ArmResourceDeleteSync<NetworkFunctionResource>;
  listByResourceGroup is ArmResourceListByParent<NetworkFunctionResource>;
  listBySubscription is ArmListBySubscription<NetworkFunctionResource>;
}

@doc("SKU Definitions")
enum SkuDefinitions {
  @doc("Azure Lab SKU")
  AzureLab,

  @doc("Azure Production SKU")
  AzureProduction,

  @doc("Nexus Lab SKU")
  NexusLab,

  @doc("Nexus Production SKU")
  NexusProduction,
}

@doc("Type of Network Function")
enum NetworkFunctionType {
  @doc("Access and Mobility Function")
  AMF,

  @doc("Session Management Function")
  SMF,

  @doc("User Plane Function")
  UPF,

  @doc("Network Repository Function")
  NRF,

  @doc("Network Slice Selection Function")
  NSSF,

  @doc("Mobility Management Entity")
  MME,

  @doc("System Architecture Evolution Gateway Control Plane, control and user plane separation (CUPS) architecture")
  SaegwControlPlane,

  @doc("System Architecture Evolution Gateway User Plane, control and user plane separation (CUPS) architecture")
  SaegwUserPlane,

  @doc("System Architecture Evolution Gateway.  This combines the Serving Gateway (SGW) and the Packet Data Network Gateway (PGW) functionality")
  Saegw,

  @doc("Evolved Packet Data Gateway")
  ePDG,

  @doc("Non-3GPP Interworking Function")
  N3IWF,

  @doc("Remote Platform As A Service Components")
  RemotePaaS,

  @doc("Element Management System")
  EMS,

  @doc("Operations and Policy Manager")
  OperationsPolicyManager,
}

@doc("Network Function Administrative State enumerations")
enum NetworkFunctionAdministrativeState {
  @doc("Resource has been commissioned")
  Commissioned,

  @doc("Resource has been decommissioned")
  Decommissioned,
}

@doc("Network Function Operational Status enumerations")
enum NetworkFunctionOperationalStatus {
  @doc("Resource is inactive")
  Inactive,

  @doc("Resource has been deployed, awaiting provisioning")
  InstantiatedNotProvisioned,

  @doc("Resource has been deployed and provisioned, awaiting testing")
  InstantiatedProvisioned,

  @doc("Resource is fully deployed and operational")
  Active,
}

@doc("Provisioning state of the resource")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning,

  @doc("Resource is updating")
  Updating,

  @doc("Resource is getting deleted")
  Deleting,

  @doc("Resource has been accepted")
  Accepted,
}
