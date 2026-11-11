import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Microsoft.Common;

namespace Microsoft.Authorization;

/**
 * Assignment type of the role assignment schedule
 */
union AssignmentType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Activated
   */
  Activated: "Activated",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Assigned
   */
  Assigned: "Assigned",
}

/**
 * Membership type of the role assignment schedule
 */
union MemberType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Inherited
   */
  Inherited: "Inherited",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Direct
   */
  Direct: "Direct",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Group
   */
  Group: "Group",
}

/**
 * The status of the role assignment schedule.
 */
union Status {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Accepted
   */
  Accepted: "Accepted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingEvaluation
   */
  PendingEvaluation: "PendingEvaluation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Granted
   */
  Granted: "Granted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Denied
   */
  Denied: "Denied",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingProvisioning
   */
  PendingProvisioning: "PendingProvisioning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingRevocation
   */
  PendingRevocation: "PendingRevocation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Revoked
   */
  Revoked: "Revoked",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Canceled
   */
  Canceled: "Canceled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Failed
   */
  Failed: "Failed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingApprovalProvisioning
   */
  PendingApprovalProvisioning: "PendingApprovalProvisioning",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingApproval
   */
  PendingApproval: "PendingApproval",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * FailedAsResourceIsLocked
   */
  FailedAsResourceIsLocked: "FailedAsResourceIsLocked",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingAdminDecision
   */
  PendingAdminDecision: "PendingAdminDecision",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminApproved
   */
  AdminApproved: "AdminApproved",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminDenied
   */
  AdminDenied: "AdminDenied",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * TimedOut
   */
  TimedOut: "TimedOut",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ProvisioningStarted
   */
  ProvisioningStarted: "ProvisioningStarted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Invalid
   */
  Invalid: "Invalid",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingScheduleCreation
   */
  PendingScheduleCreation: "PendingScheduleCreation",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ScheduleCreated
   */
  ScheduleCreated: "ScheduleCreated",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * PendingExternalProvisioning
   */
  PendingExternalProvisioning: "PendingExternalProvisioning",
}

/**
 * The type of the role assignment schedule request. Eg: SelfActivate, AdminAssign etc
 */
union RequestType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminAssign
   */
  AdminAssign: "AdminAssign",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminRemove
   */
  AdminRemove: "AdminRemove",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminUpdate
   */
  AdminUpdate: "AdminUpdate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminExtend
   */
  AdminExtend: "AdminExtend",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AdminRenew
   */
  AdminRenew: "AdminRenew",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SelfActivate
   */
  SelfActivate: "SelfActivate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SelfDeactivate
   */
  SelfDeactivate: "SelfDeactivate",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SelfExtend
   */
  SelfExtend: "SelfExtend",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SelfRenew
   */
  SelfRenew: "SelfRenew",
}

/**
 * Type of the role assignment schedule expiration
 */
union Type {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AfterDuration
   */
  AfterDuration: "AfterDuration",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * AfterDateTime
   */
  AfterDateTime: "AfterDateTime",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NoExpiration
   */
  NoExpiration: "NoExpiration",
}

/**
 * The type of rule
 */
union RoleManagementPolicyRuleType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyApprovalRule
   */
  RoleManagementPolicyApprovalRule: "RoleManagementPolicyApprovalRule",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyAuthenticationContextRule
   */
  RoleManagementPolicyAuthenticationContextRule: "RoleManagementPolicyAuthenticationContextRule",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyEnablementRule
   */
  RoleManagementPolicyEnablementRule: "RoleManagementPolicyEnablementRule",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyExpirationRule
   */
  RoleManagementPolicyExpirationRule: "RoleManagementPolicyExpirationRule",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyNotificationRule
   */
  RoleManagementPolicyNotificationRule: "RoleManagementPolicyNotificationRule",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * RoleManagementPolicyPimOnlyModeRule
   */
  RoleManagementPolicyPimOnlyModeRule: "RoleManagementPolicyPimOnlyModeRule",
}

/**
 * The type of rule
 */
