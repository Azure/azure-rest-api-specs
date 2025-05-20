import "../main.tsp";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using OpenAPI;
using Azure.Core;

namespace Microsoft.AppComplianceAutomation;

/**
 * Indicates the resource status.
 */
union ResourceStatus {
  @doc("The resource is healthy.")
  Healthy: "Healthy",

  @doc("The resource is unhealthy.")
  Unhealthy: "Unhealthy",

  string,
}

/**
 * Report status.
 */
union ReportStatus {
  @doc("The report is active.")
  Active: "Active",

  @doc("The report is failed.")
  Failed: "Failed",

  @doc("The report is under reviewing.")
  Reviewing: "Reviewing",

  @doc("The report is disabled.")
  Disabled: "Disabled",

  string,
}

/**
 * Resource Origin.
 */
union ResourceOrigin {
  @doc("The resource is from Azure.")
  Azure: "Azure",

  @doc("The resource is from AWS.")
  AWS: "AWS",

  @doc("The resource is from GCP.")
  GCP: "GCP",

  string,
}

/**
 * Resource provisioning states.
 */
union ProvisioningState {
  @doc("The provision is succeeded.")
  Succeeded: "Succeeded",

  @doc("The provision is failed.")
  Failed: "Failed",

  @doc("The provision is canceled.")
  Canceled: "Canceled",

  @doc("The creation is in progress.")
  Creating: "Creating",

  @doc("The deletion is in progress.")
  Deleting: "Deleting",

  @doc("The fix of the resource in progress.")
  Fixing: "Fixing",

  @doc("The verification of the resource in progress.")
  Verifying: "Verifying",

  @doc("The update of the resource in progress.")
  Updating: "Updating",

  string,
}

/**
 * Webhook status.
 */
union WebhookStatus {
  @doc("The webhook is enabled.")
  Enabled: "Enabled",

  @doc("The webhook is disabled.")
  Disabled: "Disabled",

  string,
}

/**
 * whether to send notification under any event.
 */
union SendAllEvents {
  @doc("Need send notification under any event.")
  True: "true",

  @doc("No need to send notification under any event.")
  False: "false",

  string,
}

/**
 * notification event.
 */
union NotificationEvent {
  @doc("The subscribed report's snapshot is successfully generated.")
  generate_snapshot_success: "generate_snapshot_success",

  @doc("The subscribed report's snapshot is failed to generate.")
  generate_snapshot_failed: "generate_snapshot_failed",

  @doc("The subscribed report failed while collecting the assessments.")
  assessment_failure: "assessment_failure",

  @doc("The subscribed report's configuration is changed.")
  report_configuration_changes: "report_configuration_changes",

  @doc("The subscribed report is deleted.")
  report_deletion: "report_deletion",

  string,
}

/**
 * content type
 */
union ContentType {
  @doc("The content type is application/json.")
  ApplicationJson: "application/json",

  string,
}

/**
 * whether to update webhookKey.
 */
union UpdateWebhookKey {
  @doc("Need update the webhook key.")
  True: "true",

  @doc("No need to update the webhook key.")
  False: "false",

  string,
}

/**
 * whether webhookKey is enabled.
 */
union WebhookKeyEnabled {
  @doc("The webhookKey is enabled.")
  True: "true",

  @doc("The webhookKey is not enabled.")
  False: "false",

  string,
}

/**
 * whether to enable ssl verification
 */
union EnableSslVerification {
  @doc("The ssl verification is enabled.")
  True: "true",

  @doc("The ssl verification is not enabled.")
  False: "false",

  string,
}

/**
 * webhook deliveryStatus
 */
union DeliveryStatus {
  @doc("The webhook is delivered successfully.")
  Succeeded: "Succeeded",

  @doc("The webhook is failed to deliver.")
  Failed: "Failed",

  @doc("The webhook is not delivered.")
  NotStarted: "NotStarted",

  string,
}

/**
 * Indicates the category status.
 */
union CategoryStatus {
  @doc("The category is passed.")
  Passed: "Passed",

  @doc("The category is failed.")
  Failed: "Failed",

  @doc("The category is not applicable.")
  NotApplicable: "NotApplicable",

  @doc("The category is pending for approval.")
  PendingApproval: "PendingApproval",

