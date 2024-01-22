import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AppComplianceAutomation;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Report status.
 */
enum ReportStatus {
  Active,
  Failed,
  Disabled,
}

/**
 * Resource provisioning states.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

/**
 * Indicates the compliance category type.
 */
enum CategoryType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

/**
 * Indicates the category status.
 */
enum CategoryStatus {
  Healthy,
  Unhealthy,
}

/**
 * Indicates the control family type.
 */
enum ControlFamilyType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

/**
 * Indicates the control family status.
 */
enum ControlFamilyStatus {
  Healthy,
  Unhealthy,
}

/**
 * Indicates the control type.
 */
enum ControlType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

/**
 * Indicates the control status.
 */
enum ControlStatus {
  Passed,
  Failed,
  NotApplicable,
}

/**
 * Indicates the assessment severity.
 */
enum AssessmentSeverity {
  High,
  Medium,
  Low,
}

/**
 * Indicates whether all the resource(s) are compliant.
 */
enum IsPass {
  True,
  False,
}

/**
 * Indicates the resource status.
 */
enum ResourceStatus {
  Healthy,
  Unhealthy,
  NotApplicable,
}

/**
 * Indicates the download type.
 */
enum DownloadType {
  ComplianceReport,
  CompliancePdfReport,
  ComplianceDetailedPdfReport,
  ResourceList,
}

/**
 * The compliance result's status.
 */
enum ComplianceState {
  Healthy,
  Unhealthy,
}

/**
 * Report's properties.
 */