union ApprovalMode {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * SingleStage
   */
  SingleStage: "SingleStage",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Serial
   */
  Serial: "Serial",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Parallel
   */
  Parallel: "Parallel",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * NoApproval
   */
  NoApproval: "NoApproval",
}

/**
 * The type of user.
 */
union UsersOrServicePrincipalSetUserType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Group
   */
  Group: "Group",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ServicePrincipal
   */
  ServicePrincipal: "ServicePrincipal",
}

/**
 * The type of user.
 */
union UserType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Group
   */
  Group: "Group",
}

/**
 * The type of enablement rule
 */
union EnablementRules {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * MultiFactorAuthentication
   */
  MultiFactorAuthentication: "MultiFactorAuthentication",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Justification
   */
  Justification: "Justification",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Ticketing
   */
  Ticketing: "Ticketing",
}

/**
 * The type of notification.
 */
union NotificationDeliveryMechanism {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Email
   */
  Email: "Email",
}

/**
 * The notification level.
 */
union NotificationLevel {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * None
   */
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Critical
   */
  Critical: "Critical",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * All
   */
  All: "All",
}

/**
 * The recipient type.
 */
union RecipientType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Requestor
   */
  Requestor: "Requestor",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Approver
   */
  Approver: "Approver",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Admin
   */
  Admin: "Admin",
}

/**
 * Determines whether the setting is enabled, disabled or report only.
 */
union PIMOnlyMode {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Disabled
   */
  Disabled: "Disabled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Enabled
   */
  Enabled: "Enabled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ReportOnly
   */
  ReportOnly: "ReportOnly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ExcludedPrincipalTypes {
  string,

  /**
   * ServicePrincipalsAsTarget
   */
  ServicePrincipalsAsTarget: "ServicePrincipalsAsTarget",

  /**
   * ServicePrincipalsAsRequestor
   */
  ServicePrincipalsAsRequestor: "ServicePrincipalsAsRequestor",
}

/**
 * Eligible child resource
 */
model EligibleChildResource {
  /**
   * The resource scope Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Role assignment schedule properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleAssignmentScheduleProperties {
  /**
   * The role assignment schedule scope.
   */
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId?: string;

  /**
   * The principal ID.
   */
  principalId?: string;

  /**
   * The principal type of the assigned principal ID.
   */
  principalType?: PrincipalType;

  /**
   * The id of roleAssignmentScheduleRequest used to create this roleAssignmentSchedule
   */
  roleAssignmentScheduleRequestId?: string;

  /**
   * The id of roleEligibilitySchedule used to activated this roleAssignmentSchedule
   */
  linkedRoleEligibilityScheduleId?: string;

  /**
   * Assignment type of the role assignment schedule
   */
  assignmentType?: AssignmentType;

  /**
   * Membership type of the role assignment schedule
   */
  memberType?: MemberType;

  /**
   * The status of the role assignment schedule.
   */
  status?: Status;

  /**
   * Start DateTime when role assignment schedule
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End DateTime when role assignment schedule
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role assignment schedule was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * DateTime when role assignment schedule was modified
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;

  /**
   * Additional properties of principal, scope and role definition
   */
  expandedProperties?: ExpandedProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExpandedProperties {
  /**
   * Details of the resource scope
   */
  scope?: ExpandedPropertiesScope;

  /**
   * Details of role definition
   */
  roleDefinition?: ExpandedPropertiesRoleDefinition;

  /**
   * Details of the principal
   */
  principal?: ExpandedPropertiesPrincipal;
}

/**
 * Details of the resource scope
 */
model ExpandedPropertiesScope {
  /**
   * Scope id of the resource
   */
  id?: string;

  /**
   * Display name of the resource
   */
  displayName?: string;

  /**
   * Type of the resource
   */
  type?: string;
}

/**
 * Details of role definition
 */
model ExpandedPropertiesRoleDefinition {
  /**
   * Id of the role definition
   */
  id?: string;

  /**
   * Display name of the role definition
   */
  displayName?: string;

  /**
   * Type of the role definition
   */
  type?: string;
}

/**
 * Details of the principal
 */
model ExpandedPropertiesPrincipal {
  /**
   * Id of the principal
   */
  id?: string;

  /**
   * Display name of the principal
   */
  displayName?: string;

  /**
   * Email id of the principal
   */
  email?: string;

  /**
   * Type of the principal
   */
  type?: string;
}

/**
 * Role assignment schedule properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleAssignmentScheduleInstanceProperties {
  /**
   * The role assignment schedule scope.
   */
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId?: string;

  /**
   * The principal ID.
   */
  principalId?: string;

  /**
   * The principal type of the assigned principal ID.
   */
  principalType?: PrincipalType;

  /**
   * Id of the master role assignment schedule
   */
  roleAssignmentScheduleId?: string;

  /**
   * Role Assignment Id in external system
   */
  originRoleAssignmentId?: string;

  /**
   * The status of the role assignment schedule instance.
   */
  status?: Status;

  /**
   * The startDateTime of the role assignment schedule instance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The endDateTime of the role assignment schedule instance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * roleEligibilityScheduleId used to activate
   */
  linkedRoleEligibilityScheduleId?: string;

  /**
   * roleEligibilityScheduleInstanceId linked to this roleAssignmentScheduleInstance
   */
  linkedRoleEligibilityScheduleInstanceId?: string;

  /**
   * Assignment type of the role assignment schedule
   */
  assignmentType?: AssignmentType;

  /**
   * Membership type of the role assignment schedule
   */
  memberType?: MemberType;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role assignment schedule was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Additional properties of principal, scope and role definition
   */
  expandedProperties?: ExpandedProperties;
}

