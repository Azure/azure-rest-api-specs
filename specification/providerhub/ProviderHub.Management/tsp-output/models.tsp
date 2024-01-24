import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ProviderHub;

interface Operations extends Azure.ResourceManager.Operations {}

enum ProvisioningState {
  NotSpecified,
  Accepted,
  Running,
  Creating,
  Created,
  Deleting,
  Deleted,
  Canceled,
  Failed,
  Succeeded,
  MovingResources,
  TransientFailure,
  RolloutInProgress,
}

enum SubscriptionTransitioningState {
  Registered,
  Unregistered,
  Warned,
  Suspended,
  Deleted,
  WarnedToRegistered,
  WarnedToSuspended,
  WarnedToDeleted,
  WarnedToUnregistered,
  SuspendedToRegistered,
  SuspendedToWarned,
  SuspendedToDeleted,
  SuspendedToUnregistered,
}

enum SubscriptionNotificationOperation {
  NotDefined,
  DeleteAllResources,
  SoftDeleteAllResources,
  NoOp,
  BillingCancellation,
  UndoSoftDelete,
}

enum ResourceProviderType {
  NotSpecified,
  Internal,
  External,
  Hidden,
  RegistrationFree,
  LegacyRegistrationRequired,
  TenantOnly,
  AuthorizationFree,
}

enum FeaturesPolicy {
  Any,
  All,
}

enum OptInHeaderType {
  NotSpecified,
  SignedUserToken,
  ClientGroupMembership,
  SignedAuxiliaryTokens,
  UnboundedClientGroupMembership,
}

enum ResourceProviderCapabilitiesEffect {
  NotSpecified,
  Allow,
  Disallow,
}

enum PreflightOption {
  None,
  ContinueDeploymentOnFailure,
  DefaultValidationOnly,
}

enum RoutingType {
  Default,
  ProxyOnly,
  HostBased,
  Extension,
  Tenant,
  Fanout,
  LocationBased,
  Failover,
  CascadeExtension,
}

enum Regionality {
  NotSpecified,
  Global,
  Regional,
}

enum ExtensionCategory {
  NotSpecified,
  ResourceCreationValidate,
  ResourceCreationBegin,
  ResourceCreationCompleted,
  ResourceReadValidate,
  ResourceReadBegin,
  ResourcePatchValidate,
  ResourcePatchCompleted,
  ResourceDeletionValidate,
  ResourceDeletionBegin,
  ResourceDeletionCompleted,
  ResourcePostAction,
  SubscriptionLifecycleNotification,
  ResourcePatchBegin,
  ResourceMoveBegin,
  ResourceMoveCompleted,
}

enum ExtensionOptionType {
  NotSpecified,
  DoNotMergeExistingReadOnlyAndSecretProperties,
  IncludeInternalMetadata,
}

enum LoggingDirections {
  None,
  Request,
  Response,
}

enum LoggingDetails {
  None,
  Body,
}

enum ThrottlingMetricType {
  NotSpecified,
  NumberOfRequests,
  NumberOfResources,
}

enum IdentityManagementTypes {
  NotSpecified,
  SystemAssigned,
  UserAssigned,
  Actor,
  DelegatedResourceIdentity,
}

enum SubscriptionState {
  NotDefined,
  Enabled,
  Warned,
  PastDue,
  Disabled,
  Deleted,
}

enum ResourceDeletionPolicy {
  NotSpecified,
  CascadeDeleteAll,
  CascadeDeleteProxyOnlyChildren,
}

enum TrafficRegionCategory {
  NotSpecified,
  Canary,
  LowTraffic,
  MediumTraffic,
  HighTraffic,
  None,
  RestOfTheWorldGroupOne,
  RestOfTheWorldGroupTwo,
}

enum SubscriptionReregistrationResult {
  NotApplicable,
  ConditionalUpdate,
  ForcedUpdate,
  Failed,
}

enum ResourceValidation {
  NotSpecified,
  ReservedWords,
  ProfaneWords,
}

enum TemplateDeploymentCapabilities {
  Default,
  Preflight,
}

enum TemplateDeploymentPreflightOptions {
  None,
  ValidationRequests,
  DeploymentRequests,
  TestOnly,
  RegisteredOnly,
}

