import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.MobilePacketCore;

@doc("AO5GC Network Function Resource")
model NetworkFunctionResource
  is TrackedResource<NetworkFunctionResourceProperties> {
  @doc("The name of the network function")
  @key("networkFunctionName")
  @segment("networkFunctions")
  @path
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

@armResourceOperations(NetworkFunctionResource)
interface NetworkFunctions {
    get is ArmResourceRead<NetworkFunctionResource>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<NetworkFunctionResource>; 
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
  NexusProduction
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
  OperationsPolicyManager
}

@doc("Network Function Administrative State enumerations")
enum NetworkFunctionAdministrativeState {
  @doc("Resource has been commissioned")
  Commissioned,
  @doc("Resource has been decommissioned")
  Decommissioned
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
  Active
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