/**
 * Role assignment schedule request properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleAssignmentScheduleRequestProperties {
  /**
   * The role assignment schedule request scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId: string;

  /**
   * The principal ID.
   */
  principalId: string;

  /**
   * The principal type of the assigned principal ID.
   */
  @visibility(Lifecycle.Read)
  principalType?: PrincipalType;

  /**
   * The type of the role assignment schedule request. Eg: SelfActivate, AdminAssign etc
   */
  requestType: RequestType;

  /**
   * The status of the role assignment schedule request.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The approvalId of the role assignment schedule request.
   */
  @visibility(Lifecycle.Read)
  approvalId?: string;

  /**
   * The resultant role assignment schedule id or the role assignment schedule id being updated
   */
  targetRoleAssignmentScheduleId?: string;

  /**
   * The role assignment schedule instance id being updated
   */
  targetRoleAssignmentScheduleInstanceId?: string;

  /**
   * Schedule info of the role assignment schedule
   */
  scheduleInfo?: RoleAssignmentScheduleRequestPropertiesScheduleInfo;

  /**
   * The linked role eligibility schedule id - to activate an eligibility.
   */
  linkedRoleEligibilityScheduleId?: string;

  /**
   * Justification for the role assignment
   */
  justification?: string;

  /**
   * Ticket Info of the role assignment
   */
  ticketInfo?: RoleAssignmentScheduleRequestPropertiesTicketInfo;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role assignment schedule request was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Id of the user who created this request
   */
  @visibility(Lifecycle.Read)
  requestorId?: string;

  /**
   * Additional properties of principal, scope and role definition
   */
  @visibility(Lifecycle.Read)
  expandedProperties?: ExpandedProperties;
}

/**
 * Schedule info of the role assignment schedule
 */
model RoleAssignmentScheduleRequestPropertiesScheduleInfo {
  /**
   * Start DateTime of the role assignment schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * Expiration of the role assignment schedule
   */
  expiration?: RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration;
}

/**
 * Expiration of the role assignment schedule
 */
model RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration {
  /**
   * Type of the role assignment schedule expiration
   */
  type?: Type;

  /**
   * End DateTime of the role assignment schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Duration of the role assignment schedule in TimeSpan.
   */
  duration?: string;
}

/**
 * Ticket Info of the role assignment
 */
