import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ProviderHub;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MovingResources: "MovingResources",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TransientFailure: "TransientFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RolloutInProgress: "RolloutInProgress",
}

/**
 * The state.
 */
union SubscriptionTransitioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warned: "Warned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WarnedToRegistered: "WarnedToRegistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WarnedToSuspended: "WarnedToSuspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WarnedToDeleted: "WarnedToDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WarnedToUnregistered: "WarnedToUnregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SuspendedToRegistered: "SuspendedToRegistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SuspendedToWarned: "SuspendedToWarned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SuspendedToDeleted: "SuspendedToDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SuspendedToUnregistered: "SuspendedToUnregistered",
}

/**
 * The action.
 */
union SubscriptionNotificationOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotDefined: "NotDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeleteAllResources: "DeleteAllResources",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SoftDeleteAllResources: "SoftDeleteAllResources",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoOp: "NoOp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BillingCancellation: "BillingCancellation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UndoSoftDelete: "UndoSoftDelete",
}

/**
 * The authentication scheme.
 */
union AuthenticationScheme {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PoP: "PoP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Bearer: "Bearer",
}

/**
 * The signed request scope.
 */
union SignedRequestScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceUri: "ResourceUri",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Endpoint: "Endpoint",
}

/**
 * The status.
 */
union ServiceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inactive: "Inactive",
}

/**
 * The provider type.
 */
union ResourceProviderType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  External: "External",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hidden: "Hidden",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegistrationFree: "RegistrationFree",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LegacyRegistrationRequired: "LegacyRegistrationRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TenantOnly: "TenantOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AuthorizationFree: "AuthorizationFree",
}

/**
 * The required feature policy.
 */
union FeaturesPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Any: "Any",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
}

/**
 * The opt in headers.
 */
union OptInHeaderType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SignedUserToken: "SignedUserToken",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ClientGroupMembership: "ClientGroupMembership",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SignedAuxiliaryTokens: "SignedAuxiliaryTokens",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnboundedClientGroupMembership: "UnboundedClientGroupMembership",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrivateLinkId: "PrivateLinkId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrivateLinkResourceId: "PrivateLinkResourceId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagementGroupAncestorsEncoded: "ManagementGroupAncestorsEncoded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrivateLinkVnetTrafficTag: "PrivateLinkVnetTrafficTag",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceGroupLocation: "ResourceGroupLocation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ClientPrincipalNameEncoded: "ClientPrincipalNameEncoded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MSIResourceIdEncoded: "MSIResourceIdEncoded",
}

/**
 * The opt out headers.
 */
union OptOutHeaderType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemDataCreatedByLastModifiedBy: "SystemDataCreatedByLastModifiedBy",
}

/**
 * The readiness.
 */
union Readiness {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ClosingDown: "ClosingDown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprecated: "Deprecated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GA: "GA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InDevelopment: "InDevelopment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InternalOnly: "InternalOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrivatePreview: "PrivatePreview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PublicPreview: "PublicPreview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RemovedFromARM: "RemovedFromARM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Retired: "Retired",
}

/**
 * Type of server failure response message.
 */
union ServerFailureResponseMessageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OutageReporting: "OutageReporting",
}

/**
 * Expedited rollout intent.
 */
union ExpeditedRolloutIntent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hotfix: "Hotfix",
}

/**
 * The effect.
 */
union ResourceProviderCapabilitiesEffect {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disallow: "Disallow",
}

/**
 * The cross tenant token validation.
 */
union CrossTenantTokenValidation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnsureSecureValidation: "EnsureSecureValidation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PassthroughInsecureToken: "PassthroughInsecureToken",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union PreflightOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ContinueDeploymentOnFailure: "ContinueDeploymentOnFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DefaultValidationOnly: "DefaultValidationOnly",
}

/**
 * The endpoint type.
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canary: "Canary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Production: "Production",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TestInProduction: "TestInProduction",
}

/**
 * The notification type.
 */
union NotificationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubscriptionNotification: "SubscriptionNotification",
}

/**
 * Whether notifications should be skipped.
 */
union SkipNotifications {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unspecified: "Unspecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The additional options.
 */
union AdditionalOptionsAsyncOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPolling: "ProtectedAsyncOperationPolling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPollingAuditOnly: "ProtectedAsyncOperationPollingAuditOnly",
}

/**
 * Notification options.
 */
union NotificationOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EmitSpendingLimit: "EmitSpendingLimit",
}

/**
 * The endpoint type.
 */
union NotificationEndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Webhook: "Webhook",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Eventhub: "Eventhub",
}

/**
 * The action verb that will be blocked when the resource group is locked during move.
 */
union BlockActionVerb {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Read: "Read",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Write: "Write",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Action: "Action",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unrecognized: "Unrecognized",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ServiceClientOptionsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DisableAutomaticDecompression: "DisableAutomaticDecompression",
}

/**
 * Provider registration kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
 */
union ProviderRegistrationKind {
  string,

  /**
   * Resource Provider with all the resource types 'managed' by the ProviderHub service.
   */
  Managed: "Managed",

  /**
   * Resource Provider with a mix of 'managed' and 'direct' resource types.
   */
  Hybrid: "Hybrid",

  /**
   * Resource Provider with all the resource types 'managed' on by itself.
   */
  Direct: "Direct",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The routing type.
 */
union RoutingType {
  string,

  /**
   * The resource routing type is default.
   */
  Default: "Default",

  /**
   * The resource routing type is proxy only.
   */
  ProxyOnly: "ProxyOnly",

  /**
   * The resource routing type is host based.
   */
  HostBased: "HostBased",

  /**
   * The resource routing type is extension.
   */
  Extension: "Extension",

  /**
   * The resource routing type is tenant.
   */
  Tenant: "Tenant",

  /**
   * The resource routing type is fanout.
   */
  Fanout: "Fanout",

  /**
   * The resource routing type is location based.
   */
  LocationBased: "LocationBased",

  /**
   * The resource routing type is failover.
   */
  Failover: "Failover",

  /**
   * The resource routing type is cascade extension.
   */
  CascadeExtension: "CascadeExtension",

  /**
   * The resource routing type is child fanout.
   */
  ChildFanout: "ChildFanout",

  /**
   * The resource routing type is cascade authorized extension.
   */
  CascadeAuthorizedExtension: "CascadeAuthorizedExtension",

  /**
   * The resource routing type is bypass endpoint selection optimization.
   */
  BypassEndpointSelectionOptimization: "BypassEndpointSelectionOptimization",

  /**
   * The resource routing type is location mapping.
   */
  LocationMapping: "LocationMapping",

  /**
   * The resource routing type is service fanout.
   */
  ServiceFanout: "ServiceFanout",
}

/**
 * The additional options.
 */
union AdditionalOptionsResourceTypeRegistration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPolling: "ProtectedAsyncOperationPolling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPollingAuditOnly: "ProtectedAsyncOperationPollingAuditOnly",
}

/**
 * The regionality.
 */
union Regionality {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Global: "Global",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Regional: "Regional",
}

/**
 * Resource type endpoint kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
 */
union ResourceTypeEndpointKind {
  string,

  /**
   * Endpoint served by ProviderHub service
   */
  Managed: "Managed",

  /**
   * Endpoint served by the onboarded Resource Provider Service.
   */
  Direct: "Direct",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExtensionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceCreationValidate: "ResourceCreationValidate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceCreationBegin: "ResourceCreationBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceCreationCompleted: "ResourceCreationCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceReadValidate: "ResourceReadValidate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceReadBegin: "ResourceReadBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourcePatchValidate: "ResourcePatchValidate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourcePatchCompleted: "ResourcePatchCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceDeletionValidate: "ResourceDeletionValidate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceDeletionBegin: "ResourceDeletionBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceDeletionCompleted: "ResourceDeletionCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourcePostAction: "ResourcePostAction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubscriptionLifecycleNotification: "SubscriptionLifecycleNotification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourcePatchBegin: "ResourcePatchBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceMoveBegin: "ResourceMoveBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceMoveCompleted: "ResourceMoveCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BestMatchOperationBegin: "BestMatchOperationBegin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubscriptionLifecycleNotificationDeletion: "SubscriptionLifecycleNotificationDeletion",
}

/**
 * The endpoint type.
 */
union EndpointTypeResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canary: "Canary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Production: "Production",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TestInProduction: "TestInProduction",
}

/**
 * The data boundary.
 */
union DataBoundary {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotDefined: "NotDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Global: "Global",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EU: "EU",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  US: "US",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ExtensionOptionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DoNotMergeExistingReadOnlyAndSecretProperties: "DoNotMergeExistingReadOnlyAndSecretProperties",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IncludeInternalMetadata: "IncludeInternalMetadata",
}

/**
 * The intent.
 */
union Intent {
  string,

  /**
   * Default value.
   */
  NOT_SPECIFIED: "NOT_SPECIFIED",

  /**
   * Data is not sensitive and ok to access.
   */
  LOW_PRIVILEGE: "LOW_PRIVILEGE",

  /**
   * Used for RP's using a custom authorization check outside of ARM.
   */
  DEFERRED_ACCESS_CHECK: "DEFERRED_ACCESS_CHECK",

  /**
   * RP contract allows certain operations to be unauthorized action.
   */
  RP_CONTRACT: "RP_CONTRACT",
}

/**
 * The direction.
 */
union LoggingDirections {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Request: "Request",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Response: "Response",
}

/**
 * The detail level.
 */
union LoggingDetails {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Body: "Body",
}

/**
 * The throttling metric type
 */
