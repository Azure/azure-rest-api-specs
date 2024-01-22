import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.BillingBenefits;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state
 */
enum ProvisioningState {
  Creating,
  PendingBilling,
  ConfirmedBilling,
  Created,
  Succeeded,
  Cancelled,
  Expired,
  Failed,
}

/**
 * Represent benefit term in ISO 8601 format.
 */
enum Term {
  P1Y,
  P3Y,
  P5Y,
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
 */
enum BillingPlan {
  P1M,
}

/**
 * Type of the Applied Scope.
 */
enum AppliedScopeType {
  Single,
  Shared,
  ManagementGroup,
}

/**
 * Commitment grain.
 */
enum CommitmentGrain {
  Hourly,
}

/**
 * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
 */
enum PaymentStatus {
  Succeeded,
  Failed,
  Scheduled,
  Cancelled,
}

/**
 * The type of the resource that is being reserved.
 */
enum ReservedResourceType {
  VirtualMachines,
  SqlDatabases,
  SuseLinux,
  CosmosDb,
  RedHat,
  SqlDataWarehouse,
  VMwareCloudSimple,
  RedHatOsa,
  Databricks,
  AppService,
  ManagedDisk,
  BlockBlob,
  RedisCache,
  AzureDataExplorer,
  MySql,
  MariaDb,
  PostgreSql,
  DedicatedHost,
  SapHana,
  SqlAzureHybridBenefit,
  AVS,
  DataFactory,
  NetAppStorage,
  AzureFiles,
  SqlEdge,
  VirtualMachineSoftware,
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group.
 */
enum InstanceFlexibility {
  On,
  Off,
}

/**
 * Represents either billing plan or savings plan term in ISO 8601 format.
 */
enum PricingCurrencyDuration {
  P1M,
  P1Y,
  P3Y,
}

/**
 * The SKU to be applied for this resource
 */
model Sku {
  /**
   * Name of the SKU to be applied
   */
  name?: string;
}

/**
 * Savings plan properties
 */
model SavingsPlanOrderAliasProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Identifier of the savings plan created
   */
  @visibility("read")
  savingsPlanOrderId?: string;

  /**
   * Provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;
}

/**
 * Properties specific to applied scope type. Not required if not applicable.
 */
model AppliedScopeProperties {
  /**
   * Tenant ID where the benefit is applied.
   */
  tenantId?: string;

  /**
   * Fully-qualified identifier of the management group where the benefit must be applied.
   */
  managementGroupId?: string;

  /**
   * Fully-qualified identifier of the subscription.
   */
  subscriptionId?: string;

  /**
   * Fully-qualified identifier of the resource group.
   */
  resourceGroupId?: string;

  /**
   * Display name
   */
  displayName?: string;
}

/**
 * Commitment towards the benefit.
 */
model Commitment extends Price {
  /**
   * Commitment grain.
   */
  grain?: CommitmentGrain;
}

model Price {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  amount?: float64;
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Savings plan order properties
 */
model SavingsPlanOrderModelProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility("read")
  billingProfileId?: string;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility("read")
  customerId?: string;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.
   */
  @visibility("read")
  billingAccountId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Expiry date time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * This is the DateTime when the savings plan benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  /**
   * Information describing the type of billing plan for this savings plan.
   */
  planInformation?: BillingPlanInformation;

  savingsPlans?: string[];

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;
}

/**
 * Information describing the type of billing plan for this savings plan.
 */
model BillingPlanInformation {
  /**
   * Amount of money to be paid for the Order. Tax is not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Date when the billing plan has started.
   */
  startDate?: plainDate;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  nextPaymentDueDate?: plainDate;

  transactions?: PaymentDetail[];
}

/**
 * Information about payment related to a savings plan order.
 */
model PaymentDetail {
  /**
   * Date when the payment needs to be done.
   */
  dueDate?: plainDate;

  /**
   * Date when the transaction is completed. Is null when it is scheduled.
   */
  paymentDate?: plainDate;

  /**
   * Amount in pricing currency. Tax not included.
   */
  pricingCurrencyTotal?: Price;

  /**
   * Amount charged in Billing currency. Tax not included. Is null for future payments
   */
  billingCurrencyTotal?: Price;

  /**
   * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
   */
  status?: PaymentStatus;

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Billing account
   */
  billingAccount?: string;
}

model ExtendedStatusInfo {
  /**
   * Status code providing additional information.
   */
  statusCode?: string;

  /**
   * The message giving detailed information about the status code.
   */
  message?: string;
}

/**
 * Role assignment entity
 */
model RoleAssignmentEntity {
  /**
   * Role assignment entity id
   */
  id?: string;

  /**
   * Role assignment entity name
   */
  name?: string;

  /**
   * Role assignment entity properties
   */
  properties?: RoleAssignmentEntityProperties;
}

/**
 * Role assignment entity properties
 */
model RoleAssignmentEntityProperties {
  /**
   * Principal Id
   */
  principalId?: string;

  /**
   * Role definition id
   */
  roleDefinitionId?: string;

  /**
   * Scope of the role assignment entity
   */
  scope?: string;
}

/**
 * Savings plan properties
 */
model SavingsPlanModelProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The provisioning state of the savings plan for display, e.g. Succeeded
   */
  @visibility("read")
  displayProvisioningState?: string;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility("read")
  billingProfileId?: string;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility("read")
  customerId?: string;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.
   */
  @visibility("read")
  billingAccountId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * The applied scope type of the savings plan for display, e.g. Shared
   */
  @visibility("read")
  userFriendlyAppliedScopeType?: string;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * DateTime of the savings plan starts providing benefit from.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * Expiry date time
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * Date time when the savings plan was purchased
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