model RoleAssignmentScheduleRequestPropertiesTicketInfo {
  /**
   * Ticket number for the role assignment
   */
  ticketNumber?: string;

  /**
   * Ticket system name for the role assignment
   */
  ticketSystem?: string;
}

/**
 * Role eligibility schedule properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleEligibilityScheduleProperties {
  /**
   * The role eligibility schedule scope.
   */
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId?: string;

  /**
   * The principal ID.
   */
  principalId?: string;

  /**
   * The principal type of the assigned principal ID.
   */
  principalType?: PrincipalType;

  /**
   * The id of roleEligibilityScheduleRequest used to create this roleAssignmentSchedule
   */
  roleEligibilityScheduleRequestId?: string;

  /**
   * Membership type of the role eligibility schedule
   */
  memberType?: MemberType;

  /**
   * The status of the role eligibility schedule.
   */
  status?: Status;

  /**
   * Start DateTime when role eligibility schedule
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End DateTime when role eligibility schedule
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role eligibility schedule was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * DateTime when role eligibility schedule was modified
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedOn?: utcDateTime;

  /**
   * Additional properties of principal, scope and role definition
   */
  expandedProperties?: ExpandedProperties;
}

/**
 * Role eligibility schedule properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleEligibilityScheduleInstanceProperties {
  /**
   * The role eligibility schedule scope.
   */
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId?: string;

  /**
   * The principal ID.
   */
  principalId?: string;

  /**
   * The principal type of the assigned principal ID.
   */
  principalType?: PrincipalType;

  /**
   * Id of the master role eligibility schedule
   */
  roleEligibilityScheduleId?: string;

  /**
   * The status of the role eligibility schedule instance
   */
  status?: Status;

  /**
   * The startDateTime of the role eligibility schedule instance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The endDateTime of the role eligibility schedule instance
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Membership type of the role eligibility schedule
   */
  memberType?: MemberType;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role eligibility schedule was created
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Additional properties of principal, scope and role definition
   */
  expandedProperties?: ExpandedProperties;
}

/**
 * Role eligibility schedule request properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleEligibilityScheduleRequestProperties {
  /**
   * The role eligibility schedule request scope.
   */
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * The role definition ID.
   */
  roleDefinitionId: string;

  /**
   * The principal ID.
   */
  principalId: string;

  /**
   * The principal type of the assigned principal ID.
   */
  @visibility(Lifecycle.Read)
  principalType?: PrincipalType;

  /**
   * The type of the role assignment schedule request. Eg: SelfActivate, AdminAssign etc
   */
  requestType: RequestType;

  /**
   * The status of the role eligibility schedule request.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The approvalId of the role eligibility schedule request.
   */
  @visibility(Lifecycle.Read)
  approvalId?: string;

  /**
   * Schedule info of the role eligibility schedule
   */
  scheduleInfo?: RoleEligibilityScheduleRequestPropertiesScheduleInfo;

  /**
   * The resultant role eligibility schedule id or the role eligibility schedule id being updated
   */
  targetRoleEligibilityScheduleId?: string;

  /**
   * The role eligibility schedule instance id being updated
   */
  targetRoleEligibilityScheduleInstanceId?: string;

  /**
   * Justification for the role eligibility
   */
  justification?: string;

  /**
   * Ticket Info of the role eligibility
   */
  ticketInfo?: RoleEligibilityScheduleRequestPropertiesTicketInfo;

  @doc("The conditions on the role assignment. This limits the resources it can be assigned to. e.g.: @Resource[Microsoft.Storage/storageAccounts/blobServices/containers:ContainerName] StringEqualsIgnoreCase 'foo_storage_container'")
  condition?: string;

  /**
   * Version of the condition. Currently accepted value is '2.0'
   */
  conditionVersion?: string;

  /**
   * DateTime when role eligibility schedule request was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Id of the user who created this request
   */
  @visibility(Lifecycle.Read)
  requestorId?: string;

  /**
   * Additional properties of principal, scope and role definition
   */
  @visibility(Lifecycle.Read)
  expandedProperties?: ExpandedProperties;
}

