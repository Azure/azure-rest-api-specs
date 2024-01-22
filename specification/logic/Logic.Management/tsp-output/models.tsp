import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Logic;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The workflow provisioning state.
 */
enum WorkflowProvisioningState {
  NotSpecified,
  Accepted,
  Running,
  Ready,
  Creating,
  Created,
  Deleting,
  Deleted,
  Canceled,
  Failed,
  Succeeded,
  Moving,
  Updating,
  Registering,
  Registered,
  Unregistering,
  Unregistered,
  Completed,
  Renewing,
  Pending,
  Waiting,
  InProgress,
}

/**
 * The workflow state.
 */
enum WorkflowState {
  NotSpecified,
  Completed,
  Enabled,
  Disabled,
  Deleted,
  Suspended,
}

/**
 * Open authentication policy provider type.
 */
enum OpenAuthenticationProviderType {
  AAD,
}

/**
 * The sku name.
 */
enum SkuName {
  NotSpecified,
  Free,
  Shared,
  Basic,
  Standard,
  Premium,
}

/**
 * The parameter type.
 */
enum ParameterType {
  NotSpecified,
  String,
  SecureString,
  Int,
  Float,
  Bool,
  Array,
  Object,
  SecureObject,
}

/**
 * Type of managed service identity. The type 'SystemAssigned' includes an implicitly created identity. The type 'None' will remove any identities from the resource.
 */
enum ManagedServiceIdentityType {
  SystemAssigned,
  UserAssigned,
  None,
}

/**
 * The key type.
 */
enum KeyType {
  NotSpecified,
  Primary,
  Secondary,
}

/**
 * The workflow trigger provisioning state.
 */
enum WorkflowTriggerProvisioningState {
  NotSpecified,
  Accepted,
  Running,
  Ready,
  Creating,
  Created,
  Deleting,
  Deleted,
  Canceled,
  Failed,
  Succeeded,
  Moving,
  Updating,
  Registering,
  Registered,
  Unregistering,
  Unregistered,
  Completed,
}

/**
 * The workflow status.
 */
enum WorkflowStatus {
  NotSpecified,
  Paused,
  Running,
  Waiting,
  Succeeded,
  Skipped,
  Suspended,
  Cancelled,
  Failed,
  Faulted,
  TimedOut,
  Aborted,
  Ignored,
}

/**
 * The recurrence frequency.
 */
enum RecurrenceFrequency {
  NotSpecified,
  Second,
  Minute,
  Hour,
  Day,
  Week,
  Month,
  Year,
}

/**
 * The integration account sku name.
 */
enum IntegrationAccountSkuName {
  NotSpecified,
  Free,
  Basic,
  Standard,
}

/**
 * The track events operation options.
 */
enum TrackEventsOperationOptions {
  None,
  DisableSourceInfoEnrich,
}

/**
 * The tracking record type.
 */
enum TrackingRecordType {
  NotSpecified,
  Custom,
  AS2Message,
  AS2MDN,
  X12Interchange,
  X12FunctionalGroup,
  X12TransactionSet,
  X12InterchangeAcknowledgment,
  X12FunctionalGroupAcknowledgment,
  X12TransactionSetAcknowledgment,
  EdifactInterchange,
  EdifactFunctionalGroup,
  EdifactTransactionSet,
  EdifactInterchangeAcknowledgment,
  EdifactFunctionalGroupAcknowledgment,
  EdifactTransactionSetAcknowledgment,
}

/**
 * The schema type.
 */
enum SchemaType {
  NotSpecified,
  Xml,
}

/**
 * The map type.
 */
enum MapType {
  NotSpecified,
  Xslt,
  Xslt20,
  Xslt30,
  Liquid,
}

/**
 * The partner type.
 */
enum PartnerType {
  NotSpecified,
  B2B,
}

/**
 * The signing or hashing algorithm.
 */
enum HashingAlgorithm {
  NotSpecified,
  None,
  MD5,
  SHA1,
  SHA2256,
  SHA2384,
  SHA2512,
}

/**
 * The encryption algorithm.
 */
enum EncryptionAlgorithm {
  NotSpecified,
  None,
  DES3,
  RC2,
  AES128,
  AES192,
  AES256,
}

/**
 * The signing or hashing algorithm.
 */
enum SigningAlgorithm {
  NotSpecified,
  Default,
  SHA1,
  SHA2256,
  SHA2384,
  SHA2512,
}

/**
 * The trailing separator policy.
 */
enum TrailingSeparatorPolicy {
  NotSpecified,
  NotAllowed,
  Optional,
  Mandatory,
}

/**
 * The X12 character set.
 */
enum X12CharacterSet {
  NotSpecified,
  Basic,
  Extended,
  UTF8,
}

/**
 * The x12 date format.
 */
enum X12DateFormat {
  NotSpecified,
  CCYYMMDD,
  YYMMDD,
}

/**
 * The x12 time format.
 */
enum X12TimeFormat {
  NotSpecified,
  HHMM,
  HHMMSS,
  HHMMSSdd,
  HHMMSSd,
}

/**
 * The usage indicator.
 */
enum UsageIndicator {
  NotSpecified,
  Test,
  Information,
  Production,
}

/**
 * The message filter type.
 */
enum MessageFilterType {
  NotSpecified,
  Include,
  Exclude,
}

/**
 * The edifact character set.
 */
enum EdifactCharacterSet {
  NotSpecified,
  UNOB,
  UNOA,
  UNOC,
  UNOD,
  UNOE,
  UNOF,
  UNOG,
  UNOH,
  UNOI,
  UNOJ,
  UNOK,
  UNOX,
  UNOY,
  KECA,
}

/**
 * The integration service environment access endpoint type.
 */
enum IntegrationServiceEnvironmentAccessEndpointType {
  NotSpecified,
  External,
  Internal,
}

/**
 * The integration service environment sku name.
 */
enum IntegrationServiceEnvironmentSkuName {
  NotSpecified,
  Premium,
  Developer,
}

/**
 * The integration service environment sku scale type.
 */
enum IntegrationServiceEnvironmentSkuScaleType {
  Manual,
  Automatic,
  None,
}

/**
 * The integration service environment network dependency category type.
 */
enum IntegrationServiceEnvironmentNetworkDependencyCategoryType {
  NotSpecified,
  AzureStorage,
  AzureManagement,
  AzureActiveDirectory,
  SSLCertificateVerification,
  DiagnosticLogsAndMetrics,
  IntegrationServiceEnvironmentConnectors,
  RedisCache,
  AccessEndpoints,
  RecoveryService,
  SQL,
  RegionalService,
}

/**
 * The integration service environment network endpoint accessibility state.
 */
enum IntegrationServiceEnvironmentNetworkEndPointAccessibilityState {
  NotSpecified,
  Unknown,
  Available,
  NotAvailable,
}

/**
 * The error response code.
 */
enum ErrorResponseCode {
  NotSpecified,
  IntegrationServiceEnvironmentNotFound,
  InternalServerError,
  InvalidOperationId,
}

/**
 * The integration service environment network dependency health state.
 */
enum IntegrationServiceEnvironmentNetworkDependencyHealthState {
  NotSpecified,
  Healthy,
  Unhealthy,
  Unknown,
}

enum ApiType {
  NotSpecified,
  Rest,
  Soap,
}

/**
 * The WSDL import method.
 */
enum WsdlImportMethod {
  NotSpecified,
  SoapToRest,
  SoapPassThrough,
}

/**
 * The Api deployment parameter visibility.
 */
enum ApiDeploymentParameterVisibility {
  NotSpecified,
  Default,
  Internal,
}

/**
 * The Api tier.
 */
enum ApiTier {
  NotSpecified,
  Enterprise,
  Standard,
  Premium,
}

/**
 * The status annotation.
 */
enum StatusAnnotation {
  NotSpecified,
  Preview,
  Production,
}

/**
 * The swagger schema type.
 */
enum SwaggerSchemaType {
  String,
  Number,
  Integer,
  Boolean,
  Array,
  File,
  Object,
  Null,
}

/**
 * The Azure async operation state.
 */
enum AzureAsyncOperationState {
  Failed,
  Succeeded,
  Pending,
  Canceled,
}