  string,
}

/**
 * Indicates the control family status.
 */
union ControlFamilyStatus {
  @doc("The control family is passed.")
  Passed: "Passed",

  @doc("The control family is failed.")
  Failed: "Failed",

  @doc("The control family is not applicable.")
  NotApplicable: "NotApplicable",

  @doc("The control family is pending for approval.")
  PendingApproval: "PendingApproval",

  string,
}

/**
 * Indicates the control status.
 */
union ControlStatus {
  @doc("The control is passed.")
  Passed: "Passed",

  @doc("The control is failed.")
  Failed: "Failed",

  @doc("The control is not applicable.")
  NotApplicable: "NotApplicable",

  @doc("The control is pending for approval.")
  PendingApproval: "PendingApproval",

  string,
}

/**
 * Indicates the customer responsibility type.
 */
union ResponsibilityType {
  @doc("The responsibility is automated.")
  Automated: "Automated",

  @doc("The responsibility is scoped manual.")
  ScopedManual: "ScopedManual",

  @doc("The responsibility is manual.")
  Manual: "Manual",

  string,
}

/**
 * Indicates the customer responsibility severity.
 */
union ResponsibilitySeverity {
  @doc("The responsibility is high severity.")
  High: "High",

  @doc("The responsibility is medium severity.")
  Medium: "Medium",

  @doc("The responsibility is low severity.")
  Low: "Low",

  string,
}

/**
 * Indicates the customer responsibility status.
 */
union ResponsibilityStatus {
  @doc("The responsibility is passed.")
  Passed: "Passed",

  @doc("The responsibility is failed.")
  Failed: "Failed",

  @doc("The responsibility is not applicable.")
  NotApplicable: "NotApplicable",

  @doc("The responsibility is pending for approval.")
  PendingApproval: "PendingApproval",

  string,
}

/**
 * Indicates the customer responsibility supported cloud environment.
 */
union ResponsibilityEnvironment {
  @doc("The responsibility is supported in Azure.")
  Azure: "Azure",

  @doc("The responsibility is supported in AWS.")
  AWS: "AWS",

  @doc("The responsibility is supported in GCP.")
  GCP: "GCP",

  @doc("The responsibility is general requirement of all environment.")
  General: "General",

  string,
}

/**
 * Indicates whether this solution is the recommended.
 */
union IsRecommendSolution {
  @doc("This solution is the recommended.")
  True: "true",

  @doc("This solution is not the recommended.")
  False: "false",

  string,
}

/**
 * Indicates the download type.
 */
union DownloadType {
  @doc("Download the compliance report.")
  ComplianceReport: "ComplianceReport",

  @doc("Download the compliance pdf report.")
  CompliancePdfReport: "CompliancePdfReport",

  @doc("Download the detailed compliance pdf report.")
  ComplianceDetailedPdfReport: "ComplianceDetailedPdfReport",

  @doc("Download the resource list of the report.")
  ResourceList: "ResourceList",

  string,
}

/**
 * Evidence type
 */
union EvidenceType {
  @doc("The evidence is a file.")
  File: "File",

  @doc("The evidence auto collected by App Compliance Automation.")
  AutoCollectedEvidence: "AutoCollectedEvidence",

  @doc("The evidence is data.")
  Data: "Data",

  string,
}

/**
 * Indicates whether the fix action is Succeeded or Failed.
 */
union Result {
  @doc("The result is succeeded.")
  Succeeded: "Succeeded",

  @doc("The result is failed.")
  Failed: "Failed",

  string,
}

/**
 * Scoping question rule.
 */
union Rule {
  @doc("The question is required to answer.")
  Required: "Required",

  @doc("The question answer length is limited.")
  CharLength: "CharLength",

  @doc("The question answer should be an Url.")
  Url: "Url",

  @doc("The question answer should be Urls.")
  Urls: "Urls",

  @doc("The question answer should be domains.")
  Domains: "Domains",

  @doc("The question answer should be a UsPrivacyShield.")
  USPrivacyShield: "USPrivacyShield",

  @doc("The question answer should be a PublicSOX.")
  PublicSOX: "PublicSOX",

  @doc("The question answer should be a CreditCardPCI.")
  CreditCardPCI: "CreditCardPCI",

