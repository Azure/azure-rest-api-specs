import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AttributeNamespaces;

/**
 * Represents a reviewer's decision for a given review
 */
union AccessReviewResult {
  string,

  /**
   * Approve
   */
  Approve: "Approve",

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * NotReviewed
   */
  NotReviewed: "NotReviewed",

  /**
   * DontKnow
   */
  DontKnow: "DontKnow",

  /**
   * NotNotified
   */
  NotNotified: "NotNotified",
}

/**
 * This read-only field specifies the of the requested review history data. This is either requested, in-progress, done or error.
 */
union AccessReviewHistoryDefinitionStatus {
  string,

  /**
   * Requested
   */
  Requested: "Requested",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Done
   */
  Done: "Done",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The identity type : user/servicePrincipal
 */
union AccessReviewActorIdentityType {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * servicePrincipal
   */
  servicePrincipal: "servicePrincipal",
}

/**
 * The identity type user/servicePrincipal to review
 */
union AccessReviewScopePrincipalType {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * guestUser
   */
  guestUser: "guestUser",

  /**
   * servicePrincipal
   */
  servicePrincipal: "servicePrincipal",

  /**
   * user,group
   */
  `user,group`: "user,group",

  /**
   * redeemedGuestUser
   */
  redeemedGuestUser: "redeemedGuestUser",
}

/**
 * The role assignment state eligible/active to review
 */
union AccessReviewScopeAssignmentState {
  string,

  /**
   * eligible
   */
  eligible: "eligible",

  /**
   * active
   */
  active: "active",
}

/**
 * The recurrence type : weekly, monthly, etc.
 */
union AccessReviewRecurrencePatternType {
  string,

  /**
   * weekly
   */
  weekly: "weekly",

  /**
   * absoluteMonthly
   */
  absoluteMonthly: "absoluteMonthly",
}

/**
 * The recurrence range type. The possible values are: endDate, noEnd, numbered.
 */
union AccessReviewRecurrenceRangeType {
  string,

  /**
   * endDate
   */
  endDate: "endDate",

  /**
   * noEnd
   */
  noEnd: "noEnd",

  /**
   * numbered
   */
  numbered: "numbered",
}

/**
 * This read-only field specifies the status of an accessReview.
 */
union AccessReviewScheduleDefinitionStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Applied
   */
  Applied: "Applied",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * Applying
   */
  Applying: "Applying",

  /**
   * Completing
   */
  Completing: "Completing",

  /**
   * Scheduled
   */
  Scheduled: "Scheduled",

  /**
   * AutoReviewing
   */
  AutoReviewing: "AutoReviewing",

  /**
   * AutoReviewed
   */
  AutoReviewed: "AutoReviewed",

  /**
   * Starting
   */
  Starting: "Starting",
}

/**
 * This specifies the behavior for the autoReview feature when an access review completes.
 */
union DefaultDecisionType {
  string,

  /**
   * Approve
   */
  Approve: "Approve",

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * Recommendation
   */
  Recommendation: "Recommendation",
}

/**
 * The identity type : user/servicePrincipal
 */
union AccessReviewReviewerType {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * servicePrincipal
   */
  servicePrincipal: "servicePrincipal",
}

/**
 * This field specifies the type of reviewers for a review. Usually for a review, reviewers are explicitly assigned. However, in some cases, the reviewers may not be assigned and instead be chosen dynamically. For example managers review or self review.
 */
union AccessReviewScheduleDefinitionReviewersType {
  string,

  /**
   * Assigned
   */
  Assigned: "Assigned",

  /**
   * Self
   */
  Self: "Self",

  /**
   * Managers
   */
  Managers: "Managers",
}

/**
 * This read-only field specifies the status of an access review instance.
 */
union AccessReviewInstanceStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Applied
   */
  Applied: "Applied",

  /**
   * Initializing
   */
  Initializing: "Initializing",

  /**
   * Applying
   */
  Applying: "Applying",

  /**
   * Completing
   */
  Completing: "Completing",

  /**
   * Scheduled
   */
  Scheduled: "Scheduled",

  /**
   * AutoReviewing
   */
  AutoReviewing: "AutoReviewing",

  /**
   * AutoReviewed
   */
  AutoReviewed: "AutoReviewed",

  /**
   * Starting
   */
  Starting: "Starting",
}

