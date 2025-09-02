import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("Cluster details.")
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;
}

@doc("The provisioning state of a resource.")
model ClusterProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The provisioning state of a resource.")
union ProvisioningState {
  string,

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("The resource provision state is not specified")
  NotSpecified: "NotSpecified",

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("Security settings proxy resource")
@parentResource(Cluster)
model SecuritySetting
  is Azure.ResourceManager.ProxyResource<SecurityProperties> {
  ...ResourceNameParameter<
    Resource = SecuritySetting,
    NamePattern = "^default$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface SecuritySettings {
  @doc("Get a SecuritySetting")
  get is ArmResourceRead<SecuritySetting>;

  @doc("Create a security setting")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecuritySetting>;

  @doc("Delete a SecuritySetting")
  delete is ArmResourceDeleteSync<SecuritySetting>;

  @doc("List SecuritySetting resources by Clusters")
  listByClusters is ArmResourceListByParent<SecuritySetting>;

  @doc("Remediate a group of settings within SecuritySetting")
  remediate is ArmResourceActionNoResponseContentAsync<
    SecuritySetting,
    Recommendation
  >;
}

@doc("Security properties of the resource")
model SecurityProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Security Compliance Status")
  @visibility(Lifecycle.Read)
  securityComplianceStatus: SecurityComplianceStatus;

  @doc("Desired security settings")
  @Azure.ResourceManager.identifiers(#[])
  desiredSettings: Array<DesiredSetting>;

  @doc("Reported compliance states for security settings")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  reportedComplianceStates: Array<ReportedComplianceState>;

  @doc("Secured Core Compliance Assignment")
  securedCoreComplianceAssignment?: ComplianceAssignmentType;

  @doc("WDAC Compliance Assignment")
  wdacComplianceAssignment?: ComplianceAssignmentType;

  @doc("SMB encryption for intra-cluster traffic Compliance Assignment")
  smbEncryptionForIntraClusterTrafficComplianceAssignment?: ComplianceAssignmentType;
}

@doc("Desired security setting")
model DesiredSetting {
  @doc("Name of the setting")
  settingName: string;

  @doc("Value of the setting")
  value: string;
}

@doc("Reported compliance state of a security setting")
model ReportedComplianceState {
  @doc("Name of the setting")
  @visibility(Lifecycle.Read)
  settingName: string;

  @doc("Aggregated compliance state value of the setting across all nodes of the cluster")
  @visibility(Lifecycle.Read)
  value: ComplianceStatus;

  @doc("Per machine compliance state value and reason for it")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  perMachineStates: Array<MachineComplianceState>;
}

@doc("Compliance state on single machine")
model MachineComplianceState {
  @doc("Name of the machine")
  @visibility(Lifecycle.Read)
  machineName: string;

  @doc("Compliance state value of the setting")
  @visibility(Lifecycle.Read)
  value: ComplianceStatus;

  @doc("Compliance score of the setting")
  @visibility(Lifecycle.Read)
  percentScore?: string;

  @doc("Reason for the compliance state of the machine")
  @visibility(Lifecycle.Read)
  reason: string;
}

@doc("Name of the recommendation")
model Recommendation {
  @doc("Name of the recommendation")
  recommendationName: string;
}

@doc("Security compliance properties of the resource")
model SecurityComplianceStatus {
  @doc("Indicates whether HCI hosts meets secured-core server requirements.")
  @visibility(Lifecycle.Read)
  securedCoreCompliance: ComplianceStatus;

  @doc("Indicates whether HCI hosts have enforced consistent Windows Defender Application Control.")
  @visibility(Lifecycle.Read)
  wdacCompliance: ComplianceStatus;

  @doc("Indicates whether data at-rest encryption is enabled on Azure Stack HCI clustered volumes.")
  @visibility(Lifecycle.Read)
  dataAtRestEncrypted: ComplianceStatus;

  @doc("Indicates whether HCI cluster has data in-transit protection.")
  @visibility(Lifecycle.Read)
  dataInTransitProtected: ComplianceStatus;

  @doc("Contains details about HCI cluster's compliance with security baseline.")
  @visibility(Lifecycle.Read)
  securityBaseline: SecurityBaseline;

  @doc("Time in UTC when compliance status was last updated.")
  @visibility(Lifecycle.Read)
  lastUpdated: string;
}

@doc("Compliance state of security baseline")
model SecurityBaseline {
  @doc("Status of compliance")
  securityBaselineCompliance: ComplianceStatus;

  @doc("Aggregated compliance score across cluster nodes")
  @visibility(Lifecycle.Read)
  percentScore: string;

  @doc("Per machine compliance state value and reason for it")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  perMachineStates: Array<MachineComplianceState>;
}

@doc("Represents the compliance status of a resource.")
union ComplianceStatus {
  string,

  @doc("The resource is compliant")
  Compliant: "Compliant",

  @doc("The resource is non-compliant")
  NonCompliant: "NonCompliant",

  @doc("The resource compliance status is pending")
  Pending: "Pending",
}

@doc("Represents the compliance assignment type of a resource.")
union ComplianceAssignmentType {
  string,

  @doc("Report on the state of the machine, but don't make changes.")
  Audit: "Audit",

  @doc("Applied to the machine. If it drifts, the local service inside the machine makes a correction at the next evaluation.")
  ApplyAndAutoCorrect: "ApplyAndAutoCorrect",
}
