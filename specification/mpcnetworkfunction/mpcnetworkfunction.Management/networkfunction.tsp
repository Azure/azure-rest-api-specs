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
  sku: string;

  @doc("Types of workloads co-located in the same infrastructure")
  @visibility("create", "read")
  workloadTypes: Array<WorkloadType>;

  @doc("Administrative state of the network function")
  networkFunctionAdministrativeState: NetworkFunctionAdministrativeState;

  @doc("Operational state of the network function")
  @visibility("read")
  networkFunctionOperationalStatus?: NetworkFunctionOperationalStatus;

  @doc("Count of infrastructure elements (kubernetes nodes for containerized network functions, virtual machines for virtual network functions)")
  @visibility("read")
  infrastructureElementCount?: int32;

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

@doc("Type of Workload")
enum WorkloadType {
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
  @doc("Serving Gateway Control Plane")
  SGWControlPlane,
  @doc("Packet Data Network Gateway Control Plane")
  PGWControlPlane,
  @doc("Serving Gateway User Plane")
  SGWUserPlane,
  @doc("Packet Data Network Gateway User Plane")
  PGWUserPlane,
  @doc("Gateway GPRS support node")
  GGSN,
  @doc("Serving GPRS support node")
  SGSN,
  @doc("Evolved Packet Data Gateway")
  ePDG,
  @doc("N3 Interworking Function")
  N3IWF,
  @doc("Platform As A Service")
  PaaS,
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
