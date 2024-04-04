import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("The current provisioning state.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning,

  @doc("Resource is updating")
  Updating,

  @doc("Resource creation state is unknown.")
  Unknown,

  @doc("Resource has been accepted.")
  Accepted,

  @doc("Resource is getting deleted.")
  Deleting,

  @doc("Resource has been deleted.")
  Deleted,
}

@doc("The type of User Equipment Address Pool.")
enum UserEquipmentAddressPoolType {
  @doc("User equipment address pool type static.")
  Static,

  @doc("User equipment address pool type dynamic.")
  Dynamic,

  @doc("User equipment address pool type unmanaged.")
  Unmanaged,
}

@doc("The platform type where packet core is deployed. The contents of this enum can change.")
enum PlatformType {
  @doc("If this option is chosen, you must set one of \"azureStackEdgeDevice\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `AKS-HCI`,

  @doc("If this option is chosen, you must set one of \"azureStackHciCluster\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `3P-AZURE-STACK-HCI`,

  @doc("If this option is chosen, you must set \"nexusEdgeCluster\".")
  Nexus,
}

@doc("Preemption capability.")
enum PreemptionCapability {
  @doc("Cannot preempt")
  NotPreempt,

  @doc("May preempt")
  MayPreempt,
}

@doc("Preemption vulnerability.")
enum PreemptionVulnerability {
  @doc("Cannot be preempted")
  NotPreemptable,

  @doc("May be preempted")
  Preemptable,
}

@doc("The provisioning state of a resource e.g. SIM/SIM policy on a site.")
enum SiteProvisioningState {
  @doc("The resource should not be provisioned on this site.")
  NotApplicable,

  @doc("The resource is being added to this site.")
  Adding,

  @doc("The resource is being updated on this site.")
  Updating,

  @doc("The resource is being deleted from this site.")
  Deleting,

  @doc("The resource is provisioned on this site.")
  Provisioned,

  @doc("The resource failed to be provisioned on this site.")
  Failed,
}

@doc("RAT Type")
enum RatType {
  @doc("RAT type 4G.")
  `4G`,

  @doc("RAT type 5G.")
  `5G`,
}

@doc("Type of managed service identity (currently only UserAssigned allowed).")
enum ManagedServiceIdentityType {
  @doc("No managed identity is assigned.")
  None,

  @doc("A managed identity assigned by the user.")
  UserAssigned,
}

@doc("State of the UE.")
enum UeState {
  @doc("UE has been connected.")
  Connected,

  @doc("UE is idle.")
  Idle,

  @doc("UE has been detached.")
  Detached,

  @doc("UE has been deregistered.")
  Deregistered,

  @doc("UE state is unknown.")
  Unknown,
}

@doc("Infrastructure Type Definitions")
enum InfrastructureType {
  @doc("Azure Core")
  AzureCore,

  @doc("Azure Operator Nexus")
  AzureOperatorNexus,
}

@doc("Deployment Type Definitions")
enum SkuDeploymentType {
  @doc("Production Deployment")
  Production,

  @doc("Lab Deployment")
  Lab,
}

@doc("Cluster Type Definitions")
enum ClusterType {
  @doc("Azure Kubernetes Service")
  Aks,

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks,
}