  @doc("The question answer should be an AzureApplication.")
  AzureApplication: "AzureApplication",

  @doc("The question answer should be a valid guid.")
  ValidGuid: "ValidGuid",

  @doc("The question answer should be publisher verification.")
  PublisherVerification: "PublisherVerification",

  @doc("The question answer should be dynamic dropdown.")
  DynamicDropdown: "DynamicDropdown",

  @doc("The question answer should prevent non-english char.")
  PreventNonEnglishChar: "PreventNonEnglishChar",

  @doc("The question answer should be a valid email.")
  ValidEmail: "ValidEmail",

  string,
}

/**
 * Question input type.
 */
union InputType {
  @doc("The input type is a text box.")
  None: "None",

  @doc("The input content is text string.")
  Text: "Text",

  @doc("The input content should be an email address.")
  Email: "Email",

  @doc("The input content should be multiline text.")
  MultilineText: "MultilineText",

  @doc("The input content should be a URL.")
  Url: "Url",

  @doc("The input content should be a number.")
  Number: "Number",

  @doc("The input content should be a boolean.")
  Boolean: "Boolean",

  @doc("The input content should be a telephone number.")
  Telephone: "Telephone",

  @doc("The input content should be Yes, No or Na.")
  YesNoNa: "YesNoNa",

  @doc("The input content should be a date.")
  Date: "Date",

  @doc("The input content is a Year, pick from the dropdown list.")
  YearPicker: "YearPicker",

  @doc("The input content is a single result seleted from the options.")
  SingleSelection: "SingleSelection",

  @doc("The input content is a single result seleted from the dropdown options.")
  SingleSelectDropdown: "SingleSelectDropdown",

  @doc("The input content are multiple results seleted from the checkboxes.")
  MultiSelectCheckbox: "MultiSelectCheckbox",

  @doc("The input content are multiple results seleted from the dropdown options.")
  MultiSelectDropdown: "MultiSelectDropdown",

  @doc("The input content are result seleted from the custom dropdown options.")
  MultiSelectDropdownCustom: "MultiSelectDropdownCustom",

  @doc("The input content is a group of answers.")
  Group: "Group",

  @doc("The input content is a uploaded file.")
  Upload: "Upload",

  string,
}

/**
 * The get collection count request body.
 */