/**
 * Schedule info of the role eligibility schedule
 */
model RoleEligibilityScheduleRequestPropertiesScheduleInfo {
  /**
   * Start DateTime of the role eligibility schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * Expiration of the role eligibility schedule
   */
  expiration?: RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration;
}

/**
 * Expiration of the role eligibility schedule
 */
model RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration {
  /**
   * Type of the role eligibility schedule expiration
   */
  type?: Type;

  /**
   * End DateTime of the role eligibility schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Duration of the role eligibility schedule in TimeSpan.
   */
  duration?: string;
}

/**
 * Ticket Info of the role eligibility
 */
model RoleEligibilityScheduleRequestPropertiesTicketInfo {
  /**
   * Ticket number for the role eligibility
   */
  ticketNumber?: string;

  /**
   * Ticket system name for the role eligibility
   */
  ticketSystem?: string;
}

/**
 * Role management policy properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleManagementPolicyProperties {
  /**
   * The role management policy scope.
   */
  scope?: string;

  /**
   * The role management policy display name.
   */
  displayName?: string;

  /**
   * The role management policy description.
   */
  description?: string;

  /**
   * The role management policy is default policy.
   */
  isOrganizationDefault?: boolean;

  /**
   * The name of the entity last modified it
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: Principal;

  /**
   * The last modified date time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * The rule applied to the policy.
   */
  rules?: RoleManagementPolicyRule[];

  /**
   * The readonly computed rule applied to the policy.
   */
  @visibility(Lifecycle.Read)
  effectiveRules?: RoleManagementPolicyRule[];

  /**
   * Additional properties of scope
   */
  @visibility(Lifecycle.Read)
  policyProperties?: PolicyProperties;
}

/**
 * The role management policy rule.
 */
@discriminator("ruleType")
model RoleManagementPolicyRule {
  /**
   * The id of the rule.
   */
  id?: string;

  /**
   * The type of rule
   */
  ruleType: RoleManagementPolicyRuleType;

  /**
   * The target of the current rule.
   */
  target?: RoleManagementPolicyRuleTarget;
}

/**
 * The role management policy rule target.
 */
model RoleManagementPolicyRuleTarget {
  /**
   * The caller of the setting.
   */
  caller?: string;

  /**
   * The type of operation.
   */
  operations?: string[];

  /**
   * The assignment level to which rule is applied.
   */
  level?: string;

  /**
   * The list of target objects.
   */
  targetObjects?: string[];

  /**
   * The list of inheritable settings.
   */
  inheritableSettings?: string[];

  /**
   * The list of enforced settings.
   */
  enforcedSettings?: string[];
}

/**
 * Expanded info of resource scope
 */
model PolicyProperties {
  /**
   * Details of the resource scope
   */
  @visibility(Lifecycle.Read)
  scope?: PolicyPropertiesScope;
}

/**
 * Details of the resource scope
 */
model PolicyPropertiesScope {
  /**
   * Scope id of the resource
   */
  id?: string;

  /**
   * Display name of the resource
   */
  displayName?: string;

  /**
   * Type of the resource
   */
  type?: string;
}

/**
 * Role management policy assignment properties with scope.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RoleManagementPolicyAssignmentProperties {
  /**
   * The role management policy scope.
   */
  scope?: string;

  /**
   * The role definition of management policy assignment.
   */
  roleDefinitionId?: string;

  /**
   * The policy id role management policy assignment.
   */
  policyId?: string;

  /**
   * The readonly computed rule applied to the policy.
   */
  @visibility(Lifecycle.Read)
  effectiveRules?: RoleManagementPolicyRule[];

  /**
   * Additional properties of scope, role definition and policy
   */
  @visibility(Lifecycle.Read)
  policyAssignmentProperties?: PolicyAssignmentProperties;
}

/**
 * Expanded info of resource scope, role definition and policy
 */
