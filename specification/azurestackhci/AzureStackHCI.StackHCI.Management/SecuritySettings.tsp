import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Security settings proxy resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@parentResource(Cluster)
@discriminator("kind")
model SecuritySetting is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = SecuritySetting,
    KeyName = "securitySettingsName",
    SegmentName = "securitySettings",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  /**
   * Cluster kind to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @visibility("read", "create")
  kind: EdgeSolutionType;
}

@armResourceOperations
interface SecuritySettings {
  /**
   * Get a SecuritySetting
   */
  get is ArmResourceRead<SecuritySetting>;

  /**
   * Create a security setting
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecuritySetting>;

  /**
   * Delete a SecuritySetting
   */
  delete is ArmResourceDeleteWithoutOkAsync<SecuritySetting>;

  /**
   * List SecuritySetting resources by Clusters
   */
  listByClusters is ArmResourceListByParent<SecuritySetting>;
}

@@doc(SecuritySetting.name, "Name of security setting");

/////////////////////models/////////////////////
using Azure.ResourceManager.Foundations;

/**
 * Represents the compliance status of a resource.
 */
union ComplianceStatus {
  string,

  /**
   * The resource is compliant
   */
  Compliant: "Compliant",

  /**
   * The resource is non-compliant
   */
  NonCompliant: "NonCompliant",

  /**
   * The resource compliance status is pending
   */
  Pending: "Pending",
}

/**
 * Represents the compliance assignment type of a resource.
 */
union ComplianceAssignmentType {
  string,

  /**
   * Report on the state of the machine, but don't make changes.
   */
  Audit: "Audit",

  /**
   * Applied to the machine. If it drifts, the local service inside the machine makes a correction at the next evaluation.
   */
  ApplyAndAutoCorrect: "ApplyAndAutoCorrect",
}

/**
 * Security compliance properties of the resource
 */
model SecurityComplianceStatus {
  /**
   * Indicates whether HCI hosts meets secured-core server requirements.
   */
  @visibility("read")
  securedCoreCompliance?: ComplianceStatus;

  /**
   * Indicates whether HCI hosts have enforced consistent Windows Defender Application Control.
   */
  @visibility("read")
  wdacCompliance?: ComplianceStatus;

  /**
   * Indicates whether data at-rest encryption is enabled on Azure Stack HCI clustered volumes.
   */
  @visibility("read")
  dataAtRestEncrypted?: ComplianceStatus;

  /**
   * Indicates whether HCI cluster has data in-transit protection.
   */
  @visibility("read")
  dataInTransitProtected?: ComplianceStatus;

  /**
   * Time in UTC when compliance status was last updated.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

/**
 * Security properties of the resource
 */
model WindowsSecuritySettingsProperties {
  /**
   * Secured Core Compliance Assignment
   */
  securedCoreComplianceAssignment?: ComplianceAssignmentType;

  /**
   * WDAC Compliance Assignment
   */
  wdacComplianceAssignment?: ComplianceAssignmentType;

  /**
   * SMB encryption for intra-cluster traffic Compliance Assignment
   */
  smbEncryptionForIntraClusterTrafficComplianceAssignment?: ComplianceAssignmentType;

  /**
   * Security Compliance Status
   */
  @visibility("read")
  securityComplianceStatus?: SecurityComplianceStatus;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Deployment Configuration for Windows-based Cluster deployment.
 */
model WindowsSecuritySetting extends SecuritySetting {
  /**
   * properties for Cluster deployment configuration.
   */
  ...WindowsSecuritySettingsProperties;

  /**
   * Cluster kind to support polymorphic resource.
   */
  kind: "WindowsServer";
}