/**
 * This field specifies the type of reviewers for a review. Usually for a review, reviewers are explicitly assigned. However, in some cases, the reviewers may not be assigned and instead be chosen dynamically. For example managers review or self review.
 */
union AccessReviewInstanceReviewersType {
  string,

  /**
   * Assigned
   */
  Assigned: "Assigned",

  /**
   * Self
   */
  Self: "Self",

  /**
   * Managers
   */
  Managers: "Managers",
}

/**
 * The type of decision target : User/ServicePrincipal
 */
union DecisionTargetType {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * servicePrincipal
   */
  servicePrincipal: "servicePrincipal",
}

/**
 * The type of resource
 */
union DecisionResourceType {
  string,

  /**
   * azureRole
   */
  azureRole: "azureRole",
}

/**
 * The feature- generated recommendation shown to the reviewer.
 */
union AccessRecommendationType {
  string,

  /**
   * Approve
   */
  Approve: "Approve",

  /**
   * Deny
   */
  Deny: "Deny",

  /**
   * NoInfoAvailable
   */
  NoInfoAvailable: "NoInfoAvailable",
}

/**
 * The outcome of applying the decision.
 */
union AccessReviewApplyResult {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Applying
   */
  Applying: "Applying",

  /**
   * AppliedSuccessfully
   */
  AppliedSuccessfully: "AppliedSuccessfully",

  /**
   * AppliedWithUnknownFailure
   */
  AppliedWithUnknownFailure: "AppliedWithUnknownFailure",

  /**
   * AppliedSuccessfullyButObjectNotFound
   */
  AppliedSuccessfullyButObjectNotFound: "AppliedSuccessfullyButObjectNotFound",

  /**
   * ApplyNotSupported
   */
  ApplyNotSupported: "ApplyNotSupported",
}

/**
 * The type of insight
 */
union AccessReviewDecisionInsightType {
  string,

  /**
   * userSignInInsight
   */
  userSignInInsight: "userSignInInsight",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AccessReviewDecisionPrincipalResourceMembershipType {
  string,

  /**
   * direct
   */
  direct: "direct",

  /**
   * indirect
   */
  indirect: "indirect",
}

/**
 * The decision to make. Approvers can take action of Approve/Deny
 */
union RecordAllDecisionsResult {
  string,

  /**
   * Approve
   */
  Approve: "Approve",

