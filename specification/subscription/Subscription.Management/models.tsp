import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Subscription;

/**
 * The workload type of the subscription. It can be either Production or DevTest.
 */
union Workload {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Production: "Production",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DevTest: "DevTest",
}

/**
 * The provisioning state of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * The accept ownership state of the resource.
 */
union AcceptOwnership {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Expired: "Expired",
}

/**
 * The provisioning state of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union Provisioning {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
}

/**
 * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SubscriptionState {
  Enabled,
  Warned,
  PastDue,
  Disabled,
  Deleted,
}

/**
 * The subscription spending limit.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum SpendingLimit {
  On,
  Off,
  CurrentPeriodOff,
}

/**
 * Location list operation response.
 */
@pagedResult
model LocationListResult {
  /**
   * An array of locations.
   */
  @items
  value?: Location[];
}

/**
 * Location information.
 */
model Location {
  /**
   * The fully qualified ID of the location. For example, /subscriptions/00000000-0000-0000-0000-000000000000/locations/westus.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The location name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The display name of the location.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The latitude of the location.
   */
  @visibility(Lifecycle.Read)
  latitude?: string;

  /**
   * The longitude of the location.
   */
  @visibility(Lifecycle.Read)
  longitude?: string;
}

/**
 * Subscription information.
 */
model Subscription {
  /**
   * The fully qualified ID for the subscription. For example, /subscriptions/00000000-0000-0000-0000-000000000000.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The subscription display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
   */
  @visibility(Lifecycle.Read)
  state?: SubscriptionState;

  /**
   * The tenant ID. For example, 00000000-0000-0000-0000-000000000000.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Tags for the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The subscription policies.
   */
  subscriptionPolicies?: SubscriptionPolicies;

  /**
   * The authorization source of the request. Valid values are one or more combinations of Legacy, RoleBased, Bypassed, Direct and Management. For example, 'Legacy, RoleBased'.
   */
  authorizationSource?: string;
}

/**
 * Subscription policies.
 */
model SubscriptionPolicies {
  /**
   * The subscription location placement ID. The ID indicates which regions are visible for a subscription. For example, a subscription with a location placement Id of Public_2014-09-01 has access to Azure public regions.
   */
  @visibility(Lifecycle.Read)
  locationPlacementId?: string;

  /**
   * The subscription quota ID.
   */
  @visibility(Lifecycle.Read)
  quotaId?: string;

  /**
   * The subscription spending limit.
   */
  @visibility(Lifecycle.Read)
  spendingLimit?: SpendingLimit;
}

/**
 * Subscription list operation response.
 */
model SubscriptionListResult is Azure.Core.Page<Subscription>;

/**
 * Tenant Ids information.
 */
model TenantListResult is Azure.Core.Page<TenantIdDescription>;

/**
 * Tenant Id information.
 */
model TenantIdDescription {
  /**
   * The fully qualified ID of the tenant. For example, /tenants/00000000-0000-0000-0000-000000000000.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The tenant ID. For example, 00000000-0000-0000-0000-000000000000.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The category of the tenant. Possible values are TenantCategoryHome,TenantCategoryProjectedBy,TenantCategoryManagedBy
   */
  @visibility(Lifecycle.Read)
  tenantCategory?: string;

  /**
   * The country/region name of the address for the tenant.
   */
  @visibility(Lifecycle.Read)
  country?: string;

  /**
   * The Country/region abbreviation for the tenant.
   */
  @visibility(Lifecycle.Read)
  countryCode?: string;

  /**
   * The display name of the tenant.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The list of domains for the tenant.
   */
  @visibility(Lifecycle.Read)
  domains?: string;

  /**
   * The default domain for the tenant.
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * The tenant type. Only available for Home tenant category.
   */
  @visibility(Lifecycle.Read)
  tenantType?: string;
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
 * Error response indicates that the service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponseBody {
  /**
   * The details of the error.
   */
  error?: ErrorResponse;

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
 * The new name of the subscription.
 */
model SubscriptionName {
  /**
   * New subscription name
   */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  exemptedPrincipals?: string[];
}

/**
 * Tenant policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  exemptedPrincipals?: string[];
}

/**
 * Tenant policy information list.
 */
model GetTenantPolicyListResponse is Azure.Core.Page<GetTenantPolicyResponse>;

/**
 * Put billing account policies response properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BillingAccountPoliciesResponseProperties {
  /**
   * Service tenant for the billing account.
   */
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