union ThrottlingMetricType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NumberOfRequests: "NumberOfRequests",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NumberOfResources: "NumberOfResources",
}

/**
 * The type.
 */
union IdentityManagementTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Actor: "Actor",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DelegatedResourceIdentity: "DelegatedResourceIdentity",
}

/**
 * The subscription state.
 */
union SubscriptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotDefined: "NotDefined",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warned: "Warned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PastDue: "PastDue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
}

/**
 * The extended location type.
 */
union ExtendedLocationType {
  string,

  /**
   * The extended location type is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * The extended location type is custom location.
   */
  CustomLocation: "CustomLocation",

  /**
   * The extended location type is edge zone.
   */
  EdgeZone: "EdgeZone",

  /**
   * The extended location type is arc zone.
   */
  ArcZone: "ArcZone",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ResourceTypeExtendedLocationPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
}

/**
 * The resource deletion policy.
 */
union ResourceDeletionPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CascadeDeleteAll: "CascadeDeleteAll",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CascadeDeleteProxyOnlyChildren: "CascadeDeleteProxyOnlyChildren",
}

/**
 * The policy.
 */
union Policy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SynchronizeBeginExtension: "SynchronizeBeginExtension",
}

/**
 * The category.
 */
union ResourceTypeCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FreeForm: "FreeForm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PureProxy: "PureProxy",
}

/**
 * The resource validation.
 */
union ResourceValidation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReservedWords: "ReservedWords",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProfaneWords: "ProfaneWords",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union QuotaPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restricted: "Restricted",
}

/**
 * The capabilities.
 */
union TemplateDeploymentCapabilities {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preflight: "Preflight",
}

/**
 * The preflight options.
 */
union TemplateDeploymentPreflightOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationRequests: "ValidationRequests",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeploymentRequests: "DeploymentRequests",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TestOnly: "TestOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegisteredOnly: "RegisteredOnly",
}

/**
 * The preflight notifications.
 */
union TemplateDeploymentPreflightNotifications {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnregisteredSubscriptions: "UnregisteredSubscriptions",
}

/**
 * The policy execution type.
 */
union PolicyExecutionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExecutePolicies: "ExecutePolicies",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BypassPolicies: "BypassPolicies",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExpectPartialPutRequests: "ExpectPartialPutRequests",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AvailabilityZonePolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SingleZoned: "SingleZoned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiZoned: "MultiZoned",
}

/**
 * The linked operation.
 */
union LinkedOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CrossResourceGroupResourceMove: "CrossResourceGroupResourceMove",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CrossSubscriptionResourceMove: "CrossSubscriptionResourceMove",
}

/**
 * The linked action.
 */
union LinkedAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Blocked: "Blocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Validate: "Validate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LegacyOperation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Waiting: "Waiting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureAsyncOperationWaiting: "AzureAsyncOperationWaiting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResourceCacheWaiting: "ResourceCacheWaiting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Action: "Action",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Read: "Read",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EvaluateDeploymentOutput: "EvaluateDeploymentOutput",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeploymentCleanup: "DeploymentCleanup",
}

/**
 * Capacity policy.
 */
union CapacityPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Restricted: "Restricted",
}

/**
 * Filter option.
 */
union FilterOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnableSubscriptionFilterOnTenant: "EnableSubscriptionFilterOnTenant",
}

/**
 * Supported operations.
 */
union SupportedOperations {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Get: "Get",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Delete: "Delete",
}

/**
 * Common api versions merge mode.
 */
union CommonApiVersionsMergeMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Merge: "Merge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Overwrite: "Overwrite",
}

/**
 * The frontdoor request mode.
 */
union FrontdoorRequestMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UseManifest: "UseManifest",
}

/**
 * The resource sub type.
 */
union ResourceSubType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AsyncOperation: "AsyncOperation",
}

/**
 * Resource type registration kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
 */
union ResourceTypeRegistrationKind {
  string,

  /**
   * Resource type served by the ProviderHub service.
   */
  Managed: "Managed",

  /**
   * Resource type served by both the ProviderHub & the onboarded Resource Provider Services (i.e. The type has a mix of managed and direct endpoints).
   */
  Hybrid: "Hybrid",

  /**
   * Resource type served by the onboarded Resource Provider Service.
   */
  Direct: "Direct",
}

/**
 * The next traffic region.
 */
union TrafficRegionCategory {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canary: "Canary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LowTraffic: "LowTraffic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MediumTraffic: "MediumTraffic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HighTraffic: "HighTraffic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RestOfTheWorldGroupOne: "RestOfTheWorldGroupOne",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RestOfTheWorldGroupTwo: "RestOfTheWorldGroupTwo",
}

/**
 * The subscription reregistration result.
 */
union SubscriptionReregistrationResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotApplicable: "NotApplicable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConditionalUpdate: "ConditionalUpdate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ForcedUpdate: "ForcedUpdate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The additional options.
 */
union AdditionalOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPolling: "ProtectedAsyncOperationPolling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProtectedAsyncOperationPollingAuditOnly: "ProtectedAsyncOperationPollingAuditOnly",
}

/**
 * The resource deletion policy.
 */
union ManifestResourceDeletionPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cascade: "Cascade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Force: "Force",
}

/**
 * The notification mode.
 */
union NotificationMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EventHub: "EventHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WebHook: "WebHook",
}

/**
 * The message scope.
 */
union MessageScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RegisteredSubscriptions: "RegisteredSubscriptions",
}

/**
 * The scale type.
 */
union SkuScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automatic: "Automatic",
}

/**
 * The ownership role the application has on the resource types. The service owner role gives the application owner permissions. The limited owner role gives elevated permissions but does not allow all the permissions of a service owner, such as read/write on internal metadata.
 */
union Role {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceOwner: "ServiceOwner",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LimitedOwner: "LimitedOwner",
}

/**
 * The environment type.
 */
union AvailableCheckInManifestEnvironment {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canary: "Canary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Prod: "Prod",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Mooncake: "Mooncake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Fairfax: "Fairfax",
}

/**
 * The service feature flag.
 */
union ServiceFeatureFlagAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DoNotCreate: "DoNotCreate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Create: "Create",
}

/**
 * The resource access policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceAccessPolicy {
  NotSpecified,
  AcisReadAllowed,
  AcisActionAllowed,
}

/**
 * The marketplace type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum MarketplaceType {
  NotSpecified,
  AddOn,
  Bypass,
  Store,
}

/**
 * The origin.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperationOrigins {
  NotSpecified,
  User,
  System,
}

/**
 * The action type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperationActionType {
  NotSpecified,
  Internal,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomRolloutProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The specification.
   */
  specification: CustomRolloutPropertiesSpecification;

  /**
   * The status.
   */
  status?: CustomRolloutPropertiesStatus;
}

/**
 * The specification.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomRolloutPropertiesSpecification extends CustomRolloutSpecification {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomRolloutSpecification {
  /**
   * The auto provisioning configuration.
   */
  autoProvisionConfig?: CustomRolloutSpecificationAutoProvisionConfig;

  /**
   * The canary region configuration.
   */
  canary?: CustomRolloutSpecificationCanary;

  /**
   * The list of ARM regions scoped for the release.
   */
  releaseScopes?: string[];

  /**
   * Whether refreshing subscription registration is enabled or disabled.
   */
  refreshSubscriptionRegistration?: boolean;

  /**
   * Whether release scope validation should be skipped.
   */
  skipReleaseScopeValidation?: boolean;

  /**
   * The provider registration.
   */
  providerRegistration?: CustomRolloutSpecificationProviderRegistration;

  /**
   * The resource type registrations.
   */
  resourceTypeRegistrations?: ResourceTypeRegistration[];
}

/**
 * The auto provisioning configuration.
 */
model CustomRolloutSpecificationAutoProvisionConfig {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  storage?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceGraph?: boolean;
}

/**
 * The canary region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomRolloutSpecificationCanary extends TrafficRegions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TrafficRegions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  regions?: string[];
}

/**
 * The provider registration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomRolloutSpecificationProviderRegistration
  extends ProviderRegistration {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProviderRegistrationProperties
  extends ResourceProviderManifestProperties {
  /**
   * The provider hub metadata.
   */
  providerHubMetadata?: ProviderRegistrationPropertiesProviderHubMetadata;

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The subscription lifecycle notification specifications.
   */
  subscriptionLifecycleNotificationSpecifications?: ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications;

  /**
   * The private resource provider configuration.
   */
  privateResourceProviderConfiguration?: ProviderRegistrationPropertiesPrivateResourceProviderConfiguration;

  /**
   * The token auth configuration.
   */
  tokenAuthConfiguration?: TokenAuthConfiguration;
}

/**
 * The provider hub metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProviderRegistrationPropertiesProviderHubMetadata
  extends ProviderHubMetadata {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProviderHubMetadata {
  /**
   * The provider authorizations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  providerAuthorizations?: ResourceProviderAuthorization[];

  /**
   * The provider authentication.
   */
  providerAuthentication?: ProviderHubMetadataProviderAuthentication;

  /**
   * The third party provider authorization.
   */
  thirdPartyProviderAuthorization?: ProviderHubMetadataThirdPartyProviderAuthorization;

  /**
   * The direct RP role definition id.
   */
  directRpRoleDefinitionId?: string;

  /**
   * The regional async operation resource type name.
   */
  regionalAsyncOperationResourceTypeName?: string;

  /**
   * The global async operation resource type name.
   */
  globalAsyncOperationResourceTypeName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderAuthorization {
  /**
   * The application id.
   */
  applicationId?: string;

  /**
   * The role definition id.
   */
  roleDefinitionId?: string;

  /**
   * The managed by role definition id.
   */
  managedByRoleDefinitionId?: string;

  /**
   * Managed by authorization.
   */
  managedByAuthorization?: ResourceProviderAuthorizationManagedByAuthorization;

  /**
   * The allowed third party extensions.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  allowedThirdPartyExtensions?: ThirdPartyExtension[];

  /**
   * The grouping tag.
   */
  groupingTag?: string;
}

