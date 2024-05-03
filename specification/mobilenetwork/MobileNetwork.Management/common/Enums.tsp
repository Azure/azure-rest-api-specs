import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@doc("The current provisioning state.")
@lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Resource is getting provisioned")
  Provisioning: "Provisioning",

  @doc("Resource is updating")
  Updating: "Updating",

  @doc("Resource creation state is unknown.")
  Unknown: "Unknown",

  @doc("Resource has been accepted.")
  Accepted: "Accepted",

  @doc("Resource is getting deleted.")
  Deleting: "Deleting",

  @doc("Resource has been deleted.")
  Deleted: "Deleted",

  string,
}

@doc("The type of User Equipment Address Pool.")
union UserEquipmentAddressPoolType {
  @doc("User equipment address pool type static.")
  Static: "Static",

  @doc("User equipment address pool type dynamic.")
  Dynamic: "Dynamic",

  @doc("User equipment address pool type unmanaged.")
  Unmanaged: "Unmanaged",

  string,
}

@doc("The platform type where packet core is deployed. The contents of this enum can change.")
union PlatformType {
  @doc("If this option is chosen, you must set one of \"azureStackEdgeDevice\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `AKS-HCI`: "AKS-HCI",

  @doc("If this option is chosen, you must set one of \"azureStackHciCluster\", \"connectedCluster\" or \"customLocation\". If multiple are set, they must be consistent with each other.")
  `3P-AZURE-STACK-HCI`: "3P-AZURE-STACK-HCI",

  @removed(Versions.v2024_06_01)
  @doc("If this option is chosen, you must set \"nexusEdgeCluster\".")
  Nexus: "Nexus",

  string,
}

@doc("Preemption capability.")
union PreemptionCapability {
  @doc("Cannot preempt")
  NotPreempt: "NotPreempt",

  @doc("May preempt")
  MayPreempt: "MayPreempt",

  string,
}

@doc("Preemption vulnerability.")
union PreemptionVulnerability {
  @doc("Cannot be preempted")
  NotPreemptable: "NotPreemptable",

  @doc("May be preempted")
  Preemptable: "Preemptable",

  string,
}

@doc("The provisioning state of a resource e.g. SIM/SIM policy on a site.")
union SiteProvisioningState {
  @doc("The resource should not be provisioned on this site.")
  NotApplicable: "NotApplicable",

  @doc("The resource is being added to this site.")
  Adding: "Adding",

  @doc("The resource is being updated on this site.")
  Updating: "Updating",

  @doc("The resource is being deleted from this site.")
  Deleting: "Deleting",

  @doc("The resource is provisioned on this site.")
  Provisioned: "Provisioned",

  @doc("The resource failed to be provisioned on this site.")
  Failed: "Failed",

  string,
}

@doc("RAT Type")
union RatType {
  @doc("RAT type 4G.")
  `4G`: "4G",

  @doc("RAT type 5G.")
  `5G`: "5G",

  string,
}

@doc("Type of managed service identity (currently only UserAssigned allowed).")
union ManagedServiceIdentityType {
  @doc("No managed identity is assigned.")
  None: "None",

  @doc("A managed identity assigned by the user.")
  UserAssigned: "UserAssigned",

  string,
}

@doc("State of the UE.")
union UeState {
  @doc("UE has been connected.")
  Connected: "Connected",

  @doc("UE is idle.")
  Idle: "Idle",

  @doc("UE has been detached.")
  Detached: "Detached",

  @doc("UE has been deregistered.")
  Deregistered: "Deregistered",

  @doc("UE state is unknown.")
  Unknown: "Unknown",

  string,
}

@doc("Deployment Type Definitions")
union SkuDeploymentType {
  @doc("Production Deployment")
  Production: "Production",

  @doc("Lab Deployment")
  Lab: "Lab",

  string,
}

@doc("Cluster Type Definitions")
union ClusterType {
  @doc("Azure Kubernetes Service")
  Aks: "Aks",

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks: "NexusAks",

  string,
}

@doc("The supported NAS Encryption types.")
union NASEncryptionType {
  @doc("NAS signaling is not encrypted.")
  `NEA0/EEA0`: "NEA0/EEA0",

  @doc("NAS signaling is encrypted with SNOW 3G cipher.")
  `NEA1/EEA1`: "NEA1/EEA1",

  @doc("NAS signaling is encrypted with AES cipher.")
  `NEA2/EEA2`: "NEA2/EEA2",

  string,
}
