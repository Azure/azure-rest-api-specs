import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.AppComplianceAutomation;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum ReportStatus {
  Active,
  Failed,
  Disabled,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Creating,
  Deleting,
  Updating,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum CategoryType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

enum CategoryStatus {
  Healthy,
  Unhealthy,
}

enum ControlFamilyType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

enum ControlFamilyStatus {
  Healthy,
  Unhealthy,
}

enum ControlType {
  FullyAutomated,
  PartiallyAutomated,
  Manual,
}

enum ControlStatus {
  Passed,
  Failed,
  NotApplicable,
}

enum AssessmentSeverity {
  High,
  Medium,
  Low,
}

enum IsPass {
  True,
  False,
}

enum ResourceStatus {
  Healthy,
  Unhealthy,
  NotApplicable,
}

enum DownloadType {
  ComplianceReport,
  CompliancePdfReport,
  ComplianceDetailedPdfReport,
  ResourceList,
}

enum ComplianceState {
  Healthy,
  Unhealthy,
}

@doc("Report's properties.")
model ReportProperties {
  @doc("Report id in database.")
  @visibility("read")
  id?: string;

  @doc("Report status.")
  @visibility("read")
  status?: ReportStatus;

  @doc("Report's tenant id.")
  @visibility("read")
  tenantId?: string;

  @doc("Report name.")
  @visibility("read")
  reportName?: string;

  @doc("Report offer Guid.")
  offerGuid?: string;

  @doc("""
Report collection trigger time's time zone, the available list can be obtained by executing \"Get-TimeZone -ListAvailable\" in PowerShell.
An example of valid timezone id is \"Pacific Standard Time\".
""")
  timeZone: string;

  @doc("Report collection trigger time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerTime: utcDateTime;

  @doc("Report next collection trigger time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextTriggerTime?: utcDateTime;

  @doc("Report last collection trigger time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTriggerTime?: utcDateTime;

  @doc("List of subscription Ids.")
  @visibility("read")
  subscriptions?: string[];

  @doc("List of resource data.")
  resources: ResourceMetadata[];

  @doc("Report compliance status.")
  @visibility("read")
  complianceStatus?: ReportComplianceStatus;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Single resource Id's metadata.")
model ResourceMetadata {
  @doc("Resource Id - e.g. \"/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1\".")
  resourceId: string;

  @doc("Resource type.")
  resourceType?: string;

  @doc("Resource kind.")
  resourceKind?: string;

  @doc("Resource name.")
  resourceName?: string;

  @doc("Resource's tag type.")
  tags?: Record<string>;
}

@doc("A list which includes all the compliance result for one report.")
model ReportComplianceStatus {
  @doc("The Microsoft 365 certification name.")
  m365?: OverviewStatus;
}

@doc("The overview of the compliance result for one report.")
model OverviewStatus {
  @doc("The count of all passed full automation control.")
  passedCount?: int32;

  @doc("The count of all failed full automation control.")
  failedCount?: int32;

  @doc("The count of all manual control.")
  manualCount?: int32;
}

@doc("Snapshot's properties.")
model SnapshotProperties {
  @doc("Snapshot id in the database.")
  @visibility("read")
  id?: string;

  @doc("Snapshot name.")
  @visibility("read")
  snapshotName?: string;

  @doc("The timestamp of resource creation (UTC).")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Azure lifecycle management")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The report essential info.")
  @visibility("read")
  reportProperties?: ReportProperties;

  // @doc("Metadata pertaining to creation and last modification of the resource.")
  // @visibility("read")
  // reportSystemData?: SystemData;

  @doc("List of compliance results.")
  @visibility("read")
  complianceResults?: ComplianceResult[];
}

@doc("A class represent the compliance result.")
model ComplianceResult {
  @doc("The name of the compliance. e.g. \"M365\"")
  @visibility("read")
  complianceName?: string;

  @doc("List of categories.")
  @visibility("read")
  categories?: Category[];
}

@doc("A class represent the compliance category.")
model Category {
  @doc("The name of the compliance category. e.g. \"Operational Security\"")
  @visibility("read")
  categoryName?: string;

  @doc("The category type ")
  @visibility("read")
  categoryType?: CategoryType;

  @doc("Category status.")
  @visibility("read")
  categoryStatus?: CategoryStatus;

  @doc("List of control families.")
  @visibility("read")
  controlFamilies?: ControlFamily[];
}

@doc("A class represent the control family.")
model ControlFamily {
  @doc("The name of the control family. e.g. \"Malware Protection - Anti-Virus\"")
  @visibility("read")
  familyName?: string;

  @doc("The control family type ")
  @visibility("read")
  familyType?: ControlFamilyType;

  @doc("Control family status.")
  @visibility("read")
  familyStatus?: ControlFamilyStatus;

  @doc("List of controls.")
  @visibility("read")
  controls?: Control[];
}

@doc("A class represent the control.")
model Control {
  @doc("The Id of the control. e.g. \"Operational Security#10\"")
  @visibility("read")
  controlId?: string;

  @doc("The short name of the control. e.g. \"Unsupported OS and Software.\"")
  @visibility("read")
  controlShortName?: string;

  @doc("The full name of the control. e.g. \"Validate that unsupported operating systems and software components are not in use.\"")
  @visibility("read")
  controlFullName?: string;

  @doc("The control type ")
  @visibility("read")
  controlType?: ControlType;

  @doc("The control's description")
  @visibility("read")
  controlDescription?: string;

  @doc("The hyper link to the control's description'.")
  @visibility("read")
  controlDescriptionHyperLink?: string;

  @doc("Control status.")
  @visibility("read")
  controlStatus?: ControlStatus;

  @doc("List of assessments.")
  @visibility("read")
  assessments?: Assessment[];
}

@doc("A class represent the assessment.")
model Assessment {
  @doc("The name of the assessment.")
  @visibility("read")
  name?: string;

  @doc("The severity level of this assessment.")
  @visibility("read")
  severity?: AssessmentSeverity;

  @doc("The description of the assessment.")
  @visibility("read")
  description?: string;

  @doc("The remediation of the assessment.")
  @visibility("read")
  remediation?: string;

  @doc("Indicates whether all the resource(s) are compliant.")
  @visibility("read")
  isPass?: IsPass;

  @doc("The policy id mapping to this assessment.")
  @visibility("read")
  policyId?: string;

  @doc("List of resource assessments.")
  @visibility("read")
  resourceList?: AssessmentResource[];
}

@doc("A class represent the assessment resource.")
model AssessmentResource {
  @doc("The Id of the resource.")
  @visibility("read")
  resourceId?: string;

  @doc("Resource status.")
  @visibility("read")
  resourceStatus?: ResourceStatus;

  @doc("The reason for the N/A resource.")
  @visibility("read")
  reason?: string;

  @doc("The status change date for the resource. For unavailable date, set it as N/A.")
  @visibility("read")
  statusChangeDate?: string;
}

@doc("Snapshot's download request.")
model SnapshotDownloadRequest {
  @doc("Tenant id.")
  reportCreatorTenantId?: string;

  @doc("Indicates the download type.")
  downloadType: DownloadType;

  @doc("The offerGuid which mapping to the reports.")
  @minLength(1)
  offerGuid?: string;
}

@doc("Object that includes all the possible response for the download operation.")
model DownloadResponse {
  @doc("List of the reports")
  @visibility("read")
  resourceList?: ResourceItem[];

  @doc("List of the compliance result")
  @visibility("read")
  complianceReport?: ComplianceReportItem[];

  @doc("compliance pdf report")
  @visibility("read")
  compliancePdfReport?: DownloadResponseCompliancePdfReport;

  @doc("compliance detailed pdf report")
  @visibility("read")
  complianceDetailedPdfReport?: DownloadResponseComplianceDetailedPdfReport;
}

@doc("Resource Id.")
model ResourceItem {
  @doc("The subscription Id of this resource.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The resource group name of this resource.")
  @visibility("read")
  resourceGroup?: string;

  @doc("The resource type of this resource.")
  @visibility("read")
  resourceType?: string;

  @doc("The resource Id - e.g. \"/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1\".")
  @visibility("read")
  resourceId?: string;
}

@doc("Object that includes all the content for single compliance result.")
model ComplianceReportItem {
  @doc("The category name.")
  @visibility("read")
  categoryName?: string;

  @doc("The control Id - e.g. \"1\".")
  @visibility("read")
  controlId?: string;

  @doc("The control name.")
  @visibility("read")
  controlName?: string;

  @doc("The control type.")
  @visibility("read")
  controlType?: ControlType;

  @doc("The compliance result's status.")
  @visibility("read")
  complianceState?: ComplianceState;

  @doc("The compliance result mapped policy Id.")
  @visibility("read")
  policyId?: string;

  @doc("The policy's display name.")
  @visibility("read")
  policyDisplayName?: string;

  @doc("The policy's detail description.")
  @visibility("read")
  policyDescription?: string;

  @doc("The compliance result mapped subscription Id.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The compliance result mapped resource group.")
  @visibility("read")
  resourceGroup?: string;

  @doc("The compliance result mapped resource type.")
  @visibility("read")
  resourceType?: string;

  @doc("The compliance result mapped resource Id - e.g. \"/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1\".")
  @visibility("read")
  resourceId?: string;

  @doc("The compliance result last changed date - e.g. \"2022-10-24T02:55:16.3274379Z\". For unavailable date, set it as \"N/A\".")
  @visibility("read")
  statusChangeDate?: string;
}

@doc("compliance pdf report")
model DownloadResponseCompliancePdfReport {
  @doc("uri of compliance pdf report")
  @visibility("read")
  sasUri?: string;
}

@doc("compliance detailed pdf report")
model DownloadResponseComplianceDetailedPdfReport {
  @doc("uri of compliance detailed pdf report")
  @visibility("read")
  sasUri?: string;
}
