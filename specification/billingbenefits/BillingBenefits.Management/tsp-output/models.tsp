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

@doc("Provisioning state")
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

@doc("Represent benefit term in ISO 8601 format.")
enum Term {
  P1Y,
  P3Y,
  P5Y,
}

@doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
enum BillingPlan {
  P1M,
}

@doc("Type of the Applied Scope.")
enum AppliedScopeType {
  Single,
  Shared,
  ManagementGroup,
}

@doc("Commitment grain.")
enum CommitmentGrain {
  Hourly,
}

@doc("Describes whether the payment is completed, failed, cancelled or scheduled in the future.")
enum PaymentStatus {
  Succeeded,
  Failed,
  Scheduled,
  Cancelled,
}

@doc("The type of the resource that is being reserved.")
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

@doc("Turning this on will apply the reservation discount to other VMs in the same VM size group.")
enum InstanceFlexibility {
  On,
  Off,
}

@doc("Represents either billing plan or savings plan term in ISO 8601 format.")
enum PricingCurrencyDuration {
  P1M,
  P1Y,
  P3Y,
}

@doc("The SKU to be applied for this resource")
model Sku {
  @doc("Name of the SKU to be applied")
  name?: string;
}

@doc("Savings plan properties")
model SavingsPlanOrderAliasProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Identifier of the savings plan created")
  @visibility("read")
  savingsPlanOrderId?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Commitment towards the benefit.")
  commitment?: Commitment;
}

@doc("Properties specific to applied scope type. Not required if not applicable.")
model AppliedScopeProperties {
  @doc("Tenant ID where the benefit is applied.")
  tenantId?: string;

  @doc("Fully-qualified identifier of the management group where the benefit must be applied.")
  managementGroupId?: string;

  @doc("Fully-qualified identifier of the subscription.")
  subscriptionId?: string;

  @doc("Fully-qualified identifier of the resource group.")
  resourceGroupId?: string;

  @doc("Display name")
  displayName?: string;
}

@doc("Commitment towards the benefit.")
model Commitment extends Price {
  @doc("Commitment grain.")
  grain?: CommitmentGrain;
}

