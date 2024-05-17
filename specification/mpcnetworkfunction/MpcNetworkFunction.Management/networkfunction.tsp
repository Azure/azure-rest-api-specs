using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

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

@armResourceOperations(NetworkFunctionResource)
interface NetworkFunctions {
  get is ArmResourceRead<NetworkFunctionResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkFunctionResource>;
  updateTags is ArmTagsPatchSync<NetworkFunctionResource>;
  delete is ArmResourceDeleteSync<NetworkFunctionResource>;
  listByResourceGroup is ArmResourceListByParent<NetworkFunctionResource>;
  listBySubscription is ArmListBySubscription<NetworkFunctionResource>;
}

@doc("SKU Definitions")
union SkuDefinitions {
  string,

  @doc("Azure Lab SKU")
  "AzureLab",

  @doc("Azure Production SKU")
  "AzureProduction",

  @doc("Nexus Lab SKU")
  "NexusLab",

  @doc("Nexus Production SKU")
  "NexusProduction",
}

@doc("Type of Network Function")
union NetworkFunctionType {
  string,

  @doc("Access and Mobility Function")
  "AMF",

  @doc("Session Management Function")
  "SMF",

  @doc("User Plane Function")
  "UPF",

  @doc("Network Repository Function")
  "NRF",

  @doc("Network Slice Selection Function")
  "NSSF",

  @doc("Mobility Management Entity")
  "MME",

  @doc("System Architecture Evolution Gateway Control Plane, control and user plane separation (CUPS) architecture")
  "SaegwControlPlane",

  @doc("System Architecture Evolution Gateway User Plane, control and user plane separation (CUPS) architecture")
  "SaegwUserPlane",

  @doc("System Architecture Evolution Gateway.  This combines the Serving Gateway (SGW) and the Packet Data Network Gateway (PGW) functionality")
  "Saegw",

  @doc("Evolved Packet Data Gateway")
  "ePDG",

  @doc("Non-3GPP Interworking Function")
  "N3IWF",

  @doc("Remote Platform As A Service Components")
  "RemotePaaS",

  @doc("Element Management System")
  "EMS",

  @doc("Operations and Policy Manager")
  "OperationsPolicyManager",
}

@doc("Network Function Administrative State enumerations")
union NetworkFunctionAdministrativeState {
  string,

  @doc("Resource has been commissioned")
  "Commissioned",

  @doc("Resource has been decommissioned")
  "Decommissioned",
}

@doc("Network Function Operational Status enumerations")
union NetworkFunctionOperationalStatus {
  string,

  @doc("Resource is inactive")
  "Inactive",

  @doc("Resource has been deployed, awaiting provisioning")
  "InstantiatedNotProvisioned",

  @doc("Resource has been deployed and provisioned, awaiting testing")
  "InstantiatedProvisioned",

  @doc("Resource is fully deployed and operational")
  "Active",
}

@doc("Provisioning state of the resource")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning: "Provisioning",

  @doc("Resource is updating")
  Updating: "Updating",

  @doc("Resource is getting deleted")
  Deleting: "Deleting",

  @doc("Resource has been accepted")
  Accepted: "Accepted",
}