/**
 * Managed by authorization.
 */
model ResourceProviderAuthorizationManagedByAuthorization {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["applicationId", "roleDefinitionId"])
  additionalAuthorizations?: AdditionalAuthorization[];

  /**
   * The managed by resource role definition ID for the application.
   */
  managedByResourceRoleDefinitionId?: string;

  /**
   * Indicates whether the managed by resource role definition ID should be inherited.
   */
  allowManagedByInheritance?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AdditionalAuthorization {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  applicationId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  roleDefinitionId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ThirdPartyExtension {
  /**
   * Name of third party extension.
   */
  name?: string;
}

/**
 * The provider authentication.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProviderHubMetadataProviderAuthentication
  extends ResourceProviderAuthentication {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderAuthentication {
  /**
   * The allowed audiences.
   */
  allowedAudiences: string[];
}

/**
 * The third party provider authorization.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProviderHubMetadataThirdPartyProviderAuthorization
  extends ThirdPartyProviderAuthorization {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ThirdPartyProviderAuthorization {
  /**
   * The authorizations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  authorizations?: LightHouseAuthorization[];

  /**
   * The managed by tenant id.
   */
  managedByTenantId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LightHouseAuthorization {
  /**
   * The principal id.
   */
  principalId: string;

  /**
   * The role definition id.
   */
  roleDefinitionId: string;
}

/**
 * The subscription lifecycle notification specifications.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProviderRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications
  extends SubscriptionLifecycleNotificationSpecifications {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriptionLifecycleNotificationSpecifications {
  /**
   * The subscription state override actions.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscriptionStateOverrideActions?: SubscriptionStateOverrideAction[];

  /**
   * The soft delete TTL.
   */
  softDeleteTTL?: duration;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriptionStateOverrideAction {
  /**
   * The state.
   */
  state: SubscriptionTransitioningState;

  /**
   * The action.
   */
  action: SubscriptionNotificationOperation;
}