@doc("Get collection count's request object.")
model GetCollectionCountRequest {
  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The get collection count response.
 */
model GetCollectionCountResponse {
  /**
   * The count of the specified resource.
   */
  count?: int32;
}

/**
 * The get overview status request body.
 */
@doc("Get overview status request object.")
model GetOverviewStatusRequest {
  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The get overview status response.
 */
model GetOverviewStatusResponse {
  /**
   * List of different status items.
   */
  @identifiers(#["statusName"])
  statusList?: StatusItem[];
}

/**
 * Single status.
 */
model StatusItem {
  /**
   * Status name - e.g. "Active", "Failed".
   */
  statusName?: string;

  /**
   * Status value. e.g. "100", or "100%".
   */
  statusValue?: string;
}

/**
 * Onboard subscriptions request.
 */
@doc("Parameters for onboard operation")
model OnboardRequest {
  /**
   * List of subscription ids to be onboarded
   */
  subscriptionIds: string[];
}

/**
 * Onboard subscriptions response.
 */
@doc("Success. The response indicates given subscriptions has been onboarded.")
model OnboardResponse {
  /**
   * List of subscription ids that are onboarded
   */
  subscriptionIds?: string[];
}

/**
 * Trigger evaluation request.
 */
model TriggerEvaluationRequest {
  /**
   * List of resource ids to be evaluated
   */
  resourceIds: string[];
}

/**
 * Trigger evaluation response.
 */
model TriggerEvaluationResponse {
  /**
   * trigger evaluation property.
   */
  properties?: TriggerEvaluationProperty;
}

/**
 * Trigger evaluation response.
 */
model TriggerEvaluationProperty {
  /**
   * The time when the evaluation is triggered.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerTime?: utcDateTime;

  /**
   * The time when the evaluation is end.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  evaluationEndTime?: utcDateTime;

  /**
   * List of resource ids to be evaluated
   */
  resourceIds?: string[];

  /**
   * List of quick assessments
   */
  @identifiers(#["resourceId"])
  quickAssessments?: QuickAssessment[];
}

/**
 * A class represent the quick assessment.
 */
model QuickAssessment {
  /**
   * Resource id.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Responsibility id.
   */
  @visibility(Lifecycle.Read)
  responsibilityId?: string;

  /**
   * The timestamp of resource creation (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Quick assessment status.
   */
  @visibility(Lifecycle.Read)
  resourceStatus?: ResourceStatus;

  /**
   * Quick assessment display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Quick assessment display name.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Link to remediation steps for this quick assessment.
   */
  @visibility(Lifecycle.Read)
  remediationLink?: string;
}

/**
 * List in use storage accounts request.
 */
@doc("Parameters for listing in use storage accounts operation. If subscription list is null, it will check the user's all subscriptions.")
model ListInUseStorageAccountsRequest {
  /**
   * List of subscription ids to be query. If the list is null or empty, the API will query all the subscriptions of the user.
   */
  subscriptionIds?: string[];
}

/**
 * List in use storage accounts response.
 */
@doc("Parameters for listing in use storage accounts operation. If subscription list is null, it will check the user's all subscriptions.")
model ListInUseStorageAccountsResponse {
  /**
   * The storage account list which in use in related reports.
   */
  @identifiers(#["accountName"])
  storageAccountList?: StorageInfo[];
}

/**
 * The information of 'bring your own storage' account binding to the report
 */
model StorageInfo {
  /**
   * The subscription id which 'bring your own storage' account belongs to
   */
  subscriptionId?: string;

  /**
   * The resourceGroup which 'bring your own storage' account belongs to
   */
  resourceGroup?: string;

  /**
   * 'bring your own storage' account name
   */
  accountName?: string;

  /**
   * The region of 'bring your own storage' account
   */
  location?: string;
}

/**
 * Report's properties.
 */
alias ReportBaseProperties = {
  /**
   * Report status.
   */
  @visibility(Lifecycle.Read)
  status?: ReportStatus;

  /**
   * List of report error codes.
   */
  @visibility(Lifecycle.Read)
  errors?: string[];

  /**
   * Report's tenant id.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * A list of comma-separated offerGuids indicates a series of offerGuids that map to the report. For example, "00000000-0000-0000-0000-000000000001,00000000-0000-0000-0000-000000000002" and "00000000-0000-0000-0000-000000000003".
   */
  offerGuid?: string;

  /**
   * Report next collection trigger time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextTriggerTime?: utcDateTime;

  /**
   * Report last collection trigger time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTriggerTime?: utcDateTime;

  /**
   * List of subscription Ids.
   */
  @visibility(Lifecycle.Read)
  subscriptions?: string[];

  /**
   * Report compliance status.
   */
  @visibility(Lifecycle.Read)
  complianceStatus?: ReportComplianceStatus;

  /**
   * The information of 'bring your own storage' binding to the report
   */
  storageInfo?: StorageInfo;

  /**
   * List of synchronized certification records.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["offerGuid"])
  certRecords?: CertSyncRecord[];

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
};

/**
 * Create Report's properties.
 */
model ReportProperties {
  /**
   * Report collection trigger time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerTime: utcDateTime;

  /**
   * Report collection trigger time's time zone, the available list can be obtained by executing "Get-TimeZone -ListAvailable" in PowerShell.
   * An example of valid timezone id is "Pacific Standard Time".
   */
  timeZone: string;

  /**
   * List of resource data.
   */
  @identifiers(#["resourceId"])
  resources: ResourceMetadata[];

  ...ReportBaseProperties;
}

/**
 * Patch Report's properties.
 */
model ReportPatchProperties {
  /**
   * Report collection trigger time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  triggerTime?: utcDateTime;

  /**
   * Report collection trigger time's time zone, the available list can be obtained by executing "Get-TimeZone -ListAvailable" in PowerShell.
   * An example of valid timezone id is "Pacific Standard Time".
   */
  timeZone?: string;

  /**
   * List of resource data.
   */
  @identifiers(#["resourceId"])
  resources?: ResourceMetadata[];

  ...ReportBaseProperties;
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
   * Resource type. e.g. "Microsoft.Compute/virtualMachines"
   */
  resourceType?: string;

  /**
   * Resource kind.
   */
  resourceKind?: string;

  /**
   * Resource Origin.
   */
  resourceOrigin?: ResourceOrigin;

  /**
   * Account Id. For example - the AWS account id.
   */
  accountId?: string;
}

/**
 * A list which includes all the compliance result for one report.
 */
model ReportComplianceStatus {
  /**
   * The Microsoft 365 certification name.
   */
  @visibility(Lifecycle.Read)
  m365?: OverviewStatus;
}

/**
 * The overview of the compliance result for one report.
 */
model OverviewStatus {
  /**
   * The count of all passed control.
   */
  @visibility(Lifecycle.Read)
  passedCount?: int32;

  /**
   * The count of all failed control.
   */
  @visibility(Lifecycle.Read)
  failedCount?: int32;

  /**
   * The count of all manual control.
   */
  @visibility(Lifecycle.Read)
  manualCount?: int32;

  /**
   * The count of all not applicable control.
   */
  @visibility(Lifecycle.Read)
  notApplicableCount?: int32;

  /**
   * The count of all pending for approval control.
   */
  @visibility(Lifecycle.Read)
  pendingCount?: int32;
}

/**
 * A class represent the certification record synchronized from app compliance.
 */
model CertSyncRecord {
  /**
   * The offerGuid which mapping to the reports.
   */
  @minLength(1)
  offerGuid?: string;

  /**
   * Indicates the status of certification process.
   */
  certificationStatus?: string;

  /**
   * Indicates the status of compliance process.
   */
  ingestionStatus?: string;

  /**
   * The control records list to be synchronized.
   */
  @identifiers(#["controlId"])
  controls?: ControlSyncRecord[];
}

/**
 * A class represent the control record synchronized from app compliance.
 */
model ControlSyncRecord {
  /**
   * The Id of the control. e.g. "Operational_Security_10"
   */
  controlId?: string;

  /**
   * Control status synchronized from app compliance.
   */
  controlStatus?: string;
}

/**
 * A class represent a AppComplianceAutomation report resource update properties.
 */
model ReportResourcePatch {
  /**
   * Report property.
   */
  properties?: ReportPatchProperties;
}

/**
 * Synchronize certification record request.
 */
model SyncCertRecordRequest {
  /**
   * certification record to be synchronized.
   */
  certRecord: CertSyncRecord;
}

/**
 * Synchronize certification record response.
 */
model SyncCertRecordResponse {
  /**
   * certification record synchronized.
   */
  certRecord?: CertSyncRecord;
}

/**
 * Webhook properties.
 */
model WebhookProperties {
  /**
   * Webhook id in database.
   */
  @visibility(Lifecycle.Read)
  webhookId?: string;

  /**
   * Webhook status.
   */
  status?: WebhookStatus;

  /**
   * Tenant id.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * whether to send notification under any event.
   */
  sendAllEvents?: SendAllEvents;

  /**
   * under which event notification should be sent.
   */
  events?: NotificationEvent[];

  /**
   * webhook payload url
   */
  @pattern("^(http(s)?://)[\\S]{0,64994}$")
  payloadUrl?: string;

  /**
   * content type
   */
  contentType?: ContentType;

  /**
   * webhook secret token. If not set, this field value is null; otherwise, please set a string value.
   */
  @pattern("^.{0,2048}$")
  webhookKey?: string;

  /**
   * whether to update webhookKey.
   */
  updateWebhookKey?: UpdateWebhookKey;

  /**
   * whether webhookKey is enabled.
   */
  @visibility(Lifecycle.Read)
  webhookKeyEnabled?: WebhookKeyEnabled;

  /**
   * whether to enable ssl verification
   */
  enableSslVerification?: EnableSslVerification;

  /**
   * webhook deliveryStatus
   */
  @visibility(Lifecycle.Read)
  deliveryStatus?: DeliveryStatus;

  /**
   * Azure Resource Provisioning State
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * A class represent a AppComplianceAutomation webhook resource update properties.
 */
model WebhookResourcePatch {
  /**
   * Webhook property.
   */
  properties?: WebhookProperties;
}

/**
 * Snapshot's properties.
 */
model SnapshotProperties {
  /**
   * Snapshot name.
   */
  @visibility(Lifecycle.Read)
  snapshotName?: string;

  /**
   * The timestamp of resource creation (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The report essential info.
   */
  @visibility(Lifecycle.Read)
  reportProperties?: ReportProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  reportSystemData?: SystemData;

  /**
   * List of compliance results.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["complianceName"])
  complianceResults?: ComplianceResult[];
}

/**
 * A class represent the compliance result.
 */
model ComplianceResult {
  /**
   * The name of the compliance. e.g. "M365"
   */
  @visibility(Lifecycle.Read)
  complianceName?: string;

  /**
   * List of categories.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["categoryName"])
  categories?: Category[];
}

/**
 * A class represent the compliance category.
 */
model Category {
  /**
   * The name of the compliance category. e.g. "Operational Security"
   */
  @visibility(Lifecycle.Read)
  categoryName?: string;

  /**
   * Category status.
   */
  @visibility(Lifecycle.Read)
  categoryStatus?: CategoryStatus;

  /**
   * List of control families.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["controlFamilyName"])
  controlFamilies?: ControlFamily[];
}

/**
 * A class represent the control family.
 */
model ControlFamily {
  /**
   * The name of the control family. e.g. "Malware Protection - Anti-Virus"
   */
  @visibility(Lifecycle.Read)
  controlFamilyName?: string;

  /**
   * The control family status
   */
  @visibility(Lifecycle.Read)
  controlFamilyStatus?: ControlFamilyStatus;

  /**
   * List of controls.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["controlId"])
  controls?: Control[];
}

/**
 * A class represent the control.
 */
model Control {
  /**
   * The Id of the control. e.g. "Operational_Security_10"
   */
  @visibility(Lifecycle.Read)
  controlId?: string;

  /**
   * The name of the control. e.g. "Unsupported OS and Software."
   */
  @visibility(Lifecycle.Read)
  controlName?: string;

  /**
   * The full name of the control. e.g. "Validate that unsupported operating systems and software components are not in use."
   */
  @visibility(Lifecycle.Read)
  controlFullName?: string;

  /**
   * The control's description
   */
  @visibility(Lifecycle.Read)
  controlDescription?: string;

  /**
   * The hyper link to the control's description'.
   */
  @visibility(Lifecycle.Read)
  controlDescriptionHyperLink?: string;

  /**
   * Control status.
   */
  @visibility(Lifecycle.Read)
  controlStatus?: ControlStatus;

  /**
   * List of customer responsibility.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["responsibilityId"])
  responsibilities?: Responsibility[];
}

/**
 * A class represent the customer responsibility.
 */
model Responsibility {
  /**
   * The id of the customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityId?: string;

  /**
   * The title of the customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityTitle?: string;

  /**
   * The description of the customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityDescription?: string;

  /**
   * The type of customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityType?: ResponsibilityType;

  /**
   * The severity level of this customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilitySeverity?: ResponsibilitySeverity;

  /**
   * The status of this customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityStatus?: ResponsibilityStatus;

  /**
   * The supported cloud environment of this customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityEnvironment?: ResponsibilityEnvironment;

  /**
   * The count of all failed resources.
   */
  failedResourceCount?: int32;

  /**
   * The count of all resources.
   */
  totalResourceCount?: int32;

  /**
   * List of resource.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  resourceList?: ResponsibilityResource[];

  /**
   * List of recommendation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["recommendationId"])
  recommendationList?: Recommendation[];

  /**
   * The evidence upload guidance description.
   */
  @visibility(Lifecycle.Read)
  guidance?: string;

  /**
   * The justification given by the user to clarify the reason.
   */
  @visibility(Lifecycle.Read)
  justification?: string;

  /**
   * List of evidence file url.
   */
  evidenceFiles?: string[];
}

/**
 * A class represent the resource.
 */
model ResponsibilityResource {
  /**
   * The Id of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * Account Id. For example - AWS account Id.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * The type of the resource. e.g. "Microsoft.SignalRService/SignalR"
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Resource origin.
   */
  @visibility(Lifecycle.Read)
  resourceOrigin?: ResourceOrigin;

  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  resourceStatus?: ResourceStatus;

  /**
   * The status change date for the resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resourceStatusChangeDate?: utcDateTime;

  /**
   * List of recommendation id.
   */
  recommendationIds?: string[];
}

/**
 * A class represent the recommendation.
 */
model Recommendation {
  /**
   * The Id of the recommendation.
   */
  @visibility(Lifecycle.Read)
  recommendationId?: string;

  /**
   * The short name of the recommendation. e.g. "Invalid TLS config"
   */
  @visibility(Lifecycle.Read)
  recommendationShortName?: string;

  /**
   * List of recommendation solutions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["recommendationSolutionIndex"])
  recommendationSolutions?: RecommendationSolution[];
}

/**
 * A class represent the recommendation solution.
 */
model RecommendationSolution {
  /**
   * The index of the recommendation solution.
   */
  @visibility(Lifecycle.Read)
  recommendationSolutionIndex?: string;

  /**
   * The detail steps of the recommendation solution.
   */
  @visibility(Lifecycle.Read)
  recommendationSolutionContent?: string;

  /**
   * Indicates whether this solution is the recommended.
   */
  @visibility(Lifecycle.Read)
  isRecommendSolution?: IsRecommendSolution;
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
   * Resource list of the report
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["resourceId"])
  resourceList?: ResourceItem[];

  /**
   * List of the compliance result
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["controlId"])
  complianceReport?: ComplianceReportItem[];

  /**
   * Compliance pdf report
   */
  @visibility(Lifecycle.Read)
  compliancePdfReport?: DownloadResponseCompliancePdfReport;

  /**
   * The detailed compliance pdf report
   */
  @visibility(Lifecycle.Read)
  complianceDetailedPdfReport?: DownloadResponseComplianceDetailedPdfReport;
}

/**
 * Resource Id.
 */
model ResourceItem {
  /**
   * The subscription Id of this resource.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The resource group name of this resource.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * The resource type of this resource. e.g. "Microsoft.SignalRService/SignalR"
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The resource Id - e.g. "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.Compute/virtualMachines/vm1".
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;
}

/**
 * Object that includes all the content for single compliance result.
 */
model ComplianceReportItem {
  /**
   * The category name.
   */
  @visibility(Lifecycle.Read)
  categoryName?: string;

  /**
   * The control family name.
   */
  @visibility(Lifecycle.Read)
  controlFamilyName?: string;

  /**
   * The control Id - e.g. "1".
   */
  @visibility(Lifecycle.Read)
  controlId?: string;

  /**
   * The control name.
   */
  @visibility(Lifecycle.Read)
  controlName?: string;

  /**
   * Control status.
   */
  @visibility(Lifecycle.Read)
  controlStatus?: ControlStatus;

  /**
   * The title of the customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityTitle?: string;

  /**
   * The description of the customer responsibility.
   */
  @visibility(Lifecycle.Read)
  responsibilityDescription?: string;

  /**
   * The Id of the resource.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * The type of the resource.  e.g. "Microsoft.SignalRService/SignalR"
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * Resource origin.
   */
  @visibility(Lifecycle.Read)
  resourceOrigin?: ResourceOrigin;

  /**
   * Resource status.
   */
  @visibility(Lifecycle.Read)
  resourceStatus?: ResourceStatus;

  /**
   * The status change date for the resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resourceStatusChangeDate?: utcDateTime;
}

/**
 * Compliance pdf report
 */
model DownloadResponseCompliancePdfReport {
  /**
   * The uri of compliance pdf report
   */
  @visibility(Lifecycle.Read)
  sasUri?: string;
}

/**
 * The detailed compliance pdf report
 */
model DownloadResponseComplianceDetailedPdfReport {
  /**
   * The uri of detailed compliance pdf report
   */
  @visibility(Lifecycle.Read)
  sasUri?: string;
}

/**
 * ScopingConfiguration's properties.
 */
model ScopingConfigurationProperties {
  /**
   * List of scoping question answers.
   */
  @identifiers(#["questionId"])
  answers?: ScopingAnswer[];

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Scoping question list.
 */
model ScopingQuestions {
  /**
   * List of scoping questions.
   */
  @identifiers(#["questionId"])
  questions?: ScopingQuestion[];
}

/**
 * The definition of a scoping question.
 */
model ScopingQuestion {
  /**
   * Question id.
   */
  @visibility(Lifecycle.Read)
  questionId: string;

  /**
   * Superior question id.
   */
  @visibility(Lifecycle.Read)
  superiorQuestionId?: string;

  /**
   * Input type of the question answer.
   */
  @visibility(Lifecycle.Read)
  inputType: InputType;

  /**
   * Option id list.
   */
  @visibility(Lifecycle.Read)
  optionIds: string[];

  /**
   * The rule of the question.
   */
  @visibility(Lifecycle.Read)
  rules: Rule[];

  /**
   * The answer value to show the sub questions.
   */
  @visibility(Lifecycle.Read)
  showSubQuestionsValue?: string;
}

/**
 * Scoping answer.
 */
model ScopingAnswer {
  /**
   * Question id.
   */
  @pattern("^[-a-zA-Z0-9_]{1,50}$")
  questionId: string;

  /**
   * Question answer value list.
   */
  answers: string[];
}

/**
 * Evidence's properties.
 */
model EvidenceProperties {
  /**
   * Evidence type.
   */
  evidenceType?: EvidenceType;

  /**
   * The path of the file in storage.
   */
  filePath: string;

  /**
   * Extra data considered as evidence.
   */
  extraData?: string;

  /**
   * Control id.
   */
  controlId?: string;

  /**
   * Responsibility id.
   */
  responsibilityId?: string;

  /**
   * Azure lifecycle management
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Evidence file's download request.
 */
model EvidenceFileDownloadRequest {
  /**
   * Tenant id.
   */
  reportCreatorTenantId?: string;

  /**
   * The offerGuid which mapping to the reports.
   */
  @minLength(1)
  offerGuid?: string;
}

/**
 * Object that includes all the possible response for the evidence file download operation.
 */
model EvidenceFileDownloadResponse {
  /**
   * The uri of evidence file
   */
  @visibility(Lifecycle.Read)
  evidenceFile?: EvidenceFileDownloadResponseEvidenceFile;
}

/**
 * The uri of evidence file
 */
model EvidenceFileDownloadResponseEvidenceFile {
  /**
   * The url of evidence file
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * Report fix result.
 */
model ReportFixResult {
  /**
   * Indicates whether the fix action is Succeeded or Failed.
   */
  @visibility(Lifecycle.Read)
  result?: Result;

  /**
   * If the report fix action failed, to indicate the detailed failed reason.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Report health status verification result.
 */
model ReportVerificationResult {
  /**
   * Indicates whether the report verification action is Succeeded or Failed.
   */
  @visibility(Lifecycle.Read)
  result?: Result;

  /**
   * If the report verification action failed, to indicate the detailed failed reason.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Query parameters for list operations.
 */
model QueryParameters {
  /**
   * Skip over when retrieving results.
   */
  @query("$skipToken")
  skipToken?: string;

  /**
   * Number of elements to return when retrieving results.
   */
  @maxValue(100)
  @minValue(1)
  @query("$top")
  top?: int32;

  /**
   * OData Select statement. Limits the properties on each entry to just those requested, e.g. ?$select=reportName,id.
   */
  @minLength(1)
  @query("$select")
  select?: string;

  /**
   * The filter to apply on the operation.
   */
  @minLength(1)
  @query("$filter")
  filter?: string;

  /**
   * OData order by query option.
   */
  @minLength(1)
  @query("$orderby")
  orderby?: string;

  /**
   * The offerGuid which mapping to the reports.
   */
  @minLength(1)
  @query("offerGuid")
  offerGuid?: string;

  /**
   * The tenant id of the report creator.
   */
  @minLength(1)
  @query("reportCreatorTenantId")
  reportCreatorTenantId?: string;
}

/**
 * Extra parameters for app compliance.
 */
model ExtraParameter {
  /**
   * The offerGuid which mapping to the reports.
   */
  @minLength(1)
  @query("offerGuid")
  offerGuid?: string;

  /**
   * The tenant id of the report creator.
   */
  @minLength(1)
  @query("reportCreatorTenantId")
  reportCreatorTenantId?: string;
}
