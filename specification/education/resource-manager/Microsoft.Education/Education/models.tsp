import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Education;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * user
   */
  user: "user",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * system
   */
  system: "system",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Grant Offer Type
 */
union GrantType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Student
   */
  Student: "Student",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Academic
   */
  Academic: "Academic",
}

/**
 * Grant status
 */
union GrantStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Active
   */
  Active: "Active",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Inactive
   */
  Inactive: "Inactive",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * User
   */
  User: "User",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Application
   */
  Application: "Application",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Key
   */
  Key: "Key",
}

/**
 * The status of this lab
 */
union LabStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Active
   */
  Active: "Active",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Deleted
   */
  Deleted: "Deleted",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Join request status
 */
union JoinRequestStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Denied
   */
  Denied: "Denied",
}

/**
 * Student Role
 */
union StudentRole {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Student
   */
  Student: "Student",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Admin
   */
  Admin: "Admin",
}

/**
 * Student Lab Status
 */
union StudentLabStatus {
  string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Active
   */
  Active: "Active",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Disabled
   */
  Disabled: "Disabled",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Expired
   */
  Expired: "Expired",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Pending
   */
  Pending: "Pending",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Preserve the existing published API description for backward compatibility."
  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponseBody {
  /**
   * The details of the error.
   */
  error?: ErrorResponse;
}

/**
 * Describes the format of Error response.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Describes the error if the operation is not successful.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@error
model DefaultErrorResponse {
  /**
   * The error response body.
   */
  @body
  error: ErrorResponseBody;
}

/**
 * Error response describing why the operation failed.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@error
model DeleteErrorResponse {
  /**
   * The error response body.
   */
  @body
  error: ErrorResponseBody;
}

/**
 * List of Grants info.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model GrantListResponse {
  /**
   * The GrantDetails items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: GrantDetails[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of Labs info.
 */
model LabListResult {
  /**
   * The LabDetails items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: LabDetails[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of Students info.
 */
model StudentListResult {
  /**
   * The StudentDetails items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: StudentDetails[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of Student Labs info.
 */
model StudentLabListResult {
  /**
   * The StudentLabDetails items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: StudentLabDetails[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Grant detail properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GrantDetailProperties {
  /**
   * Offer Cap
   */
  @visibility(Lifecycle.Read)
  offerCap?: Amount;

  /**
   * Grant Effective Date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * Grant Offer Type
   */
  @visibility(Lifecycle.Read)
  offerType?: GrantType;

  /**
   * Expiration Date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Grant status
   */
  @visibility(Lifecycle.Read)
  status?: GrantStatus;

  /**
   * allocated budget
   */
  @visibility(Lifecycle.Read)
  allocatedBudget?: Amount;
}

/**
 * The amount.
 */
model Amount {
  /**
   * The type of currency being used for the value.
   */
  currency?: string;

  /**
   * Amount value.
   */
  value?: float32;
}

/**
 * Lab detail result properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LabProperties {
  /**
   * Lab Display Name
   */
  displayName: string;

  /**
   * Default monetary cap for each student in this lab
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  budgetPerStudent: Amount;

  /**
   * Detail description of this lab
   */
  description: string;

  /**
   * Default expiration date for each student in this lab
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate: utcDateTime;

  /**
   * Lab creation date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * The status of this lab
   */
  @visibility(Lifecycle.Read)
  status?: LabStatus;

  /**
   * the total number of students that can be accepted to the lab.
   */
  @visibility(Lifecycle.Read)
  maxStudentCount?: float32;

  /**
   * invitation code for redeemable lab
   */
  @visibility(Lifecycle.Read)
  invitationCode?: string;

  /**
   * Total budget
   */
  @visibility(Lifecycle.Read)
  totalBudget?: Amount;

  /**
   * Total allocated budget
   */
  @visibility(Lifecycle.Read)
  totalAllocatedBudget?: Amount;
}

/**
 * invite code generate request.
 */
model InviteCodeGenerateRequest {
  /**
   * the total number of students that can be accepted to the lab.
   */
  maxStudentCount?: float32;
}

/**
 * list of join requests.
 */
model JoinRequestList {
  /**
   * The JoinRequestDetails items on this page.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: JoinRequestDetails[];

  /**
   * The link to the next page of items.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Join request properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model JoinRequestProperties {
  /**
   * First Name
   */
  firstName?: string;

  /**
   * Last Name
   */
  lastName?: string;

  /**
   * join request email
   */
  email?: string;

  /**
   * Join request status
   */
  status?: JoinRequestStatus;
}

/**
 * redeem request.
 */
model RedeemRequest {
  /**
   * redeem code
   */
  redeemCode: string;

  /**
   * first name of requester
   */
  firstName: string;

  /**
   * last name of requester
   */
  lastName: string;
}

/**
 * Student detail properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StudentProperties {
  /**
   * First Name
   */
  firstName: string;

  /**
   * Last Name
   */
  lastName: string;

  /**
   * Student Email
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  email: string;

  /**
   * Student Role
   */
  role: StudentRole;

  /**
   * Student Budget
   */
  budget: Amount;

  /**
   * Subscription Id
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Date this student is set to expire from the lab.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate: utcDateTime;

  /**
   * Student Lab Status
   */
  @visibility(Lifecycle.Read)
  status?: StudentLabStatus;

  /**
   * Date student was added to the lab
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * Subscription alias
   */
  subscriptionAlias?: string;

  /**
   * subscription invite last sent date
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  subscriptionInviteLastSentDate?: utcDateTime;
}

/**
 * Student lab detail properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StudentLabProperties {
  /**
   * Student lab Display Name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Detail description of this lab
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Date the lab will expire and by default will be the expiration date for each student in this lab
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Student Role
   */
  @visibility(Lifecycle.Read)
  role?: StudentRole;

  /**
   * Student Budget
   */
  @visibility(Lifecycle.Read)
  budget?: Amount;

  /**
   * Subscription Id
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Student Lab Status
   */
  @visibility(Lifecycle.Read)
  status?: StudentLabStatus;

  /**
   * User Added Date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDate?: utcDateTime;

  /**
   * Lab Scope. /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}/providers/Microsoft.Education/labs/default
   */
  @visibility(Lifecycle.Read)
  labScope?: string;
}