enum LinkedOperation {
  None,
  CrossResourceGroupResourceMove,
  CrossSubscriptionResourceMove,
}

enum LinkedAction {
  NotSpecified,
  Blocked,
  Validate,
  Enabled,
}

enum ManifestResourceDeletionPolicy {
  NotSpecified,
  Cascade,
  Force,
}

enum NotificationMode {
  NotSpecified,
  EventHub,
  WebHook,
}

enum MessageScope {
  NotSpecified,
  RegisteredSubscriptions,
}

enum SkuScaleType {
  None,
  Manual,
  Automatic,
}

@fixed
enum ResourceAccessPolicy {
  NotSpecified,
  AcisReadAllowed,
  AcisActionAllowed,
}

@fixed
enum MarketplaceType {
  NotSpecified,
  AddOn,
  Bypass,
  Store,
}

@fixed
enum ExtendedLocationType {
  NotSpecified,
  EdgeZone,
  ArcZone,
}

@fixed
enum OperationOrigins {
  NotSpecified,
  User,
  System,
}

@fixed
enum OperationActionType {
  NotSpecified,
  Internal,
}

model CustomRolloutProperties {
  provisioningState?: ProvisioningState;
  specification: CustomRolloutSpecification;
  status?: CustomRolloutStatus;
}

model CustomRolloutSpecification {
  canary: TrafficRegions;
  providerRegistration?: ProviderRegistration;
  resourceTypeRegistrations?: ResourceTypeRegistration[];
}

model TrafficRegions {
  regions?: string[];
}

model ProviderRegistrationProperties
  extends ResourceProviderManifestProperties {
  providerHubMetadata?: ProviderHubMetadata;
  provisioningState?: ProvisioningState;
  subscriptionLifecycleNotificationSpecifications?: SubscriptionLifecycleNotificationSpecifications;
}

model ProviderHubMetadata {
  providerAuthorizations?: ResourceProviderAuthorization[];
  providerAuthentication?: ResourceProviderAuthentication;
  thirdPartyProviderAuthorization?: ThirdPartyProviderAuthorization;
}

model ResourceProviderAuthorization {
  applicationId?: string;
  roleDefinitionId?: string;
  managedByRoleDefinitionId?: string;
}

model ResourceProviderAuthentication {
  allowedAudiences: string[];
}

model ThirdPartyProviderAuthorization {
  authorizations?: LightHouseAuthorization[];
  managedByTenantId?: string;
}

model LightHouseAuthorization {
  principalId: string;
  roleDefinitionId: string;
}

model SubscriptionLifecycleNotificationSpecifications {
  subscriptionStateOverrideActions?: SubscriptionStateOverrideAction[];
  softDeleteTTL?: duration;
}

model SubscriptionStateOverrideAction {
  state: SubscriptionTransitioningState;
  action: SubscriptionNotificationOperation;
}

model ResourceProviderManifestProperties {
  providerAuthentication?: ResourceProviderAuthentication;
  providerAuthorizations?: ResourceProviderAuthorization[];
  `namespace`?: string;
  providerVersion?: string;
  providerType?: ResourceProviderType;
  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  requestHeaderOptions?: RequestHeaderOptions;
  management?: ResourceProviderManagement;
  capabilities?: ResourceProviderCapabilities[];

  /**
   * Anything
   */
  metadata?: unknown;

  templateDeploymentOptions?: TemplateDeploymentOptions;
}

model FeaturesRule {
  requiredFeaturesPolicy: FeaturesPolicy;
}

model RequestHeaderOptions {
  optInHeaders?: OptInHeaderType;
}

model ResourceProviderManagement {
  schemaOwners?: string[];
  manifestOwners?: string[];
  incidentRoutingService?: string;
  incidentRoutingTeam?: string;
  incidentContactEmail?: string;
  serviceTreeInfos?: ServiceTreeInfo[];
  resourceAccessPolicy?: ResourceAccessPolicy;
  resourceAccessRoles?: unknown[];
}

model ServiceTreeInfo {
  serviceId?: string;
  componentId?: string;
}