  /**
   * This is the DateTime when the savings plan benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * Savings plan utilization
   */
  @visibility("read")
  utilization?: Utilization;

  /**
   * SavingsPlan Id of the SavingsPlan from which this SavingsPlan is renewed.
   */
  renewSource?: string;

  /**
   * SavingsPlan Id of the SavingsPlan which is purchased because of renew.
   */
  renewDestination?: string;

  renewProperties?: RenewProperties;
}

/**
 * Savings plan utilization
 */
model Utilization {
  /**
   * The number of days trend for a savings plan
   */
  @visibility("read")
  trend?: string;

  /**
   * The array of aggregates of a savings plan's utilization
   */
  aggregates?: UtilizationAggregates[];
}

/**
 * The aggregate values of savings plan utilization
 */
model UtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility("read")
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility("read")
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility("read")
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility("read")
  valueUnit?: string;
}

model RenewProperties {
  purchaseProperties?: PurchaseRequest;
}

model PurchaseRequest {
  /**
   * The SKU to be applied for this resource
   */
  sku?: Sku;

  properties?: PurchaseRequestProperties;
}

model PurchaseRequestProperties {
  /**
   * Friendly name of the savings plan
   */
  displayName?: string;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * DateTime of the savings plan starts providing benefit from.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;
}

/**
 * Savings plans list summary
 */
model SavingsPlanSummary {
  /**
   * This property has value 'summary'
   */
  @visibility("read")
  name?: string;

  /**
   * The roll up count summary of savings plans in each state
   */
  value?: SavingsPlanSummaryCount;
}

/**
 * The roll up count summary of savings plans in each state
 */
model SavingsPlanSummaryCount {
  /**
   * The number of savings plans in Succeeded state
   */
  @visibility("read")
  succeededCount?: float32;

  /**
   * The number of savings plans in Failed state
   */
  @visibility("read")
  failedCount?: float32;

  /**
   * The number of savings plans in Expiring state
   */
  @visibility("read")
  expiringCount?: float32;

  /**
   * The number of savings plans in Expired state
   */
  @visibility("read")
  expiredCount?: float32;

  /**
   * The number of savings plans in Pending state
   */
  @visibility("read")
  pendingCount?: float32;

  /**
   * The number of savings plans in Cancelled state
   */
  @visibility("read")
  cancelledCount?: float32;

  /**
   * The number of savings plans in Processing state
   */
  @visibility("read")
  processingCount?: float32;

  /**
   * The number of savings plans in No Benefit state
   */
  @visibility("read")
  noBenefitCount?: float32;

  /**
   * The number of savings plans in Warning state
   */
  @visibility("read")
  warningCount?: float32;
}

/**
 * Savings plan patch request
 */
model SavingsPlanUpdateRequest {
  /**
   * Savings plan patch request
   */
  properties?: SavingsPlanUpdateRequestProperties;
}