model ReportProperties {
  /**
   * Report id in database.
   */
  @visibility("read")
  id?: string;

  /**
   * Report status.
   */
  @visibility("read")
  status?: ReportStatus;

  /**
   * Report's tenant id.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Report name.
   */
  @visibility("read")
  reportName?: string;

  /**
   * Report offer Guid.
   */
  offerGuid?: string;

  /**
* Report collection trigger time's time zone, the available list can be obtained by executing "Get-TimeZone -ListAvailable" in PowerShell.
An example of valid timezone id is "Pacific Standard Time".
*/
  timeZone: string;

  /**
   * Report collection trigger time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerTime: utcDateTime;

  /**
   * Report next collection trigger time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextTriggerTime?: utcDateTime;

  /**
   * Report last collection trigger time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTriggerTime?: utcDateTime;

  /**
   * List of subscription Ids.
   */
  @visibility("read")
  subscriptions?: string[];

  /**
   * List of resource data.
   */
  resources: ResourceMetadata[];

  /**
   * Report compliance status.
   */
  @visibility("read")
  complianceStatus?: ReportComplianceStatus;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Single resource Id's metadata.
 */
model ResourceMetadata {
  /**
   * Resource Id - e.g. "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1".
   */
  resourceId: string;

  /**
   * Resource type.
   */
  resourceType?: string;

  /**
   * Resource kind.
   */
  resourceKind?: string;

  /**
   * Resource name.
   */
  resourceName?: string;

  /**
   * Resource's tag type.
   */
  tags?: Record<string>;
}

/**
 * A list which includes all the compliance result for one report.
 */
model ReportComplianceStatus {
  /**
   * The Microsoft 365 certification name.
   */
  m365?: OverviewStatus;
}

/**
 * The overview of the compliance result for one report.
 */
model OverviewStatus {
  /**
   * The count of all passed full automation control.
   */
  passedCount?: int32;

  /**
   * The count of all failed full automation control.
   */
  failedCount?: int32;

  /**
   * The count of all manual control.
   */
  manualCount?: int32;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * A class represent a AppComplianceAutomation report resource update properties.
 */
model ReportResourcePatch {
  /**
   * Report property.
   */
  properties?: ReportProperties;
}

/**
 * Snapshot's properties.
 */
model SnapshotProperties {
  /**
   * Snapshot id in the database.
   */
  @visibility("read")
  id?: string;

  /**
   * Snapshot name.
   */
  @visibility("read")
  snapshotName?: string;

  /**
   * The timestamp of resource creation (UTC).
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The report essential info.
   */
  @visibility("read")
  reportProperties?: ReportProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  reportSystemData?: SystemData;

  /**
   * List of compliance results.
   */
  @visibility("read")
  complianceResults?: ComplianceResult[];
}

/**
 * A class represent the compliance result.
 */
model ComplianceResult {
  /**
   * The name of the compliance. e.g. "M365"
   */
  @visibility("read")
  complianceName?: string;

  /**
   * List of categories.
   */
  @visibility("read")
  categories?: Category[];
}

/**
 * A class represent the compliance category.
 */
model Category {
  /**
   * The name of the compliance category. e.g. "Operational Security"
   */
  @visibility("read")
  categoryName?: string;

  /**
   * The category type
   */
  @visibility("read")
  categoryType?: CategoryType;

  /**
   * Category status.
   */
  @visibility("read")
  categoryStatus?: CategoryStatus;

  /**
   * List of control families.
   */
  @visibility("read")
  controlFamilies?: ControlFamily[];
}

/**
 * A class represent the control family.
 */
model ControlFamily {
  /**
   * The name of the control family. e.g. "Malware Protection - Anti-Virus"
   */
  @visibility("read")
  familyName?: string;

  /**
   * The control family type
   */
  @visibility("read")
  familyType?: ControlFamilyType;

  /**
   * Control family status.
   */
  @visibility("read")
  familyStatus?: ControlFamilyStatus;

  /**
   * List of controls.
   */
  @visibility("read")
  controls?: Control[];
}

/**
 * A class represent the control.
 */
model Control {
  /**
   * The Id of the control. e.g. "Operational Security#10"
   */
  @visibility("read")
  controlId?: string;

  /**
   * The short name of the control. e.g. "Unsupported OS and Software."
   */
  @visibility("read")
  controlShortName?: string;

  /**
   * The full name of the control. e.g. "Validate that unsupported operating systems and software components are not in use."
   */
  @visibility("read")
  controlFullName?: string;

  /**
   * The control type
   */
  @visibility("read")
  controlType?: ControlType;

  /**
   * The control's description
   */
  @visibility("read")
  controlDescription?: string;

  /**
   * The hyper link to the control's description'.
   */
  @visibility("read")
  controlDescriptionHyperLink?: string;

  /**
   * Control status.
   */
  @visibility("read")
  controlStatus?: ControlStatus;

  /**
   * List of assessments.
   */
  @visibility("read")
  assessments?: Assessment[];
}

/**
 * A class represent the assessment.
 */
model Assessment {
  /**
   * The name of the assessment.
   */
  @visibility("read")
  name?: string;

  /**
   * The severity level of this assessment.
   */
  @visibility("read")
  severity?: AssessmentSeverity;

  /**
   * The description of the assessment.
   */
  @visibility("read")
  description?: string;

  /**
   * The remediation of the assessment.
   */
  @visibility("read")
  remediation?: string;

  /**
   * Indicates whether all the resource(s) are compliant.
   */
  @visibility("read")
  isPass?: IsPass;

  /**
   * The policy id mapping to this assessment.
   */
  @visibility("read")
  policyId?: string;

  /**
   * List of resource assessments.
   */
  @visibility("read")
  resourceList?: AssessmentResource[];
}

/**
 * A class represent the assessment resource.
 */
model AssessmentResource {
  /**
   * The Id of the resource.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * Resource status.
   */
  @visibility("read")
  resourceStatus?: ResourceStatus;

  /**
   * The reason for the N/A resource.
   */
  @visibility("read")
  reason?: string;

  /**
   * The status change date for the resource. For unavailable date, set it as N/A.
   */
  @visibility("read")
  statusChangeDate?: string;
}

/**
 * Snapshot's download request.
 */
model SnapshotDownloadRequest {
  /**
   * Tenant id.
   */
  reportCreatorTenantId?: string;

  /**
   * Indicates the download type.
   */
  downloadType: DownloadType;

  /**
   * The offerGuid which mapping to the reports.
   */
  @minLength(1)
  offerGuid?: string;
}

/**
 * Object that includes all the possible response for the download operation.
 */
model DownloadResponse {
  /**
   * List of the reports
   */
  @visibility("read")
  resourceList?: ResourceItem[];

  /**
   * List of the compliance result
   */
  @visibility("read")
  complianceReport?: ComplianceReportItem[];

  /**
   * compliance pdf report
   */
  @visibility("read")
  compliancePdfReport?: DownloadResponseCompliancePdfReport;

  /**
   * compliance detailed pdf report
   */
  @visibility("read")
  complianceDetailedPdfReport?: DownloadResponseComplianceDetailedPdfReport;
}

/**
 * Resource Id.
 */
model ResourceItem {
  /**
   * The subscription Id of this resource.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The resource group name of this resource.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * The resource type of this resource.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The resource Id - e.g. "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1".
   */
  @visibility("read")
  resourceId?: string;
}

/**
 * Object that includes all the content for single compliance result.
 */
model ComplianceReportItem {
  /**
   * The category name.
   */
  @visibility("read")
  categoryName?: string;

  /**
   * The control Id - e.g. "1".
   */
  @visibility("read")
  controlId?: string;

  /**
   * The control name.
   */
  @visibility("read")
  controlName?: string;

  /**
   * The control type.
   */
  @visibility("read")
  controlType?: ControlType;

  /**
   * The compliance result's status.
   */
  @visibility("read")
  complianceState?: ComplianceState;

  /**
   * The compliance result mapped policy Id.
   */
  @visibility("read")
  policyId?: string;

  /**
   * The policy's display name.
   */
  @visibility("read")
  policyDisplayName?: string;

  /**
   * The policy's detail description.
   */
  @visibility("read")
  policyDescription?: string;

  /**
   * The compliance result mapped subscription Id.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The compliance result mapped resource group.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * The compliance result mapped resource type.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The compliance result mapped resource Id - e.g. "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1".
   */
  @visibility("read")
  resourceId?: string;

  /**
   * The compliance result last changed date - e.g. "2022-10-24T02:55:16.3274379Z". For unavailable date, set it as "N/A".
   */
  @visibility("read")
  statusChangeDate?: string;
}

/**
 * compliance pdf report
 */
model DownloadResponseCompliancePdfReport {
  /**
   * uri of compliance pdf report
   */
  @visibility("read")
  sasUri?: string;
}

/**
 * compliance detailed pdf report
 */
model DownloadResponseComplianceDetailedPdfReport {
  /**
   * uri of compliance detailed pdf report
   */
  @visibility("read")
  sasUri?: string;
}
