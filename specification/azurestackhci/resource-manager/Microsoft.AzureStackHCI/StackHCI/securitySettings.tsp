import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("Security settings proxy resource")
model SecuritySetting
  is Azure.ResourceManager.ProxyResource<SecurityProperties> {
  ...ResourceNameParameter<
    Resource = SecuritySetting,
    KeyName = "securitySettingsName",
    SegmentName = "securitySettings"
  >;
}

@armResourceOperations
interface SecuritySettings {
  @doc("Get a SecuritySetting")
  get is ArmResourceRead<SecuritySetting>;

  @doc("Create a security setting")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecuritySetting>;

  @doc("Delete a SecuritySetting")
  delete is ArmResourceDeleteWithoutOkAsync<SecuritySetting>;

  @doc("List SecuritySetting resources by Clusters")
  listByClusters is ArmResourceListByParent<SecuritySetting>;
}

@@doc(SecuritySetting.name, "Name of SecuritySetting");

////////////////////models////////////////////

@doc("Represents the compliance assignment type of a resource.")
union ComplianceAssignmentType {
  string,

  @doc("Report on the state of the machine, but don't make changes.")
  Audit: "Audit",

  @doc("Applied to the machine. If it drifts, the local service inside the machine makes a correction at the next evaluation.")
  ApplyAndAutoCorrect: "ApplyAndAutoCorrect",
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

@doc("Security compliance properties of the resource")
model SecurityComplianceStatus {
  @doc("Indicates whether HCI hosts meets secured-core server requirements.")
  @visibility(Lifecycle.Read)
  securedCoreCompliance?: ComplianceStatus;

  @doc("Indicates whether HCI hosts have enforced consistent Windows Defender Application Control.")
  @visibility(Lifecycle.Read)
  wdacCompliance?: ComplianceStatus;

  @doc("Indicates whether data at-rest encryption is enabled on Azure Stack HCI clustered volumes.")
  @visibility(Lifecycle.Read)
  dataAtRestEncrypted?: ComplianceStatus;

  @doc("Indicates whether HCI cluster has data in-transit protection.")
  @visibility(Lifecycle.Read)
  dataInTransitProtected?: ComplianceStatus;

  @doc("Time in UTC when compliance status was last updated.")
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;
}

@doc("Security properties of the resource")
model SecurityProperties {
  @doc("Secured Core Compliance Assignment")
  securedCoreComplianceAssignment?: ComplianceAssignmentType;

  @doc("WDAC Compliance Assignment")
  wdacComplianceAssignment?: ComplianceAssignmentType;

  @doc("SMB encryption for intra-cluster traffic Compliance Assignment")
  smbEncryptionForIntraClusterTrafficComplianceAssignment?: ComplianceAssignmentType;

  @doc("Security Compliance Status")
  @visibility(Lifecycle.Read)
  securityComplianceStatus?: SecurityComplianceStatus;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