model ResourceProviderCapabilities {
  quotaId: string;
  effect: ResourceProviderCapabilitiesEffect;
  requiredFeatures?: string[];
}

model TemplateDeploymentOptions {
  preflightSupported?: boolean;
  preflightOptions?: PreflightOption[];
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
}

model ResourceTypeRegistrationProperties {
  routingType?: RoutingType;
  regionality?: Regionality;
  endpoints?: ResourceTypeEndpoint[];
  extensionOptions?: ResourceTypeExtensionOptions;
  marketplaceType?: MarketplaceType;
  swaggerSpecifications?: SwaggerSpecification[];
  allowedUnauthorizedActions?: string[];
  authorizationActionMappings?: AuthorizationActionMapping[];
  linkedAccessChecks?: LinkedAccessCheck[];
  defaultApiVersion?: string;
  loggingRules?: LoggingRule[];
  throttlingRules?: ThrottlingRule[];
  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  enableAsyncOperation?: boolean;
  provisioningState?: ProvisioningState;
  enableThirdPartyS2S?: boolean;
  subscriptionLifecycleNotificationSpecifications?: SubscriptionLifecycleNotificationSpecifications;
  isPureProxy?: boolean;
  identityManagement?: IdentityManagementProperties;
  checkNameAvailabilitySpecifications?: CheckNameAvailabilitySpecifications;
  disallowedActionVerbs?: string[];
  serviceTreeInfos?: ServiceTreeInfo[];
  requestHeaderOptions?: RequestHeaderOptions;
  subscriptionStateRules?: SubscriptionStateRule[];
  templateDeploymentOptions?: TemplateDeploymentOptions;
  extendedLocations?: ExtendedLocationOptions[];
  resourceMovePolicy?: ResourceMovePolicy;
  resourceDeletionPolicy?: ResourceDeletionPolicy;
}

model ResourceTypeEndpoint {
  enabled?: boolean;
  apiVersions?: string[];
  locations?: string[];
  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  extensions?: ResourceTypeExtension[];
  timeout?: duration;
}

model ResourceTypeExtension {
  endpointUri?: string;
  extensionCategories?: ExtensionCategory[];
  timeout?: duration;
}

model ResourceTypeExtensionOptions {
  resourceCreationBegin?: ExtensionOptions;
}

model ExtensionOptions {
  request?: ExtensionOptionType[];
  response?: ExtensionOptionType[];
}

model SwaggerSpecification {
  apiVersions?: string[];
  swaggerSpecFolderUri?: string;
}

model AuthorizationActionMapping {
  original?: string;
  desired?: string;
}

model LinkedAccessCheck {
  actionName?: string;
  linkedProperty?: string;
  linkedAction?: string;
  linkedActionVerb?: string;
  linkedType?: string;
}

model LoggingRule {
  action: string;
  direction: LoggingDirections;
  detailLevel: LoggingDetails;
  hiddenPropertyPaths?: LoggingHiddenPropertyPath;
}

model LoggingHiddenPropertyPath {
  hiddenPathsOnRequest?: string[];
  hiddenPathsOnResponse?: string[];
}

model ThrottlingRule {
  action: string;
  metrics: ThrottlingMetric[];
  requiredFeatures?: string[];
}

model ThrottlingMetric {
  type: ThrottlingMetricType;
  limit: int64;
  interval?: duration;
}

model IdentityManagementProperties {
  type?: IdentityManagementTypes;
  applicationId?: string;
}

model CheckNameAvailabilitySpecifications {
  enableDefaultValidation?: boolean;
  resourceTypesWithCustomValidation?: string[];
}

model SubscriptionStateRule {
  state?: SubscriptionState;
  allowedActions?: string[];
}

model ExtendedLocationOptions {
  type?: string;
  supportedPolicy?: string;
}

model ResourceMovePolicy {
  validationRequired?: boolean;
  crossResourceGroupMoveEnabled?: boolean;
  crossSubscriptionMoveEnabled?: boolean;
}

model CustomRolloutStatus {
  completedRegions?: string[];

  /**
   * Dictionary of <ExtendedErrorInfo>
   */
  failedOrSkippedRegions?: Record<ExtendedErrorInfo>;
}