  /**
   * Deny
   */
  Deny: "Deny",
}

/**
 * The definition of a Microsoft.Authorization operation.
 */
model Operation {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}

model OperationListResult is Azure.Core.Page<Operation>;
@@identifiers(OperationListResult.value, #["name"]);

/**
 * The display information for a Microsoft.Authorization operation.
 */
model OperationDisplay {
  /**
   * The resource provider name: Microsoft.Authorization.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The operation that users can perform.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The description for the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Error description and code explaining why an operation failed.
 */
@error
@summary("Error")
model ErrorDefinition {
  /**
   * Error of the list gateway status.
   */
  error?: ErrorDefinitionProperties;
}

/**
 * Error description and code explaining why an operation failed.
 */
@summary("Error")
model ErrorDefinitionProperties {
  /**
   * Description of the error.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Error code of list gateway.
   */
  code?: string;
}

/**
 * Access Review History Instances.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessReviewHistoryDefinitionProperties {
  /**
   * The display name for the history definition.
   */
  displayName?: string;

  /**
   * Date time used when selecting review data, all reviews included in data start on or after this date. For use only with one-time/non-recurring reports.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewHistoryPeriodStartDateTime?: utcDateTime | null;

  /**
   * Date time used when selecting review data, all reviews included in data end on or before this date. For use only with one-time/non-recurring reports.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewHistoryPeriodEndDateTime?: utcDateTime | null;

  /**
   * Collection of review decisions which the history data should be filtered on. For example if Approve and Deny are supplied the data will only contain review results in which the decision maker approved or denied a review request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  decisions?: AccessReviewResult[] | null;

  /**
   * This read-only field specifies the of the requested review history data. This is either requested, in-progress, done or error.
   */
  @visibility(Lifecycle.Read)
  status?: AccessReviewHistoryDefinitionStatus;

  /**
   * Date time when history definition was created
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime | null;

  /**
   * The user or other identity who created this history definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  createdBy?: AccessReviewActorIdentity | null;

  /**
   * A collection of scopes used when selecting review history data
   */
  @identifiers(#[])
  scopes?: AccessReviewScope[];

  /**
   * Recurrence settings for recurring history reports, skip for one-time reports.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: AccessReviewHistoryScheduleSettings | null;

  /**
   * Set of access review history instances for this history definition.
   */
  instances?: AccessReviewHistoryInstance[];
}

/**
 * Details of the actor identity
 */
model AccessReviewActorIdentity {
  /**
   * The identity id
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The identity type : user/servicePrincipal
   */
  @visibility(Lifecycle.Read)
  principalType?: AccessReviewActorIdentityType;

  /**
   * The identity display name
   */
  @visibility(Lifecycle.Read)
  principalName?: string;

  /**
   * The user principal name(if valid)
   */
  @visibility(Lifecycle.Read)
  userPrincipalName?: string;
}

/**
 * Descriptor for what needs to be reviewed
 */
model AccessReviewScope {
  /**
   * ResourceId in which this review is getting created
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * This is used to indicate the role being reviewed
   */
  @visibility(Lifecycle.Read)
  roleDefinitionId?: string;

  /**
   * The identity type user/servicePrincipal to review
   */
  @visibility(Lifecycle.Read)
  principalType?: AccessReviewScopePrincipalType;

  /**
   * The role assignment state eligible/active to review
   */
  @visibility(Lifecycle.Read)
  assignmentState?: AccessReviewScopeAssignmentState;

  /**
   * Duration users are inactive for. The value should be in ISO  8601 format (http://en.wikipedia.org/wiki/ISO_8601#Durations).This code can be used to convert TimeSpan to a valid interval string: XmlConvert.ToString(new TimeSpan(hours, minutes, seconds))
   */
  inactiveDuration?: duration;

  /**
   * Flag to indicate whether to expand nested memberships or not.
   */
  expandNestedMemberships?: boolean;

  /**
   * Flag to indicate whether to expand nested memberships or not.
   */
  includeInheritedAccess?: boolean;

  /**
   * Flag to indicate whether to expand nested memberships or not.
   */
  includeAccessBelowResource?: boolean;

  /**
   * This is used to indicate the resource id(s) to exclude
   */
  excludeResourceId?: string;

  /**
   * This is used to indicate the role definition id(s) to exclude
   */
  excludeRoleDefinitionId?: string;
}

/**
 * Recurrence settings of an Access Review History Definition.
 */
model AccessReviewHistoryScheduleSettings {
  /**
   * Access Review History Definition recurrence settings.
   */
  pattern?: AccessReviewRecurrencePattern;

  /**
   * Access Review History Definition recurrence settings.
   */
  range?: AccessReviewRecurrenceRange;
}

/**
 * Recurrence Pattern of an Access Review Schedule Definition.
 */
model AccessReviewRecurrencePattern {
  /**
   * The recurrence type : weekly, monthly, etc.
   */
  type?: AccessReviewRecurrencePatternType;

  /**
   * The interval for recurrence. For a quarterly review, the interval is 3 for type : absoluteMonthly.
   */
  interval?: int32;
}

/**
 * Recurrence Range of an Access Review Schedule Definition.
 */
model AccessReviewRecurrenceRange {
  /**
   * The recurrence range type. The possible values are: endDate, noEnd, numbered.
   */
  type?: AccessReviewRecurrenceRangeType;

  /**
   * The number of times to repeat the access review. Required and must be positive if type is numbered.
   */
  numberOfOccurrences?: int32;

  /**
   * The DateTime when the review is scheduled to be start. This could be a date in the future. Required on create.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startDate?: utcDateTime | null;

  /**
   * The DateTime when the review is scheduled to end. Required if type is endDate
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endDate?: utcDateTime | null;
}

/**
 * Access Review History Definition Instance.
 */
model AccessReviewHistoryInstance {
  /**
   * The access review history definition instance id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The access review history definition instance unique id.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Access Review History Definition Instance properties.
   */
  properties?: AccessReviewHistoryInstanceProperties;
}

/**
 * Access Review History Definition Instance properties.
 */
model AccessReviewHistoryInstanceProperties {
  /**
   * Date time used when selecting review data, all reviews included in data start on or after this date. For use only with one-time/non-recurring reports.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewHistoryPeriodStartDateTime?: utcDateTime;

  /**
   * Date time used when selecting review data, all reviews included in data end on or before this date. For use only with one-time/non-recurring reports.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewHistoryPeriodEndDateTime?: utcDateTime;

  /**
   * The display name for the parent history definition.
   */
  displayName?: string;

  /**
   * Status of the requested review history instance data. This is either requested, in-progress, done or error. The state transitions are as follows - Requested -> InProgress -> Done -> Expired
   */
  @visibility(Lifecycle.Read)
  status?: AccessReviewHistoryDefinitionStatus;

  /**
   * Date time when the history data report is scheduled to be generated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runDateTime?: utcDateTime | null;

  /**
   * Date time when the history data report is scheduled to be generated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  fulfilledDateTime?: utcDateTime | null;

  /**
   * Uri which can be used to retrieve review history data. To generate this Uri, generateDownloadUri() must be called for a specific accessReviewHistoryDefinitionInstance. The link expires after a 24 hour period. Callers can see the expiration date time by looking at the 'se' parameter in the generated uri.
   */
  @visibility(Lifecycle.Read)
  downloadUri?: string;

  /**
   * Date time when history data report expires and the associated data is deleted.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  expiration?: utcDateTime | null;
}

/**
 * Access Review.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessReviewScheduleDefinitionProperties {
  /**
   * The display name for the schedule definition.
   */
  displayName?: string;

  /**
   * This read-only field specifies the status of an accessReview.
   */
  @visibility(Lifecycle.Read)
  status?: AccessReviewScheduleDefinitionStatus;

  /**
   * The description provided by the access review creator and visible to admins.
   */
  descriptionForAdmins?: string;

  /**
   * The description provided by the access review creator to be shown to reviewers.
   */
  descriptionForReviewers?: string;

  /**
   * The user or other identity who created this review.
   */
  @visibility(Lifecycle.Read)
  createdBy?: AccessReviewActorIdentity;

  /**
   * Access Review Settings.
   */
  settings?: AccessReviewScheduleSettings;

  /**
   * This is used to define what to include in scope of the review. The scope definition includes the resourceId and roleDefinitionId.
   */
  @visibility(Lifecycle.Read)
  scope?: AccessReviewScope;

  /**
   * This is the collection of reviewers.
   */
  @identifiers(#["principalId"])
  reviewers?: AccessReviewReviewer[];

  /**
   * This is the collection of backup reviewers.
   */
  @identifiers(#["principalId"])
  backupReviewers?: AccessReviewReviewer[];

  /**
   * This field specifies the type of reviewers for a review. Usually for a review, reviewers are explicitly assigned. However, in some cases, the reviewers may not be assigned and instead be chosen dynamically. For example managers review or self review.
   */
  @visibility(Lifecycle.Read)
  reviewersType?: AccessReviewScheduleDefinitionReviewersType;

  /**
   * This is the collection of instances returned when one does an expand on it.
   */
  instances?: AccessReviewInstance[];
}

/**
 * Settings of an Access Review.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessReviewScheduleSettings {
  /**
   * Flag to indicate whether sending mails to reviewers and the review creator is enabled.
   */
  mailNotificationsEnabled?: boolean;

  /**
   * Flag to indicate whether sending reminder emails to reviewers are enabled.
   */
  reminderNotificationsEnabled?: boolean;

  /**
   * Flag to indicate whether reviewers are required to provide a justification when reviewing access.
   */
  defaultDecisionEnabled?: boolean;

  /**
   * Flag to indicate whether the reviewer is required to pass justification when recording a decision.
   */
  justificationRequiredOnApproval?: boolean;

  /**
   * This specifies the behavior for the autoReview feature when an access review completes.
   */
  defaultDecision?: DefaultDecisionType;

  /**
   * Flag to indicate whether auto-apply capability, to automatically change the target object access resource, is enabled. If not enabled, a user must, after the review completes, apply the access review.
   */
  autoApplyDecisionsEnabled?: boolean;

  /**
   * Flag to indicate whether showing recommendations to reviewers is enabled.
   */
  recommendationsEnabled?: boolean;

  /**
   * Recommendations for access reviews are calculated by looking back at 30 days of data(w.r.t the start date of the review) by default. However, in some scenarios, customers want to change how far back to look at and want to configure 60 days, 90 days, etc. instead. This setting allows customers to configure this duration. The value should be in ISO  8601 format (http://en.wikipedia.org/wiki/ISO_8601#Durations).This code can be used to convert TimeSpan to a valid interval string: XmlConvert.ToString(new TimeSpan(hours, minutes, seconds))
   */
  recommendationLookBackDuration?: duration;

  /**
   * The duration in days for an instance.
   */
  instanceDurationInDays?: int32;

  /**
   * Access Review Settings.
   */
  recurrence?: AccessReviewRecurrenceSettings;
}

/**
 * Recurrence Settings of an Access Review Schedule Definition.
 */
model AccessReviewRecurrenceSettings {
  /**
   * Access Review schedule definition recurrence pattern.
   */
  pattern?: AccessReviewRecurrencePattern;

  /**
   * Access Review schedule definition recurrence range.
   */
  range?: AccessReviewRecurrenceRange;
}

/**
 * Descriptor for what needs to be reviewed
 */
model AccessReviewReviewer {
  /**
   * The id of the reviewer(user/servicePrincipal)
   */
  principalId?: string;

  /**
   * The identity type : user/servicePrincipal
   */
  @visibility(Lifecycle.Read)
  principalType?: AccessReviewReviewerType;
}

/**
 * Access Review Instance properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessReviewInstanceProperties {
  /**
   * This read-only field specifies the status of an access review instance.
   */
  @visibility(Lifecycle.Read)
  status?: AccessReviewInstanceStatus;

  /**
   * The DateTime when the review instance is scheduled to be start.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The DateTime when the review instance is scheduled to end.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * This is the collection of reviewers.
   */
  @identifiers(#["principalId"])
  reviewers?: AccessReviewReviewer[];

  /**
   * This is the collection of backup reviewers.
   */
  @identifiers(#["principalId"])
  backupReviewers?: AccessReviewReviewer[];

  /**
   * This field specifies the type of reviewers for a review. Usually for a review, reviewers are explicitly assigned. However, in some cases, the reviewers may not be assigned and instead be chosen dynamically. For example managers review or self review.
   */
  @visibility(Lifecycle.Read)
  reviewersType?: AccessReviewInstanceReviewersType;
}

/**
 * Approval Step.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccessReviewDecisionProperties {
  /**
   * Principal associated with the decision record. Can be AccessReviewDecisionUserIdentity or AccessReviewDecisionServicePrincipalIdentity
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principal?: AccessReviewDecisionIdentity | null;

  /**
   * Resource associated with this decision record.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resource?: AccessReviewDecisionResource | null;

  /**
   * The feature- generated recommendation shown to the reviewer.
   */
  @visibility(Lifecycle.Read)
  recommendation?: AccessRecommendationType;

  /**
   * The decision on the approval step. This value is initially set to NotReviewed. Approvers can take action of Approve/Deny
   */
  decision?: AccessReviewResult;

  /**
   * Justification provided by approvers for their action
   */
  justification?: string;

  /**
   * Date Time when a decision was taken.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewedDateTime?: utcDateTime | null;

  /**
   * Details of the approver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  reviewedBy?: AccessReviewActorIdentity | null;

  /**
   * The outcome of applying the decision.
   */
  @visibility(Lifecycle.Read)
  applyResult?: AccessReviewApplyResult;

  /**
   * The date and time when the review decision was applied.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  appliedDateTime?: utcDateTime | null;

  /**
   * Details of the approver.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  appliedBy?: AccessReviewActorIdentity | null;

  /**
   * This is the collection of insights for this decision item.
   */
  insights?: AccessReviewDecisionInsight[];

  /**
   * Details of the membership type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  principalResourceMembership?: AccessReviewDecisionPrincipalResourceMembership | null;
}

/**
 * Target of the decision.
 */
@discriminator("type")
model AccessReviewDecisionIdentity {
  /**
   * The type of decision target : User/ServicePrincipal
   */
  type: DecisionTargetType;

  /**
   * The id of principal whose access was reviewed.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The display name of the user whose access was reviewed.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * Target of the decision.
 */
model AccessReviewDecisionResource {
  /**
   * The type of resource
   */
  type: DecisionResourceType;

  /**
   * The id of resource associated with a decision record.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The display name of resource associated with a decision record.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * Access Review Decision Insight.
 */
model AccessReviewDecisionInsight {
  /**
   * The access review insight id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The access review insight name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Access Review Decision Insight properties.
   */
  properties?: AccessReviewDecisionInsightProperties;
}

/**
 * Details of the Insight.
 */
@discriminator("type")
model AccessReviewDecisionInsightProperties {
  /**
   * The type of insight
   */
  type: AccessReviewDecisionInsightType;

  /**
   * Date Time when the insight was created.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  insightCreatedDateTime?: utcDateTime | null;
}

/**
 * Target of the decision.
 */
model AccessReviewDecisionPrincipalResourceMembership {
  /**
   * Every decision item in an access review represents a principal's membership to a resource. This property represents details of the membership. Examples of this detail might be whether the principal has direct access or indirect access
   */
  membershipTypes?: AccessReviewDecisionPrincipalResourceMembershipType[];
}

/**
 * Access Review Contacted Reviewer.
 */
model AccessReviewContactedReviewer {
  /**
   * The access review reviewer id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The access review reviewer id.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Access Review Contacted Reviewer properties.
   */
  properties?: AccessReviewContactedReviewerProperties;
}

/**
 * Properties of access review contacted reviewer.
 */
model AccessReviewContactedReviewerProperties {
  /**
   * The display name of the reviewer
   */
  @visibility(Lifecycle.Read)
  userDisplayName?: string;

  /**
   * The user principal name of the reviewer
   */
  @visibility(Lifecycle.Read)
  userPrincipalName?: string;

  /**
   * Date Time when the reviewer was contacted.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDateTime?: utcDateTime | null;
}

/**
 * Record All Decisions payload.
 */
model RecordAllDecisionsProperties {
  /**
   * The id of principal which needs to be approved/denied.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The id of resource which needs to be approved/denied.
   */
  @visibility(Lifecycle.Read)
  resourceId?: string;

  /**
   * The decision to make. Approvers can take action of Approve/Deny
   */
  decision?: RecordAllDecisionsResult;

  /**
   * Justification provided by approvers for their action
   */
  justification?: string;
}

/**
 * User Decision Target
 */
model AccessReviewDecisionUserSignInInsightProperties
  extends AccessReviewDecisionInsightProperties {
  /**
   * Date Time when the user signed into the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  lastSignInDateTime?: utcDateTime | null;

  /**
   * The type of insight
   */
  type: "userSignInInsight";
}

/**
 * User Decision Target
 */
model AccessReviewDecisionUserIdentity extends AccessReviewDecisionIdentity {
  /**
   * The user principal name of the user whose access was reviewed.
   */
  @visibility(Lifecycle.Read)
  userPrincipalName?: string;

  /**
   * The type of decision target : User/ServicePrincipal
   */
  type: "user";
}

/**
 * Service Principal Decision Target
 */
model AccessReviewDecisionServicePrincipalIdentity
  extends AccessReviewDecisionIdentity {
  /**
   * The appId for the service principal entity being reviewed
   */
  @visibility(Lifecycle.Read)
  appId?: string;

  /**
   * The type of decision target : User/ServicePrincipal
   */
  type: "servicePrincipal";
}

model AccessReviewHistoryDefinitionInstanceListResult
  is Azure.Core.Page<AccessReviewHistoryInstance>;