@fixed
enum DayOfWeek {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

/**
 * The event level.
 */
@fixed
enum EventLevel {
  LogAlways,
  Critical,
  Error,
  Warning,
  Informational,
  Verbose,
}

/**
 * The agreement type.
 */
@fixed
enum AgreementType {
  NotSpecified,
  AS2,
  X12,
  Edifact,
}

/**
 * The segment terminator suffix.
 */
@fixed
enum SegmentTerminatorSuffix {
  NotSpecified,
  None,
  CR,
  LF,
  CRLF,
}

/**
 * The edifact decimal indicator.
 */
@fixed
enum EdifactDecimalIndicator {
  NotSpecified,
  Comma,
  Decimal,
}

/**
 * The workflow properties.
 */
model WorkflowProperties {
  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: WorkflowProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The state.
   */
  state?: WorkflowState;

  /**
   * Gets the version.
   */
  @visibility("read")
  version?: string;

  /**
   * Gets the access endpoint.
   */
  @visibility("read")
  accessEndpoint?: string;

  /**
   * The endpoints configuration.
   */
  endpointsConfiguration?: FlowEndpointsConfiguration;

  /**
   * The access control configuration.
   */
  accessControl?: FlowAccessControlConfiguration;

  /**
   * The sku.
   */
  @visibility("read")
  sku?: Sku;

  /**
   * The integration account.
   */
  integrationAccount?: ResourceReference;

  /**
   * The integration service environment.
   */
  integrationServiceEnvironment?: ResourceReference;

  /**
   * The definition.
   */
  definition?: Record<unknown>;

  /**
   * The parameters.
   */
  parameters?: Record<WorkflowParameter>;
}

/**
 * The endpoints configuration.
 */
model FlowEndpointsConfiguration {
  /**
   * The workflow endpoints.
   */
  workflow?: FlowEndpoints;

  /**
   * The connector endpoints.
   */
  connector?: FlowEndpoints;
}

/**
 * The flow endpoints configuration.
 */
model FlowEndpoints {
  /**
   * The outgoing ip address.
   */
  outgoingIpAddresses?: IpAddress[];

  /**
   * The access endpoint ip address.
   */
  accessEndpointIpAddresses?: IpAddress[];
}

/**
 * The ip address.
 */
model IpAddress {
  /**
   * The address.
   */
  @projectedName("json", "address")
  cidrAddress?: string;
}

/**
 * The access control configuration.
 */
model FlowAccessControlConfiguration {
  /**
   * The access control configuration for invoking workflow triggers.
   */
  triggers?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for accessing workflow run contents.
   */
  contents?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for workflow actions.
   */
  actions?: FlowAccessControlConfigurationPolicy;

  /**
   * The access control configuration for workflow management.
   */
  workflowManagement?: FlowAccessControlConfigurationPolicy;
}

/**
 * The access control configuration policy.
 */
model FlowAccessControlConfigurationPolicy {
  /**
   * The allowed caller IP address ranges.
   */
  allowedCallerIpAddresses?: IpAddressRange[];

  /**
   * The authentication policies for workflow.
   */
  openAuthenticationPolicies?: OpenAuthenticationAccessPolicies;
}

/**
 * The ip address range.
 */
model IpAddressRange {
  /**
   * The IP address range.
   */
  addressRange?: string;
}

/**
 * AuthenticationPolicy of type Open.
 */
model OpenAuthenticationAccessPolicies {
  /**
   * Open authentication policies.
   */
  @projectedName("json", "policies")
  accessPolicies?: Record<OpenAuthenticationAccessPolicy>;
}

/**
 * Open authentication access policy defined by user.
 */
model OpenAuthenticationAccessPolicy {
  /**
   * Type of provider for OAuth.
   */
  type?: OpenAuthenticationProviderType;

  /**
   * The access policy claims.
   */
  claims?: OpenAuthenticationPolicyClaim[];
}

/**
 * Open authentication policy claim.
 */
model OpenAuthenticationPolicyClaim {
  /**
   * The name of the claim.
   */
  name?: string;

  /**
   * The value of the claim.
   */
  value?: string;
}

/**
 * The sku type.
 */
model Sku {
  /**
   * The name.
   */
  name: SkuName;

  /**
   * The reference to plan.
   */
  plan?: ResourceReference;
}

/**
 * The resource reference.
 */
model ResourceReference {
  /**
   * The resource id.
   */
  id?: string;

  /**
   * Gets the resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets the resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The workflow parameters.
 */
model WorkflowParameter {
  /**
   * The type.
   */
  type?: ParameterType;

  /**
   * The value.
   */
  value?: Record<unknown>;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The description.
   */
  description?: string;
}

/**
 * The base resource type.
 */
model Resource {
  /**
   * The resource id.
   */
  @visibility("read")
  id?: string;

  /**
   * Gets the resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  location?: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;
}

/**
 * Error properties indicate why the Logic service was not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorProperties {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * The parameters to generate upgraded definition.
 */
model GenerateUpgradedDefinitionParameters {
  /**
   * The target schema version.
   */
  targetSchemaVersion?: string;
}

/**
 * The callback url parameters.
 */
model GetCallbackUrlParameters {
  /**
   * The expiry time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  /**
   * The key type.
   */
  keyType?: KeyType;
}

/**
 * The workflow trigger callback URL.
 */
model WorkflowTriggerCallbackUrl {
  /**
   * Gets the workflow trigger callback URL.
   */
  @visibility("read")
  value?: string;

  /**
   * Gets the workflow trigger callback URL HTTP method.
   */
  @visibility("read")
  method?: string;

  /**
   * Gets the workflow trigger callback URL base path.
   */
  @visibility("read")
  basePath?: string;

  /**
   * Gets the workflow trigger callback URL relative path.
   */
  @visibility("read")
  relativePath?: string;

  /**
   * Gets the workflow trigger callback URL relative path parameters.
   */
  relativePathParameters?: string[];

  /**
   * Gets the workflow trigger callback URL query parameters.
   */
  queries?: WorkflowTriggerListCallbackUrlQueries;
}

/**
 * Gets the workflow trigger callback URL query parameters.
 */
model WorkflowTriggerListCallbackUrlQueries {
  /**
   * The api version.
   */
  @projectedName("json", "api-version")
  apiVersion?: string;

  /**
   * The SAS permissions.
   */
  sp?: string;

  /**
   * The SAS version.
   */
  sv?: string;

  /**
   * The SAS signature.
   */
  sig?: string;

  /**
   * The SAS timestamp.
   */
  se?: string;
}

/**
 * The workflow reference.
 */
model WorkflowReference extends ResourceReference {}

/**
 * The access key regenerate action content.
 */
model RegenerateActionParameter {
  /**
   * The key type.
   */
  keyType?: KeyType;
}

/**
 * The workflow version properties.
 */
model WorkflowVersionProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: WorkflowProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The state.
   */
  state?: WorkflowState;

  /**
   * Gets the version.
   */
  @visibility("read")
  version?: string;

  /**
   * Gets the access endpoint.
   */
  @visibility("read")
  accessEndpoint?: string;

  /**
   * The endpoints configuration.
   */
  endpointsConfiguration?: FlowEndpointsConfiguration;

  /**
   * The access control configuration.
   */
  accessControl?: FlowAccessControlConfiguration;

  /**
   * The sku.
   */
  @visibility("read")
  sku?: Sku;

  /**
   * The integration account.
   */
  integrationAccount?: ResourceReference;

  /**
   * The definition.
   */
  definition?: Record<unknown>;

  /**
   * The parameters.
   */
  parameters?: Record<WorkflowParameter>;
}

/**
 * The workflow trigger properties.
 */
model WorkflowTriggerProperties {
  /**
   * Gets the provisioning state.
   */
  @visibility("read")
  provisioningState?: WorkflowTriggerProvisioningState;

  /**
   * Gets the created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets the changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * Gets the state.
   */
  @visibility("read")
  state?: WorkflowState;

  /**
   * Gets the status.
   */
  @visibility("read")
  status?: WorkflowStatus;

  /**
   * Gets the last execution time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecutionTime?: utcDateTime;

  /**
   * Gets the next execution time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextExecutionTime?: utcDateTime;

  /**
   * Gets the workflow trigger recurrence.
   */
  @visibility("read")
  recurrence?: WorkflowTriggerRecurrence;

  /**
   * Gets the reference to workflow.
   */
  @visibility("read")
  workflow?: ResourceReference;
}

/**
 * The workflow trigger recurrence.
 */
model WorkflowTriggerRecurrence {
  /**
   * The frequency.
   */
  frequency?: RecurrenceFrequency;

  /**
   * The interval.
   */
  interval?: int32;

  /**
   * The start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The time zone.
   */
  timeZone?: string;

  /**
   * The recurrence schedule.
   */
  schedule?: RecurrenceSchedule;
}

/**
 * The recurrence schedule.
 */
model RecurrenceSchedule {
  /**
   * The minutes.
   */
  minutes?: int32[];

  /**
   * The hours.
   */
  hours?: int32[];

  /**
   * The days of the week.
   */
  weekDays?: DayOfWeek[];

  /**
   * The month days.
   */
  monthDays?: int32[];

  /**
   * The monthly occurrences.
   */
  monthlyOccurrences?: RecurrenceScheduleOccurrence[];
}

/**
 * The recurrence schedule occurrence.
 */
model RecurrenceScheduleOccurrence {
  /**
   * The day of the week.
   */
  day?: DayOfWeek;

  /**
   * The occurrence.
   */
  occurrence?: int32;
}

/**
 * The sub resource type.
 */
model SubResource {
  /**
   * The resource id.
   */
  @visibility("read")
  id?: string;
}

/**
 * The JSON schema.
 */
model JsonSchema {
  /**
   * The JSON title.
   */
  title?: string;

  /**
   * The JSON content.
   */
  content?: string;
}

/**
 * The set trigger state action definition.
 */
model SetTriggerStateActionDefinition {
  /**
   * The source.
   */
  source: WorkflowTriggerReference;
}

/**
 * The workflow trigger reference.
 */
model WorkflowTriggerReference extends ResourceReference {
  /**
   * The workflow name.
   */
  flowName?: string;

  /**
   * The workflow trigger name.
   */
  triggerName?: string;
}

/**
 * The workflow trigger history properties.
 */
model WorkflowTriggerHistoryProperties {
  /**
   * Gets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The scheduled time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility("read")
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets the error.
   */
  @visibility("read")
  error?: Record<unknown>;

  /**
   * Gets the tracking id.
   */
  @visibility("read")
  trackingId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the link to input parameters.
   */
  @visibility("read")
  inputsLink?: ContentLink;

  /**
   * Gets the link to output parameters.
   */
  @visibility("read")
  outputsLink?: ContentLink;

  /**
   * The value indicating whether trigger was fired.
   */
  @visibility("read")
  fired?: boolean;

  /**
   * Gets the reference to workflow run.
   */
  @visibility("read")
  run?: ResourceReference;
}

/**
 * The correlation property.
 */
model Correlation {
  /**
   * The client tracking id.
   */
  clientTrackingId?: string;
}

/**
 * The content link.
 */
model ContentLink {
  /**
   * The content link URI.
   */
  uri?: string;

  /**
   * The content version.
   */
  @visibility("read")
  contentVersion?: string;

  /**
   * The content size.
   */
  @visibility("read")
  contentSize?: int64;

  /**
   * The content hash.
   */
  @visibility("read")
  contentHash?: ContentHash;

  /**
   * The metadata.
   */
  @visibility("read")
  metadata?: Record<unknown>;
}

/**
 * The content hash.
 */
model ContentHash {
  /**
   * The algorithm of the content hash.
   */
  algorithm?: string;

  /**
   * The value of the content hash.
   */
  value?: string;
}

/**
 * The workflow run properties.
 */
model WorkflowRunProperties {
  /**
   * Gets the wait end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  waitEndTime?: utcDateTime;

  /**
   * Gets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility("read")
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets the error.
   */
  @visibility("read")
  error?: Record<unknown>;

  /**
   * Gets the correlation id.
   */
  @visibility("read")
  correlationId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the reference to workflow version.
   */
  @visibility("read")
  workflow?: ResourceReference;

  /**
   * Gets the fired trigger.
   */
  @visibility("read")
  trigger?: WorkflowRunTrigger;

  /**
   * Gets the outputs.
   */
  @visibility("read")
  outputs?: Record<WorkflowOutputParameter>;

  /**
   * Gets the response of the flow run.
   */
  @visibility("read")
  response?: WorkflowRunTrigger;
}

/**
 * The workflow run trigger.
 */
model WorkflowRunTrigger {
  /**
   * Gets the name.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets the inputs.
   */
  @visibility("read")
  inputs?: Record<unknown>;

  /**
   * Gets the link to inputs.
   */
  @visibility("read")
  inputsLink?: ContentLink;

  /**
   * Gets the outputs.
   */
  @visibility("read")
  outputs?: Record<unknown>;

  /**
   * Gets the link to outputs.
   */
  @visibility("read")
  outputsLink?: ContentLink;

  /**
   * Gets the scheduled time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime?: utcDateTime;

  /**
   * Gets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the tracking id.
   */
  @visibility("read")
  trackingId?: string;

  /**
   * The run correlation.
   */
  correlation?: Correlation;

  /**
   * Gets the code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets the status.
   */
  @visibility("read")
  status?: WorkflowStatus;

  /**
   * Gets the error.
   */
  @visibility("read")
  error?: Record<unknown>;

  /**
   * Gets the tracked properties.
   */
  @visibility("read")
  trackedProperties?: Record<unknown>;
}

/**
 * The workflow output parameter.
 */
model WorkflowOutputParameter extends WorkflowParameter {
  /**
   * Gets the error.
   */
  @visibility("read")
  error?: Record<unknown>;
}

/**
 * The workflow run action properties.
 */
model WorkflowRunActionProperties {
  /**
   * Gets the start time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status.
   */
  @visibility("read")
  status?: WorkflowStatus;

  /**
   * Gets the code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets the error.
   */
  @visibility("read")
  error?: Record<unknown>;

  /**
   * Gets the tracking id.
   */
  @visibility("read")
  trackingId?: string;

  /**
   * The correlation properties.
   */
  correlation?: RunActionCorrelation;

  /**
   * Gets the link to inputs.
   */
  @visibility("read")
  inputsLink?: ContentLink;

  /**
   * Gets the link to outputs.
   */
  @visibility("read")
  outputsLink?: ContentLink;

  /**
   * Gets the tracked properties.
   */
  @visibility("read")
  trackedProperties?: Record<unknown>;

  /**
   * Gets the retry histories.
   */
  retryHistory?: RetryHistory[];
}

/**
 * The workflow run action correlation properties.
 */
model RunActionCorrelation extends RunCorrelation {
  /**
   * The action tracking identifier.
   */
  actionTrackingId?: string;
}

/**
 * The correlation properties.
 */
model RunCorrelation {
  /**
   * The client tracking identifier.
   */
  clientTrackingId?: string;

  /**
   * The client keywords.
   */
  clientKeywords?: string[];
}

/**
 * The retry history.
 */
model RetryHistory {
  /**
   * Gets the start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the status code.
   */
  code?: string;

  /**
   * Gets the client request Id.
   */
  clientRequestId?: string;

  /**
   * Gets the service request Id.
   */
  serviceRequestId?: string;

  /**
   * Gets the error response.
   */
  error?: ErrorResponse;
}

/**
 * The expression traces.
 */
@pagedResult
model ExpressionTraces {
  @items
  inputs?: ExpressionRoot[];
}

/**
 * The expression root.
 */
model ExpressionRoot extends Expression {
  /**
   * The path.
   */
  path?: string;
}

/**
 * The expression.
 */
model Expression {
  /**
   * The text.
   */
  text?: string;

  /**
   * Anything
   */
  value?: unknown;

  /**
   * The sub expressions.
   */
  subexpressions?: Expression[];

  /**
   * The azure resource error info.
   */
  error?: AzureResourceErrorInfo;
}

/**
 * The azure resource error info.
 */
model AzureResourceErrorInfo extends ErrorInfo {
  /**
   * The error message.
   */
  message: string;

  /**
   * The error details.
   */
  details?: AzureResourceErrorInfo[];
}

/**
 * The error info.
 */
model ErrorInfo {
  /**
   * The error code.
   */
  code: string;
}

/**
 * The workflow run action repetition properties definition.
 */
model WorkflowRunActionRepetitionProperties extends OperationResult {
  /**
   * The repetition indexes.
   */
  repetitionIndexes?: RepetitionIndex[];
}

/**
 * The workflow run action repetition index.
 */
model RepetitionIndex {
  /**
   * The scope.
   */
  scopeName?: string;

  /**
   * The index.
   */
  itemIndex: int32;
}

/**
 * The operation result definition.
 */
model OperationResult extends OperationResultProperties {
  /**
   * Gets the tracking id.
   */
  @visibility("read")
  trackingId?: string;

  /**
   * Gets the inputs.
   */
  @visibility("read")
  inputs?: Record<unknown>;

  /**
   * Gets the link to inputs.
   */
  @visibility("read")
  inputsLink?: ContentLink;

  /**
   * Gets the outputs.
   */
  @visibility("read")
  outputs?: Record<unknown>;

  /**
   * Gets the link to outputs.
   */
  @visibility("read")
  outputsLink?: ContentLink;

  /**
   * Gets the tracked properties.
   */
  @visibility("read")
  trackedProperties?: Record<unknown>;

  /**
   * Gets the retry histories.
   */
  retryHistory?: RetryHistory[];

  iterationCount?: int32;
}

/**
 * The run operation result properties.
 */
model OperationResultProperties {
  /**
   * The start time of the workflow scope repetition.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the workflow scope repetition.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The correlation properties.
   */
  correlation?: RunActionCorrelation;

  /**
   * The status of the workflow scope repetition.
   */
  status?: WorkflowStatus;

  /**
   * The workflow scope repetition code.
   */
  code?: string;

  /**
   * Anything
   */
  error?: unknown;
}

/**
 * The request history.
 */
model RequestHistoryProperties {
  /**
   * The time the request started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the request ended.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The request.
   */
  request?: Request;

  /**
   * The response.
   */
  response?: Response;
}

/**
 * A request.
 */
model Request {
  /**
   * A list of all the headers attached to the request.
   */
  headers?: Record<unknown>;

  /**
   * The destination for the request.
   */
  uri?: string;

  /**
   * The HTTP method used for the request.
   */
  method?: string;
}

/**
 * A response.
 */
model Response {
  /**
   * A list of all the headers attached to the response.
   */
  headers?: Record<unknown>;

  /**
   * The status code of the response.
   */
  statusCode?: int32;

  /**
   * Details on the location of the body content.
   */
  bodyLink?: ContentLink;
}

/**
 * The integration account properties.
 */
model IntegrationAccountProperties {
  /**
   * The integration service environment.
   */
  integrationServiceEnvironment?: ResourceReference;

  /**
   * The workflow state.
   */
  state?: WorkflowState;
}

/**
 * The integration account sku.
 */
model IntegrationAccountSku {
  /**
   * The sku name.
   */
  name: IntegrationAccountSkuName;
}

/**
 * The assembly properties definition.
 */
model AssemblyProperties extends ArtifactContentPropertiesDefinition {
  /**
   * The assembly name.
   */
  assemblyName: string;

  /**
   * The assembly version.
   */
  assemblyVersion?: string;

  /**
   * The assembly culture.
   */
  assemblyCulture?: string;

  /**
   * The assembly public key token.
   */
  assemblyPublicKeyToken?: string;
}

/**
 * The artifact content properties definition.
 */
model ArtifactContentPropertiesDefinition extends ArtifactProperties {
  /**
   * Anything
   */
  content?: unknown;

  /**
   * The content type.
   */
  contentType?: string;

  /**
   * The content link.
   */
  contentLink?: ContentLink;
}

/**
 * The artifact properties definition.
 */
model ArtifactProperties {
  /**
   * The artifact creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The artifact changed time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * Anything
   */
  metadata?: unknown;
}

/**
 * The batch configuration properties definition.
 */
model BatchConfigurationProperties extends ArtifactProperties {
  /**
   * The name of the batch group.
   */
  batchGroupName: string;

  /**
   * The batch release criteria.
   */
  releaseCriteria: BatchReleaseCriteria;
}

/**
 * The batch release criteria.
 */
model BatchReleaseCriteria {
  /**
   * The message count.
   */
  messageCount?: int32;

  /**
   * The batch size in bytes.
   */
  batchSize?: int32;

  /**
   * The recurrence.
   */
  recurrence?: WorkflowTriggerRecurrence;
}

/**
 * The callback url.
 */
model CallbackUrl {
  /**
   * The URL value.
   */
  @projectedName("json", "value")
  url?: string;
}

/**
 * The list key vault keys definition.
 */
model ListKeyVaultKeysDefinition {
  /**
   * The key vault reference.
   */
  keyVault: KeyVaultReference;

  /**
   * The skip token.
   */
  skipToken?: string;
}

/**
 * The key vault reference.
 */
model KeyVaultReference extends ResourceReference {}

/**
 * Collection of key vault keys.
 */
@pagedResult
model KeyVaultKeyCollection {
  /**
   * The key vault keys.
   */
  @items
  value?: KeyVaultKey[];

  /**
   * The skip token.
   */
  skipToken?: string;
}

/**
 * The key vault key.
 */
model KeyVaultKey {
  /**
   * The key id.
   */
  kid?: string;

  /**
   * The key attributes.
   */
  attributes?: KeyVaultKeyAttributes;
}

/**
 * The key attributes.
 */
model KeyVaultKeyAttributes {
  /**
   * Whether the key is enabled or not.
   */
  enabled?: boolean;

  /**
   * When the key was created.
   */
  created?: plainTime;

  /**
   * When the key was updated.
   */
  updated?: plainTime;
}

/**
 * The tracking events definition.
 */
model TrackingEventsDefinition {
  /**
   * The source type.
   */
  sourceType: string;

  /**
   * The track events options.
   */
  trackEventsOptions?: TrackEventsOperationOptions;

  /**
   * The events.
   */
  events: TrackingEvent[];
}

/**
 * The tracking event.
 */
model TrackingEvent {
  /**
   * The event level.
   */
  eventLevel: EventLevel;

  /**
   * The event time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime: utcDateTime;

  /**
   * The record type.
   */
  recordType: TrackingRecordType;

  /**
   * The record.
   */
  record?: Record<unknown>;

  /**
   * The error.
   */
  error?: TrackingEventErrorInfo;
}

/**
 * The tracking event error info.
 */
model TrackingEventErrorInfo {
  /**
   * The message.
   */
  message?: string;

  /**
   * The code.
   */
  code?: string;
}

/**
 * The integration account schema properties.
 */
model IntegrationAccountSchemaProperties {
  /**
   * The schema type.
   */
  schemaType: SchemaType;

  /**
   * The target namespace of the schema.
   */
  targetNamespace?: string;

  /**
   * The document name.
   */
  documentName?: string;

  /**
   * The file name.
   */
  fileName?: string;

  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The content.
   */
  content?: string;

  /**
   * The content type.
   */
  contentType?: string;

  /**
   * The content link.
   */
  @visibility("read")
  contentLink?: ContentLink;
}

/**
 * The integration account map.
 */
model IntegrationAccountMapProperties {
  /**
   * The map type.
   */
  mapType: MapType;

  /**
   * The parameters schema of integration account map.
   */
  parametersSchema?: IntegrationAccountMapPropertiesParametersSchema;

  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The content.
   */
  content?: string;

  /**
   * The content type.
   */
  contentType?: string;

  /**
   * The content link.
   */
  @visibility("read")
  contentLink?: ContentLink;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;
}

/**
 * The parameters schema of integration account map.
 */
model IntegrationAccountMapPropertiesParametersSchema {
  /**
   * The reference name.
   */
  ref?: string;
}

/**
 * The integration account partner properties.
 */
model IntegrationAccountPartnerProperties {
  /**
   * The partner type.
   */
  partnerType: PartnerType;

  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The partner content.
   */
  content: PartnerContent;
}

/**
 * The integration account partner content.
 */
model PartnerContent {
  /**
   * The B2B partner content.
   */
  @projectedName("json", "b2b")
  b2B?: B2BPartnerContent;
}

/**
 * The B2B partner content.
 */
model B2BPartnerContent {
  /**
   * The list of partner business identities.
   */
  businessIdentities?: BusinessIdentity[];
}

/**
 * The integration account partner's business identity.
 */
model BusinessIdentity {
  /**
   * The business identity qualifier e.g. as2identity, ZZ, ZZZ, 31, 32
   */
  qualifier: string;

  /**
   * The user defined business identity value.
   */
  value: string;
}

/**
 * The integration account agreement properties.
 */
model IntegrationAccountAgreementProperties {
  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The agreement type.
   */
  agreementType: AgreementType;

  /**
   * The integration account partner that is set as host partner for this agreement.
   */
  hostPartner: string;

  /**
   * The integration account partner that is set as guest partner for this agreement.
   */
  guestPartner: string;

  /**
   * The business identity of the host partner.
   */
  hostIdentity: BusinessIdentity;

  /**
   * The business identity of the guest partner.
   */
  guestIdentity: BusinessIdentity;

  /**
   * The agreement content.
   */
  content: AgreementContent;
}

/**
 * The integration account agreement content.
 */
model AgreementContent {
  /**
   * The AS2 agreement content.
   */
  aS2?: AS2AgreementContent;

  /**
   * The X12 agreement content.
   */
  x12?: X12AgreementContent;

  /**
   * The EDIFACT agreement content.
   */
  edifact?: EdifactAgreementContent;
}

/**
 * The integration account AS2 agreement content.
 */
model AS2AgreementContent {
  /**
   * The AS2 one-way receive agreement.
   */
  receiveAgreement: AS2OneWayAgreement;

  /**
   * The AS2 one-way send agreement.
   */
  sendAgreement: AS2OneWayAgreement;
}

/**
 * The integration account AS2 one-way agreement.
 */
model AS2OneWayAgreement {
  /**
   * The sender business identity
   */
  senderBusinessIdentity: BusinessIdentity;

  /**
   * The receiver business identity
   */
  receiverBusinessIdentity: BusinessIdentity;

  /**
   * The AS2 protocol settings.
   */
  protocolSettings: AS2ProtocolSettings;
}

/**
 * The AS2 agreement protocol settings.
 */
model AS2ProtocolSettings {
  /**
   * The message connection settings.
   */
  messageConnectionSettings: AS2MessageConnectionSettings;

  /**
   * The acknowledgement connection settings.
   */
  acknowledgementConnectionSettings: AS2AcknowledgementConnectionSettings;

  /**
   * The MDN settings.
   */
  mdnSettings: AS2MdnSettings;

  /**
   * The security settings.
   */
  securitySettings: AS2SecuritySettings;

  /**
   * The validation settings.
   */
  validationSettings: AS2ValidationSettings;

  /**
   * The envelope settings.
   */
  envelopeSettings: AS2EnvelopeSettings;

  /**
   * The error settings.
   */
  errorSettings: AS2ErrorSettings;
}

/**
 * The AS2 agreement message connection settings.
 */
model AS2MessageConnectionSettings {
  /**
   * The value indicating whether to ignore mismatch in certificate name.
   */
  ignoreCertificateNameMismatch: boolean;

  /**
   * The value indicating whether to support HTTP status code 'CONTINUE'.
   */
  supportHttpStatusCodeContinue: boolean;

  /**
   * The value indicating whether to keep the connection alive.
   */
  keepHttpConnectionAlive: boolean;

  /**
   * The value indicating whether to unfold the HTTP headers.
   */
  unfoldHttpHeaders: boolean;
}

/**
 * The AS2 agreement acknowledgement connection settings.
 */
model AS2AcknowledgementConnectionSettings {
  /**
   * Indicates whether to ignore mismatch in certificate name.
   */
  ignoreCertificateNameMismatch: boolean;

  /**
   * Indicates whether to support HTTP status code 'CONTINUE'.
   */
  supportHttpStatusCodeContinue: boolean;

  /**
   * Indicates whether to keep the connection alive.
   */
  keepHttpConnectionAlive: boolean;

  /**
   * Indicates whether to unfold the HTTP headers.
   */
  unfoldHttpHeaders: boolean;
}

/**
 * The AS2 agreement mdn settings.
 */
model AS2MdnSettings {
  /**
   * The value indicating whether to send or request a MDN.
   */
  needMDN: boolean;

  /**
   * The value indicating whether the MDN needs to be signed or not.
   */
  signMDN: boolean;

  /**
   * The value indicating whether to send the asynchronous MDN.
   */
  sendMDNAsynchronously: boolean;

  /**
   * The receipt delivery URL.
   */
  receiptDeliveryUrl?: string;

  /**
   * The disposition notification to header value.
   */
  dispositionNotificationTo?: string;

  /**
   * The value indicating whether to sign the outbound MDN if optional.
   */
  signOutboundMDNIfOptional: boolean;

  /**
   * The MDN text.
   */
  mdnText?: string;

  /**
   * The value indicating whether to send inbound MDN to message box.
   */
  sendInboundMDNToMessageBox: boolean;

  /**
   * The signing or hashing algorithm.
   */
  micHashingAlgorithm: HashingAlgorithm;
}

/**
 * The AS2 agreement security settings.
 */
model AS2SecuritySettings {
  /**
   * The value indicating whether to send or request a MDN.
   */
  overrideGroupSigningCertificate: boolean;

  /**
   * The name of the signing certificate.
   */
  signingCertificateName?: string;

  /**
   * The name of the encryption certificate.
   */
  encryptionCertificateName?: string;

  /**
   * The value indicating whether to enable NRR for inbound encoded messages.
   */
  enableNRRForInboundEncodedMessages: boolean;

  /**
   * The value indicating whether to enable NRR for inbound decoded messages.
   */
  enableNRRForInboundDecodedMessages: boolean;

  /**
   * The value indicating whether to enable NRR for outbound MDN.
   */
  enableNRRForOutboundMDN: boolean;

  /**
   * The value indicating whether to enable NRR for outbound encoded messages.
   */
  enableNRRForOutboundEncodedMessages: boolean;

  /**
   * The value indicating whether to enable NRR for outbound decoded messages.
   */
  enableNRRForOutboundDecodedMessages: boolean;

  /**
   * The value indicating whether to enable NRR for inbound MDN.
   */
  enableNRRForInboundMDN: boolean;

  /**
   * The Sha2 algorithm format. Valid values are Sha2, ShaHashSize, ShaHyphenHashSize, Sha2UnderscoreHashSize.
   */
  sha2AlgorithmFormat?: string;
}

/**
 * The AS2 agreement validation settings.
 */
model AS2ValidationSettings {
  /**
   * The value indicating whether to override incoming message properties with those in agreement.
   */
  overrideMessageProperties: boolean;

  /**
   * The value indicating whether the message has to be encrypted.
   */
  encryptMessage: boolean;

  /**
   * The value indicating whether the message has to be signed.
   */
  signMessage: boolean;

  /**
   * The value indicating whether the message has to be compressed.
   */
  compressMessage: boolean;

  /**
   * The value indicating whether to check for duplicate message.
   */
  checkDuplicateMessage: boolean;

  /**
   * The number of days to look back for duplicate interchange.
   */
  interchangeDuplicatesValidityDays: int32;

  /**
   * The value indicating whether to check for certificate revocation list on send.
   */
  checkCertificateRevocationListOnSend: boolean;

  /**
   * The value indicating whether to check for certificate revocation list on receive.
   */
  checkCertificateRevocationListOnReceive: boolean;

  /**
   * The encryption algorithm.
   */
  encryptionAlgorithm: EncryptionAlgorithm;

  /**
   * The signing algorithm.
   */
  signingAlgorithm?: SigningAlgorithm;
}

/**
 * The AS2 agreement envelope settings.
 */
model AS2EnvelopeSettings {
  /**
   * The message content type.
   */
  messageContentType: string;

  /**
   * The value indicating whether to transmit file name in mime header.
   */
  transmitFileNameInMimeHeader: boolean;

  /**
   * The template for file name.
   */
  fileNameTemplate: string;

  /**
   * The value indicating whether to suspend message on file name generation error.
   */
  suspendMessageOnFileNameGenerationError: boolean;

  /**
   * The value indicating whether to auto generate file name.
   */
  autogenerateFileName: boolean;
}

/**
 * The AS2 agreement error settings.
 */
model AS2ErrorSettings {
  /**
   * The value indicating whether to suspend duplicate message.
   */
  suspendDuplicateMessage: boolean;

  /**
   * The value indicating whether to resend message If MDN is not received.
   */
  resendIfMDNNotReceived: boolean;
}

/**
 * The X12 agreement content.
 */
model X12AgreementContent {
  /**
   * The X12 one-way receive agreement.
   */
  receiveAgreement: X12OneWayAgreement;

  /**
   * The X12 one-way send agreement.
   */
  sendAgreement: X12OneWayAgreement;
}

/**
 * The X12 one-way agreement.
 */
model X12OneWayAgreement {
  /**
   * The sender business identity
   */
  senderBusinessIdentity: BusinessIdentity;

  /**
   * The receiver business identity
   */
  receiverBusinessIdentity: BusinessIdentity;

  /**
   * The X12 protocol settings.
   */
  protocolSettings: X12ProtocolSettings;
}

/**
 * The X12 agreement protocol settings.
 */
model X12ProtocolSettings {
  /**
   * The X12 validation settings.
   */
  validationSettings: X12ValidationSettings;

  /**
   * The X12 framing settings.
   */
  framingSettings: X12FramingSettings;

  /**
   * The X12 envelope settings.
   */
  envelopeSettings: X12EnvelopeSettings;

  /**
   * The X12 acknowledgment settings.
   */
  acknowledgementSettings: X12AcknowledgementSettings;

  /**
   * The X12 message filter.
   */
  messageFilter: X12MessageFilter;

  /**
   * The X12 security settings.
   */
  securitySettings: X12SecuritySettings;

  /**
   * The X12 processing settings.
   */
  processingSettings: X12ProcessingSettings;

  /**
   * The X12 envelope override settings.
   */
  envelopeOverrides?: X12EnvelopeOverride[];

  /**
   * The X12 validation override settings.
   */
  validationOverrides?: X12ValidationOverride[];

  /**
   * The X12 message filter list.
   */
  messageFilterList?: X12MessageIdentifier[];

  /**
   * The X12 schema references.
   */
  schemaReferences: X12SchemaReference[];

  /**
   * The X12 delimiter override settings.
   */
  x12DelimiterOverrides?: X12DelimiterOverrides[];
}

/**
 * The X12 agreement validation settings.
 */
model X12ValidationSettings {
  /**
   * The value indicating whether to validate character set in the message.
   */
  validateCharacterSet: boolean;

  /**
   * The value indicating whether to check for duplicate interchange control number.
   */
  checkDuplicateInterchangeControlNumber: boolean;

  /**
   * The validity period of interchange control number.
   */
  interchangeControlNumberValidityDays: int32;

  /**
   * The value indicating whether to check for duplicate group control number.
   */
  checkDuplicateGroupControlNumber: boolean;

  /**
   * The value indicating whether to check for duplicate transaction set control number.
   */
  checkDuplicateTransactionSetControlNumber: boolean;

  /**
   * The value indicating whether to Whether to validate EDI types.
   */
  validateEDITypes: boolean;

  /**
   * The value indicating whether to Whether to validate XSD types.
   */
  validateXSDTypes: boolean;

  /**
   * The value indicating whether to allow leading and trailing spaces and zeroes.
   */
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The value indicating whether to trim leading and trailing spaces and zeroes.
   */
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The trailing separator policy.
   */
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

/**
 * The X12 agreement framing settings.
 */
model X12FramingSettings {
  /**
   * The data element separator.
   */
  dataElementSeparator: int32;

  /**
   * The component separator.
   */
  componentSeparator: int32;

  /**
   * The value indicating whether to replace separators in payload.
   */
  replaceSeparatorsInPayload: boolean;

  /**
   * The replacement character.
   */
  replaceCharacter: int32;

  /**
   * The segment terminator.
   */
  segmentTerminator: int32;

  /**
   * The X12 character set.
   */
  characterSet: X12CharacterSet;

  /**
   * The segment terminator suffix.
   */
  segmentTerminatorSuffix: SegmentTerminatorSuffix;
}

/**
 * The X12 agreement envelope settings.
 */
model X12EnvelopeSettings {
  /**
   * The controls standards id.
   */
  controlStandardsId: int32;

  /**
   * The value indicating whether to use control standards id as repetition character.
   */
  useControlStandardsIdAsRepetitionCharacter: boolean;

  /**
   * The sender application id.
   */
  senderApplicationId: string;

  /**
   * The receiver application id.
   */
  receiverApplicationId: string;

  /**
   * The control version number.
   */
  controlVersionNumber: string;

  /**
   * The interchange  control number lower bound.
   */
  interchangeControlNumberLowerBound: int32;

  /**
   * The interchange  control number upper bound.
   */
  interchangeControlNumberUpperBound: int32;

  /**
   * The value indicating whether to rollover interchange control number.
   */
  rolloverInterchangeControlNumber: boolean;

  /**
   * The value indicating whether to enable default group headers.
   */
  enableDefaultGroupHeaders: boolean;

  /**
   * The functional group id.
   */
  functionalGroupId?: string;

  /**
   * The group control number lower bound.
   */
  groupControlNumberLowerBound: int32;

  /**
   * The group control number upper bound.
   */
  groupControlNumberUpperBound: int32;

  /**
   * The value indicating whether to rollover group control number.
   */
  rolloverGroupControlNumber: boolean;

  /**
   * The group header agency code.
   */
  groupHeaderAgencyCode: string;

  /**
   * The group header version.
   */
  groupHeaderVersion: string;

  /**
   * The transaction set control number lower bound.
   */
  transactionSetControlNumberLowerBound: int32;

  /**
   * The transaction set control number upper bound.
   */
  transactionSetControlNumberUpperBound: int32;

  /**
   * The value indicating whether to rollover transaction set control number.
   */
  rolloverTransactionSetControlNumber: boolean;

  /**
   * The transaction set control number prefix.
   */
  transactionSetControlNumberPrefix?: string;

  /**
   * The transaction set control number suffix.
   */
  transactionSetControlNumberSuffix?: string;

  /**
   * The value indicating whether to overwrite existing transaction set control number.
   */
  overwriteExistingTransactionSetControlNumber: boolean;

  /**
   * The group header date format.
   */
  groupHeaderDateFormat: X12DateFormat;

  /**
   * The group header time format.
   */
  groupHeaderTimeFormat: X12TimeFormat;

  /**
   * The usage indicator.
   */
  usageIndicator: UsageIndicator;
}

/**
 * The X12 agreement acknowledgement settings.
 */
model X12AcknowledgementSettings {
  /**
   * The value indicating whether technical acknowledgement is needed.
   */
  needTechnicalAcknowledgement: boolean;

  /**
   * The value indicating whether to batch the technical acknowledgements.
   */
  batchTechnicalAcknowledgements: boolean;

  /**
   * The value indicating whether functional acknowledgement is needed.
   */
  needFunctionalAcknowledgement: boolean;

  /**
   * The functional acknowledgement version.
   */
  functionalAcknowledgementVersion?: string;

  /**
   * The value indicating whether to batch functional acknowledgements.
   */
  batchFunctionalAcknowledgements: boolean;

  /**
   * The value indicating whether implementation acknowledgement is needed.
   */
  needImplementationAcknowledgement: boolean;

  /**
   * The implementation acknowledgement version.
   */
  implementationAcknowledgementVersion?: string;

  /**
   * The value indicating whether to batch implementation acknowledgements.
   */
  batchImplementationAcknowledgements: boolean;

  /**
   * The value indicating whether a loop is needed for valid messages.
   */
  needLoopForValidMessages: boolean;

  /**
   * The value indicating whether to send synchronous acknowledgement.
   */
  sendSynchronousAcknowledgement: boolean;

  /**
   * The acknowledgement control number prefix.
   */
  acknowledgementControlNumberPrefix?: string;

  /**
   * The acknowledgement control number suffix.
   */
  acknowledgementControlNumberSuffix?: string;

  /**
   * The acknowledgement control number lower bound.
   */
  acknowledgementControlNumberLowerBound: int32;

  /**
   * The acknowledgement control number upper bound.
   */
  acknowledgementControlNumberUpperBound: int32;

  /**
   * The value indicating whether to rollover acknowledgement control number.
   */
  rolloverAcknowledgementControlNumber: boolean;
}

/**
 * The X12 message filter for odata query.
 */
model X12MessageFilter {
  /**
   * The message filter type.
   */
  messageFilterType: MessageFilterType;
}

/**
 * The X12 agreement security settings.
 */
model X12SecuritySettings {
  /**
   * The authorization qualifier.
   */
  authorizationQualifier: string;

  /**
   * The authorization value.
   */
  authorizationValue?: string;

  /**
   * The security qualifier.
   */
  securityQualifier: string;

  /**
   * The password value.
   */
  passwordValue?: string;
}

/**
 * The X12 processing settings.
 */
model X12ProcessingSettings {
  /**
   * The value indicating whether to mask security information.
   */
  maskSecurityInfo: boolean;

  /**
   * The value indicating whether to convert numerical type to implied decimal.
   */
  convertImpliedDecimal: boolean;

  /**
   * The value indicating whether to preserve interchange.
   */
  preserveInterchange: boolean;

  /**
   * The value indicating whether to suspend interchange on error.
   */
  suspendInterchangeOnError: boolean;

  /**
   * The value indicating whether to create empty xml tags for trailing separators.
   */
  createEmptyXmlTagsForTrailingSeparators: boolean;

  /**
   * The value indicating whether to use dot as decimal separator.
   */
  useDotAsDecimalSeparator: boolean;
}

/**
 * The X12 envelope override settings.
 */
model X12EnvelopeOverride {
  /**
   * The target namespace on which this envelope settings has to be applied.
   */
  targetNamespace: string;

  /**
   * The protocol version on which this envelope settings has to be applied.
   */
  protocolVersion: string;

  /**
   * The message id on which this envelope settings has to be applied.
   */
  messageId: string;

  /**
   * The responsible agency code.
   */
  responsibleAgencyCode: string;

  /**
   * The header version.
   */
  headerVersion: string;

  /**
   * The sender application id.
   */
  senderApplicationId: string;

  /**
   * The receiver application id.
   */
  receiverApplicationId: string;

  /**
   * The functional identifier code.
   */
  functionalIdentifierCode?: string;

  /**
   * The date format.
   */
  dateFormat: X12DateFormat;

  /**
   * The time format.
   */
  timeFormat: X12TimeFormat;
}

/**
 * The X12 validation override settings.
 */
model X12ValidationOverride {
  /**
   * The message id on which the validation settings has to be applied.
   */
  messageId: string;

  /**
   * The value indicating whether to validate EDI types.
   */
  validateEDITypes: boolean;

  /**
   * The value indicating whether to validate XSD types.
   */
  validateXSDTypes: boolean;

  /**
   * The value indicating whether to allow leading and trailing spaces and zeroes.
   */
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The value indicating whether to validate character Set.
   */
  validateCharacterSet: boolean;

  /**
   * The value indicating whether to trim leading and trailing spaces and zeroes.
   */
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The trailing separator policy.
   */
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

/**
 * The X12 message identifier.
 */
model X12MessageIdentifier {
  /**
   * The message id.
   */
  messageId: string;
}

/**
 * The X12 schema reference.
 */
model X12SchemaReference {
  /**
   * The message id.
   */
  messageId: string;

  /**
   * The sender application id.
   */
  senderApplicationId?: string;

  /**
   * The schema version.
   */
  schemaVersion: string;

  /**
   * The schema name.
   */
  schemaName: string;
}

/**
 * The X12 delimiter override settings.
 */
model X12DelimiterOverrides {
  /**
   * The protocol version.
   */
  protocolVersion?: string;

  /**
   * The message id.
   */
  messageId?: string;

  /**
   * The data element separator.
   */
  dataElementSeparator: int32;

  /**
   * The component separator.
   */
  componentSeparator: int32;

  /**
   * The segment terminator.
   */
  segmentTerminator: int32;

  /**
   * The segment terminator suffix.
   */
  segmentTerminatorSuffix: SegmentTerminatorSuffix;

  /**
   * The replacement character.
   */
  replaceCharacter: int32;

  /**
   * The value indicating whether to replace separators in payload.
   */
  replaceSeparatorsInPayload: boolean;

  /**
   * The target namespace on which this delimiter settings has to be applied.
   */
  targetNamespace?: string;
}

/**
 * The Edifact agreement content.
 */
model EdifactAgreementContent {
  /**
   * The EDIFACT one-way receive agreement.
   */
  receiveAgreement: EdifactOneWayAgreement;

  /**
   * The EDIFACT one-way send agreement.
   */
  sendAgreement: EdifactOneWayAgreement;
}

/**
 * The Edifact one way agreement.
 */
model EdifactOneWayAgreement {
  /**
   * The sender business identity
   */
  senderBusinessIdentity: BusinessIdentity;

  /**
   * The receiver business identity
   */
  receiverBusinessIdentity: BusinessIdentity;

  /**
   * The EDIFACT protocol settings.
   */
  protocolSettings: EdifactProtocolSettings;
}

/**
 * The Edifact agreement protocol settings.
 */
model EdifactProtocolSettings {
  /**
   * The EDIFACT validation settings.
   */
  validationSettings: EdifactValidationSettings;

  /**
   * The EDIFACT framing settings.
   */
  framingSettings: EdifactFramingSettings;

  /**
   * The EDIFACT envelope settings.
   */
  envelopeSettings: EdifactEnvelopeSettings;

  /**
   * The EDIFACT acknowledgement settings.
   */
  acknowledgementSettings: EdifactAcknowledgementSettings;

  /**
   * The EDIFACT message filter.
   */
  messageFilter: EdifactMessageFilter;

  /**
   * The EDIFACT processing Settings.
   */
  processingSettings: EdifactProcessingSettings;

  /**
   * The EDIFACT envelope override settings.
   */
  envelopeOverrides?: EdifactEnvelopeOverride[];

  /**
   * The EDIFACT message filter list.
   */
  messageFilterList?: EdifactMessageIdentifier[];

  /**
   * The EDIFACT schema references.
   */
  schemaReferences: EdifactSchemaReference[];

  /**
   * The EDIFACT validation override settings.
   */
  validationOverrides?: EdifactValidationOverride[];

  /**
   * The EDIFACT delimiter override settings.
   */
  edifactDelimiterOverrides?: EdifactDelimiterOverride[];
}

/**
 * The Edifact agreement validation settings.
 */
model EdifactValidationSettings {
  /**
   * The value indicating whether to validate character set in the message.
   */
  validateCharacterSet: boolean;

  /**
   * The value indicating whether to check for duplicate interchange control number.
   */
  checkDuplicateInterchangeControlNumber: boolean;

  /**
   * The validity period of interchange control number.
   */
  interchangeControlNumberValidityDays: int32;

  /**
   * The value indicating whether to check for duplicate group control number.
   */
  checkDuplicateGroupControlNumber: boolean;

  /**
   * The value indicating whether to check for duplicate transaction set control number.
   */
  checkDuplicateTransactionSetControlNumber: boolean;

  /**
   * The value indicating whether to Whether to validate EDI types.
   */
  validateEDITypes: boolean;

  /**
   * The value indicating whether to Whether to validate XSD types.
   */
  validateXSDTypes: boolean;

  /**
   * The value indicating whether to allow leading and trailing spaces and zeroes.
   */
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The value indicating whether to trim leading and trailing spaces and zeroes.
   */
  trimLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The trailing separator policy.
   */
  trailingSeparatorPolicy: TrailingSeparatorPolicy;
}

/**
 * The Edifact agreement framing settings.
 */
model EdifactFramingSettings {
  /**
   * The service code list directory version.
   */
  serviceCodeListDirectoryVersion?: string;

  /**
   * The character encoding.
   */
  characterEncoding?: string;

  /**
   * The protocol version.
   */
  protocolVersion: int32;

  /**
   * The data element separator.
   */
  dataElementSeparator: int32;

  /**
   * The component separator.
   */
  componentSeparator: int32;

  /**
   * The segment terminator.
   */
  segmentTerminator: int32;

  /**
   * The release indicator.
   */
  releaseIndicator: int32;

  /**
   * The repetition separator.
   */
  repetitionSeparator: int32;

  /**
   * The EDIFACT frame setting characterSet.
   */
  characterSet: EdifactCharacterSet;

  /**
   * The EDIFACT frame setting decimal indicator.
   */
  decimalPointIndicator: EdifactDecimalIndicator;

  /**
   * The EDIFACT frame setting segment terminator suffix.
   */
  segmentTerminatorSuffix: SegmentTerminatorSuffix;
}

/**
 * The Edifact agreement envelope settings.
 */
model EdifactEnvelopeSettings {
  /**
   * The group association assigned code.
   */
  groupAssociationAssignedCode?: string;

  /**
   * The communication agreement id.
   */
  communicationAgreementId?: string;

  /**
   * The value indicating whether to apply delimiter string advice.
   */
  applyDelimiterStringAdvice: boolean;

  /**
   * The value indicating whether to create grouping segments.
   */
  createGroupingSegments: boolean;

  /**
   * The value indicating whether to enable default group headers.
   */
  enableDefaultGroupHeaders: boolean;

  /**
   * The recipient reference password value.
   */
  recipientReferencePasswordValue?: string;

  /**
   * The recipient reference password qualifier.
   */
  recipientReferencePasswordQualifier?: string;

  /**
   * The application reference id.
   */
  applicationReferenceId?: string;

  /**
   * The processing priority code.
   */
  processingPriorityCode?: string;

  /**
   * The interchange control number lower bound.
   */
  interchangeControlNumberLowerBound: int64;

  /**
   * The interchange control number upper bound.
   */
  interchangeControlNumberUpperBound: int64;

  /**
   * The value indicating whether to rollover interchange control number.
   */
  rolloverInterchangeControlNumber: boolean;

  /**
   * The interchange control number prefix.
   */
  interchangeControlNumberPrefix?: string;

  /**
   * The interchange control number suffix.
   */
  interchangeControlNumberSuffix?: string;

  /**
   * The sender reverse routing address.
   */
  senderReverseRoutingAddress?: string;

  /**
   * The receiver reverse routing address.
   */
  receiverReverseRoutingAddress?: string;

  /**
   * The functional group id.
   */
  functionalGroupId?: string;

  /**
   * The group controlling agency code.
   */
  groupControllingAgencyCode?: string;

  /**
   * The group message version.
   */
  groupMessageVersion?: string;

  /**
   * The group message release.
   */
  groupMessageRelease?: string;

  /**
   * The group control number lower bound.
   */
  groupControlNumberLowerBound: int64;

  /**
   * The group control number upper bound.
   */
  groupControlNumberUpperBound: int64;

  /**
   * The value indicating whether to rollover group control number.
   */
  rolloverGroupControlNumber: boolean;

  /**
   * The group control number prefix.
   */
  groupControlNumberPrefix?: string;

  /**
   * The group control number suffix.
   */
  groupControlNumberSuffix?: string;

  /**
   * The group application receiver qualifier.
   */
  groupApplicationReceiverQualifier?: string;

  /**
   * The group application receiver id.
   */
  groupApplicationReceiverId?: string;

  /**
   * The group application sender qualifier.
   */
  groupApplicationSenderQualifier?: string;

  /**
   * The group application sender id.
   */
  groupApplicationSenderId?: string;

  /**
   * The group application password.
   */
  groupApplicationPassword?: string;

  /**
   * The value indicating whether to overwrite existing transaction set control number.
   */
  overwriteExistingTransactionSetControlNumber: boolean;

  /**
   * The transaction set control number prefix.
   */
  transactionSetControlNumberPrefix?: string;

  /**
   * The transaction set control number suffix.
   */
  transactionSetControlNumberSuffix?: string;

  /**
   * The transaction set control number lower bound.
   */
  transactionSetControlNumberLowerBound: int64;

  /**
   * The transaction set control number upper bound.
   */
  transactionSetControlNumberUpperBound: int64;

  /**
   * The value indicating whether to rollover transaction set control number.
   */
  rolloverTransactionSetControlNumber: boolean;

  /**
   * The value indicating whether the message is a test interchange.
   */
  isTestInterchange: boolean;

  /**
   * The sender internal identification.
   */
  senderInternalIdentification?: string;

  /**
   * The sender internal sub identification.
   */
  senderInternalSubIdentification?: string;

  /**
   * The receiver internal identification.
   */
  receiverInternalIdentification?: string;

  /**
   * The receiver internal sub identification.
   */
  receiverInternalSubIdentification?: string;
}

/**
 * The Edifact agreement acknowledgement settings.
 */
model EdifactAcknowledgementSettings {
  /**
   * The value indicating whether technical acknowledgement is needed.
   */
  needTechnicalAcknowledgement: boolean;

  /**
   * The value indicating whether to batch the technical acknowledgements.
   */
  batchTechnicalAcknowledgements: boolean;

  /**
   * The value indicating whether functional acknowledgement is needed.
   */
  needFunctionalAcknowledgement: boolean;

  /**
   * The value indicating whether to batch functional acknowledgements.
   */
  batchFunctionalAcknowledgements: boolean;

  /**
   * The value indicating whether a loop is needed for valid messages.
   */
  needLoopForValidMessages: boolean;

  /**
   * The value indicating whether to send synchronous acknowledgement.
   */
  sendSynchronousAcknowledgement: boolean;

  /**
   * The acknowledgement control number prefix.
   */
  acknowledgementControlNumberPrefix?: string;

  /**
   * The acknowledgement control number suffix.
   */
  acknowledgementControlNumberSuffix?: string;

  /**
   * The acknowledgement control number lower bound.
   */
  acknowledgementControlNumberLowerBound: int32;

  /**
   * The acknowledgement control number upper bound.
   */
  acknowledgementControlNumberUpperBound: int32;

  /**
   * The value indicating whether to rollover acknowledgement control number.
   */
  rolloverAcknowledgementControlNumber: boolean;
}

/**
 * The Edifact message filter for odata query.
 */
model EdifactMessageFilter {
  /**
   * The message filter type.
   */
  messageFilterType: MessageFilterType;
}

/**
 * The Edifact agreement protocol settings.
 */
model EdifactProcessingSettings {
  /**
   * The value indicating whether to mask security information.
   */
  maskSecurityInfo: boolean;

  /**
   * The value indicating whether to preserve interchange.
   */
  preserveInterchange: boolean;

  /**
   * The value indicating whether to suspend interchange on error.
   */
  suspendInterchangeOnError: boolean;

  /**
   * The value indicating whether to create empty xml tags for trailing separators.
   */
  createEmptyXmlTagsForTrailingSeparators: boolean;

  /**
   * The value indicating whether to use dot as decimal separator.
   */
  useDotAsDecimalSeparator: boolean;
}

/**
 * The Edifact envelope override settings.
 */
model EdifactEnvelopeOverride {
  /**
   * The message id on which this envelope settings has to be applied.
   */
  messageId?: string;

  /**
   * The message version on which this envelope settings has to be applied.
   */
  messageVersion?: string;

  /**
   * The message release version on which this envelope settings has to be applied.
   */
  messageRelease?: string;

  /**
   * The message association assigned code.
   */
  messageAssociationAssignedCode?: string;

  /**
   * The target namespace on which this envelope settings has to be applied.
   */
  targetNamespace?: string;

  /**
   * The functional group id.
   */
  functionalGroupId?: string;

  /**
   * The sender application qualifier.
   */
  senderApplicationQualifier?: string;

  /**
   * The sender application id.
   */
  senderApplicationId?: string;

  /**
   * The receiver application qualifier.
   */
  receiverApplicationQualifier?: string;

  /**
   * The receiver application id.
   */
  receiverApplicationId?: string;

  /**
   * The controlling agency code.
   */
  controllingAgencyCode?: string;

  /**
   * The group header message version.
   */
  groupHeaderMessageVersion?: string;

  /**
   * The group header message release.
   */
  groupHeaderMessageRelease?: string;

  /**
   * The association assigned code.
   */
  associationAssignedCode?: string;

  /**
   * The application password.
   */
  applicationPassword?: string;
}

/**
 * The Edifact message identifier.
 */
model EdifactMessageIdentifier {
  /**
   * The message id on which this envelope settings has to be applied.
   */
  messageId: string;
}

/**
 * The Edifact schema reference.
 */
model EdifactSchemaReference {
  /**
   * The message id.
   */
  messageId: string;

  /**
   * The message version.
   */
  messageVersion: string;

  /**
   * The message release version.
   */
  messageRelease: string;

  /**
   * The sender application id.
   */
  senderApplicationId?: string;

  /**
   * The sender application qualifier.
   */
  senderApplicationQualifier?: string;

  /**
   * The association assigned code.
   */
  associationAssignedCode?: string;

  /**
   * The schema name.
   */
  schemaName: string;
}

/**
 * The Edifact validation override settings.
 */
model EdifactValidationOverride {
  /**
   * The message id on which the validation settings has to be applied.
   */
  messageId: string;

  /**
   * The value indicating whether to validate character Set.
   */
  enforceCharacterSet: boolean;

  /**
   * The value indicating whether to validate EDI types.
   */
  validateEDITypes: boolean;

  /**
   * The value indicating whether to validate XSD types.
   */
  validateXSDTypes: boolean;

  /**
   * The value indicating whether to allow leading and trailing spaces and zeroes.
   */
  allowLeadingAndTrailingSpacesAndZeroes: boolean;

  /**
   * The trailing separator policy.
   */
  trailingSeparatorPolicy: TrailingSeparatorPolicy;

  /**
   * The value indicating whether to trim leading and trailing spaces and zeroes.
   */
  trimLeadingAndTrailingSpacesAndZeroes: boolean;
}

/**
 * The Edifact delimiter override settings.
 */
model EdifactDelimiterOverride {
  /**
   * The message id.
   */
  messageId?: string;

  /**
   * The message version.
   */
  messageVersion?: string;

  /**
   * The message release.
   */
  messageRelease?: string;

  /**
   * The data element separator.
   */
  dataElementSeparator: int32;

  /**
   * The component separator.
   */
  componentSeparator: int32;

  /**
   * The segment terminator.
   */
  segmentTerminator: int32;

  /**
   * The repetition separator.
   */
  repetitionSeparator: int32;

  /**
   * The segment terminator suffix.
   */
  segmentTerminatorSuffix: SegmentTerminatorSuffix;

  /**
   * The decimal point indicator.
   */
  decimalPointIndicator: EdifactDecimalIndicator;

  /**
   * The release indicator.
   */
  releaseIndicator: int32;

  /**
   * The message association assigned code.
   */
  messageAssociationAssignedCode?: string;

  /**
   * The target namespace on which this delimiter settings has to be applied.
   */
  targetNamespace?: string;
}

/**
 * The integration account certificate properties.
 */
model IntegrationAccountCertificateProperties {
  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The key details in the key vault.
   */
  key?: KeyVaultKeyReference;

  /**
   * The public certificate.
   */
  publicCertificate?: string;
}

/**
 * The reference to the key vault key.
 */
model KeyVaultKeyReference {
  /**
   * The key vault reference.
   */
  keyVault: KeyVaultKeyReferenceKeyVault;

  /**
   * The private key name in key vault.
   */
  keyName: string;

  /**
   * The private key version in key vault.
   */
  keyVersion?: string;
}

/**
 * The key vault reference.
 */
model KeyVaultKeyReferenceKeyVault {
  /**
   * The resource id.
   */
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The integration account session properties.
 */
model IntegrationAccountSessionProperties {
  /**
   * The created time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The changed time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime?: utcDateTime;

  /**
   * The session content.
   */
  content?: Record<unknown>;
}

/**
 * The integration service environment properties.
 */
model IntegrationServiceEnvironmentProperties {
  /**
   * The provisioning state.
   */
  provisioningState?: WorkflowProvisioningState;

  /**
   * The integration service environment state.
   */
  state?: WorkflowState;

  /**
   * Gets the tracking id.
   */
  integrationServiceEnvironmentId?: string;

  /**
   * The endpoints configuration.
   */
  endpointsConfiguration?: FlowEndpointsConfiguration;

  /**
   * The network configuration.
   */
  networkConfiguration?: NetworkConfiguration;

  /**
   * The encryption configuration.
   */
  encryptionConfiguration?: IntegrationServiceEnvironmenEncryptionConfiguration;
}

/**
 * The network configuration.
 */
model NetworkConfiguration {
  /**
   * Gets the virtual network address space.
   */
  virtualNetworkAddressSpace?: string;

  /**
   * The access endpoint.
   */
  accessEndpoint?: IntegrationServiceEnvironmentAccessEndpoint;

  /**
   * The subnets.
   */
  subnets?: ResourceReference[];
}

/**
 * The integration service environment access endpoint.
 */
model IntegrationServiceEnvironmentAccessEndpoint {
  /**
   * The access endpoint type.
   */
  type?: IntegrationServiceEnvironmentAccessEndpointType;
}

/**
 * The encryption configuration for the integration service environment.
 */
model IntegrationServiceEnvironmenEncryptionConfiguration {
  /**
   * The encryption key reference.
   */
  encryptionKeyReference?: IntegrationServiceEnvironmenEncryptionKeyReference;
}

/**
 * The encryption key details for the integration service environment.
 */
model IntegrationServiceEnvironmenEncryptionKeyReference {
  /**
   * The key vault reference.
   */
  keyVault?: ResourceReference;

  /**
   * Gets the key name in the Key Vault.
   */
  keyName?: string;

  /**
   * Gets the version of the key specified in the keyName property.
   */
  keyVersion?: string;
}

/**
 * The integration service environment sku.
 */
model IntegrationServiceEnvironmentSku {
  /**
   * The sku name.
   */
  name?: IntegrationServiceEnvironmentSkuName;

  /**
   * The sku capacity.
   */
  capacity?: int32;
}

/**
 * The list of integration service environment skus.
 */
model IntegrationServiceEnvironmentSkuList
  is Azure.Core.Page<IntegrationServiceEnvironmentSkuDefinition>;

/**
 * The integration service environment sku definition.
 */
model IntegrationServiceEnvironmentSkuDefinition {
  /**
   * The resource type.
   */
  resourceType?: string;

  /**
   * The sku.
   */
  sku?: IntegrationServiceEnvironmentSkuDefinitionSku;

  /**
   * The sku capacity.
   */
  capacity?: IntegrationServiceEnvironmentSkuCapacity;
}

/**
 * The sku.
 */
model IntegrationServiceEnvironmentSkuDefinitionSku {
  /**
   * The sku name.
   */
  name?: IntegrationServiceEnvironmentSkuName;

  /**
   * The sku tier.
   */
  tier?: string;
}

/**
 * The integration service environment sku capacity.
 */
model IntegrationServiceEnvironmentSkuCapacity {
  /**
   * The minimum capacity.
   */
  minimum?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;

  /**
   * The default capacity.
   */
  default?: int32;

  /**
   * The sku scale type.
   */
  scaleType?: IntegrationServiceEnvironmentSkuScaleType;
}

/**
 * The integration service environment subnet network health.
 */
model IntegrationServiceEnvironmentSubnetNetworkHealth {
  /**
   * The outbound network dependencies.
   */
  outboundNetworkDependencies?: IntegrationServiceEnvironmentNetworkDependency[];

  /**
   * The integration service environment network health.
   */
  outboundNetworkHealth?: IntegrationServiceEnvironmentNetworkDependencyHealth;

  /**
   * The integration service environment network health state.
   */
  networkDependencyHealthState: IntegrationServiceEnvironmentNetworkEndPointAccessibilityState;
}

/**
 * The azure async operation resource.
 */
model IntegrationServiceEnvironmentNetworkDependency {
  /**
   * The network dependency category type.
   */
  category?: IntegrationServiceEnvironmentNetworkDependencyCategoryType;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The endpoints.
   */
  endpoints?: IntegrationServiceEnvironmentNetworkEndpoint[];
}

/**
 * The network endpoint.
 */
model IntegrationServiceEnvironmentNetworkEndpoint {
  /**
   * The accessibility state.
   */
  accessibility?: IntegrationServiceEnvironmentNetworkEndPointAccessibilityState;

  /**
   * The domain name.
   */
  domainName?: string;

  /**
   * The ports.
   */
  ports?: string[];
}

/**
 * The integration service environment subnet network health.
 */
model IntegrationServiceEnvironmentNetworkDependencyHealth {
  /**
   * The error if any occurred during the operation.
   */
  error?: ExtendedErrorInfo;

  /**
   * The network dependency health state.
   */
  state?: IntegrationServiceEnvironmentNetworkDependencyHealthState;
}

/**
 * The extended error info.
 */
model ExtendedErrorInfo {
  /**
   * The error code.
   */
  code: ErrorResponseCode;

  /**
   * The error message.
   */
  message: string;

  /**
   * The error message details.
   */
  details?: ExtendedErrorInfo[];

  /**
   * The inner error.
   */
  innerError?: Record<unknown>;
}

/**
 * The integration service environment managed api properties.
 */
model IntegrationServiceEnvironmentManagedApiProperties
  extends ApiResourceProperties {
  /**
   * The integration service environment managed api deployment parameters.
   */
  deploymentParameters?: IntegrationServiceEnvironmentManagedApiDeploymentParameters;
}

/**
 * The integration service environment managed api deployment parameters.
 */
model IntegrationServiceEnvironmentManagedApiDeploymentParameters {
  /**
   * The integration service environment managed api content link for deployment.
   */
  contentLinkDefinition?: ContentLink;
}

/**
 * The API resource properties.
 */
model ApiResourceProperties {
  /**
   * The name
   */
  @visibility("read")
  name?: string;

  /**
   * The connection parameters.
   */
  @visibility("read")
  connectionParameters?: Record<Record<unknown>>;

  /**
   * The metadata.
   */
  @visibility("read")
  metadata?: ApiResourceMetadata;

  /**
   * The runtime urls.
   */
  @visibility("read")
  runtimeUrls?: string[];

  /**
   * The api general information.
   */
  @visibility("read")
  generalInformation?: ApiResourceGeneralInformation;

  /**
   * The capabilities.
   */
  @visibility("read")
  capabilities?: string[];

  /**
   * The backend service.
   */
  @visibility("read")
  backendService?: ApiResourceBackendService;

  /**
   * The policies for the API.
   */
  @visibility("read")
  policies?: ApiResourcePolicies;

  /**
   * The API definition.
   */
  @visibility("read")
  apiDefinitionUrl?: string;

  /**
   * The api definitions.
   */
  @visibility("read")
  apiDefinitions?: ApiResourceDefinitions;

  /**
   * The integration service environment reference.
   */
  integrationServiceEnvironment?: ResourceReference;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: WorkflowProvisioningState;

  /**
   * The category.
   */
  @visibility("read")
  category?: ApiTier;
}

/**
 * The api resource metadata.
 */
model ApiResourceMetadata {
  /**
   * The source.
   */
  source?: string;

  /**
   * The brand color.
   */
  brandColor?: string;

  /**
   * The hide key.
   */
  hideKey?: string;

  /**
   * The tags.
   */
  tags?: Record<string>;

  /**
   * The api type.
   */
  @projectedName("json", "ApiType")
  apiType?: ApiType;

  /**
   * The WSDL service.
   */
  wsdlService?: WsdlService;

  /**
   * The WSDL import method.
   */
  wsdlImportMethod?: WsdlImportMethod;

  /**
   * The connection type.
   */
  connectionType?: string;

  /**
   * The provisioning state.
   */
  provisioningState?: WorkflowProvisioningState;

  /**
   * The connector deployment parameters metadata.
   */
  deploymentParameters?: ApiDeploymentParameterMetadataSet;
}

/**
 * The WSDL service.
 */
model WsdlService {
  /**
   * The qualified name.
   */
  qualifiedName?: string;

  /**
   * The list of endpoints' qualified names.
   */
  @projectedName("json", "EndpointQualifiedNames")
  endpointQualifiedNames?: string[];
}

/**
 * The API deployment parameters metadata.
 */
model ApiDeploymentParameterMetadataSet {
  /**
   * The package content link parameter.
   */
  packageContentLink?: ApiDeploymentParameterMetadata;

  /**
   * The package content link parameter.
   */
  redisCacheConnectionString?: ApiDeploymentParameterMetadata;
}

/**
 * The API deployment parameter metadata.
 */
model ApiDeploymentParameterMetadata {
  /**
   * The type.
   */
  type?: string;

  /**
   * Indicates whether its required.
   */
  isRequired?: boolean;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The description.
   */
  description?: string;

  /**
   * The visibility.
   */
  visibility?: ApiDeploymentParameterVisibility;
}

/**
 * The API general information.
 */
model ApiResourceGeneralInformation {
  /**
   * The icon url.
   */
  iconUrl?: string;

  /**
   * The display name.
   */
  displayName?: string;

  /**
   * The description.
   */
  description?: string;

  /**
   * The terms of use url.
   */
  termsOfUseUrl?: string;

  /**
   * The release tag.
   */
  releaseTag?: string;

  /**
   * The tier.
   */
  tier?: ApiTier;
}

/**
 * The API backend service.
 */
model ApiResourceBackendService {
  /**
   * The service URL.
   */
  serviceUrl?: string;
}

/**
 * The API resource policies.
 */
model ApiResourcePolicies {
  /**
   * The API level only policies XML as embedded content.
   */
  content?: string;

  /**
   * The content link to the policies.
   */
  contentLink?: string;
}

/**
 * The Api resource definition.
 */
model ApiResourceDefinitions {
  /**
   * The original swagger url.
   */
  originalSwaggerUrl?: string;

  /**
   * The modified swagger url.
   */
  modifiedSwaggerUrl?: string;
}

/**
 * The list of managed API operations.
 */
model ApiOperationListResult is Azure.Core.Page<ApiOperation>;

/**
 * The api operation.
 */
model ApiOperation extends Resource {
  /**
   * The api operations properties
   */
  properties?: ApiOperationPropertiesDefinition;
}

/**
 * The api operations properties
 */
model ApiOperationPropertiesDefinition {
  /**
   * The summary of the api operation.
   */
  summary?: string;

  /**
   * The description of the api operation.
   */
  description?: string;

  /**
   * The visibility of the api operation.
   */
  visibility?: string;

  /**
   * The trigger type of api operation.
   */
  trigger?: string;

  /**
   * The trigger hint for the api operation.
   */
  triggerHint?: string;

  /**
   * Indicates whether the api operation is pageable.
   */
  pageable?: boolean;

  /**
   * The annotation of api operation.
   */
  annotation?: ApiOperationAnnotation;

  /**
   * The api reference.
   */
  api?: ApiReference;

  /**
   * The operation inputs definition schema.
   */
  inputsDefinition?: SwaggerSchema;

  /**
   * The operation responses definition schemas.
   */
  responsesDefinition?: Record<SwaggerSchema>;

  /**
   * Indicates whether the API operation is webhook or not.
   */
  isWebhook?: boolean;

  /**
   * Indicates whether the API operation is notification or not.
   */
  isNotification?: boolean;
}

/**
 * The Api Operation Annotation.
 */
model ApiOperationAnnotation {
  /**
   * The status annotation.
   */
  status?: StatusAnnotation;

  /**
   * The family.
   */
  family?: string;

  /**
   * The revision.
   */
  revision?: int32;
}

/**
 * The Api reference.
 */
model ApiReference extends ResourceReference {
  /**
   * The display name of the api.
   */
  displayName?: string;

  /**
   * The description of the api.
   */
  description?: string;

  /**
   * The icon uri of the api.
   */
  iconUri?: string;

  /**
   * The swagger of the api.
   */
  swagger?: Record<unknown>;

  /**
   * The brand color of the api.
   */
  brandColor?: string;

  /**
   * The tier.
   */
  category?: ApiTier;

  /**
   * The integration service environment reference.
   */
  integrationServiceEnvironment?: ResourceReference;
}

/**
 * The swagger schema.
 */
model SwaggerSchema {
  /**
   * The reference.
   */
  ref?: string;

  /**
   * The type
   */
  type?: SwaggerSchemaType;

  /**
   * The title.
   */
  title?: string;

  /**
   * The items schema.
   */
  items?: SwaggerSchema;

  /**
   * The object properties
   */
  properties?: Record<SwaggerSchema>;

  /**
   * The additional properties.
   */
  additionalProperties?: Record<unknown>;

  /**
   * The object required properties.
   */
  required?: string[];

  /**
   * The maximum number of allowed properties.
   */
  maxProperties?: int32;

  /**
   * The minimum number of allowed properties.
   */
  minProperties?: int32;

  /**
   * The schemas which must pass validation when this schema is used.
   */
  allOf?: SwaggerSchema[];

  /**
   * The discriminator.
   */
  discriminator?: string;

  /**
   * Indicates whether this property must be present in the a request.
   */
  readOnly?: boolean;

  /**
   * The xml representation format for a property.
   */
  xml?: SwaggerXml;

  /**
   * The external documentation.
   */
  externalDocs?: SwaggerExternalDocumentation;

  /**
   * The example value.
   */
  example?: Record<unknown>;

  /**
   * Indicates the notification url extension. If this is set, the property's value should be a callback url for a webhook.
   */
  notificationUrlExtension?: boolean;

  /**
   * The dynamic schema configuration.
   */
  dynamicSchemaOld?: SwaggerCustomDynamicSchema;

  /**
   * The dynamic schema configuration.
   */
  dynamicSchemaNew?: SwaggerCustomDynamicProperties;

  /**
   * The dynamic list.
   */
  dynamicListNew?: SwaggerCustomDynamicList;

  /**
   * The dynamic values tree configuration.
   */
  dynamicTree?: SwaggerCustomDynamicTree;
}

/**
 * The Swagger XML.
 */
model SwaggerXml {
  /**
   * The xml element or attribute name.
   */
  name?: string;

  /**
   * The xml namespace.
   */
  `namespace`?: string;

  /**
   * The name prefix.
   */
  prefix?: string;

  /**
   * Indicates whether the property should be an attribute instead of an element.
   */
  attribute?: boolean;

  /**
   * Indicates whether the array elements are wrapped in a container element.
   */
  wrapped?: boolean;

  /**
   * The vendor extensions.
   */
  extensions?: Record<Record<unknown>>;
}

/**
 * The swagger external documentation
 */
model SwaggerExternalDocumentation {
  /**
   * The document description.
   */
  description?: string;

  /**
   * The documentation Uri.
   */
  uri?: string;

  /**
   * The vendor extensions.
   */
  extensions?: Record<Record<unknown>>;
}

/**
 * The swagger custom dynamic schema.
 */
model SwaggerCustomDynamicSchema {
  /**
   * The operation id to fetch dynamic schema.
   */
  operationId?: string;

  /**
   * Json pointer to the dynamic schema on the response body.
   */
  valuePath?: string;

  /**
   * The operation parameters.
   */
  parameters?: Record<Record<unknown>>;
}

/**
 * The swagger custom dynamic properties.
 */
model SwaggerCustomDynamicProperties {
  /**
   * The operation id to fetch dynamic schema.
   */
  operationId?: string;

  /**
   * Json pointer to the dynamic schema on the response body.
   */
  valuePath?: string;

  /**
   * The operation parameters.
   */
  parameters?: Record<SwaggerCustomDynamicProperties>;
}

/**
 * The swagger custom dynamic list.
 */
model SwaggerCustomDynamicList {
  /**
   * The operation id to fetch dynamic schema.
   */
  operationId?: string;

  /**
   * The built in operation.
   */
  builtInOperation?: string;

  /**
   * The path to a response property (relative to the response object, not the response body) which contains an array of dynamic value items.
   */
  itemsPath?: string;

  /**
   * The path to a property which defines the value which should be used.
   */
  itemValuePath?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemTitlePath?: string;

  /**
   * The parameters.
   */
  parameters?: Record<SwaggerCustomDynamicProperties>;
}

/**
 * The swagger custom dynamic tree.
 */
model SwaggerCustomDynamicTree {
  /**
   * The tree settings
   */
  settings?: SwaggerCustomDynamicTreeSettings;

  /**
   * The tree on-open configuration
   */
  open?: SwaggerCustomDynamicTreeCommand;

  /**
   * The tree on-browse configuration
   */
  browse?: SwaggerCustomDynamicTreeCommand;
}

/**
 * The swagger custom dynamic tree settings.
 */
model SwaggerCustomDynamicTreeSettings {
  /**
   * Indicates whether parent nodes can be selected.
   */
  @projectedName("json", "CanSelectParentNodes")
  canSelectParentNodes?: boolean;

  /**
   * Indicates whether leaf nodes can be selected.
   */
  @projectedName("json", "CanSelectLeafNodes")
  canSelectLeafNodes?: boolean;
}

/**
 * The swagger tree command.
 */
model SwaggerCustomDynamicTreeCommand {
  /**
   * The path to an item property which defines the display name of the item.
   */
  operationId?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemsPath?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemValuePath?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemTitlePath?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemFullTitlePath?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  itemIsParent?: string;

  /**
   * The path to an item property which defines the display name of the item.
   */
  selectableFilter?: string;

  /**
   * Dictionary of <SwaggerCustomDynamicTreeParameter>
   */
  parameters?: Record<SwaggerCustomDynamicTreeParameter>;
}

/**
 * The swagger custom dynamic tree parameter.
 */
model SwaggerCustomDynamicTreeParameter {
  /**
   * Gets or sets a path to a property in the currently selected item to pass as a value to a parameter for the given operation.
   */
  selectedItemValuePath?: string;

  /**
   * The parameter value.
   */
  value?: Record<unknown>;

  /**
   * The parameter reference.
   */
  parameterReference?: string;

  /**
   * Indicates whether the parameter is required.
   */
  required?: boolean;
}

/**
 * The workflow filter.
 */
model WorkflowFilter {
  /**
   * The state of workflows.
   */
  state?: WorkflowState;
}

/**
 * The workflow trigger filter.
 */
model WorkflowTriggerFilter {
  /**
   * The state of workflow trigger.
   */
  state?: WorkflowState;
}

/**
 * The workflow trigger history filter.
 */
model WorkflowTriggerHistoryFilter {
  /**
   * The status of workflow trigger history.
   */
  status?: WorkflowStatus;
}

/**
 * The workflow run filter.
 */
model WorkflowRunFilter {
  /**
   * The status of workflow run.
   */
  status?: WorkflowStatus;
}

/**
 * The workflow run action filter.
 */
model WorkflowRunActionFilter {
  /**
   * The status of workflow run action.
   */
  status?: WorkflowStatus;
}

/**
 * The list of managed APIs.
 */
model ManagedApiListResult {
  /**
   * The managed APIs.
   */
  value?: ManagedApi[];

  /**
   * The URL to get the next set of results.
   */
  nextLink?: string;
}

/**
 * The managed api definition.
 */
model ManagedApi extends Resource {
  /**
   * The api resource properties.
   */
  properties?: ApiResourceProperties;
}

/**
 * The integration account schema filter for odata query.
 */
model IntegrationAccountSchemaFilter {
  /**
   * The schema type of integration account schema.
   */
  schemaType: SchemaType;
}

/**
 * The integration account map filter for odata query.
 */
model IntegrationAccountMapFilter {
  /**
   * The map type of integration account map.
   */
  mapType: MapType;
}

/**
 * The integration account partner filter for odata query.
 */
model IntegrationAccountPartnerFilter {
  /**
   * The partner type of integration account partner.
   */
  partnerType: PartnerType;
}

/**
 * The integration account agreement filter for odata query.
 */
model IntegrationAccountAgreementFilter {
  /**
   * The agreement type of integration account agreement.
   */
  agreementType: AgreementType;
}

/**
 * The integration account session filter.
 */
model IntegrationAccountSessionFilter {
  /**
   * The changed time of integration account sessions.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  changedTime: utcDateTime;
}
