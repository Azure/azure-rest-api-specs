import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Security settings proxy resource
 */
@parentResource(Cluster)
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
@@doc(SecuritySetting.properties,
  "The resource-specific properties for this resource."
);

// Models

/**
 * Security properties of the resource
 */
model SecurityProperties {
  /**
   * Secured Core Compliance Assignment
   */
  securedCoreComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * WDAC Compliance Assignment
   */
  wdacComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * SMB encryption for intra-cluster traffic Compliance Assignment
   */
  smbEncryptionForIntraClusterTrafficComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * Security Compliance Status
   */
  @visibility(Lifecycle.Read)
  securityComplianceStatus?: SecurityComplianceStatus;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Security compliance properties of the resource
 */
model SecurityComplianceStatus {
  /**
   * Indicates whether HCI hosts meets secured-core server requirements.
   */
  @visibility(Lifecycle.Read)
  securedCoreCompliance?: ComplianceStatus;

  /**
   * Indicates whether HCI hosts have enforced consistent Windows Defender Application Control.
   */
  @visibility(Lifecycle.Read)
  wdacCompliance?: ComplianceStatus;

  /**
   * Indicates whether data at-rest encryption is enabled on Azure Stack HCI clustered volumes.
   */
  @visibility(Lifecycle.Read)
  dataAtRestEncrypted?: ComplianceStatus;

  /**
   * Indicates whether HCI cluster has data in-transit protection.
   */
  @visibility(Lifecycle.Read)
  dataInTransitProtected?: ComplianceStatus;

  /**
   * Time in UTC when compliance status was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}
