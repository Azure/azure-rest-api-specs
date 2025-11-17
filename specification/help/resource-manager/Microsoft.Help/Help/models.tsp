import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Help;

/**
 * Status of diagnostic provisioning.
 */
union DiagnosticProvisioningState {
  string,

  /**
   * All Diagnostics in the Batch succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Some Diagnostics are still running or failed.
   */
  PartialComplete: "PartialComplete",

  /**
   * All Diagnostics failed to run.
   */
  Failed: "Failed",

  /**
   * All Diagnostics are still running.
   */
  Running: "Running",

  /**
   * When Diagnostic request gets canceled.
   */
  Canceled: "Canceled",
}

/**
 * Denotes the status of the diagnostic resource.
 */
union Status {
  string,

  /**
   * Diagnostic creation failed.
   */
  Failed: "Failed",

  /**
   * Request is missing required inputs to run.
   */
  MissingInputs: "MissingInputs",

  /**
   * Diagnostic is still running.
   */
  Running: "Running",

  /**
   * Diagnostic creation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Diagnostic was timed out.
   */
  Timeout: "Timeout",
}

/**
 * Importance level of the insight.
 */
union ImportanceLevel {
  string,

  /**
   * A critical insight has been found after running the diagnostic.
   */
  Critical: "Critical",

  /**
   * A warning insight has been found after running the diagnostic.
   */
  Warning: "Warning",

  /**
   * An information insight has been found after running the diagnostic.
   */
  Information: "Information",
}

/**
 * Solution Type.
 */
union SolutionType {
  string,

  /**
   * Diagnostics resource type.
   */
  Diagnostics: "Diagnostics",

  /**
   * Solutions resource type.
   */
  Solutions: "Solutions",

  /**
   * Troubleshooters resource type.
   */
  Troubleshooters: "Troubleshooters",

  /**
   * SelfHelp resource type.
   */
  SelfHelp: "SelfHelp",
}

/**
 * Trigger criterion name.
 */
union Name {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SolutionId: "SolutionId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProblemClassificationId: "ProblemClassificationId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReplacementKey: "ReplacementKey",
}

/**
 * Status of solution provisioning.
 */
union SolutionProvisioningState {
  string,

  /**
   * All Solutions in the Batch succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Some Solutions are still running or failed.
   */
  PartialComplete: "PartialComplete",

  /**
   * All Solutions failed to run.
   */
  Failed: "Failed",

  /**
   * All Solutions are still running.
   */
  Running: "Running",

  /**
   * When Solutions request gets canceled.
   */
  Canceled: "Canceled",
}

/**
 * Confidence of the search result.
 */
union Confidence {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Low: "Low",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Medium: "Medium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  High: "High",
}

/**
 * Result type of the search result.
 */
union ResultType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Community: "Community",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Documentation: "Documentation",
}

/**
 * Allowed values are Sum, Avg, Count, Min, Max. Default is Sum
 */
union AggregationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sum: "Sum",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Avg: "Avg",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Min: "Min",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Max: "Max",
}

/**
 * Status of troubleshooter provisioning.
 */
union TroubleshooterProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AutoContinue: "AutoContinue",
}

/**
 * Status of Troubleshooter Step execution.
 */
union ExecutionStatus {
  string,

  /**
   * Step execution succeeded.
   */
  Success: "Success",

  /**
   * Step execution running
   */
  Running: "Running",

  /**
   * Step execution failed
   */
  Failed: "Failed",

  /**
   * Step execution warning
   */
  Warning: "Warning",
}

/**
 * Type of Troubleshooting step.
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Decision: "Decision",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Solution: "Solution",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Insight: "Insight",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AutomatedCheck: "AutomatedCheck",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Input: "Input",
}

/**
 * Type of Question
 */
union QuestionType {
  string,

  /**
   * SingleChoice radio button
   */
  RadioButton: "RadioButton",

  /**
   * SingleChoice dropdown.
   */
  Dropdown: "Dropdown",

  /**
   * Text Input
   */
  TextInput: "TextInput",

  /**
   * MultiLineInfoBox
   */
  MultiLineInfoBox: "MultiLineInfoBox",

  /**
   * DateTime Picker
   */
  DateTimePicker: "DateTimePicker",

  /**
   * Multi Select
   */
  MultiSelect: "MultiSelect",
}

/**
 * Default is Text.
 */
union QuestionContentType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Text: "Text",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Html: "Html",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Markdown: "Markdown",
}

/**
 * Validation scope
 */
union ValidationScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  URLFormat: "URLFormat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GuidFormat: "GuidFormat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IpAddressFormat: "IpAddressFormat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NumberOnlyFormat: "NumberOnlyFormat",
}

/**
 * Type of Result.
 */
union AutomatedCheckResultType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Information: "Information",
}

/**
 * Response for whether the requested resource name is available or not.
 */
model CheckNameAvailabilityResponse {
  /**
   * Returns true or false depending on the availability of the name
   */
  nameAvailable?: boolean;

  /**
   * Reason for why value is not available. This field is returned if nameAvailable is false.
   */
  reason?: string;

  /**
   * Gets an error message explaining the 'reason' value with more details. This field is returned iif nameAvailable is false.
   */
  message?: string;
}

/**
 * Diagnostic resource properties.
 */
model DiagnosticResourceProperties {
  /**
   * Global parameters is an optional map which can be used to add key and  value to request body to improve the diagnostics results
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  globalParameters?: Record<string>;

  /**
   * SolutionIds that are needed to be invoked.
   */
  @identifiers(#["solutionId"])
  insights?: DiagnosticInvocation[];

  /**
   * Diagnostic Request Accepted time.
   */
  @visibility(Lifecycle.Read)
  acceptedAt?: string;

  /**
   * Status of diagnostic provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DiagnosticProvisioningState;

  /**
   * Array of Diagnostics.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["solutionId"])
  diagnostics?: Diagnostic[];
}

/**
 * Solution Invocation with additional params needed for invocation.
 */
model DiagnosticInvocation {
  /**
   * Solution Id to invoke.
   */
  solutionId?: string;

  /**
   * Additional parameters required to invoke the solutionId.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  additionalParameters?: Record<string>;
}

/**
 * Properties returned with in an insight.
 */
model Diagnostic {
  /**
   * Solution Id
   */
  solutionId?: string;

  /**
   * Denotes the status of the diagnostic resource.
   */
  status?: Status;

  /**
   * The problems (if any) detected by this insight.
   */
  @identifiers(#[])
  insights?: Insight[];

  /**
   * Error definition.
   */
  error?: Error;
}

/**
 * Detailed insights(s) obtained via the invocation of an insight diagnostic
 */
model Insight {
  /**
   * Article id.
   */
  id?: string;

  /**
   * This insight's title.
   */
  title?: string;

  /**
   * Detailed result content.
   */
  results?: string;

  /**
   * Importance level of the insight.
   */
  importanceLevel?: ImportanceLevel;
}

/**
 * Error definition.
 */
model Error {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Service specific error type which serves as additional context for the error herein.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * An array of additional nested error response info objects, as described by this contract.
   */
  @identifiers(#["type", "message"])
  details?: Error[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Discovery response.
 */
model DiscoveryResponse is Azure.Core.Page<SolutionMetadataResource>;

/**
 * Metadata resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SolutionMetadataResource
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Solution metadata Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: Solutions;
}

/**
 * List of solutions
 */
model Solutions {
  /**
   * List of metadata.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  solutions?: SolutionMetadataProperties[];
}

/**
 * Metadata Properties
 */
model SolutionMetadataProperties {
  /**
   * Solution Id.
   */
  solutionId?: string;

  /**
   * Solution Type.
   */
  @visibility(Lifecycle.Read)
  solutionType?: SolutionType;

  /**
   * A detailed description of solution.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Required parameters for invoking this particular solution.
   */
  @visibility(Lifecycle.Read)
  requiredInputs?: string[];
}

/**
 * Solution result
 */
model SolutionResourceProperties {
  /**
   * Solution request trigger criteria
   */
  @identifiers(#["name"])
  triggerCriteria?: TriggerCriterion[];

  /**
   * Client input parameters to run Solution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;

  /**
   * Solution Id to identify single solution.
   */
  @visibility(Lifecycle.Read)
  solutionId?: string;

  /**
   * Status of solution provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SolutionProvisioningState;

  /**
   * The title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * The HTML content that needs to be rendered and shown to customer.
   */
  @visibility(Lifecycle.Read)
  content?: string;

  /**
   * Solution replacement maps.
   */
  @visibility(Lifecycle.Read)
  replacementMaps?: ReplacementMaps;

  /**
   * List of section object.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["title"])
  sections?: Section[];
}

/**
 * Solution request trigger criterion. SolutionId/ProblemClassificationId is the only supported trigger type for Solution PUT request. ReplacementKey is the only supported trigger type for Solution PATCH request.
 */
model TriggerCriterion {
  /**
   * Trigger criterion name.
   */
  name?: Name;

  /**
   * Trigger criterion value.
   */
  value?: string;
}

/**
 * Solution replacement maps.
 */
model ReplacementMaps {
  /**
   * Solution AzureKB results
   */
  @identifiers(#[])
  webResults?: WebResult[];

  /**
   * Solution diagnostics results.
   */
  @identifiers(#["solutionId"])
  diagnostics?: SolutionsDiagnostic[];

  /**
   * Solutions Troubleshooters
   */
  @identifiers(#["solutionId"])
  troubleshooters?: SolutionsTroubleshooters[];

  /**
   * Solution metrics based charts
   */
  @identifiers(#[])
  metricsBasedCharts?: MetricsBasedChart[];

  /**
   * Video solutions, which have the power to engage the customer by stimulating their senses
   */
  @identifiers(#[])
  videos?: Video[];

  /**
   * Group of Videos
   */
  @identifiers(#[])
  videoGroups?: VideoGroup[];
}

/**
 * AzureKB web result
 */
model WebResult {
  /**
   * Place holder used in HTML Content replace control with the content
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  replacementKey?: string;

  /**
   * AzureKB search results
   */
  @identifiers(#["solutionId"])
  searchResults?: SearchResult[];
}

/**
 * Details of an AzureKB search result.
 */
model SearchResult {
  /**
   * Unique id of the result.
   */
  solutionId?: string;

  /**
   * Content of the search result.
   */
  content?: string;

  /**
   * Title of the search result.
   */
  title?: string;

  /**
   * Confidence of the search result.
   */
  confidence?: Confidence;

  /**
   * Source of the search result.
   */
  source?: string;

  /**
   * Result type of the search result.
   */
  resultType?: ResultType;

  /**
   * rank of the search result
   */
  rank?: int32;

  /**
   * Link to the document.
   */
  link?: string;
}

/**
 * Solutions Diagnostic
 */
model SolutionsDiagnostic {
  /**
   * Solution Id to identify single Solutions Diagnostic
   */
  solutionId?: string;

  /**
   * Denotes the status of the diagnostic resource.
   */
  status?: Status;

  /**
   * Details of the status
   */
  statusDetails?: string;

  /**
   * Place holder used in HTML Content replace control with the content
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  replacementKey?: string;

  /**
   * Diagnostics estimated completion time in minutes
   */
  estimatedCompletionTime?: string;

  /**
   * Required parameters of this item
   */
  requiredParameters?: string[];

  /**
   * Diagnostic insights
   */
  @identifiers(#[])
  insights?: Insight[];
}

/**
 * Troubleshooters in Solutions
 */
model SolutionsTroubleshooters {
  /**
   * Solution Id to identify single Solutions Troubleshooter
   */
  solutionId?: string;

  /**
   * Troubleshooter title
   */
  title?: string;

  /**
   * Troubleshooter summary
   */
  summary?: string;
}

/**
 * Solutions metrics based chart
 */
model MetricsBasedChart {
  /**
   * Chart name
   */
  name?: string;

  /**
   * Allowed values are Sum, Avg, Count, Min, Max. Default is Sum
   */
  aggregationType?: AggregationType;

  /**
   * Time span duration
   */
  timeSpanDuration?: string;

  /**
   * Chart title
   */
  title?: string;

  /**
   * Filter group
   */
  filterGroup?: FilterGroup;

  /**
   * Place holder used in HTML Content replace control with the content
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  replacementKey?: string;
}

/**
 * Filter group
 */
model FilterGroup {
  /**
   * List of filters
   */
  @identifiers(#[])
  filter?: Filter[];
}

/**
 * Filter criterion
 */
model Filter {
  /**
   * Filter name
   */
  name?: string;

  /**
   * Filter values
   */
  values?: string;

  /**
   * Filter operator
   */
  operator?: string;
}

/**
 * Video detail
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Video extends VideoGroupVideo {
  /**
   * Place holder used in HTML Content replace control with the insight content
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  replacementKey?: string;
}

/**
 * VideoGroup video detail
 */
model VideoGroupVideo {
  /**
   * Link to the video
   */
  src?: string;

  /**
   * Title of the video
   */
  title?: string;
}

/**
 * Video group detail
 */
model VideoGroup {
  /**
   * List of videos will be shown to customers
   */
  @identifiers(#[])
  videos?: VideoGroupVideo[];

  /**
   * Place holder used in HTML Content replace control with the insight content
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  replacementKey?: string;
}

/**
 * Part of the solution and are dividers in the solution rendering.
 */
model Section {
  /**
   * Solution sections title.
   */
  title?: string;

  /**
   * Solution sections content.
   */
  content?: string;

  /**
   * Solution replacement maps.
   */
  replacementMaps?: ReplacementMaps;
}

/**
 * Solution PatchRequest body
 */
model SolutionPatchRequestBody {
  /**
   * Solution result
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SolutionResourceProperties;
}

/**
 * Simplified Solutions result
 */
model SimplifiedSolutionsResourceProperties {
  /**
   * Solution Id to identify single Simplified Solution.
   */
  solutionId?: string;

  /**
   * Client input parameters to run Simplified Solutions
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;

  /**
   * The title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * Additional parameter response for Simplified Solutions
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  appendix?: Record<string>;

  /**
   * The HTML content that needs to be rendered and shown to customer.
   */
  @visibility(Lifecycle.Read)
  content?: string;

  /**
   * Status of Simplified Solution provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SolutionProvisioningState;
}

/**
 * Solution WarmUpRequest body
 */
model SolutionWarmUpRequestBody {
  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;
}

/**
 * Troubleshooter Instance properties.
 */
model TroubleshooterInstanceProperties {
  /**
   * Solution Id to identify single troubleshooter.
   */
  solutionId?: string;

  /**
   * Client input parameters to run Troubleshooter Resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: Record<string>;

  /**
   * Status of troubleshooter provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TroubleshooterProvisioningState;

  /**
   * List of step object.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  steps?: Step[];
}

/**
 * Troubleshooter step
 */
model Step {
  /**
   * Unique step id.
   */
  id?: string;

  /**
   * Step title.
   */
  title?: string;

  /**
   * Step description.
   */
  description?: string;

  /**
   * Get or sets the Step guidance.
   */
  guidance?: string;

  /**
   * Status of Troubleshooter Step execution.
   */
  executionStatus?: ExecutionStatus;

  /**
   * This field has more detailed status description of the execution status.
   */
  executionStatusDescription?: string;

  /**
   * Type of Troubleshooting step.
   */
  type?: Type;

  /**
   * is this last step of the workflow.
   */
  isLastStep?: boolean;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["questionId"])
  inputs?: StepInput[];

  /**
   * Only for AutomatedStep type
   */
  automatedCheckResults?: AutomatedCheckResult;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["id"])
  insights?: Insight[];

  /**
   * The error detail.
   */
  error?: ErrorDetail;
}

/**
 * Details of step input.
 */
model StepInput {
  /**
   * Use Index as QuestionId.
   */
  questionId?: string;

  /**
   * Type of Question
   */
  questionType?: QuestionType;

  /**
   * Question title
   */
  questionTitle?: string;

  /**
   * User question content.
   */
  questionContent?: string;

  /**
   * Default is Text.
   */
  questionContentType?: QuestionContentType;

  /**
   * Place holder text for response hints.
   */
  responseHint?: string;

  /**
   * Result of Automate step.
   */
  recommendedOption?: string;

  /**
   * Text of response that was selected.
   */
  selectedOptionValue?: string;

  /**
   * Troubleshooter step input response validation properties
   */
  responseValidationProperties?: ResponseValidationProperties;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["key"])
  responseOptions?: ResponseOption[];
}

/**
 * Troubleshooter step input response validation properties
 */
model ResponseValidationProperties {
  /**
   * Regex used for the input validation.
   */
  regex?: string;

  /**
   * Validation scope
   */
  validationScope?: ValidationScope;

  /**
   * Default True
   */
  isRequired?: boolean;

  /**
   * Validation Error Message.
   */
  validationErrorMessage?: string;

  /**
   * Max text input (open Ended Text).
   */
  maxLength?: int64;
}

/**
 * The status of the resource.
 */
model ResponseOption {
  /**
   * Unique string.
   */
  key?: string;

  /**
   * Option description
   */
  value?: string;
}

/**
 * Only for AutomatedStep type
 */
model AutomatedCheckResult {
  /**
   * Version for automated check result
   */
  version?: string;

  /**
   * Status for automated check result
   */
  status?: string;

  /**
   * Insight Article Content
   */
  result?: string;

  /**
   * Type of Result.
   */
  type?: AutomatedCheckResultType;
}

/**
 * Troubleshooter ContinueRequest body.
 */
model ContinueRequestBody {
  /**
   * Unique id of the result.
   */
  stepId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  responses?: TroubleshooterResponse[];
}

/**
 * User Response for Troubleshooter continue request
 */
model TroubleshooterResponse {
  /**
   * id of the question.
   */
  questionId?: string;

  /**
   * Type of Question
   */
  questionType?: QuestionType;

  /**
   * Response key for SingleInput. For Multi-line test/open ended question it is free form text
   */
  response?: string;
}

/**
 * Troubleshooter restart response
 */
model RestartTroubleshooterResponse {
  /**
   * Updated TroubleshooterResource Name .
   */
  @visibility(Lifecycle.Read)
  troubleshooterResourceName?: string;
}

/**
 * Solution result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SolutionsResourcePropertiesSelfHelp {
  /**
   * SolutionId is a unique id to identify a solution. You can retrieve the solution id using the Discovery api - https://learn.microsoft.com/en-us/rest/api/help/discovery-solution/list?view=rest-help-2023-09-01-preview&tabs=HTTP
   */
  @visibility(Lifecycle.Read)
  solutionId?: string;

  /**
   * The title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * The HTML content that needs to be rendered and shown to customer.
   */
  @visibility(Lifecycle.Read)
  content?: string;

  /**
   * Solution replacement maps.
   */
  @visibility(Lifecycle.Read)
  replacementMaps?: ReplacementMapsSelfHelp;

  /**
   * List of section object.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["title"])
  sections?: SectionSelfHelp[];
}

/**
 * Solution replacement maps.
 */
model ReplacementMapsSelfHelp {
  /**
   * Solution AzureKB results
   */
  @identifiers(#[])
  webResults?: WebResult[];

  /**
   * Video solutions, which have the power to engage the customer by stimulating their senses
   */
  @identifiers(#[])
  videos?: Video[];

  /**
   * Group of Videos
   */
  @identifiers(#[])
  videoGroups?: VideoGroup[];
}

/**
 * Part of the solution and are dividers in the solution rendering.
 */
model SectionSelfHelp {
  /**
   * Solution sections title.
   */
  title?: string;

  /**
   * Solution sections content.
   */
  content?: string;

  /**
   * Solution replacement maps.
   */
  replacementMaps?: ReplacementMapsSelfHelp;
}

/**
 * Discover NLP request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiscoveryNlpRequest {
  /**
   * Natural language description of the issue.
   */
  issueSummary: string;

  /**
   * ARM resource Id of the resource that is having the issue. Only applicable for Discovery Solution NLP Subscription Scope.
   */
  resourceId?: string;

  /**
   * ARM service Id of the service that is having the issue. For more information on service Id see https://learn.microsoft.com/rest/api/support/services/list?tabs=HTTP.
   */
  serviceId?: string;

  /**
   * Additional information in the form of a string.
   */
  additionalContext?: string;
}

/**
 * Successfully fetched list of solution metadata.
 */
model DiscoveryNlpResponse {
  /**
   * The list of solution metadata.
   */
  value?: SolutionNlpMetadataResource[];
}

/**
 * Nlp Metadata resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SolutionNlpMetadataResource
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Solution metadata Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: NlpSolutions;
}

/**
 * Nlp metadata.
 */
model NlpSolutions {
  /**
   * Title of the problem classification.
   */
  problemTitle?: string;

  /**
   * Description of the problem classification.
   */
  problemDescription?: string;

  /**
   * Id of the service (https://learn.microsoft.com/en-us/rest/api/support/services?view=rest-support-2020-04-01) that may be used to create a support ticket.
   */
  serviceId?: string;

  /**
   * Id of the ProblemClassification (https://learn.microsoft.com/en-us/rest/api/support/problem-classifications?view=rest-support-2020-04-01) that may be used to create a support ticket.
   */
  problemClassificationId?: string;

  /**
   * The list of solution metadata.
   */
  @identifiers(#[])
  solutions?: SolutionMetadataProperties[];

  /**
   * The set of services that are most likely related to the request. If relatedServices is included in the response then solutions may not be discovered until the client calls a second time specifying one of the service Ids in the relatedServices object.
   */
  @identifiers(#[])
  relatedServices?: ClassificationService[];
}

/**
 * Service Classification result object.
 */
model ClassificationService {
  /**
   * Azure resource Id of the service.
   */
  @visibility(Lifecycle.Read)
  serviceId?: Azure.Core.armResourceIdentifier;

  /**
   * Localized name of the azure service.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * List of applicable ARM resource types for this service.
   */
  resourceTypes?: string[];
}
