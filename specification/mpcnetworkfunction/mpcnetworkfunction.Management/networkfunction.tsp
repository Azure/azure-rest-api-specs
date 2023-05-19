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
interface NetworkFunctions
  extends TrackedResourceOperations<NetworkFunctionResource, NetworkFunctionResourceProperties> {
    delete is ArmResourceDeleteSync<NetworkFunctionResource>;
    createOrUpdate is ArmResourceCreateOrUpdateSync<NetworkFunctionResource>
}

@doc("Type of Workload")
enum WorkloadType {
  AMF,
  SMF,
  UPF,
  NRF,
  NSSF,
  MME,
  SGWControlPlane,
  PGWControlPlane,
  SGWUserPlane,
  PGWUserPlane,
  GGSN,
  SGSN,
  ePDG,
  N3IWF,
  PaaS,
  EMS,
  OperationsPolicyManager
}

@doc("Network Function Administrative State enumerations")
enum NetworkFunctionAdministrativeState {
  Commissioned,
  Decommissioned
}

@doc("Network Function Operational Status enumerations")
enum NetworkFunctionOperationalStatus {
  Inactive,
  InstantiatedNotProvisioned,
  InstantiatedProvisioned,
  Active
}

@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}