model Price {
  @doc("The ISO 4217 3-letter currency code for the currency used by this purchase record.")
  currencyCode?: string;

  amount?: float32;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Savings plan order properties")
model SavingsPlanOrderModelProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.")
  @visibility("read")
  billingProfileId?: string;

  @doc("Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.")
  @visibility("read")
  customerId?: string;

  @doc("Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.")
  @visibility("read")
  billingAccountId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Expiry date time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  @doc("This is the DateTime when the savings plan benefit started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  @doc("Information describing the type of billing plan for this savings plan.")
  planInformation?: BillingPlanInformation;

  savingsPlans?: string[];

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;
}

@doc("Information describing the type of billing plan for this savings plan.")
model BillingPlanInformation {
  @doc("Amount of money to be paid for the Order. Tax is not included.")
  pricingCurrencyTotal?: Price;

  @doc("Date when the billing plan has started.")
  startDate?: plainDate;

  @doc("For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.")
  nextPaymentDueDate?: plainDate;

  transactions?: PaymentDetail[];
}

@doc("Information about payment related to a savings plan order.")
model PaymentDetail {
  @doc("Date when the payment needs to be done.")
  dueDate?: plainDate;

  @doc("Date when the transaction is completed. Is null when it is scheduled.")
  paymentDate?: plainDate;

  @doc("Amount in pricing currency. Tax not included.")
  pricingCurrencyTotal?: Price;

  @doc("Amount charged in Billing currency. Tax not included. Is null for future payments")
  billingCurrencyTotal?: Price;

  @doc("Describes whether the payment is completed, failed, cancelled or scheduled in the future.")
  status?: PaymentStatus;

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;

  @doc("Billing account")
  billingAccount?: string;
}

model ExtendedStatusInfo {
  @doc("Status code providing additional information.")
  statusCode?: string;

  @doc("The message giving detailed information about the status code.")
  message?: string;
}

@doc("Role assignment entity")
model RoleAssignmentEntity {
  @doc("Role assignment entity id")
  id?: string;

  @doc("Role assignment entity name")
  name?: string;

  @doc("Role assignment entity properties")
  properties?: RoleAssignmentEntityProperties;
}

@doc("Role assignment entity properties")
model RoleAssignmentEntityProperties {
  @doc("Principal Id")
  principalId?: string;

  @doc("Role definition id")
  roleDefinitionId?: string;

  @doc("Scope of the role assignment entity")
  scope?: string;
}

@doc("Savings plan properties")
model SavingsPlanModelProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The provisioning state of the savings plan for display, e.g. Succeeded")
  @visibility("read")
  displayProvisioningState?: string;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.")
  @visibility("read")
  billingProfileId?: string;

  @doc("Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.")
  @visibility("read")
  customerId?: string;

  @doc("Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.")
  @visibility("read")
  billingAccountId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("The applied scope type of the savings plan for display, e.g. Shared")
  @visibility("read")
  userFriendlyAppliedScopeType?: string;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Commitment towards the benefit.")
  commitment?: Commitment;

  @doc("DateTime of the savings plan starts providing benefit from.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  @doc("Expiry date time")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  @doc("Date time when the savings plan was purchased")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

  @doc("This is the DateTime when the savings plan benefit started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  @visibility("read")
  extendedStatusInfo?: ExtendedStatusInfo;

  @doc("Setting this to true will automatically purchase a new benefit on the expiration date time.")
  renew?: boolean;

  @doc("Savings plan utilization")
  @visibility("read")
  utilization?: Utilization;

  @doc("SavingsPlan Id of the SavingsPlan from which this SavingsPlan is renewed.")
  renewSource?: string;

  @doc("SavingsPlan Id of the SavingsPlan which is purchased because of renew.")
  renewDestination?: string;

  renewProperties?: RenewProperties;
}

@doc("Savings plan utilization")
model Utilization {
  @doc("The number of days trend for a savings plan")
  @visibility("read")
  trend?: string;

  @doc("The array of aggregates of a savings plan's utilization")
  aggregates?: UtilizationAggregates[];
}

@doc("The aggregate values of savings plan utilization")
model UtilizationAggregates {
  @doc("The grain of the aggregate")
  @visibility("read")
  grain?: float32;

  @doc("The grain unit of the aggregate")
  @visibility("read")
  grainUnit?: string;

  @doc("The aggregate value")
  @visibility("read")
  value?: float32;

  @doc("The aggregate value unit")
  @visibility("read")
  valueUnit?: string;
}

model RenewProperties {
  purchaseProperties?: PurchaseRequest;
}

model PurchaseRequest {
  @doc("The SKU to be applied for this resource")
  sku?: Sku;

  properties?: PurchaseRequestProperties;
}

model PurchaseRequestProperties {
  @doc("Friendly name of the savings plan")
  displayName?: string;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Commitment towards the benefit.")
  commitment?: Commitment;

  @doc("DateTime of the savings plan starts providing benefit from.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  @doc("Setting this to true will automatically purchase a new benefit on the expiration date time.")
  renew?: boolean;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;
}

@doc("Savings plans list summary")
model SavingsPlanSummary {
  @doc("This property has value 'summary'")
  @visibility("read")
  name?: string;

  @doc("The roll up count summary of savings plans in each state")
  value?: SavingsPlanSummaryCount;
}

@doc("The roll up count summary of savings plans in each state")
model SavingsPlanSummaryCount {
  @doc("The number of savings plans in Succeeded state")
  @visibility("read")
  succeededCount?: float32;

  @doc("The number of savings plans in Failed state")
  @visibility("read")
  failedCount?: float32;

  @doc("The number of savings plans in Expiring state")
  @visibility("read")
  expiringCount?: float32;

  @doc("The number of savings plans in Expired state")
  @visibility("read")
  expiredCount?: float32;

  @doc("The number of savings plans in Pending state")
  @visibility("read")
  pendingCount?: float32;

  @doc("The number of savings plans in Cancelled state")
  @visibility("read")
  cancelledCount?: float32;

  @doc("The number of savings plans in Processing state")
  @visibility("read")
  processingCount?: float32;

  @doc("The number of savings plans in No Benefit state")
  @visibility("read")
  noBenefitCount?: float32;

  @doc("The number of savings plans in Warning state")
  @visibility("read")
  warningCount?: float32;
}

@doc("Savings plan patch request")
model SavingsPlanUpdateRequest {
  @doc("Savings plan patch request")
  properties?: SavingsPlanUpdateRequestProperties;
}

@doc("Savings plan patch request")
model SavingsPlanUpdateRequestProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Setting this to true will automatically purchase a new benefit on the expiration date time.")
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

  @doc("Url to get the next page.")
  @nextLink
  nextLink?: string;
}

@doc("Benefit scope response property")
model SavingsPlanValidResponseProperty {
  @doc("Indicates if the provided input was valid")
  valid?: boolean;

  @doc("Failure reason code if the provided input was invalid")
  reasonCode?: string;

  @doc("Failure reason if the provided input was invalid")
  reason?: string;
}

model SavingsPlanPurchaseValidateRequest {
  benefits?: SavingsPlanOrderAliasModel[];
}

@doc("Reservation order alias")
model ReservationOrderAliasRequest extends Resource {
  @doc("Reservation order SKU")
  sku: Sku;

  @doc("The Azure Region where the reservation benefits are applied to.")
  location?: string;

  @doc("Reservation order alias request properties")
  properties?: ReservationOrderAliasRequestProperties;
}

@doc("Reservation properties")
model ReservationOrderAliasRequestProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Total Quantity of the SKUs purchased in the Reservation.")
  @minValue(1)
  quantity?: int32;

  @doc("Setting this to true will automatically purchase a new benefit on the expiration date time.")
  renew?: boolean;

  @doc("The type of the resource that is being reserved.")
  reservedResourceType?: ReservedResourceType;

  @doc("This is the date-time when the Azure Hybrid Benefit needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  @doc("Properties specific to each reserved resource type. Not required if not applicable.")
  reservedResourceProperties?: ReservationOrderAliasRequestPropertiesReservedResourceProperties;
}

@doc("Properties specific to each reserved resource type. Not required if not applicable.")
model ReservationOrderAliasRequestPropertiesReservedResourceProperties {
  @doc("Turning this on will apply the reservation discount to other VMs in the same VM size group.")
  instanceFlexibility?: InstanceFlexibility;
}

@doc("Reservation properties")
model ReservationOrderAliasResponseProperties {
  @doc("Display name")
  displayName?: string;

  @doc("Identifier of the reservation order created")
  @visibility("read")
  reservationOrderId?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Subscription that will be charged for purchasing the benefit")
  billingScopeId?: string;

  @doc("Represent benefit term in ISO 8601 format.")
  term?: Term;

  @doc("Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.")
  billingPlan?: BillingPlan;

  @doc("Type of the Applied Scope.")
  appliedScopeType?: AppliedScopeType;

  @doc("Properties specific to applied scope type. Not required if not applicable.")
  appliedScopeProperties?: AppliedScopeProperties;

  @doc("Total Quantity of the SKUs purchased in the Reservation.")
  quantity?: int32;

  @doc("Setting this to true will automatically purchase a new benefit on the expiration date time.")
  renew?: boolean;

  @doc("The type of the resource that is being reserved.")
  reservedResourceType?: ReservedResourceType;

  @doc("This is the date-time when the Reservation needs to be reviewed.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  reviewDateTime?: utcDateTime;

  @doc("Properties specific to each reserved resource type. Not required if not applicable.")
  reservedResourceProperties?: ReservationOrderAliasResponsePropertiesReservedResourceProperties;
}

@doc("Properties specific to each reserved resource type. Not required if not applicable.")
model ReservationOrderAliasResponsePropertiesReservedResourceProperties {
  @doc("Turning this on will apply the reservation discount to other VMs in the same VM size group.")
  instanceFlexibility?: InstanceFlexibility;
}

model PricingCurrencyTotal extends Price {
  @doc("Represents either billing plan or savings plan term in ISO 8601 format.")
  duration?: PricingCurrencyDuration;
}

@doc("Required if status == failed or status == canceled.")
model OperationResultError {
  @doc("Required if status == failed or status == cancelled. If status == failed, provide an invariant error code used for error troubleshooting, aggregation, and analysis.")
  code?: string;

  @doc("Required if status == failed. Localized. If status == failed, provide an actionable error message indicating what error occurred, and what the user can do to address the issue.")
  message?: string;
}

@doc("billing information")
model BillingInformation {
  billingCurrencyTotalPaidAmount?: Price;
  billingCurrencyProratedAmount?: Price;
  billingCurrencyRemainingCommitmentAmount?: Price;
}
