import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Help;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum DiagnosticProvisioningState {
  @doc("All Diagnostics in the Batch succeeded.") Succeeded,
  @doc("Some Diagnostics are still running or failed.") PartialComplete,
  @doc("All Diagnostics failed to run.") Failed,
  @doc("When Diagnostic request gets canceled.") Canceled,
}

enum Status {
  @doc("Diagnostic creation failed.") Failed,
  @doc("Request is missing required inputs to run.") MissingInputs,
  @doc("Diagnostic is still running.") Running,
  @doc("Diagnostic creation succeeded.") Succeeded,
  @doc("Diagnostic was timed out.") Timeout,
}

enum ImportanceLevel {
  @doc("A critical insight has been found after running the diagnostic.")
  Critical,
  @doc("A warning insight has been found after running the diagnostic.")
  Warning,
  @doc("An information insight has been found after running the diagnostic.")
  Information,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum SolutionType {
  @doc("Diagnostics resource type.") Diagnostics,
  @doc("Solutions resource type.") Solutions,
}

enum Name {
  SolutionId,
  ProblemClassificationId,
  ReplacementKey,
}

enum SolutionProvisioningState {
  Succeeded,
  Failed,
  Canceled,
}

enum Confidence {
  Low,
  Medium,
  High,
}

enum ResultType {
  Community,
  Documentation,
}

enum AggregationType {
  Sum,
  Avg,
  Count,
  Min,
  Max,
}

enum TroubleshooterProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Running,
  AutoContinue,
}

enum ExecutionStatus {
  Success,
  Running,
  Failed,
  Warning,
}

enum Type {
  Decision,
  Solution,
  Insight,
  AutomatedCheck,
}

enum QuestionContentType {
  Text,
  Html,
  Markdown,
}

enum AutomatedCheckResultType {
  Success,
  Warning,
  Error,
  Information,
}