model PolicyAssignmentProperties {
  /**
   * Details of the resource scope
   */
  scope?: PolicyAssignmentPropertiesScope;

  /**
   * Details of role definition
   */
  roleDefinition?: PolicyAssignmentPropertiesRoleDefinition;

  /**
   * Details of the policy
   */
  policy?: PolicyAssignmentPropertiesPolicy;
}

/**
 * Details of the resource scope
 */
model PolicyAssignmentPropertiesScope {
  /**
   * Scope id of the resource
   */
  id?: string;

  /**
   * Display name of the resource
   */
  displayName?: string;

  /**
   * Type of the resource
   */
  type?: string;
}

/**
 * Details of role definition
 */
model PolicyAssignmentPropertiesRoleDefinition {
  /**
   * Id of the role definition
   */
  id?: string;

  /**
   * Display name of the role definition
   */
  displayName?: string;

  /**
   * Type of the role definition
   */
  type?: string;
}

/**
 * Details of the policy
 */
model PolicyAssignmentPropertiesPolicy {
  /**
   * Id of the policy
   */
  id?: string;

  /**
   * The name of the entity last modified it
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: Principal;

  /**
   * The last modified date time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;
}

/**
 * The role management policy approval rule.
 */
model RoleManagementPolicyApprovalRule extends RoleManagementPolicyRule {
  /**
   * The approval setting
   */
  setting?: ApprovalSettings;

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyApprovalRule";
}

/**
 * The approval settings.
 */
model ApprovalSettings {
  /**
   * Determines whether approval is required or not.
   */
  isApprovalRequired?: boolean;

  /**
   * Determines whether approval is required for assignment extension.
   */
  isApprovalRequiredForExtension?: boolean;

  /**
   * Determine whether requestor justification is required.
   */
  isRequestorJustificationRequired?: boolean;

  /**
   * The type of rule
   */
  approvalMode?: ApprovalMode;

  /**
   * The approval stages of the request.
   */
  @identifiers(#[])
  approvalStages?: ApprovalStage[];
}

/**
 * The approval stage.
 */
model ApprovalStage {
  /**
   * The time in days when approval request would be timed out
   */
  approvalStageTimeOutInDays?: int32;

  /**
   * Determines whether approver need to provide justification for his decision.
   */
  isApproverJustificationRequired?: boolean;

  /**
   * The time in minutes when the approval request would be escalated if the primary approver does not approve
   */
  escalationTimeInMinutes?: int32;

  /**
   * The primary approver of the request.
   */
  primaryApprovers?: UserSet[];

  /**
   * The value determine whether escalation feature is enabled.
   */
  isEscalationEnabled?: boolean;

  /**
   * The escalation approver of the request.
   */
  escalationApprovers?: UserSet[];
}

/**
 * The detail of a user.
 */
model UserSet {
  /**
   * The type of user.
   */
  userType?: UserType;

  /**
   * The value indicating whether the user is a backup fallback approver
   */
  isBackup?: boolean;

  /**
   * The object id of the user.
   */
  id?: string;

  /**
   * The description of the user.
   */
  description?: string;
}

/**
 * The detail of a subject.
 */
model UsersOrServicePrincipalSet {
  /**
   * The type of user.
   */
  type?: UsersOrServicePrincipalSetUserType;

  /**
   * The object id of the entity.
   */
  id?: string;

  /**
   * The display Name of the entity.
   */
  displayName?: string;
}

/**
 * The role management policy authentication context rule.
 */
model RoleManagementPolicyAuthenticationContextRule
  extends RoleManagementPolicyRule {
  /**
   * The value indicating if rule is enabled.
   */
  isEnabled?: boolean;

  /**
   * The claim value.
   */
  claimValue?: string;

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyAuthenticationContextRule";
}

/**
 * The role management policy enablement rule.
 */
model RoleManagementPolicyEnablementRule extends RoleManagementPolicyRule {
  /**
   * The list of enabled rules.
   */
  enabledRules?: EnablementRules[];

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyEnablementRule";
}

/**
 * The role management policy expiration rule.
 */
model RoleManagementPolicyExpirationRule extends RoleManagementPolicyRule {
  /**
   * The value indicating whether expiration is required.
   */
  isExpirationRequired?: boolean;

  /**
   * The maximum duration of expiration in timespan.
   */
  maximumDuration?: string;

  /**
   * The members not restricted by expiration rule.
   */
  exceptionMembers?: UserSet[];

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyExpirationRule";
}

/**
 * The role management policy notification rule.
 */
model RoleManagementPolicyNotificationRule extends RoleManagementPolicyRule {
  /**
   * The type of notification.
   */
  notificationType?: NotificationDeliveryMechanism;

  /**
   * The notification level.
   */
  notificationLevel?: NotificationLevel;

  /**
   * The recipient type.
   */
  recipientType?: RecipientType;

  /**
   * The list of notification recipients.
   */
  notificationRecipients?: string[];

  /**
   * Determines if the notification will be sent to the recipient type specified in the policy rule.
   */
  isDefaultRecipientsEnabled?: boolean;

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyNotificationRule";
}

/**
 * The role management policy PIM only mode rule.
 */
model RoleManagementPolicyPimOnlyModeRule extends RoleManagementPolicyRule {
  /**
   * The PIM Only Mode settings
   */
  pimOnlyModeSettings?: PIMOnlyModeSettings;

  /**
   * The type of rule
   */
  ruleType: "RoleManagementPolicyPimOnlyModeRule";
}

/**
 * The PIM Only Mode settings.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PIMOnlyModeSettings {
  /**
   * Determines whether the setting is enabled, disabled or report only.
   */
  mode?: PIMOnlyMode;

  /**
   * The list of excluded entities that the rule does not apply to.
   */
  excludes?: UsersOrServicePrincipalSet[];

  /**
   * The list of excluded assignment types allowed.
   */
  excludedAssignmentTypes?: ExcludedPrincipalTypes[];
}

/**
 * Role assignment schedule filter
 */
model RoleAssignmentScheduleFilter {
  /**
   * Returns role assignment schedule of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role assignment schedule of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role assignment schedule instances of the specific status.
   */
  status?: string;
}

/**
 * Role assignment schedule instance filter
 */
model RoleAssignmentScheduleInstanceFilter {
  /**
   * Returns role assignment schedule instances of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role assignment schedule instances of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role assignment schedule instances of the specific status.
   */
  status?: string;

  /**
   * Returns role assignment schedule instances belonging to a specific role assignment schedule.
   */
  roleAssignmentScheduleId?: string;
}

/**
 * Role assignment schedule request filter
 */
model RoleAssignmentScheduleRequestFilter {
  /**
   * Returns role assignment requests of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role assignment requests of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role assignment requests created by specific principal.
   */
  requestorId?: string;

  /**
   * Returns role assignment requests of specific status.
   */
  status?: string;
}

/**
 * Role eligibility schedule filter
 */
model RoleEligibilityScheduleFilter {
  /**
   * Returns role eligibility schedule of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role eligibility schedule of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role eligibility schedule of the specific status.
   */
  status?: string;
}

/**
 * Role eligibility schedule instance filter
 */
model RoleEligibilityScheduleInstanceFilter {
  /**
   * Returns role eligibility schedule instances of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role eligibility schedule instances of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role eligibility schedule instances of the specific status.
   */
  status?: string;

  /**
   * Returns role eligibility schedule instances belonging to a specific role eligibility schedule.
   */
  roleEligibilityScheduleId?: string;
}

/**
 * Role eligibility schedule request filter
 */
model RoleEligibilityScheduleRequestFilter {
  /**
   * Returns role eligibility requests of the specific principal.
   */
  principalId?: string;

  /**
   * Returns role eligibility requests of the specific role definition.
   */
  roleDefinitionId?: string;

  /**
   * Returns role eligibility requests created by specific principal.
   */
  requestorId?: string;

  /**
   * Returns role eligibility requests of specific status.
   */
  status?: string;
}

model EligibleChildResourcesListResult
  is Azure.Core.Page<EligibleChildResource>;
