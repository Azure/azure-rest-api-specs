import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Help;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Status of diagnostic provisioning.
 */
enum DiagnosticProvisioningState {
  /**
   * All Diagnostics in the Batch succeeded.
   */
  Succeeded,

  /**
   * Some Diagnostics are still running or failed.
   */
  PartialComplete,

  /**
   * All Diagnostics failed to run.
   */
  Failed,

  /**
   * When Diagnostic request gets canceled.
   */
  Canceled,
}

/**
 * Denotes the status of the diagnostic resource.
 */
enum Status {
  /**
   * Diagnostic creation failed.
   */
  Failed,

  /**
   * Request is missing required inputs to run.
   */
  MissingInputs,

  /**
   * Diagnostic is still running.
   */
  Running,

  /**
   * Diagnostic creation succeeded.
   */
  Succeeded,

  /**
   * Diagnostic was timed out.
   */
  Timeout,
}

/**
 * Importance level of the insight.
 */
enum ImportanceLevel {
  /**
   * A critical insight has been found after running the diagnostic.
   */
  Critical,

  /**
   * A warning insight has been found after running the diagnostic.
   */
  Warning,

  /**
   * An information insight has been found after running the diagnostic.
   */
  Information,
}

/**
 * Solution Type.
 */
enum SolutionType {
  /**
   * Diagnostics resource type.
   */
  Diagnostics,

  /**
   * Solutions resource type.
   */
  Solutions,
}

/**
 * Trigger criterion name.
 */
enum Name {
  SolutionId,
  ProblemClassificationId,
  ReplacementKey,
}

/**
 * Status of solution provisioning.
 */
enum SolutionProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

/**
 * Confidence of the search result.
 */
enum Confidence {
  Low,
  Medium,
  High,
}

/**
 * Result type of the search result.
 */
enum ResultType {
  Community,
  Documentation,
}

/**
 * Allowed values are Sum, Avg, Count, Min, Max. Default is Sum
 */
enum AggregationType {
  Sum,
  Avg,
  Count,
  Min,
  Max,
}

/**
 * Status of troubleshooter provisioning.
 */
enum TroubleshooterProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Running,
  AutoContinue,
}

/**
 * Status of Troubleshooter Step execution.
 */
enum ExecutionStatus {
  Success,
  Running,
  Failed,
  Warning,
}

/**
 * Type of Troubleshooting step.
 */
enum Type {
  Decision,
  Solution,
  Insight,
  AutomatedCheck,
}

/**
 * Default is Text.
 */
enum QuestionContentType {
  Text,
  Html,
  Markdown,
}

/**
 * Type of Result.
 */
enum AutomatedCheckResultType {
  Success,
  Warning,
  Error,
  Information,
}

/**
 * Text Input. Will be a single line input.
 */
enum QuestionType {
  /**
   * SingleChoice radio button
   */
  RadioButton,

  /**
   * SingleChoice dropdown.
   */
  Dropdown,

  /**
   * Text Input
   */
  TextInput,

  /**
   * MultiLineInfoBox
   */
  MultiLineInfoBox,
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
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
   * Global parameters that can be passed to all solutionIds.
   */
  globalParameters?: Record<string>;

  /**
   * SolutionIds that are needed to be invoked.
   */
  insights?: DiagnosticInvocation[];

  /**
   * Diagnostic Request Accepted time.
   */
  @visibility("read")
  acceptedAt?: string;

  /**
   * Status of diagnostic provisioning.
   */
  @visibility("read")
  provisioningState?: DiagnosticProvisioningState;

  /**
   * Array of Diagnostics.
   */
  @visibility("read")
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
  @visibility("read")
  code?: string;

  /**
   * Service specific error type which serves as additional context for the error herein.
   */
  @visibility("read")
  type?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * An array of additional nested error response info objects, as described by this contract.
   */
  details?: Error[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

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
 * Discovery response.
 */
model DiscoveryResponse is Azure.Core.Page<SolutionMetadataResource>;

/**
 * Metadata resource
 */
model SolutionMetadataResource extends ProxyResource {
  /**
   * Solution metadata Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: Solutions;
}

/**
 * List of solutions
 */
model Solutions {
  /**
   * List of metadata.
   */
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
  @visibility("read")
  solutionType?: SolutionType;

  /**
   * A detailed description of solution.
   */
  @visibility("read")
  description?: string;

  /**
   * Required parameters for invoking this particular solution.
   */
  @visibility("read")
  requiredInputs?: string[];
}

/**
 * Solution result
 */
model SolutionResourceProperties {
  /**
   * Solution request trigger criteria
   */
  triggerCriteria?: TriggerCriterion[];

  /**
   * Client input parameters to run Solution
   */
  parameters?: Record<string>;

  /**
   * Solution Id to identify single solution.
   */
  solutionId?: string;

  /**
   * Status of solution provisioning.
   */
  provisioningState?: SolutionProvisioningState;

  /**
   * The title.
   */
  title?: string;

  /**
   * The HTML content that needs to be rendered and shown to customer.
   */
  content?: string;

  /**
   * Solution replacement maps.
   */
  replacementMaps?: ReplacementMaps;

  /**
   * List of section object.
   */
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
  webResults?: WebResult[];

  /**
   * Solution diagnostics results.
   */
  diagnostics?: SolutionsDiagnostic[];

  /**
   * Solutions Troubleshooters
   */
  troubleshooters?: SolutionsTroubleshooters[];

  /**
   * Solution metrics based charts
   */
  metricsBasedCharts?: MetricsBasedChart[];

  /**
   * Video solutions, which have the power to engage the customer by stimulating their senses
   */
  videos?: Video[];

  /**
   * Group of Videos
   */
  videoGroups?: VideoGroup[];
}

/**
 * AzureKB web result
 */
model WebResult {
  /**
   * Place holder used in HTML Content replace control with the content
   */
  replacementKey?: string;

  /**
   * AzureKB search results
   */
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
  replacementKey?: string;

  /**
   * Required parameters of this item
   */
  requiredParameters?: string[];

  /**
   * Diagnostic insights
   */
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
  timeSpanDuration?: duration;

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
  replacementKey?: string;
}

/**
 * Filter group
 */
model FilterGroup {
  /**
   * List of filters
   */
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
model Video extends VideoGroupVideo {
  /**
   * Place holder used in HTML Content replace control with the insight content
   */
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
  videos?: VideoGroupVideo[];

  /**
   * Place holder used in HTML Content replace control with the insight content
   */
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
 * Solution response.
 */
model SolutionPatchRequestBody {
  /**
   * Solution result
   */
  properties?: SolutionResourceProperties;
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
  parameters?: Record<string>;

  /**
   * Status of troubleshooter provisioning.
   */
  @visibility("read")
  provisioningState?: TroubleshooterProvisioningState;

  /**
   * List of step object.
   */
  @visibility("read")
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
  @projectedName("json", "type")
  stepType?: Type;

  /**
   * is this last step of the workflow.
   */
  isLastStep?: boolean;

  inputs?: StepInput[];

  /**
   * Only for AutomatedStep type
   */
  automatedCheckResults?: AutomatedCheckResult;

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
   * Text Input. Will be a single line input.
   */
  questionType?: string;

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
   * Text Input. Will be a single line input.
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
  @visibility("read")
  troubleshooterResourceName?: string;
}