model ExtendedErrorInfo {
  code?: string;
  target?: string;
  message?: string;
  details?: ExtendedErrorInfo[];
  additionalInfo?: TypedErrorInfo[];
}

model TypedErrorInfo {
  type: string;

  /**
   * Any object
   */
  @visibility("read")
  info?: Record<unknown>;
}

/**
 * Standard error object.
 */
model ErrorResponseError extends Error {}

/**
 * Standard error object.
 */
model Error {
  /**
   * Server-defined set of error codes.
   */
  @visibility("read")
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Target of the error.
   */
  @visibility("read")
  target?: string;

  /**
   * Array of details about specific errors that led to this reported error.
   */
  @visibility("read")
  details?: Error[];

  /**
   * Object containing more specific information than  the current object about the error.
   */
  @visibility("read")
  innerError?: ErrorInnerError;
}

/**
 * Object containing more specific information than  the current object about the error.
 */
model ErrorInnerError extends InnerError {}

/**
 * Inner error containing list of errors.
 */
model InnerError extends Record<Record<unknown>> {
  /**
   * Specific error code than was provided by the containing error.
   */
  @visibility("read")
  code?: string;

  /**
   * Object containing more specific information than the current object about the error.
   */
  @visibility("read")
  innerError?: Record<unknown>;
}

model DefaultRolloutProperties {
  provisioningState?: ProvisioningState;
  specification?: DefaultRolloutSpecification;
  status?: DefaultRolloutStatus;
}

model DefaultRolloutSpecification {
  canary?: CanaryTrafficRegionRolloutConfiguration;
  lowTraffic?: TrafficRegionRolloutConfiguration;
  mediumTraffic?: TrafficRegionRolloutConfiguration;
  highTraffic?: TrafficRegionRolloutConfiguration;
  restOfTheWorldGroupOne?: TrafficRegionRolloutConfiguration;
  restOfTheWorldGroupTwo?: TrafficRegionRolloutConfiguration;
  providerRegistration?: ProviderRegistration;
  resourceTypeRegistrations?: ResourceTypeRegistration[];
}

model CanaryTrafficRegionRolloutConfiguration {
  skipRegions?: string[];
  regions?: string[];
}

model TrafficRegionRolloutConfiguration extends TrafficRegions {
  waitDuration?: duration;
}

model DefaultRolloutStatus extends RolloutStatusBase {
  nextTrafficRegion?: TrafficRegionCategory;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextTrafficRegionScheduledTime?: utcDateTime;

  subscriptionReregistrationResult?: SubscriptionReregistrationResult;
}

model RolloutStatusBase {
  completedRegions?: string[];

  /**
   * Dictionary of <ExtendedErrorInfo>
   */
  failedOrSkippedRegions?: Record<ExtendedErrorInfo>;
}

model ResourceProviderManifest {
  providerAuthentication?: ResourceProviderAuthentication;
  providerAuthorizations?: ResourceProviderAuthorization[];
  `namespace`?: string;
  providerVersion?: string;
  providerType?: ResourceProviderType;
  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  requestHeaderOptions?: RequestHeaderOptions;
  resourceTypes?: ResourceType[];
  management?: ResourceProviderManagement;
  capabilities?: ResourceProviderCapabilities[];

  /**
   * Anything
   */
  metadata?: unknown;

  globalNotificationEndpoints?: ResourceProviderEndpoint[];
  reRegisterSubscriptionMetadata?: ReRegisterSubscriptionMetadata;
}

model ResourceType {
  name?: string;
  routingType?: RoutingType;
  resourceValidation?: ResourceValidation;
  allowedUnauthorizedActions?: string[];
  authorizationActionMappings?: AuthorizationActionMapping[];
  linkedAccessChecks?: LinkedAccessCheck[];
  defaultApiVersion?: string;
  loggingRules?: LoggingRule[];
  throttlingRules?: ThrottlingRule[];
  endpoints?: ResourceProviderEndpoint[];
  marketplaceType?: MarketplaceType;
  identityManagement?: IdentityManagement;

  /**
   * Anything
   */
  metadata?: unknown;

  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  subscriptionStateRules?: SubscriptionStateRule[];
  serviceTreeInfos?: ServiceTreeInfo[];
  requestHeaderOptions?: RequestHeaderOptions;
  skuLink?: string;
  disallowedActionVerbs?: string[];
  templateDeploymentPolicy?: TemplateDeploymentPolicy;
  extendedLocations?: ExtendedLocationOptions[];
  linkedOperationRules?: LinkedOperationRule[];
  resourceDeletionPolicy?: ManifestResourceDeletionPolicy;
}

