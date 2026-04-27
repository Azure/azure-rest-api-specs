import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Subscription;

/**
 * The list of aliases.
 */
model SubscriptionAliasListResult {
  /**
   * The list of subscription aliases.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SubscriptionAliasResponse[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Subscription Response to list out Changed Target Directory.
 */
model TargetDirectoryListResult {
  /**
   * The list of subscription response to changed target directory.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  value?: TargetDirectoryResult[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}
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
 * The workload type of the subscription. It can be either Production or DevTest.
 */
union Workload {
  string,

  /**
   * Production
   */
  Production: "Production",

  /**
   * DevTest
   */
  DevTest: "DevTest",
}

/**
 * The provisioning state of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The accept ownership state of the resource.
 */
union AcceptOwnership {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Expired
   */
  Expired: "Expired",
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
 * The provisioning state of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Provisioning {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * Status of the subscription transfer operation.
 */
union ChangeDirectoryOperationStatus {
  string,

  /**
   * The subscription transfer request has been created and is waiting for acceptance by the destination tenant.
   */
  Initialized: "Initialized",

  /**
   * The subscription transfer request has been accepted by the destination tenant and the transfer is in progress.
   */
  InProgress: "InProgress",

  /**
   * The subscription transfer has been completed and is now owned by the destination tenant.
   */
  Completed: "Completed",
}

/**
 * The ID of the canceled subscription
 */
model CanceledSubscriptionId {
  /**
   * The ID of the canceled subscription
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * The new name of the subscription.
 */
model SubscriptionName {
  /**
   * New subscription name
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptionName?: string;
}

/**
 * The ID of the subscriptions that is being renamed
 */
model RenamedSubscriptionId {
  /**
   * The ID of the subscriptions that is being renamed
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * The ID of the subscriptions that is being enabled
 */
model EnabledSubscriptionId {
  /**
   * The ID of the subscriptions that is being enabled
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

/**
 * The created subscription object.
 */
model SubscriptionCreationResult {
  /**
   * The link to the new subscription. Use this link to check the status of subscription creation operation.
   */
  subscriptionLink?: string;
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
 * The parameters required to create a new subscription.
 */
model PutAliasRequest {
  /**
   * Put alias request properties.
   */
  properties?: PutAliasRequestProperties;
}

/**
 * Put subscription properties.
 */
model PutAliasRequestProperties {
  /**
   * The friendly name of the subscription.
   */
  displayName?: string;

  /**
   * The workload type of the subscription. It can be either Production or DevTest.
   */
  workload?: Workload;

  /**
   * Billing scope of the subscription.
   * For CustomerLed and FieldLed - /billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}
   * For PartnerLed - /billingAccounts/{billingAccountName}/customers/{customerName}
   * For Legacy EA - /billingAccounts/{billingAccountName}/enrollmentAccounts/{enrollmentAccountName}
   */
  billingScope?: string;

  /**
   * This parameter can be used to create alias for existing subscription Id
   */
  subscriptionId?: string;

  /**
   * Reseller Id
   */
  resellerId?: string;

  /**
   * Put alias request additional properties.
   */
  additionalProperties?: PutAliasRequestAdditionalProperties;
}

/**
 * Put subscription additional properties.
 */
model PutAliasRequestAdditionalProperties {
  /**
   * Management group Id for the subscription.
   */
  managementGroupId?: string;

  /**
   * Tenant Id of the subscription
   */
  subscriptionTenantId?: string;

  /**
   * Owner Id of the subscription
   */
  subscriptionOwnerId?: string;

  /**
   * Tags for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Put subscription creation result properties.
 */
model SubscriptionAliasResponseProperties {
  /**
   * Newly created subscription Id.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The display name of the subscription.
   */
  displayName?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Url to accept ownership of the subscription.
   */
  @visibility(Lifecycle.Read)
  acceptOwnershipUrl?: string;

  /**
   * The accept ownership state of the resource.
   */
  @visibility(Lifecycle.Read)
  acceptOwnershipState?: AcceptOwnership;

  /**
   * Billing scope of the subscription.
   * For CustomerLed and FieldLed - /billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/invoiceSections/{invoiceSectionName}
   * For PartnerLed - /billingAccounts/{billingAccountName}/customers/{customerName}
   * For Legacy EA - /billingAccounts/{billingAccountName}/enrollmentAccounts/{enrollmentAccountName}
   */
  billingScope?: string;

  /**
   * The workload type of the subscription. It can be either Production or DevTest.
   */
  workload?: Workload;

  /**
   * Reseller Id
   */
  resellerId?: string;

  /**
   * Owner Id of the subscription
   */
  subscriptionOwnerId?: string;

  /**
   * The Management Group Id.
   */
  managementGroupId?: string;

  /**
   * Created Time
   */
  createdTime?: string;

  /**
   * Tags for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The parameters required to accept subscription ownership.
 */
model AcceptOwnershipRequest {
  /**
   * Accept subscription ownership request properties.
   */
  properties?: AcceptOwnershipRequestProperties;
}

/**
 * Accept subscription ownership request properties.
 */
model AcceptOwnershipRequestProperties {
  /**
   * The friendly name of the subscription.
   */
  displayName: string;

  /**
   * Management group Id for the subscription.
   */
  managementGroupId?: string;

  /**
   * Tags for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Subscription Accept Ownership Response
 */
model AcceptOwnershipStatusResponse {
  /**
   * Newly created subscription Id.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The accept ownership state of the resource.
   */
  @visibility(Lifecycle.Read)
  acceptOwnershipState?: AcceptOwnership;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: Provisioning;

  /**
   * UPN of the billing owner
   */
  @visibility(Lifecycle.Read)
  billingOwner?: string;

  /**
   * Tenant Id of the subscription
   */
  subscriptionTenantId?: string;

  /**
   * The display name of the subscription.
   */
  displayName?: string;

  /**
   * Tags for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Put tenant policy request properties.
 */
model PutTenantPolicyRequestProperties {
  /**
   * Blocks the leaving of subscriptions from user's tenant.
   */
  blockSubscriptionsLeavingTenant?: boolean;

  /**
   * Blocks the entering of subscriptions into user's tenant.
   */
  blockSubscriptionsIntoTenant?: boolean;

  /**
   * List of user objectIds that are exempted from the set subscription tenant policies for the user's tenant.
   */
  exemptedPrincipals?: Azure.Core.uuid[];
}

/**
 * Tenant policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TenantPolicy {
  /**
   * Policy Id.
   */
  @visibility(Lifecycle.Read)
  policyId?: string;

  /**
   * Blocks the leaving of subscriptions from user's tenant.
   */
  blockSubscriptionsLeavingTenant?: boolean;

  /**
   * Blocks the entering of subscriptions into user's tenant.
   */
  blockSubscriptionsIntoTenant?: boolean;

  /**
   * List of user objectIds that are exempted from the set subscription tenant policies for the user's tenant.
   */
  exemptedPrincipals?: Azure.Core.uuid[];
}

/**
 * Tenant policy information list.
 */
model GetTenantPolicyListResponse is Azure.Core.Page<GetTenantPolicyResponse>;

/**
 * Put billing account policies response properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BillingAccountPoliciesResponseProperties {
  /**
   * Service tenant for the billing account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceTenants?: ServiceTenantResponse[];

  /**
   * Determine if the transfers are allowed for the billing account
   */
  allowTransfers?: boolean;
}

/**
 * Billing account service tenant.
 */
model ServiceTenantResponse {
  /**
   * Service tenant id.
   */
  tenantId?: string;

  /**
   * Service tenant name.
   */
  tenantName?: string;
}

/**
 * Subscription Request for Changed Target Directory.
 */
model TargetDirectoryRequest {
  /**
   * Target Directory request properties.
   */
  properties?: TargetDirectoryRequestProperties;
}

/**
 * Properties of subscription Request for Changed Target Directory.
 */
model TargetDirectoryRequestProperties {
  /**
   * The destination OwnerId, can be object id or email address
   */
  destinationOwnerId?: string;

  /**
   * The destination Tenant id where subscription needs to be accepted
   */
  destinationTenantId?: string;
}

/**
 * Properties of subscription Response for Changed Target Directory.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TargetDirectoryResultProperties {
  /**
   * Destination Tenant Id where Subscription will be accepted.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  destinationTenantId?: string;

  /**
   * Destination Owner Id where Subscription will be accepted.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  destinationOwnerId?: string;

  /**
   * The id of the subscription being transferred.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  subscriptionId?: string;

  /**
   * The UTC date and time when the transfer request was created
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The UTC date and time when the transfer request was accepted
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  acceptedDate?: utcDateTime | null;

  /**
   * The email address of the user who initiated the transfer request. If the request was generated by a Service Principal, this field may be null.
   */
  @visibility(Lifecycle.Read)
  sourceOwnerEmail?: string;

  /**
   * The object id of the user who initiated the transfer request.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  sourceOwnerId?: string;

  /**
   * The id of the tenant where the subscription originally resided.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  sourceTenantId?: string;

  /**
   * Status of the subscription transfer operation.
   */
  @visibility(Lifecycle.Read)
  status?: ChangeDirectoryOperationStatus;

  /**
   * Subscription Initiate Request Expiry time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;
}
