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

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

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

  /**
   * Student
   */
  Student: "Student",

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

  /**
   * Active
   */
  Active: "Active",

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

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

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

  /**
   * Active
   */
  Active: "Active",

  /**
   * Deleted
   */
  Deleted: "Deleted",

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

  /**
   * Pending
   */
  Pending: "Pending",

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

  /**
   * Student
   */
  Student: "Student",

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

  /**
   * Active
   */
  Active: "Active",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Pending
   */
  Pending: "Pending",

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
 * List of Grants info.
 */
model GrantListResponse is Azure.Core.Page<GrantDetails>;

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
model JoinRequestList is Azure.Core.Page<JoinRequestDetails>;

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