model ResourceProviderEndpoint {
  enabled?: boolean;
  apiVersions?: string[];
  endpointUri?: string;
  locations?: string[];
  requiredFeatures?: string[];
  featuresRule?: FeaturesRule;
  timeout?: duration;
}

model IdentityManagement {
  type?: IdentityManagementTypes;
}

model TemplateDeploymentPolicy {
  capabilities: TemplateDeploymentCapabilities;
  preflightOptions: TemplateDeploymentPreflightOptions;
}

model LinkedOperationRule {
  linkedOperation: LinkedOperation;
  linkedAction: LinkedAction;
}

model ReRegisterSubscriptionMetadata {
  enabled: boolean;
  concurrencyLimit?: int32;
}

model CheckinManifestParams {
  /**
   * The environment supplied to the checkin manifest operation.
   */
  environment: string;

  /**
   * The baseline ARM manifest location supplied to the checkin manifest operation.
   */
  baselineArmManifestLocation: string;
}

model CheckinManifestInfo {
  isCheckedIn: boolean;
  statusMessage: string;
  pullRequest?: string;
  commitId?: string;
}

model NotificationRegistrationProperties {
  notificationMode?: NotificationMode;
  messageScope?: MessageScope;
  includedEvents?: string[];
  notificationEndpoints?: NotificationEndpoint[];
  provisioningState?: ProvisioningState;
}

model NotificationEndpoint {
  notificationDestination?: string;
  locations?: string[];
}

model ResourceTypeSku {
  skuSettings: SkuSetting[];
  provisioningState?: ProvisioningState;
}

model SkuSetting {
  name: string;
  tier?: string;
  size?: string;
  family?: string;
  kind?: string;
  locations?: string[];
  locationInfo?: SkuLocationInfo[];
  requiredQuotaIds?: string[];
  requiredFeatures?: string[];
  capacity?: SkuCapacity;
  costs?: SkuCost[];
  capabilities?: SkuCapability[];
}

model SkuLocationInfo {
  location: string;
  zones?: string[];
  zoneDetails?: SkuZoneDetail[];
  extendedLocations?: string[];
  type?: ExtendedLocationType;
}

model SkuZoneDetail {
  name?: string[];
  capabilities?: SkuCapability[];
}

model SkuCapability {
  name: string;
  value: string;
}

model SkuCapacity {
  minimum: int32;
  maximum?: int32;
  default?: int32;
  scaleType?: SkuScaleType;
}

model SkuCost {
  meterId: string;
  quantity?: int32;
  extendedUnit?: string;
}

model OperationsDisplayDefinition {
  provider: string;
  resource: string;
  operation: string;
  description: string;
}

/**
 * Properties of an Operation.
 */
model OperationsDefinition {
  /**
   * Name of the operation.
   */
  name: string;

  /**
   * Indicates whether the operation applies to data-plane.
   */
  isDataAction?: boolean;

  origin?: OperationOrigins;

  /**
   * Display information of the operation.
   */
  display: OperationsDefinitionDisplay;

  actionType?: OperationActionType;

  /**
   * Anything
   */
  properties?: unknown;
}

/**
 * Display information of the operation.
 */
model OperationsDefinitionDisplay extends OperationsDisplayDefinition {}

model OperationsContent extends Resource {
  /**
   * Operations content.
   */
  @extension("x-ms-client-flatten", true)
  properties?: OperationsDefinition;
}

model OperationsPutContent {
  contents: OperationsDefinition[];
}

model OperationsDefinitionArrayResponseWithContinuation {
  value?: OperationsDefinition[];

  /**
   * The URL to get to the next set of results, if there are any.
   */
  nextLink?: string;
}