enum QuestionType {
  @doc("SingleChoice radio button") RadioButton,
  @doc("SingleChoice dropdown.") Dropdown,
  @doc("Text Input") TextInput,
  @doc("MultiLineInfoBox") MultiLineInfoBox,
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("Response for whether the requested resource name is available or not.")
model CheckNameAvailabilityResponse {
  @doc("Returns true or false depending on the availability of the name")
  nameAvailable?: boolean;

  @doc("Reason for why value is not available. This field is returned if nameAvailable is false.")
  reason?: string;

  @doc("Gets an error message explaining the 'reason' value with more details. This field is returned iif nameAvailable is false.")
  message?: string;
}

@doc("Diagnostic resource properties.")
model DiagnosticResourceProperties {
  @doc("Global parameters that can be passed to all solutionIds.")
  globalParameters?: Record<string>;

  @doc("SolutionIds that are needed to be invoked.")
  insights?: DiagnosticInvocation[];

  @doc("Diagnostic Request Accepted time.")
  @visibility("read")
  acceptedAt?: string;

  @doc("Status of diagnostic provisioning.")
  @visibility("read")
  provisioningState?: DiagnosticProvisioningState;

  @doc("Array of Diagnostics.")
  @visibility("read")
  diagnostics?: Diagnostic[];
}

@doc("Solution Invocation with additional params needed for invocation.")
model DiagnosticInvocation {
  @doc("Solution Id to invoke.")
  solutionId?: string;

  @doc("Additional parameters required to invoke the solutionId.")
  additionalParameters?: Record<string>;
}

@doc("Properties returned with in an insight.")
model Diagnostic {
  @doc("Solution Id")
  solutionId?: string;

  @doc("Denotes the status of the diagnostic resource.")
  status?: Status;

  @doc("The problems (if any) detected by this insight.")
  insights?: Insight[];

  @doc("Error definition.")
  error?: Error;
}

@doc("Detailed insights(s) obtained via the invocation of an insight diagnostic")
model Insight {
  @doc("Article id.")
  id?: string;

  @doc("This insight's title.")
  title?: string;

  @doc("Detailed result content.")
  results?: string;

  @doc("Importance level of the insight.")
  importanceLevel?: ImportanceLevel;
}

@doc("Error definition.")
model Error {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Service specific error type which serves as additional context for the error herein.")
  @visibility("read")
  type?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("An array of additional nested error response info objects, as described by this contract.")
  details?: Error[];
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Discovery response.")
model DiscoveryResponse is Azure.Core.Page<SolutionMetadataResource>;

@doc("Metadata resource")
model SolutionMetadataResource extends ProxyResource {
  @doc("Solution metadata Resource properties.")
  properties?: Solutions;
}

@doc("List of solutions")
model Solutions {
  @doc("List of metadata.")
  solutions?: SolutionMetadataProperties[];
}

@doc("Metadata Properties")
model SolutionMetadataProperties {
  @doc("Solution Id.")
  solutionId?: string;

  @doc("Solution Type.")
  @visibility("read")
  solutionType?: SolutionType;

  @doc("A detailed description of solution.")
  @visibility("read")
  description?: string;

  @doc("Required parameters for invoking this particular solution.")
  @visibility("read")
  requiredInputs?: string[];
}

@doc("Solution result")
model SolutionResourceProperties {
  @doc("Solution request trigger criteria")
  triggerCriteria?: TriggerCriterion[];

  @doc("Client input parameters to run Solution")
  parameters?: Record<string>;

  @doc("Solution Id to identify single solution.")
  solutionId?: string;

  @doc("Status of solution provisioning.")
  provisioningState?: SolutionProvisioningState;

  @doc("The title.")
  title?: string;

  @doc("The HTML content that needs to be rendered and shown to customer.")
  content?: string;

  @doc("Solution replacement maps.")
  replacementMaps?: ReplacementMaps;

  @doc("List of section object.")
  sections?: Section[];
}

@doc("Solution request trigger criterion. SolutionId/ProblemClassificationId is the only supported trigger type for Solution PUT request. ReplacementKey is the only supported trigger type for Solution PATCH request.")
model TriggerCriterion {
  @doc("Trigger criterion name.")
  name?: Name;

  @doc("Trigger criterion value.")
  value?: string;
}

@doc("Solution replacement maps.")
model ReplacementMaps {
  @doc("Solution AzureKB results")
  webResults?: WebResult[];

  @doc("Solution diagnostics results.")
  diagnostics?: SolutionsDiagnostic[];

  @doc("Solutions Troubleshooters")
  troubleshooters?: SolutionsTroubleshooters[];

  @doc("Solution metrics based charts")
  metricsBasedCharts?: MetricsBasedChart[];

  @doc("Video solutions, which have the power to engage the customer by stimulating their senses")
  videos?: Video[];

  @doc("Group of Videos")
  videoGroups?: VideoGroup[];
}

@doc("AzureKB web result")
model WebResult {
  @doc("Place holder used in HTML Content replace control with the content")
  replacementKey?: string;

  @doc("AzureKB search results")
  searchResults?: SearchResult[];
}

@doc("Details of an AzureKB search result.")
model SearchResult {
  @doc("Unique id of the result.")
  solutionId?: string;

  @doc("Content of the search result.")
  content?: string;

  @doc("Title of the search result.")
  title?: string;

  @doc("Confidence of the search result.")
  confidence?: Confidence;

  @doc("Source of the search result.")
  source?: string;

  @doc("Result type of the search result.")
  resultType?: ResultType;

  @doc("rank of the search result")
  rank?: int32;

  @doc("Link to the document.")
  link?: string;
}

@doc("Solutions Diagnostic")
model SolutionsDiagnostic {
  @doc("Solution Id to identify single Solutions Diagnostic")
  solutionId?: string;

  @doc("Denotes the status of the diagnostic resource.")
  status?: Status;

  @doc("Details of the status")
  statusDetails?: string;

  @doc("Place holder used in HTML Content replace control with the content")
  replacementKey?: string;

  @doc("Required parameters of this item")
  requiredParameters?: string[];

  @doc("Diagnostic insights")
  insights?: Insight[];
}

@doc("Troubleshooters in Solutions")
model SolutionsTroubleshooters {
  @doc("Solution Id to identify single Solutions Troubleshooter")
  solutionId?: string;

  @doc("Troubleshooter title")
  title?: string;

  @doc("Troubleshooter summary")
  summary?: string;
}

@doc("Solutions metrics based chart")
model MetricsBasedChart {
  @doc("Chart name")
  name?: string;

  @doc("Allowed values are Sum, Avg, Count, Min, Max. Default is Sum")
  aggregationType?: AggregationType;

  @doc("Time span duration")
  timeSpanDuration?: duration;

  @doc("Chart title")
  title?: string;

  @doc("Filter group")
  filterGroup?: FilterGroup;

  @doc("Place holder used in HTML Content replace control with the content")
  replacementKey?: string;
}

@doc("Filter group")
model FilterGroup {
  @doc("List of filters")
  filter?: Filter[];
}

@doc("Filter criterion")
model Filter {
  @doc("Filter name")
  name?: string;

  @doc("Filter values")
  values?: string;

  @doc("Filter operator")
  operator?: string;
}

@doc("Video detail")
model Video extends VideoGroupVideo {
  @doc("Place holder used in HTML Content replace control with the insight content")
  replacementKey?: string;
}

@doc("VideoGroup video detail")
model VideoGroupVideo {
  @doc("Link to the video")
  src?: string;

  @doc("Title of the video")
  title?: string;
}

@doc("Video group detail")
model VideoGroup {
  @doc("List of videos will be shown to customers")
  videos?: VideoGroupVideo[];

  @doc("Place holder used in HTML Content replace control with the insight content")
  replacementKey?: string;
}

@doc("Part of the solution and are dividers in the solution rendering.")
model Section {
  @doc("Solution sections title.")
  title?: string;

  @doc("Solution sections content.")
  content?: string;

  @doc("Solution replacement maps.")
  replacementMaps?: ReplacementMaps;
}

@doc("Solution response.")
model SolutionPatchRequestBody {
  @doc("Solution result")
  properties?: SolutionResourceProperties;
}

@doc("Troubleshooter Instance properties.")
model TroubleshooterInstanceProperties {
  @doc("Solution Id to identify single troubleshooter.")
  solutionId?: string;

  @doc("Client input parameters to run Troubleshooter Resource")
  parameters?: Record<string>;

  @doc("Status of troubleshooter provisioning.")
  @visibility("read")
  provisioningState?: TroubleshooterProvisioningState;

  @doc("List of step object.")
  @visibility("read")
  steps?: Step[];
}

@doc("Troubleshooter step")
model Step {
  @doc("Unique step id.")
  id?: string;

  @doc("Step title.")
  title?: string;

  @doc("Step description.")
  description?: string;

  @doc("Get or sets the Step guidance.")
  guidance?: string;

  @doc("Status of Troubleshooter Step execution.")
  executionStatus?: ExecutionStatus;

  @doc("This field has more detailed status description of the execution status.")
  executionStatusDescription?: string;

  @doc("Type of Troubleshooting step.")
  @projectedName("json", "type")
  stepType?: Type;

  @doc("is this last step of the workflow.")
  isLastStep?: boolean;

  inputs?: StepInput[];

  @doc("Only for AutomatedStep type")
  automatedCheckResults?: AutomatedCheckResult;

  insights?: Insight[];

  @doc("The error detail.")
  error?: ErrorDetail;
}

@doc("Details of step input.")
model StepInput {
  @doc("Use Index as QuestionId.")
  questionId?: string;

  @doc("Text Input. Will be a single line input.")
  questionType?: string;

  @doc("User question content.")
  questionContent?: string;

  @doc("Default is Text.")
  questionContentType?: QuestionContentType;

  @doc("Place holder text for response hints.")
  responseHint?: string;

  @doc("Result of Automate step.")
  recommendedOption?: string;

  @doc("Text of response that was selected.")
  selectedOptionValue?: string;

  @doc("Troubleshooter step input response validation properties")
  responseValidationProperties?: ResponseValidationProperties;

  responseOptions?: ResponseOption[];
}

@doc("Troubleshooter step input response validation properties")
model ResponseValidationProperties {
  @doc("Regex used for the input validation.")
  regex?: string;

  @doc("Default True")
  isRequired?: boolean;

  @doc("Validation Error Message.")
  validationErrorMessage?: string;

  @doc("Max text input (open Ended Text).")
  maxLength?: int32;
}

@doc("The status of the resource.")
model ResponseOption {
  @doc("Unique string.")
  key?: string;

  @doc("Option description")
  value?: string;
}

@doc("Only for AutomatedStep type")
model AutomatedCheckResult {
  @doc("Insight Article Content")
  result?: string;

  @doc("Type of Result.")
  type?: AutomatedCheckResultType;
}

@doc("Troubleshooter ContinueRequest body.")
model ContinueRequestBody {
  @doc("Unique id of the result.")
  stepId?: string;

  responses?: TroubleshooterResponse[];
}

@doc("User Response for Troubleshooter continue request")
model TroubleshooterResponse {
  @doc("id of the question.")
  questionId?: string;

  @doc("Text Input. Will be a single line input.")
  questionType?: QuestionType;

  @doc("Response key for SingleInput. For Multi-line test/open ended question it is free form text")
  response?: string;
}

@doc("Troubleshooter restart response")
model RestartTroubleshooterResponse {
  @doc("Updated TroubleshooterResource Name .")
  @visibility("read")
  troubleshooterResourceName?: string;
}