/**
 * Savings plan patch request
 */
model SavingsPlanUpdateRequestProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  renewProperties?: RenewProperties;
}

model SavingsPlanUpdateValidateRequest {
  benefits?: SavingsPlanUpdateRequestProperties[];
}

@pagedResult
model SavingsPlanValidateResponse {
  @items
  benefits?: SavingsPlanValidResponseProperty[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Benefit scope response property
 */
model SavingsPlanValidResponseProperty {
  /**
   * Indicates if the provided input was valid
   */
  valid?: boolean;

  /**
   * Failure reason code if the provided input was invalid
   */
  reasonCode?: string;

  /**
   * Failure reason if the provided input was invalid
   */
  reason?: string;
}

model SavingsPlanPurchaseValidateRequest {
  benefits?: SavingsPlanOrderAliasModel[];
}

/**
 * Reservation order alias
 */
model ReservationOrderAliasRequest extends Resource {
  /**
   * Reservation order SKU
   */
  sku: Sku;

  /**
   * The Azure Region where the reservation benefits are applied to.
   */
  location?: string;

  /**
   * Reservation order alias request properties
   */
  properties?: ReservationOrderAliasRequestProperties;
}

/**
 * Reservation properties
 */
model ReservationOrderAliasRequestProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Total Quantity of the SKUs purchased in the Reservation.
   */
  @minValue(1)
  quantity?: int32;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * The type of the resource that is being reserved.
   */
  reservedResourceType?: ReservedResourceType;

  /**
   * This is the date-time when the Azure Hybrid Benefit needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  /**
   * Properties specific to each reserved resource type. Not required if not applicable.
   */
  reservedResourceProperties?: ReservationOrderAliasRequestPropertiesReservedResourceProperties;
}

/**
 * Properties specific to each reserved resource type. Not required if not applicable.
 */
model ReservationOrderAliasRequestPropertiesReservedResourceProperties {
  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group.
   */
  instanceFlexibility?: InstanceFlexibility;
}

/**
 * Reservation properties
 */
model ReservationOrderAliasResponseProperties {
  /**
   * Display name
   */
  displayName?: string;

  /**
   * Identifier of the reservation order created
   */
  @visibility("read")
  reservationOrderId?: string;

  /**
   * Provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Represent benefit term in ISO 8601 format.
   */
  term?: Term;

  /**
   * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
   */
  billingPlan?: BillingPlan;

  /**
   * Type of the Applied Scope.
   */
  appliedScopeType?: AppliedScopeType;

  /**
   * Properties specific to applied scope type. Not required if not applicable.
   */
  appliedScopeProperties?: AppliedScopeProperties;

  /**
   * Total Quantity of the SKUs purchased in the Reservation.
   */
  quantity?: int32;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean;

  /**
   * The type of the resource that is being reserved.
   */
  reservedResourceType?: ReservedResourceType;

  /**
   * This is the date-time when the Reservation needs to be reviewed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  /**
   * Properties specific to each reserved resource type. Not required if not applicable.
   */
  reservedResourceProperties?: ReservationOrderAliasResponsePropertiesReservedResourceProperties;
}

/**
 * Properties specific to each reserved resource type. Not required if not applicable.
 */
model ReservationOrderAliasResponsePropertiesReservedResourceProperties {
  /**
   * Turning this on will apply the reservation discount to other VMs in the same VM size group.
   */
  instanceFlexibility?: InstanceFlexibility;
}

model PricingCurrencyTotal extends Price {
  /**
   * Represents either billing plan or savings plan term in ISO 8601 format.
   */
  duration?: PricingCurrencyDuration;
}

/**
 * Required if status == failed or status == canceled.
 */
model OperationResultError {
  /**
   * Required if status == failed or status == cancelled. If status == failed, provide an invariant error code used for error troubleshooting, aggregation, and analysis.
   */
  code?: string;

  /**
   * Required if status == failed. Localized. If status == failed, provide an actionable error message indicating what error occurred, and what the user can do to address the issue.
   */
  message?: string;
}

/**
 * billing information
 */
model BillingInformation {
  billingCurrencyTotalPaidAmount?: Price;
  billingCurrencyProratedAmount?: Price;
  billingCurrencyRemainingCommitmentAmount?: Price;
}