/**
 * The private resource provider configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProviderRegistrationPropertiesPrivateResourceProviderConfiguration
  extends PrivateResourceProviderConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateResourceProviderConfiguration {
  /**
   * The allowed subscriptions.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  allowedSubscriptions?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TokenAuthConfiguration {
  /**
   * The authentication scheme.
   */
  authenticationScheme?: AuthenticationScheme;

  /**
   * The signed request scope.
   */
  signedRequestScope?: SignedRequestScope;

  /**
   * Whether certification authentication fallback is disabled.
   */
  disableCertificateAuthenticationFallback?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderManifestProperties {
  /**
   * The provider authentication.
   */
  providerAuthentication?: ResourceProviderManifestPropertiesProviderAuthentication;

  /**
   * The provider authorizations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  providerAuthorizations?: ResourceProviderAuthorization[];

  /**
   * The namespace.
   */
  `namespace`?: string;

  /**
   * The services.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  services?: ResourceProviderService[];

  /**
   * The service name.
   */
  serviceName?: string;

  /**
   * The provider version.
   */
  providerVersion?: string;

  /**
   * The provider type.
   */
  providerType?: ResourceProviderType;

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The features rule.
   */
  featuresRule?: ResourceProviderManifestPropertiesFeaturesRule;

  /**
   * The request header options.
   */
  requestHeaderOptions?: ResourceProviderManifestPropertiesRequestHeaderOptions;

  /**
   * The resource provider management.
   */
  management?: ResourceProviderManifestPropertiesManagement;

  /**
   * The capabilities.
   */
  @OpenAPI.extension("x-ms-identifiers", #["quotaId"])
  capabilities?: ResourceProviderCapabilities[];

  /**
   * The cross tenant token validation.
   */
  crossTenantTokenValidation?: CrossTenantTokenValidation;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The template deployment options.
   */
  templateDeploymentOptions?: ResourceProviderManifestPropertiesTemplateDeploymentOptions;

  /**
   * The global notification endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  globalNotificationEndpoints?: ResourceProviderEndpoint[];

  /**
   * The enable tenant linked notification.
   */
  enableTenantLinkedNotification?: boolean;

  /**
   * The notifications.
   */
  notifications?: Notification[];

  /**
   * The linked notification rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedNotificationRules?: FanoutLinkedNotificationRule[];

  /**
   * The resource provider authorization rules.
   */
  resourceProviderAuthorizationRules?: ResourceProviderAuthorizationRules;

  /**
   * The dsts configuration.
   */
  dstsConfiguration?: ResourceProviderManifestPropertiesDstsConfiguration;

  /**
   * Notification options.
   */
  notificationOptions?: NotificationOptions;

  /**
   * resource hydration accounts
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  resourceHydrationAccounts?: ResourceHydrationAccount[];

  /**
   * Notification settings.
   */
  notificationSettings?: ResourceProviderManifestPropertiesNotificationSettings;

  /**
   * Management groups global notification endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  managementGroupGlobalNotificationEndpoints?: ResourceProviderEndpoint[];

  /**
   * Optional features.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  optionalFeatures?: string[];

  /**
   * Resource group lock option during move.
   */
  resourceGroupLockOptionDuringMove?: ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove;

  /**
   * Response options.
   */
  responseOptions?: ResourceProviderManifestPropertiesResponseOptions;

  /**
   * Legacy namespace.
   */
  legacyNamespace?: string;

  /**
   * Legacy registrations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  legacyRegistrations?: string[];

  /**
   * Custom manifest version.
   */
  customManifestVersion?: string;
}

/**
 * The provider authentication.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesProviderAuthentication
  extends ResourceProviderAuthentication {}

/**
 * Resource provider service.
 */
model ResourceProviderService {
  /**
   * The service name.
   */
  serviceName?: string;

  /**
   * The status.
   */
  status?: ServiceStatus;
}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesFeaturesRule extends FeaturesRule {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FeaturesRule {
  /**
   * The required feature policy.
   */
  requiredFeaturesPolicy: FeaturesPolicy;
}

/**
 * The request header options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesRequestHeaderOptions
  extends RequestHeaderOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RequestHeaderOptions {
  /**
   * The opt in headers.
   */
  optInHeaders?: OptInHeaderType;

  /**
   * The opt out headers.
   */
  optOutHeaders?: OptOutHeaderType;
}

/**
 * The resource provider management.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesManagement
  extends ResourceProviderManagement {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderManagement {
  /**
   * The schema owners.
   */
  schemaOwners?: string[];

  /**
   * The manifest owners.
   */
  manifestOwners?: string[];

  /**
   * The authorization owners.
   */
  authorizationOwners?: string[];

  /**
   * The incident routing service.
   */
  incidentRoutingService?: string;

  /**
   * The incident routing team.
   */
  incidentRoutingTeam?: string;

  /**
   * The incident contact email.
   */
  incidentContactEmail?: string;

  /**
   * The service tree infos.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  serviceTreeInfos?: ServiceTreeInfo[];

  /**
   * The resource access policy.
   */
  resourceAccessPolicy?: ResourceAccessPolicy;

  /**
   * The resource access roles.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  resourceAccessRoles?: ResourceAccessRole[];

  /**
   * List of expedited rollout submitters.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  expeditedRolloutSubmitters?: string[];

  /**
   * Options for error response messages.
   */
  errorResponseMessageOptions?: ResourceProviderManagementErrorResponseMessageOptions;

  /**
   * Metadata for expedited rollout.
   */
  expeditedRolloutMetadata?: ResourceProviderManagementExpeditedRolloutMetadata;

  /**
   * List of manifest owners for canary.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  canaryManifestOwners?: string[];

  /**
   * The profit center code for the subscription.
   */
  pcCode?: string;

  /**
   * The profit center program id for the subscription.
   */
  profitCenterProgramId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ServiceTreeInfo {
  /**
   * The service id.
   */
  serviceId?: string;

  /**
   * The component id.
   */
  componentId?: string;

  /**
   * The readiness.
   */
  readiness?: Readiness;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceAccessRole {
  /**
   * The allowed group claims.
   */
  allowedGroupClaims?: string[];

  /**
   * The actions.
   */
  actions?: string[];
}

/**
 * Options for error response messages.
 */
model ResourceProviderManagementErrorResponseMessageOptions {
  /**
   * Type of server failure response message.
   */
  serverFailureResponseMessageType?: ServerFailureResponseMessageType;
}

/**
 * Metadata for expedited rollout.
 */
model ResourceProviderManagementExpeditedRolloutMetadata {
  /**
   * Expedited rollout enabled?
   */
  enabled?: boolean;

  /**
   * Expedited rollout intent.
   */
  expeditedRolloutIntent?: ExpeditedRolloutIntent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderCapabilities {
  /**
   * The quota id.
   */
  quotaId: string;

  /**
   * The effect.
   */
  effect: ResourceProviderCapabilitiesEffect;

  /**
   * The required features.
   */
  requiredFeatures?: string[];
}

/**
 * The template deployment options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesTemplateDeploymentOptions
  extends TemplateDeploymentOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TemplateDeploymentOptions {
  /**
   * Whether preflight is supported.
   */
  preflightSupported?: boolean;

  /**
   * The preflight options.
   */
  preflightOptions?: PreflightOption[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderEndpoint {
  /**
   * Whether the endpoint is enabled.
   */
  enabled?: boolean;

  /**
   * The api versions.
   */
  apiVersions?: string[];

  /**
   * The endpoint uri.
   */
  endpointUri?: string;

  /**
   * The locations.
   */
  locations?: string[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The feature rules.
   */
  featuresRule?: ResourceProviderEndpointFeaturesRule;

  /**
   * The timeout.
   */
  timeout?: duration;

  /**
   * The endpoint type.
   */
  endpointType?: EndpointType;

  /**
   * The sku link.
   */
  skuLink?: string;
}

/**
 * The feature rules.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderEndpointFeaturesRule extends FeaturesRule {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Notification {
  /**
   * The notification type.
   */
  notificationType?: NotificationType;

  /**
   * Whether notifications should be skipped.
   */
  skipNotifications?: SkipNotifications;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FanoutLinkedNotificationRule {
  /**
   * The token auth configuration.
   */
  tokenAuthConfiguration?: TokenAuthConfiguration;

  /**
   * The actions.
   */
  actions?: string[];

  /**
   * The endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: ResourceProviderEndpoint[];

  /**
   * The dsts configuration.
   */
  dstsConfiguration?: FanoutLinkedNotificationRuleDstsConfiguration;
}

/**
 * The dsts configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FanoutLinkedNotificationRuleDstsConfiguration extends DstsConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DstsConfiguration {
  /**
   * The service name.
   */
  serviceName: string;

  /**
   * This is a URI property.
   */
  serviceDnsName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderAuthorizationRules {
  /**
   * The async operation polling rules.
   */
  asyncOperationPollingRules?: AsyncOperationPollingRules;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AsyncOperationPollingRules {
  /**
   * The authorization actions.
   */
  authorizationActions?: string[];

  /**
   * The additional options.
   */
  additionalOptions?: AdditionalOptionsAsyncOperation;
}

/**
 * The dsts configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestPropertiesDstsConfiguration
  extends DstsConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceHydrationAccount {
  /**
   * The max child resource consistency job limit.
   */
  maxChildResourceConsistencyJobLimit?: int64;

  /**
   * The encrypted key.
   */
  encryptedKey?: string;

  /**
   * The account name.
   */
  accountName?: string;

  /**
   * The subscription id.
   */
  subscriptionId?: string;
}

/**
 * Notification settings.
 */
model ResourceProviderManifestPropertiesNotificationSettings {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscriberSettings?: SubscriberSetting[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriberSetting {
  /**
   * The filter rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  filterRules?: FilterRule[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FilterRule {
  /**
   * The filter query.
   */
  filterQuery?: string;

  /**
   * The endpoint information.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpointInformation?: EndpointInformation[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model EndpointInformation {
  /**
   * The endpoint.
   */
  endpoint?: string;

  /**
   * The endpoint type.
   */
  endpointType?: NotificationEndpointType;

  /**
   * The schema version.
   */
  schemaVersion?: string;
}

/**
 * Resource group lock option during move.
 */
model ResourceProviderManifestPropertiesResourceGroupLockOptionDuringMove {
  /**
   * The action verb that will be blocked when the resource group is locked during move.
   */
  blockActionVerb?: BlockActionVerb;
}

/**
 * Response options.
 */
model ResourceProviderManifestPropertiesResponseOptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  serviceClientOptionsType?: ServiceClientOptionsType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeRegistrationProperties {
  /**
   * The resource routing type.
   */
  routingType?: RoutingType;

  /**
   * The additional options.
   */
  additionalOptions?: AdditionalOptionsResourceTypeRegistration;

  /**
   * The cross tenant token validation.
   */
  crossTenantTokenValidation?: CrossTenantTokenValidation;

  /**
   * The regionality.
   */
  regionality?: Regionality;

  /**
   * The extensions.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: ResourceTypeEndpoint[];

  /**
   * The extension options.
   */
  extensionOptions?: ResourceTypeRegistrationPropertiesExtensionOptions;

  /**
   * The marketplace type.
   */
  marketplaceType?: MarketplaceType;

  /**
   * The swagger specifications.
   */
  @OpenAPI.extension("x-ms-identifiers", #["swaggerSpecFolderUri"])
  swaggerSpecifications?: SwaggerSpecification[];

  /**
   * The allowed unauthorized actions.
   */
  allowedUnauthorizedActions?: string[];

  /**
   * The allowed unauthorized actions extensions.
   */
  allowedUnauthorizedActionsExtensions?: AllowedUnauthorizedActionsExtension[];

  /**
   * The authorization action mappings
   */
  @OpenAPI.extension("x-ms-identifiers", #["original"])
  authorizationActionMappings?: AuthorizationActionMapping[];

  /**
   * The linked access checks.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedAccessChecks?: LinkedAccessCheck[];

  /**
   * The default api version.
   */
  defaultApiVersion?: string;

  /**
   * The logging rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  loggingRules?: LoggingRule[];

  /**
   * The throttling rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  throttlingRules?: ThrottlingRule[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The features rule.
   */
  featuresRule?: ResourceTypeRegistrationPropertiesFeaturesRule;

  /**
   * Whether async operation is enabled.
   */
  enableAsyncOperation?: boolean;

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Whether third party S2S is enabled.
   */
  enableThirdPartyS2S?: boolean;

  /**
   * The subscription lifecycle notification specifications.
   */
  subscriptionLifecycleNotificationSpecifications?: ResourceTypeRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications;

  /**
   * Whether it is pure proxy.
   */
  isPureProxy?: boolean;

  /**
   * The identity management.
   */
  identityManagement?: ResourceTypeRegistrationPropertiesIdentityManagement;

  /**
   * The check name availability specifications.
   */
  checkNameAvailabilitySpecifications?: ResourceTypeRegistrationPropertiesCheckNameAvailabilitySpecifications;

  /**
   * The disallowed action verbs.
   */
  disallowedActionVerbs?: string[];

  /**
   * The service tree infos.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  serviceTreeInfos?: ServiceTreeInfo[];

  /**
   * The request header options.
   */
  requestHeaderOptions?: ResourceTypeRegistrationPropertiesRequestHeaderOptions;

  /**
   * The subscription state rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscriptionStateRules?: SubscriptionStateRule[];

  /**
   * The template deployment options.
   */
  templateDeploymentOptions?: ResourceTypeRegistrationPropertiesTemplateDeploymentOptions;

  /**
   * The extended locations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  extendedLocations?: ExtendedLocationOptions[];

  /**
   * The resource move policy.
   */
  resourceMovePolicy?: ResourceTypeRegistrationPropertiesResourceMovePolicy;

  /**
   * The resource deletion policy.
   */
  resourceDeletionPolicy?: ResourceDeletionPolicy;

  /**
   * The resource concurrency control options.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  resourceConcurrencyControlOptions?: Record<ResourceConcurrencyControlOption>;

  /**
   * The resource graph configuration.
   */
  resourceGraphConfiguration?: ResourceTypeRegistrationPropertiesResourceGraphConfiguration;

  /**
   * The resource provider management.
   */
  management?: ResourceTypeRegistrationPropertiesManagement;

  /**
   * The open api configuration.
   */
  openApiConfiguration?: OpenApiConfiguration;

  /**
   * The on behalf of tokens.
   */
  onBehalfOfTokens?: ResourceTypeOnBehalfOfToken;

  /**
   * The category.
   */
  category?: ResourceTypeCategory;

  /**
   * The resource validation.
   */
  resourceValidation?: ResourceValidation;

  /**
   * The disallowed end user operations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  disallowedEndUserOperations?: string[];

  /**
   * The metadata.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<Record<unknown>>;

  /**
   * The sku link.
   */
  skuLink?: string;

  /**
   * The quota rule.
   */
  quotaRule?: QuotaRule;

  /**
   * The notifications.
   */
  notifications?: Notification[];

  /**
   * The linked notification rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedNotificationRules?: LinkedNotificationRule[];

  /**
   * The resource provider authorization rules.
   */
  resourceProviderAuthorizationRules?: ResourceProviderAuthorizationRules;

  /**
   * The token auth configuration.
   */
  tokenAuthConfiguration?: TokenAuthConfiguration;

  /**
   * The template deployment policy.
   */
  templateDeploymentPolicy?: ResourceTypeRegistrationPropertiesTemplateDeploymentPolicy;

  /**
   * The allow empty role assignments.
   */
  allowEmptyRoleAssignments?: boolean;

  /**
   * The policy execution type.
   */
  policyExecutionType?: PolicyExecutionType;

  /**
   * The availability zone rule.
   */
  availabilityZoneRule?: ResourceTypeRegistrationPropertiesAvailabilityZoneRule;

  /**
   * The dsts configuration.
   */
  dstsConfiguration?: ResourceTypeRegistrationPropertiesDstsConfiguration;

  /**
   * Async timeout rules
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  asyncTimeoutRules?: AsyncTimeoutRule[];

  /**
   * Common API versions for the resource type.
   */
  commonApiVersions?: string[];

  /**
   * The api profiles.
   */
  @OpenAPI.extension("x-ms-identifiers", #["profileVersion", "apiVersion"])
  apiProfiles?: ApiProfile[];

  /**
   * The linked operation rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #["linkedOperation", "linkedAction"])
  linkedOperationRules?: LinkedOperationRule[];

  /**
   * The legacy name.
   */
  legacyName?: string;

  /**
   * The legacy names.
   */
  legacyNames?: string[];

  /**
   * Allowed template deployment reference actions.
   */
  allowedTemplateDeploymentReferenceActions?: string[];

  /**
   * The legacy policy.
   */
  legacyPolicy?: ResourceTypeRegistrationPropertiesLegacyPolicy;

  /**
   * Manifest link.
   */
  manifestLink?: string;

  /**
   * Capacity rule.
   */
  capacityRule?: ResourceTypeRegistrationPropertiesCapacityRule;

  /**
   * Marketplace options.
   */
  marketplaceOptions?: ResourceTypeRegistrationPropertiesMarketplaceOptions;

  /**
   * The allowed resource names.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name", "getActionVerb"])
  allowedResourceNames?: AllowedResourceName[];

  /**
   * Resource cache options.
   */
  resourceCache?: ResourceTypeRegistrationPropertiesResourceCache;

  /**
   * Resource query management options.
   */
  resourceQueryManagement?: ResourceTypeRegistrationPropertiesResourceQueryManagement;

  /**
   * Whether tags are supported.
   */
  supportsTags?: boolean;

  /**
   * Resource management options.
   */
  resourceManagementOptions?: ResourceTypeRegistrationPropertiesResourceManagementOptions;

  /**
   * Grouping tag.
   */
  groupingTag?: string;

  /**
   * Add resource list target locations?
   */
  addResourceListTargetLocations?: boolean;

  /**
   * Resource type common attribute management.
   */
  resourceTypeCommonAttributeManagement?: ResourceTypeRegistrationPropertiesResourceTypeCommonAttributeManagement;

  /**
   * Routing rule.
   */
  routingRule?: ResourceTypeRegistrationPropertiesRoutingRule;

  /**
   * The frontdoor request mode.
   */
  frontdoorRequestMode?: FrontdoorRequestMode;

  /**
   * The resource sub type.
   */
  resourceSubType?: ResourceSubType;

  /**
   * The async operation resource type name.
   */
  asyncOperationResourceTypeName?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeEndpoint {
  /**
   * Resource type endpoint kind. This Metadata is also used by portal/tooling/etc to render different UX experiences for resources of the same type.
   */
  kind?: ResourceTypeEndpointKind = ResourceTypeEndpointKind.Managed;

  /**
   * Whether the endpoint is enabled.
   */
  enabled?: boolean;

  /**
   * The api versions.
   */
  apiVersions?: string[];

  /**
   * The locations.
   */
  locations?: string[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The features rule.
   */
  featuresRule?: ResourceTypeEndpointFeaturesRule;

  /**
   * The extensions.
   */
  @OpenAPI.extension("x-ms-identifiers", #["endpointUri"])
  extensions?: ResourceTypeExtension[];

  /**
   * The timeout.
   */
  timeout?: duration;

  /**
   * The endpoint type.
   */
  endpointType?: EndpointTypeResourceType;

  /**
   * The token auth configuration.
   */
  tokenAuthConfiguration?: TokenAuthConfiguration;

  /**
   * The sku link.
   */
  skuLink?: string;

  /**
   * The endpoint uri.
   */
  endpointUri?: string;

  /**
   * Api version.
   */
  apiVersion?: string;

  /**
   * List of zones.
   */
  zones?: string[];

  /**
   * The dsts configuration.
   */
  dstsConfiguration?: ResourceTypeEndpointDstsConfiguration;

  /**
   * The data boundary.
   */
  dataBoundary?: DataBoundary;
}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeEndpointFeaturesRule extends FeaturesRule {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeExtension {
  /**
   * The endpoint uri.
   */
  endpointUri?: string;

  /**
   * The extension categories.
   */
  extensionCategories?: ExtensionCategory[];

  /**
   * The timeout.
   */
  timeout?: duration;
}

/**
 * The dsts configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeEndpointDstsConfiguration extends DstsConfiguration {}

/**
 * The extension options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesExtensionOptions
  extends ResourceTypeExtensionOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeExtensionOptions {
  /**
   * Resource creation begin.
   */
  resourceCreationBegin?: ResourceTypeExtensionOptionsResourceCreationBegin;
}

/**
 * Resource creation begin.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeExtensionOptionsResourceCreationBegin
  extends ExtensionOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExtensionOptions {
  /**
   * The request.
   */
  request?: ExtensionOptionType[];

  /**
   * The response.
   */
  response?: ExtensionOptionType[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SwaggerSpecification {
  /**
   * The api versions.
   */
  apiVersions?: string[];

  /**
   * The swagger spec folder uri.
   */
  swaggerSpecFolderUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AllowedUnauthorizedActionsExtension {
  /**
   * The action.
   */
  action?: string;

  /**
   * The intent.
   */
  intent?: Intent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AuthorizationActionMapping {
  /**
   * The original action name.
   */
  original?: string;

  /**
   * The desired action name.
   */
  desired?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LinkedAccessCheck {
  /**
   * The action name.
   */
  actionName?: string;

  /**
   * The linked property.
   */
  linkedProperty?: string;

  /**
   * The linked action.
   */
  linkedAction?: string;

  /**
   * The linked action verb.
   */
  linkedActionVerb?: string;

  /**
   * The linked type.
   */
  linkedType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LoggingRule {
  /**
   * The action.
   */
  action: string;

  /**
   * The direction.
   */
  direction: LoggingDirections;

  /**
   * The detail level.
   */
  detailLevel: LoggingDetails;

  /**
   * The hidden property paths.
   */
  hiddenPropertyPaths?: LoggingRuleHiddenPropertyPaths;
}

/**
 * The hidden property paths.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LoggingRuleHiddenPropertyPaths extends LoggingHiddenPropertyPath {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LoggingHiddenPropertyPath {
  /**
   * The hidden paths on request.
   */
  hiddenPathsOnRequest?: string[];

  /**
   * The hidden paths on response.
   */
  hiddenPathsOnResponse?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ThrottlingRule {
  /**
   * The action.
   */
  action: string;

  /**
   * The metrics.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  metrics: ThrottlingMetric[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The application id.
   */
  applicationId?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ThrottlingMetric {
  /**
   * The throttling metric type
   */
  type: ThrottlingMetricType;

  /**
   * The limit.
   */
  limit: int64;

  /**
   * The interval.
   */
  interval?: duration;
}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesFeaturesRule extends FeaturesRule {}

/**
 * The subscription lifecycle notification specifications.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesSubscriptionLifecycleNotificationSpecifications
  extends SubscriptionLifecycleNotificationSpecifications {}

/**
 * The identity management.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesIdentityManagement
  extends IdentityManagementProperties {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IdentityManagementProperties {
  /**
   * The type.
   */
  type?: IdentityManagementTypes;

  /**
   * The application id.
   */
  applicationId?: string;

  /**
   * The application ids.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  applicationIds?: string[];

  /**
   * The delegation app ids.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  delegationAppIds?: string[];
}

/**
 * The check name availability specifications.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesCheckNameAvailabilitySpecifications
  extends CheckNameAvailabilitySpecifications {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CheckNameAvailabilitySpecifications {
  /**
   * Whether default validation is enabled.
   */
  enableDefaultValidation?: boolean;

  /**
   * The resource types with custom validation.
   */
  resourceTypesWithCustomValidation?: string[];
}

/**
 * The request header options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesRequestHeaderOptions
  extends RequestHeaderOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SubscriptionStateRule {
  /**
   * The subscription state.
   */
  state?: SubscriptionState;

  /**
   * The allowed actions.
   */
  allowedActions?: string[];
}

/**
 * The template deployment options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesTemplateDeploymentOptions
  extends TemplateDeploymentOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExtendedLocationOptions {
  /**
   * The type.
   */
  type?: ExtendedLocationType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  supportedPolicy?: ResourceTypeExtendedLocationPolicy;
}

/**
 * The resource move policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesResourceMovePolicy
  extends ResourceMovePolicy {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceMovePolicy {
  /**
   * Whether validation is required.
   */
  validationRequired?: boolean;

  /**
   * Whether cross resource group move is enabled.
   */
  crossResourceGroupMoveEnabled?: boolean;

  /**
   * Whether cross subscription move is enabled.
   */
  crossSubscriptionMoveEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceConcurrencyControlOption {
  /**
   * The policy.
   */
  policy?: Policy;
}

/**
 * The resource graph configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesResourceGraphConfiguration
  extends ResourceGraphConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceGraphConfiguration {
  /**
   * Whether it's enabled.
   */
  enabled?: boolean;

  /**
   * The api version.
   */
  apiVersion?: string;
}

/**
 * The resource provider management.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesManagement
  extends ResourceProviderManagement {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OpenApiConfiguration {
  /**
   * The open api validation.
   */
  validation?: OpenApiValidation;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OpenApiValidation {
  /**
   * Indicates whether a non compliance response is allowed for a LIST call
   */
  allowNoncompliantCollectionResponse?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeOnBehalfOfToken {
  /**
   * The action name.
   */
  actionName?: string;

  /**
   * This is a TimeSpan property.
   */
  lifeTime?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model QuotaRule {
  /**
   * The quota policy.
   */
  quotaPolicy?: QuotaPolicy;

  /**
   * The location rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  locationRules?: LocationQuotaRule[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LocationQuotaRule {
  /**
   * The policy.
   */
  policy?: QuotaPolicy;

  /**
   * The quota id.
   */
  quotaId?: string;

  /**
   * The location.
   */
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LinkedNotificationRule {
  /**
   * The actions.
   */
  actions?: string[];

  /**
   * The actions on failed operation.
   */
  actionsOnFailedOperation?: string[];

  /**
   * The fast path actions.
   */
  fastPathActions?: string[];

  /**
   * The fast path action on failed operation.
   */
  fastPathActionsOnFailedOperation?: string[];

  /**
   * This is a TimeSpan property.
   */
  linkedNotificationTimeout?: duration;
}

/**
 * The template deployment policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesTemplateDeploymentPolicy
  extends TemplateDeploymentPolicy {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TemplateDeploymentPolicy {
  /**
   * The capabilities.
   */
  capabilities: TemplateDeploymentCapabilities;

  /**
   * The preflight options.
   */
  preflightOptions: TemplateDeploymentPreflightOptions;

  /**
   * The preflight notifications.
   */
  preflightNotifications?: TemplateDeploymentPreflightNotifications;
}

/**
 * The availability zone rule.
 */
model ResourceTypeRegistrationPropertiesAvailabilityZoneRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  availabilityZonePolicy?: AvailabilityZonePolicy;
}

/**
 * The dsts configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRegistrationPropertiesDstsConfiguration
  extends DstsConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AsyncTimeoutRule {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  actionName?: string;

  /**
   * This is a TimeSpan property
   */
  timeout?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApiProfile {
  /**
   * Profile version.
   */
  profileVersion?: string;

  /**
   * Api version.
   */
  apiVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LinkedOperationRule {
  /**
   * The linked operation.
   */
  linkedOperation: LinkedOperation;

  /**
   * The linked action.
   */
  linkedAction: LinkedAction;

  /**
   * Depends on types.
   */
  dependsOnTypes?: string[];
}

/**
 * The legacy policy.
 */
model ResourceTypeRegistrationPropertiesLegacyPolicy {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  disallowedLegacyOperations?: LegacyOperation[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #[])
  disallowedConditions?: LegacyDisallowedCondition[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LegacyDisallowedCondition {
  /**
   * The disallowed legacy operations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  disallowedLegacyOperations?: LegacyOperation[];

  /**
   * Feature string.
   */
  feature?: string;
}

/**
 * Capacity rule.
 */
model ResourceTypeRegistrationPropertiesCapacityRule {
  /**
   * Capacity policy.
   */
  capacityPolicy?: CapacityPolicy;

  /**
   * Sku alias
   */
  skuAlias?: string;
}

/**
 * Marketplace options.
 */
model ResourceTypeRegistrationPropertiesMarketplaceOptions {
  /**
   * Add-on plan conversion allowed.
   */
  addOnPlanConversionAllowed?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AllowedResourceName {
  /**
   * Resource name.
   */
  name?: string;

  /**
   * Get action verb.
   */
  getActionVerb?: string;
}

/**
 * Resource cache options.
 */
model ResourceTypeRegistrationPropertiesResourceCache {
  /**
   * Enable resource cache.
   */
  enableResourceCache?: boolean;

  /**
   * Resource cache expiration timespan. This is a TimeSpan property.
   */
  resourceCacheExpirationTimespan?: string;
}

/**
 * Resource query management options.
 */
model ResourceTypeRegistrationPropertiesResourceQueryManagement {
  /**
   * Filter option.
   */
  filterOption?: FilterOption;
}

/**
 * Resource management options.
 */
model ResourceTypeRegistrationPropertiesResourceManagementOptions {
  /**
   * Batch provisioning support.
   */
  batchProvisioningSupport?: ResourceTypeRegistrationPropertiesResourceManagementOptionsBatchProvisioningSupport;

  /**
   * Delete dependencies.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["linkedType", "linkedProperty", "requiredFeatures"]
  )
  deleteDependencies?: DeleteDependency[];

  /**
   * Nested provisioning support.
   */
  nestedProvisioningSupport?: ResourceTypeRegistrationPropertiesResourceManagementOptionsNestedProvisioningSupport;
}

/**
 * Batch provisioning support.
 */
model ResourceTypeRegistrationPropertiesResourceManagementOptionsBatchProvisioningSupport {
  /**
   * Supported operations.
   */
  supportedOperations?: SupportedOperations;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DeleteDependency {
  /**
   * Required features.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  requiredFeatures?: string[];

  /**
   * Linked property.
   */
  linkedProperty?: string;

  /**
   * Linked type.
   */
  linkedType?: string;
}

/**
 * Nested provisioning support.
 */
model ResourceTypeRegistrationPropertiesResourceManagementOptionsNestedProvisioningSupport {
  /**
   * Minimum API version.
   */
  minimumApiVersion?: string;
}

/**
 * Resource type common attribute management.
 */
model ResourceTypeRegistrationPropertiesResourceTypeCommonAttributeManagement {
  /**
   * Common api versions merge mode.
   */
  commonApiVersionsMergeMode?: CommonApiVersionsMergeMode;
}

/**
 * Routing rule.
 */
model ResourceTypeRegistrationPropertiesRoutingRule {
  /**
   * Hosted resource type.
   */
  hostResourceType?: string;
}

/**
 * The status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomRolloutPropertiesStatus extends CustomRolloutStatus {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomRolloutStatus {
  /**
   * The completed regions.
   */
  completedRegions?: string[];

  /**
   * The failed or skipped regions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  failedOrSkippedRegions?: Record<ExtendedErrorInfo>;

  /**
   * The manifest checkin status.
   */
  manifestCheckinStatus?: CustomRolloutStatusManifestCheckinStatus;
}

/**
 * Error information.
 */
model ExtendedErrorInfo {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The target of the error.
   */
  target?: string;

  /**
   * The error message.
   */
  message?: string;

  /**
   * The error details.
   */
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  details?: ExtendedErrorInfo[];

  /**
   * The additional error information.
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  additionalInfo?: TypedErrorInfo[];
}

/**
 * Error information.
 */
model TypedErrorInfo {
  /**
   * The type of the error.
   */
  type: string;

  /**
   * The error information.
   */
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}

/**
 * The manifest checkin status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CustomRolloutStatusManifestCheckinStatus extends CheckinManifestInfo {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CheckinManifestInfo {
  /**
   * Whether the manifest is checked in.
   */
  isCheckedIn: boolean;

  /**
   * The status message.
   */
  statusMessage: string;

  /**
   * The pull request.
   */
  pullRequest?: string;

  /**
   * The commit id.
   */
  commitId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomRolloutArrayResponseWithContinuation
  is Azure.Core.Page<CustomRollout>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefaultRolloutProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The default rollout specification.
   */
  specification?: DefaultRolloutPropertiesSpecification;

  /**
   * The default rollout status.
   */
  status?: DefaultRolloutPropertiesStatus;
}

/**
 * The default rollout specification.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutPropertiesSpecification
  extends DefaultRolloutSpecification {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefaultRolloutSpecification {
  /**
   * The expedited rollout definition.
   */
  expeditedRollout?: DefaultRolloutSpecificationExpeditedRollout;

  /**
   * The canary traffic region configuration.
   */
  canary?: DefaultRolloutSpecificationCanary;

  /**
   * The low traffic region configuration.
   */
  lowTraffic?: DefaultRolloutSpecificationLowTraffic;

  /**
   * The medium traffic region configuration.
   */
  mediumTraffic?: DefaultRolloutSpecificationMediumTraffic;

  /**
   * The high traffic region configuration.
   */
  highTraffic?: DefaultRolloutSpecificationHighTraffic;

  /**
   * The rest of the world group one region configuration.
   */
  restOfTheWorldGroupOne?: DefaultRolloutSpecificationRestOfTheWorldGroupOne;

  /**
   * The rest of the world group two region configuration.
   */
  restOfTheWorldGroupTwo?: DefaultRolloutSpecificationRestOfTheWorldGroupTwo;

  /**
   * The provider registration.
   */
  providerRegistration?: DefaultRolloutSpecificationProviderRegistration;

  /**
   * The resource type registrations.
   */
  resourceTypeRegistrations?: ResourceTypeRegistration[];

  /**
   * The auto provisioning config.
   */
  autoProvisionConfig?: DefaultRolloutSpecificationAutoProvisionConfig;
}

/**
 * The expedited rollout definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationExpeditedRollout
  extends ExpeditedRolloutDefinition {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ExpeditedRolloutDefinition {
  /**
   * Indicates whether expedited rollout is enabled/disabled
   */
  enabled?: boolean;
}

/**
 * The canary traffic region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationCanary
  extends CanaryTrafficRegionRolloutConfiguration {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CanaryTrafficRegionRolloutConfiguration {
  /**
   * The skip regions.
   */
  skipRegions?: string[];

  /**
   * The regions.
   */
  regions?: string[];
}

/**
 * The low traffic region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationLowTraffic
  extends TrafficRegionRolloutConfiguration {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TrafficRegionRolloutConfiguration extends TrafficRegions {
  /**
   * The wait duration.
   */
  waitDuration?: duration;
}

/**
 * The medium traffic region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationMediumTraffic
  extends TrafficRegionRolloutConfiguration {}

/**
 * The high traffic region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationHighTraffic
  extends TrafficRegionRolloutConfiguration {}

/**
 * The rest of the world group one region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationRestOfTheWorldGroupOne
  extends TrafficRegionRolloutConfiguration {}

/**
 * The rest of the world group two region configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationRestOfTheWorldGroupTwo
  extends TrafficRegionRolloutConfiguration {}

/**
 * The provider registration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutSpecificationProviderRegistration
  extends ProviderRegistration {}

/**
 * The auto provisioning config.
 */
model DefaultRolloutSpecificationAutoProvisionConfig {
  /**
   * Whether auto provisioning for storage is enabled.
   */
  storage?: boolean;

  /**
   * Whether auto provisioning for resource graph is enabled.
   */
  resourceGraph?: boolean;
}

/**
 * The default rollout status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutPropertiesStatus extends DefaultRolloutStatus {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefaultRolloutStatus extends RolloutStatusBase {
  /**
   * The next traffic region.
   */
  nextTrafficRegion?: TrafficRegionCategory;

  /**
   * The next traffic region scheduled time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextTrafficRegionScheduledTime?: utcDateTime;

  /**
   * The subscription reregistration result.
   */
  subscriptionReregistrationResult?: SubscriptionReregistrationResult;

  /**
   * The manifest checkin status.
   */
  manifestCheckinStatus?: DefaultRolloutStatusManifestCheckinStatus;
}

/**
 * The manifest checkin status.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DefaultRolloutStatusManifestCheckinStatus extends CheckinManifestInfo {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model RolloutStatusBase {
  /**
   * The completed regions.
   */
  completedRegions?: string[];

  /**
   * The failed or skipped regions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  failedOrSkippedRegions?: Record<ExtendedErrorInfo>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefaultRolloutArrayResponseWithContinuation
  is Azure.Core.Page<DefaultRollout>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceProviderManifest {
  /**
   * The provider authentication.
   */
  providerAuthentication?: ResourceProviderManifestProviderAuthentication;

  /**
   * The provider authorizations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  providerAuthorizations?: ResourceProviderAuthorization[];

  /**
   * The namespace.
   */
  `namespace`?: string;

  /**
   * The services.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  services?: ResourceProviderService[];

  /**
   * The service name.
   */
  serviceName?: string;

  /**
   * The provider version.
   */
  providerVersion?: string;

  /**
   * The provider type.
   */
  providerType?: ResourceProviderType;

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The features rule.
   */
  featuresRule?: ResourceProviderManifestFeaturesRule;

  /**
   * The request header options.
   */
  requestHeaderOptions?: ResourceProviderManifestRequestHeaderOptions;

  /**
   * The resource types.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  resourceTypes?: ResourceType[];

  /**
   * The resource provider management.
   */
  management?: ResourceProviderManifestManagement;

  /**
   * The capabilities.
   */
  @OpenAPI.extension("x-ms-identifiers", #["quotaId"])
  capabilities?: ResourceProviderCapabilities[];

  /**
   * The cross tenant token validation.
   */
  crossTenantTokenValidation?: CrossTenantTokenValidation;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The global notification endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  globalNotificationEndpoints?: ResourceProviderEndpoint[];

  /**
   * The re-register subscription metadata.
   */
  reRegisterSubscriptionMetadata?: ResourceProviderManifestReRegisterSubscriptionMetadata;

  /**
   * Whether tenant linked notification is enabled.
   */
  enableTenantLinkedNotification?: boolean;

  /**
   * The notifications.
   */
  notifications?: Notification[];

  /**
   * The linked notification rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedNotificationRules?: FanoutLinkedNotificationRule[];

  /**
   * The resource provider authorization rules.
   */
  resourceProviderAuthorizationRules?: ResourceProviderAuthorizationRules;
}

/**
 * The provider authentication.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestProviderAuthentication
  extends ResourceProviderAuthentication {}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestFeaturesRule extends FeaturesRule {}

/**
 * The request header options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestRequestHeaderOptions
  extends RequestHeaderOptions {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceType {
  /**
   * The resource type name.
   */
  name?: string;

  /**
   * The resource routing type.
   */
  routingType?: RoutingType;

  /**
   * The additional options.
   */
  additionalOptions?: AdditionalOptions;

  /**
   * The cross tenant token validation.
   */
  crossTenantTokenValidation?: CrossTenantTokenValidation;

  /**
   * The resource validation.
   */
  resourceValidation?: ResourceValidation;

  /**
   * The allowed unauthorized actions.
   */
  allowedUnauthorizedActions?: string[];

  /**
   * The allowed unauthorized actions extensions.
   */
  allowedUnauthorizedActionsExtensions?: AllowedUnauthorizedActionsExtension[];

  /**
   * The authorization action mappings.
   */
  @OpenAPI.extension("x-ms-identifiers", #["original"])
  authorizationActionMappings?: AuthorizationActionMapping[];

  /**
   * The linked access checks.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedAccessChecks?: LinkedAccessCheck[];

  /**
   * The default api version.
   */
  defaultApiVersion?: string;

  /**
   * The logging rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  loggingRules?: LoggingRule[];

  /**
   * The throttling rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  throttlingRules?: ThrottlingRule[];

  /**
   * The endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints?: ResourceProviderEndpoint[];

  /**
   * The marketplace type.
   */
  marketplaceType?: MarketplaceType;

  /**
   * The identity management.
   */
  identityManagement?: ResourceTypeIdentityManagement;

  /**
   * The metadata.
   */
  metadata?: Record<unknown>;

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The features rule.
   */
  featuresRule?: ResourceTypeFeaturesRule;

  /**
   * The subscription state rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  subscriptionStateRules?: SubscriptionStateRule[];

  /**
   * The service tree infos.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  serviceTreeInfos?: ServiceTreeInfo[];

  /**
   * The request header options.
   */
  requestHeaderOptions?: ResourceTypeRequestHeaderOptions;

  /**
   * The sku link.
   */
  skuLink?: string;

  /**
   * The disallowed action verbs.
   */
  disallowedActionVerbs?: string[];

  /**
   * The template deployment policy.
   */
  templateDeploymentPolicy?: ResourceTypeTemplateDeploymentPolicy;

  /**
   * The extended locations.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  extendedLocations?: ExtendedLocationOptions[];

  /**
   * The linked operation rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedOperationRules?: LinkedOperationRule[];

  /**
   * The resource deletion policy.
   */
  resourceDeletionPolicy?: ManifestResourceDeletionPolicy;

  /**
   * The quota rule.
   */
  quotaRule?: QuotaRule;

  /**
   * The notifications.
   */
  notifications?: Notification[];

  /**
   * The linked notification rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  linkedNotificationRules?: LinkedNotificationRule[];

  /**
   * The resource provider authorization rules.
   */
  resourceProviderAuthorizationRules?: ResourceProviderAuthorizationRules;
}

/**
 * The identity management.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeIdentityManagement extends IdentityManagement {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model IdentityManagement {
  /**
   * The type.
   */
  type?: IdentityManagementTypes;
}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeFeaturesRule extends FeaturesRule {}

/**
 * The request header options.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeRequestHeaderOptions extends RequestHeaderOptions {}

/**
 * The template deployment policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeTemplateDeploymentPolicy extends TemplateDeploymentPolicy {}

/**
 * The resource provider management.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestManagement extends ResourceProviderManagement {}

/**
 * The re-register subscription metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceProviderManifestReRegisterSubscriptionMetadata
  extends ReRegisterSubscriptionMetadata {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ReRegisterSubscriptionMetadata {
  /**
   * Whether it's enabled or not.
   */
  enabled: boolean;

  /**
   * The concurrency limit.
   */
  concurrencyLimit?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotificationRegistrationProperties {
  /**
   * The notification mode.
   */
  notificationMode?: NotificationMode;

  /**
   * The message scope.
   */
  messageScope?: MessageScope;

  /**
   * The included events.
   */
  includedEvents?: string[];

  /**
   * The notification endpoints.
   */
  @OpenAPI.extension("x-ms-identifiers", #["notificationDestination"])
  notificationEndpoints?: NotificationEndpoint[];

  /**
   * The provisioned state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotificationEndpoint {
  /**
   * The notification destination.
   */
  notificationDestination?: string;

  /**
   * The locations.
   */
  locations?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NotificationRegistrationArrayResponseWithContinuation
  is Azure.Core.Page<NotificationRegistration>;

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

  /**
   * The origin.
   */
  origin?: OperationOrigins;

  /**
   * Display information of the operation.
   */
  display: OperationsDefinitionDisplay;

  /**
   * The action type.
   */
  actionType?: OperationActionType;

  /**
   * Anything
   */
  properties?: unknown;
}

/**
 * Display information of the operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OperationsDefinitionDisplay extends OperationsDisplayDefinition {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationsDisplayDefinition {
  /**
   * The provider.
   */
  provider: string;

  /**
   * The resource.
   */
  resource: string;

  /**
   * The operation.
   */
  operation: string;

  /**
   * The description.
   */
  description: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationsPutContentProperties extends OperationsContentProperties {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationsContentProperties {
  /**
   * Operations content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @Azure.ResourceManager.Private.conditionalClientFlatten
  contents?: LocalizedOperationDefinition[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LocalizedOperationDefinition {
  /**
   * Name of the operation.
   */
  name: string;

  /**
   * Indicates whether the operation applies to data-plane.
   */
  isDataAction?: boolean;

  /**
   * The origin.
   */
  origin?: OperationOrigins;

  /**
   * Display information of the operation.
   */
  display: LocalizedOperationDefinitionDisplay;

  /**
   * The action type.
   */
  actionType?: OperationActionType;
}

/**
 * Display information of the operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDefinitionDisplay
  extends LocalizedOperationDisplayDefinition {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LocalizedOperationDisplayDefinition {
  /**
   * Display information of the operation.
   */
  default: LocalizedOperationDisplayDefinitionDefault;

  /**
   * Display information of the operation for en locale.
   */
  en?: LocalizedOperationDisplayDefinitionEn;

  /**
   * Display information of the operation for cs locale.
   */
  cs?: LocalizedOperationDisplayDefinitionCs;

  /**
   * Display information of the operation for de locale.
   */
  de?: LocalizedOperationDisplayDefinitionDe;

  /**
   * Display information of the operation for es locale.
   */
  es?: LocalizedOperationDisplayDefinitionEs;

  /**
   * Display information of the operation for fr locale.
   */
  fr?: LocalizedOperationDisplayDefinitionFr;

  /**
   * Display information of the operation for hu locale.
   */
  hu?: LocalizedOperationDisplayDefinitionHu;

  /**
   * Display information of the operation for it locale.
   */
  it?: LocalizedOperationDisplayDefinitionIt;

  /**
   * Display information of the operation for ja locale.
   */
  ja?: LocalizedOperationDisplayDefinitionJa;

  /**
   * Display information of the operation for ko locale.
   */
  ko?: LocalizedOperationDisplayDefinitionKo;

  /**
   * Display information of the operation for nl locale.
   */
  nl?: LocalizedOperationDisplayDefinitionNl;

  /**
   * Display information of the operation for pl locale.
   */
  pl?: LocalizedOperationDisplayDefinitionPl;

  /**
   * Display information of the operation for pt-BR locale.
   */
  ptBR?: LocalizedOperationDisplayDefinitionPtBR;

  /**
   * Display information of the operation for pt-PT locale.
   */
  ptPT?: LocalizedOperationDisplayDefinitionPtPT;

  /**
   * Display information of the operation for ru locale.
   */
  ru?: LocalizedOperationDisplayDefinitionRu;

  /**
   * Display information of the operation for sv locale.
   */
  sv?: LocalizedOperationDisplayDefinitionSv;

  /**
   * Display information of the operation for zh-Hans locale.
   */
  zhHans?: LocalizedOperationDisplayDefinitionZhHans;

  /**
   * Display information of the operation for zh-Hant locale.
   */
  zhHant?: LocalizedOperationDisplayDefinitionZhHant;
}

/**
 * Display information of the operation.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionDefault
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for en locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionEn
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for cs locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionCs
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for de locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionDe
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for es locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionEs
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for fr locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionFr
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for hu locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionHu
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for it locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionIt
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for ja locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionJa
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for ko locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionKo
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for nl locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionNl
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for pl locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionPl
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for pt-BR locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionPtBR
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for pt-PT locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionPtPT
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for ru locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionRu
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for sv locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionSv
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for zh-Hans locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionZhHans
  extends OperationsDisplayDefinition {}

/**
 * Display information of the operation for zh-Hant locale.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocalizedOperationDisplayDefinitionZhHant
  extends OperationsDisplayDefinition {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProviderRegistrationArrayResponseWithContinuation
  is Azure.Core.Page<ProviderRegistration>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeRegistrationArrayResponseWithContinuation
  is Azure.Core.Page<ResourceTypeRegistration>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuResourceProperties extends ResourceTypeSku {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeSku {
  /**
   * The sku settings.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  skuSettings: SkuSetting[];

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuSetting {
  /**
   * The name.
   */
  name: string;

  /**
   * The tier.
   */
  tier?: string;

  /**
   * The size.
   */
  size?: string;

  /**
   * The family.
   */
  family?: string;

  /**
   * The kind.
   */
  kind?: string;

  /**
   * The locations.
   */
  locations?: string[];

  /**
   * The location info.
   */
  @OpenAPI.extension("x-ms-identifiers", #["location"])
  locationInfo?: SkuLocationInfo[];

  /**
   * The required quota ids.
   */
  requiredQuotaIds?: string[];

  /**
   * The required features.
   */
  requiredFeatures?: string[];

  /**
   * The capacity.
   */
  capacity?: SkuSettingCapacity;

  /**
   * The costs.
   */
  @OpenAPI.extension("x-ms-identifiers", #["meterId"])
  costs?: SkuCost[];

  /**
   * The capabilities.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  capabilities?: SkuCapability[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuLocationInfo {
  /**
   * The location.
   */
  location: string;

  /**
   * The zones.
   */
  zones?: string[];

  /**
   * The zone details.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  zoneDetails?: SkuZoneDetail[];

  /**
   * The extended locations.
   */
  extendedLocations?: string[];

  /**
   * The type.
   */
  type?: ExtendedLocationType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuZoneDetail {
  /**
   * The name.
   */
  name?: string[];

  /**
   * The capabilities.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  capabilities?: SkuCapability[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuCapability {
  /**
   * The name.
   */
  name: string;

  /**
   * The value.
   */
  value: string;
}

/**
 * The capacity.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model SkuSettingCapacity extends SkuCapacity {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuCapacity {
  /**
   * The minimum.
   */
  minimum: int32;

  /**
   * The maximum.
   */
  maximum?: int32;

  /**
   * The default.
   */
  default?: int32;

  /**
   * The scale type.
   */
  scaleType?: SkuScaleType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuCost {
  /**
   * The meter id.
   */
  meterId: string;

  /**
   * The quantity.
   */
  quantity?: int32;

  /**
   * The extended unit.
   */
  extendedUnit?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SkuResourceArrayResponseWithContinuation is Azure.Core.Page<SkuResource>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceManagementAction {
  /**
   * resource management action content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  @Azure.ResourceManager.Private.conditionalClientFlatten
  resources?: ResourceManagementEntity[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceManagementEntity {
  /**
   * The resource id.
   */
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The home tenant id.
   */
  homeTenantId?: string;

  /**
   * The location.
   */
  location?: string;

  /**
   * The operation status.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AuthorizedApplicationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  providerAuthorization?: ApplicationProviderAuthorization;

  /**
   * The authorizations that determine the level of data access permissions on the specified resource types.
   */
  @OpenAPI.extension("x-ms-identifiers", #["role"])
  dataAuthorizations?: ApplicationDataAuthorization[];

  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApplicationProviderAuthorization {
  /**
   * The role definition ID for the application.
   */
  roleDefinitionId?: string;

  /**
   * The managed by role definition ID for the application.
   */
  managedByRoleDefinitionId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApplicationDataAuthorization {
  /**
   * The ownership role the application has on the resource types. The service owner role gives the application owner permissions. The limited owner role gives elevated permissions but does not allow all the permissions of a service owner, such as read/write on internal metadata.
   */
  role: Role;

  /**
   * The resource types from the defined resource types in the provider namespace that the application can access. If no resource types are specified and the role is service owner, the default is * which is all resource types
   */
  resourceTypes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AuthorizedApplicationArrayResponseWithContinuation
  is Azure.Core.Page<AuthorizedApplication>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProviderMonitorSettingProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ProviderMonitorSettingArrayResponseWithContinuation
  is Azure.Core.Page<ProviderMonitorSetting>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FrontloadPayload {
  /**
   * Properties of the frontload payload.
   */
  properties: FrontloadPayloadProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model FrontloadPayloadProperties {
  /**
   * The operation type.
   */
  operationType: string;

  /**
   * The provider namespace.
   */
  providerNamespace: string;

  /**
   * The frontload location.
   */
  frontloadLocation: string;

  /**
   * The copy from location.
   */
  copyFromLocation: string;

  /**
   * The environment type.
   */
  environmentType: AvailableCheckInManifestEnvironment;

  /**
   * The service feature flag.
   */
  serviceFeatureFlag: ServiceFeatureFlagAction;

  /**
   * The resource types to include.
   */
  includeResourceTypes: string[];

  /**
   * The resource types to exclude.
   */
  excludeResourceTypes: string[];

  /**
   * The manifest level fields to override.
   */
  overrideManifestLevelFields: FrontloadPayloadPropertiesOverrideManifestLevelFields;

  /**
   * The endpoint level fields to override.
   */
  overrideEndpointLevelFields: FrontloadPayloadPropertiesOverrideEndpointLevelFields;

  /**
   * The fields to ignore.
   */
  ignoreFields: string[];
}

/**
 * The manifest level fields to override.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FrontloadPayloadPropertiesOverrideManifestLevelFields
  extends ManifestLevelPropertyBag {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ManifestLevelPropertyBag {
  /**
   * The resource hydration accounts.
   */
  @OpenAPI.extension("x-ms-identifiers", #["accountName"])
  resourceHydrationAccounts?: ResourceHydrationAccount[];
}

/**
 * The endpoint level fields to override.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model FrontloadPayloadPropertiesOverrideEndpointLevelFields
  extends ResourceTypeEndpointBase {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceTypeEndpointBase {
  /**
   * Whether it's enabled.
   */
  enabled: boolean;

  /**
   * The api versions.
   */
  apiVersions: string[];

  /**
   * The endpoint uri.
   */
  endpointUri: string;

  /**
   * The locations.
   */
  locations: string[];

  /**
   * The required features.
   */
  requiredFeatures: string[];

  /**
   * The features rule.
   */
  featuresRule: ResourceTypeEndpointBaseFeaturesRule;

  /**
   * This is a TimeSpan property.
   */
  timeout: duration;

  /**
   * The endpoint type.
   */
  endpointType: EndpointType;

  /**
   * The dsts configuration.
   */
  dstsConfiguration: ResourceTypeEndpointBaseDstsConfiguration;

  /**
   * The sku link.
   */
  skuLink: string;

  /**
   * The api version.
   */
  apiVersion: string;

  /**
   * The zones.
   */
  zones: string[];
}

/**
 * The features rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeEndpointBaseFeaturesRule extends FeaturesRule {}

/**
 * The dsts configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceTypeEndpointBaseDstsConfiguration extends DstsConfiguration {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationsContent extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Operations content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OperationsDefinition;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model GroupConnectivityInformation {
  /**
   * The group id.
   */
  groupId: string;

  /**
   * List of required members for the group id.
   */
  requiredMembers: string[];

  /**
   * List of required zone names for the group id.
   */
  requiredZoneNames: string[];

  /**
   * The redirect map id.
   */
  redirectMapId?: string;
}
