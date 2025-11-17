import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.BillingBenefits;

/**
 * Represents the result of listing savings plan models
 */
model SavingsPlanModelListResult {
  /**
   * The list of savings plans.
   */
  @pageItems
  @visibility(Lifecycle.Read)
  value?: SavingsPlanModel[];

  /**
   * Url to get the next page.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;

  /**
   * The roll out count summary of the savings plans
   */
  @visibility(Lifecycle.Read)
  additionalProperties?: SavingsPlanSummary[];
}

/**
 * Provisioning state
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingBilling: "PendingBilling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfirmedBilling: "ConfirmedBilling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Represent benefit term in ISO 8601 format.
 */
union Term {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1Y: "P1Y",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P3Y: "P3Y",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P5Y: "P5Y",
}

/**
 * Represents the billing plan in ISO 8601 format. Required only for monthly billing plans.
 */
union BillingPlan {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1M: "P1M",
}

/**
 * Type of the Applied Scope.
 */
union AppliedScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Single: "Single",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Shared: "Shared",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagementGroup: "ManagementGroup",
}

/**
 * Commitment grain.
 */
union CommitmentGrain {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hourly: "Hourly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FullTerm: "FullTerm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * Describes whether the payment is completed, failed, cancelled or scheduled in the future.
 */
union PaymentStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cancelled: "Cancelled",
}

/**
 * The type of the resource that is being reserved.
 */
union ReservedResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualMachines: "VirtualMachines",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlDatabases: "SqlDatabases",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SuseLinux: "SuseLinux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CosmosDb: "CosmosDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RedHat: "RedHat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlDataWarehouse: "SqlDataWarehouse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMwareCloudSimple: "VMwareCloudSimple",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RedHatOsa: "RedHatOsa",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AppService: "AppService",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedDisk: "ManagedDisk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BlockBlob: "BlockBlob",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RedisCache: "RedisCache",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureDataExplorer: "AzureDataExplorer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MySql: "MySql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MariaDb: "MariaDb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostgreSql: "PostgreSql",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DedicatedHost: "DedicatedHost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SapHana: "SapHana",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlAzureHybridBenefit: "SqlAzureHybridBenefit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AVS: "AVS",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DataFactory: "DataFactory",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NetAppStorage: "NetAppStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureFiles: "AzureFiles",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SqlEdge: "SqlEdge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VirtualMachineSoftware: "VirtualMachineSoftware",
}

/**
 * Turning this on will apply the reservation discount to other VMs in the same VM size group.
 */
union InstanceFlexibility {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Off: "Off",
}

/**
 * This defines whether the entity being created is primary or affiliate. Supported values: primary, affiliate. Validation: Required, must match one of the 2 values.
 */
union DiscountEntityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Affiliate: "Affiliate",
}

/**
 * Provisioning states of Discount.
 */
union DiscountProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * Represents the current status of the discount.
 */
union DiscountStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
}

/**
 * List of applied scopes supported for discounts.
 */
union DiscountAppliedScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingAccount: "BillingAccount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BillingProfile: "BillingProfile",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Customer: "Customer",
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * Represents either billing plan or savings plan term in ISO 8601 format.
 */
union PricingCurrencyDuration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1M: "P1M",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1Y: "P1Y",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P3Y: "P3Y",
}

/**
 * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
 */
union DiscountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProductFamily: "ProductFamily",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Product: "Product",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Sku: "Sku",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CustomPrice: "CustomPrice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CustomPriceMultiCurrency: "CustomPriceMultiCurrency",
}

/**
 * The customer action on which the discount is applied. Supported values are Purchase, Consume, and Renew. Validation: Required, one of supported values.
 */
union ApplyDiscountOn {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Purchase: "Purchase",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Consume: "Consume",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Renew: "Renew",
}

/**
 * The discount combination rule when there are multiple applicable custom prices. Validation: Required. Supported values are Stackable and BestOf.
 */
union DiscountCombinationRule {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BestOf: "BestOf",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stackable: "Stackable",
}

/**
 * Supported values: Protected, Locked
 */
union PricingPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Protected: "Protected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Locked: "Locked",
}

/**
 * The type of the priceable node pricing rule. Validation: Required. Supported values are fixedPriceLock, fixedListPrice, and priceCeiling.
 */
union DiscountRuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FixedPriceLock: "FixedPriceLock",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  FixedListPrice: "FixedListPrice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PriceCeiling: "PriceCeiling",
}

/**
 * Provisioning sub state of Discount.
 */
union DiscountProvisioningSubState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Expired: "Expired",
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
  @visibility(Lifecycle.Read)
  savingsPlanOrderId?: string;

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
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

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean = false;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Commitment extends Price {
  /**
   * Commitment grain.
   */
  grain?: CommitmentGrain;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Price {
  /**
   * The ISO 4217 3-letter currency code for the currency used by this purchase record.
   */
  currencyCode?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  amount?: float64;
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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility(Lifecycle.Read)
  customerId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/customers";
    }
  ]>;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

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
  @visibility(Lifecycle.Read)
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  savingsPlans?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
  @encode(DateTimeKnownEncoding.rfc7231)
  startDate?: utcDateTime;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  nextPaymentDueDate?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  transactions?: PaymentDetail[];
}

/**
 * Information about payment related to a savings plan order.
 */
model PaymentDetail {
  /**
   * Date when the payment needs to be done.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  dueDate?: utcDateTime;

  /**
   * Date when the transaction is completed. Is null when it is scheduled.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  paymentDate?: utcDateTime;

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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Billing account
   */
  billingAccount?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanOrderModelList is Azure.Core.Page<SavingsPlanOrderModel>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanModelList is Azure.Core.Page<SavingsPlanModel>;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The provisioning state of the savings plan for display, e.g. Succeeded
   */
  @visibility(Lifecycle.Read)
  displayProvisioningState?: string;

  /**
   * Subscription that will be charged for purchasing the benefit
   */
  billingScopeId?: string;

  /**
   * Fully-qualified identifier of the billing profile where the savings plan is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
      scopes: ["Tenant"];
    }
  ]>;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers.
   */
  @visibility(Lifecycle.Read)
  customerId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/customers";
    }
  ]>;

  /**
   * Fully-qualified identifier of the billing account where the savings plan is applied. Present only for Enterprise Agreement customers.
   */
  @visibility(Lifecycle.Read)
  billingAccountId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * Expiry date time
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryDateTime?: utcDateTime;

  /**
   * Date time when the savings plan was purchased
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  purchaseDateTime?: utcDateTime;

  /**
   * This is the DateTime when the savings plan benefit started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  benefitStartTime?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  extendedStatusInfo?: ExtendedStatusInfo;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean = false;

  /**
   * Savings plan utilization
   */
  @visibility(Lifecycle.Read)
  utilization?: Utilization;

  /**
   * SavingsPlan Id of the SavingsPlan from which this SavingsPlan is renewed.
   */
  renewSource?: string;

  /**
   * SavingsPlan Id of the SavingsPlan which is purchased because of renew.
   */
  renewDestination?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renewProperties?: RenewProperties;
}

/**
 * Savings plan utilization
 */
model Utilization {
  /**
   * The number of days trend for a savings plan
   */
  @visibility(Lifecycle.Read)
  trend?: string;

  /**
   * The array of aggregates of a savings plan's utilization
   */
  @identifiers(#[])
  aggregates?: UtilizationAggregates[];
}

/**
 * The aggregate values of savings plan utilization
 */
model UtilizationAggregates {
  /**
   * The grain of the aggregate
   */
  @visibility(Lifecycle.Read)
  grain?: float32;

  /**
   * The grain unit of the aggregate
   */
  @visibility(Lifecycle.Read)
  grainUnit?: string;

  /**
   * The aggregate value
   */
  @visibility(Lifecycle.Read)
  value?: float32;

  /**
   * The aggregate value unit
   */
  @visibility(Lifecycle.Read)
  valueUnit?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RenewProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  purchaseProperties?: PurchaseRequest;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceSku {
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PurchaseRequest {
  /**
   * The SKU to be applied for this resource
   */
  sku?: ResourceSku;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: PurchaseRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveDateTime?: utcDateTime;

  /**
   * Setting this to true will automatically purchase a new benefit on the expiration date time.
   */
  renew?: boolean = false;

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  succeededCount?: float32;

  /**
   * The number of savings plans in Failed state
   */
  @visibility(Lifecycle.Read)
  failedCount?: float32;

  /**
   * The number of savings plans in Expiring state
   */
  @visibility(Lifecycle.Read)
  expiringCount?: float32;

  /**
   * The number of savings plans in Expired state
   */
  @visibility(Lifecycle.Read)
  expiredCount?: float32;

  /**
   * The number of savings plans in Pending state
   */
  @visibility(Lifecycle.Read)
  pendingCount?: float32;

  /**
   * The number of savings plans in Cancelled state
   */
  @visibility(Lifecycle.Read)
  cancelledCount?: float32;

  /**
   * The number of savings plans in Processing state
   */
  @visibility(Lifecycle.Read)
  processingCount?: float32;

  /**
   * The number of savings plans in No Benefit state
   */
  @visibility(Lifecycle.Read)
  noBenefitCount?: float32;

  /**
   * The number of savings plans in Warning state
   */
  @visibility(Lifecycle.Read)
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
  renew?: boolean = false;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  renewProperties?: RenewProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanUpdateValidateRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  benefits?: SavingsPlanUpdateRequestProperties[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanValidateResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  benefits?: SavingsPlanValidResponseProperty[];

  /**
   * Url to get the next page.
   */
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SavingsPlanPurchaseValidateRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  benefits?: SavingsPlanOrderAliasModel[];
}

/**
 * Reservation order alias
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReservationOrderAliasRequest
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Reservation order SKU
   */
  sku: ResourceSku;

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
  renew?: boolean = false;

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
  @visibility(Lifecycle.Read)
  reservationOrderId?: string;

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
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
  renew?: boolean = false;

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

/**
 * Properties belonging to discounts.
 */
@discriminator("entityType")
model DiscountProperties {
  /**
   * This defines whether the entity being created is primary or affiliate. Supported values: primary, affiliate. Validation: Required, must match one of the 2 values.
   */
  entityType: DiscountEntityType;

  /**
   * This is the catalog UPN for the product.
   */
  productCode: string;

  /**
   * Start date of the discount. Value is the date the discount started or will start in the future.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt: utcDateTime;

  /**
   * This is the globally unique identifier of the Discount which will not change for the lifetime of the Discount.
   */
  systemId?: string;

  /**
   * The state of the resource. Supported values are Pending, Failed, Succeeded, Canceled.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DiscountProvisioningState;

  /**
   * Billing account resource id where the discount metadata is present.
   */
  @visibility(Lifecycle.Read)
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
      scopes: ["Tenant"];
    }
  ]>;

  /**
   * Billing profile resource id where the discount is scoped to.
   */
  @visibility(Lifecycle.Read)
  billingProfileResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
      scopes: ["Tenant"];
    }
  ]>;

  /**
   * Customer resource id where the discount is scoped to.
   */
  @visibility(Lifecycle.Read)
  customerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts/customers";
      scopes: ["Tenant"];
    }
  ]>;

  /**
   * This defines a user friendly display name for the discount.
   */
  displayName?: string;

  /**
   * Represents the current status of the discount.
   */
  @visibility(Lifecycle.Read)
  status?: DiscountStatus;

  /**
   * Fully-qualified identifier of the benefit under applicable benefit list.
   */
  @visibility(Lifecycle.Read)
  benefitResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/discounts";
      scopes: ["ResourceGroup"];
    }
  ]>;

  /**
   * List of applied scopes supported for discounts.
   */
  appliedScopeType?: DiscountAppliedScopeType;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ManagedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
   */
  type: ManagedServiceIdentityType;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. E.g. P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * Plan for the resource.
 */
model Plan {
  /**
   * A user defined name of the 3rd Party Artifact that is being procured.
   */
  name: string;

  /**
   * The publisher of the 3rd Party Artifact that is being bought. E.g. NewRelic
   */
  publisher: string;

  /**
   * The 3rd Party artifact that is being procured. E.g. NewRelic. Product maps to the OfferID specified for the artifact at the time of Data Market onboarding.
   */
  product: string;

  /**
   * A publisher provided promotion code as provisioned in Data Market for the said product/artifact.
   */
  promotionCode?: string;

  /**
   * The version of the desired product/artifact.
   */
  version?: string;
}

/**
 * Discounts patch request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiscountPatchRequest {
  /**
   * Discounts patch request properties
   */
  properties?: DiscountPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Discounts patch request properties
 */
model DiscountPatchRequestProperties {
  /**
   * Display name
   */
  displayName?: string;
}

/**
 * Discount list
 */
model DiscountList is Azure.Core.Page<Discount>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  billingCurrencyTotalPaidAmount?: Price;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  billingCurrencyProratedAmount?: Price;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  billingCurrencyRemainingCommitmentAmount?: Price;
}

/**
 * Entity type for affiliate discounts
 */
model EntityTypeAffiliateDiscount extends DiscountProperties {
  /**
   * This will be present in the response if the primary has a resource ID
   */
  @visibility(Lifecycle.Read)
  primaryResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/discounts";
      scopes: ["ResourceGroup"];
    }
  ]>;

  /**
   * End date of the discount. No duration will be supported. Allowed value is any date greater than or equal to startDate.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * This defines whether the entity being created is primary or affiliate. Supported values: primary, affiliate. Validation: Required, must match one of the 2 values.
   */
  entityType: "Affiliate";
}

/**
 * Entity type for primary discounts
 */
model EntityTypePrimaryDiscount extends DiscountProperties {
  /**
   * This defines the conditions for a given discount type.
   */
  discountTypeProperties?: DiscountTypeProperties;

  /**
   * End date of the discount. No duration will be supported. Allowed value is any date greater than or equal to startDate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt: utcDateTime;

  /**
   * This defines whether the entity being created is primary or affiliate. Supported values: primary, affiliate. Validation: Required, must match one of the 2 values.
   */
  entityType: "Primary";
}

/**
 * This defines the conditions for a given discount type.
 */
@discriminator("discountType")
model DiscountTypeProperties {
  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: DiscountType;

  /**
   * The customer action on which the discount is applied. Supported values are Purchase, Consume, and Renew. Validation: Required, one of supported values.
   */
  applyDiscountOn: ApplyDiscountOn;

  /**
   * Discount percentage provided for the customer. Validation: Required unless this is a price rule.
   */
  @maxValue(100)
  @minValue(0)
  discountPercentage?: float64;

  /**
   * The discount combination rule when there are multiple applicable custom prices. Validation: Required. Supported values are Stackable and BestOf.
   */
  discountCombinationRule?: DiscountCombinationRule;

  /**
   * Set only in price guarantee scenario.
   */
  priceGuaranteeProperties?: PriceGuaranteeProperties;

  /**
   * Array of conditions for the discount. Validation: Optional. Maximum length is 1000.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conditions?: ConditionsItem[];
}

/**
 * Set only in price guarantee scenario.
 */
model PriceGuaranteeProperties {
  /**
   * Supported values: Protected, Locked
   */
  pricingPolicy?: PricingPolicy;

  /**
   * The date on which prices are to be used for guarantee calculation. Validation: expected to be 00 hours, Format: 2024-09-30T00:00:00Z. Must be in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  priceGuaranteeDate?: utcDateTime;
}

/**
 * Condition for a discount.
 */
model ConditionsItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  conditionName?: string;

  /**
   * These items are open-ended strings.
   */
  value?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: string;
}

/**
 * Discount type properties including product family name
 */
model DiscountTypeProductFamily extends DiscountTypeProperties {
  /**
   * Product family for which the discount is given. Validation: Optional
   */
  productFamilyName?: string;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: "ProductFamily";
}

/**
 * Discount type properties including product family name and product id.
 */
model DiscountTypeProduct extends DiscountTypeProperties {
  /**
   * Product family for which the discount is given. Validation: Optional
   */
  productFamilyName?: string;

  /**
   * Product ID for which the discount is given. Validation: Optional. No specific format, example: DZH318Z09V6F
   */
  productId?: string;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: "Product";
}

/**
 * Discount type properties including product family name, product id, and sku id.
 */
model DiscountTypeProductSku extends DiscountTypeProperties {
  /**
   * Product family for which the discount is given. Validation: Optional
   */
  productFamilyName?: string;

  /**
   * Product ID for which the discount is given. Validation: Optional. No specific format, example: DZH318Z09V6F
   */
  productId?: string;

  /**
   * ResourceSku for the given discount. Validation: Optional.
   */
  skuId?: string;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: "Sku";
}

alias DiscountCommonProperties = {
  /**
   * Product family for which the discount is given. Validation: Optional
   */
  productFamilyName?: string;

  /**
   * Product ID for which the discount is given. Validation: Optional. No specific format, example: DZH318Z09V6F
   */
  productId?: string;

  /**
   * ResourceSku for the given discount. Validation: Optional.
   */
  skuId?: string;

  /**
   * Custom price properties for a given discount.
   */
  customPriceProperties?: CustomPriceProperties;
};

/**
 * Discount type properties including product family name, product id, sku, and custom price properties. Allows a single entry in marketSetPrices.
 */
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiscountTypeCustomPrice extends DiscountTypeProperties {
  ...DiscountCommonProperties;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: DiscountType.CustomPrice;
}

/**
 * Custom price properties for a given discount.
 */
model CustomPriceProperties {
  /**
   * The type of the priceable node pricing rule. Validation: Required. Supported values are fixedPriceLock, fixedListPrice, and priceCeiling.
   */
  ruleType: DiscountRuleType;

  /**
   * The catalog instance where the priceable node lives. Validation: Required. No defined format, will vary per team.
   */
  catalogId: string;

  /**
   * The set of BigCat claims. Validation: Required. Must contain AgreementType, NationalCloud, and PricingAudience claims. Additionally requires AccessPass claim when creating custom price with action == consume on the pricing instructions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  catalogClaims: CatalogClaimsItem[];

  /**
   * The term units for the priceable node. Validation: Optional, Maximum length 128 characters. Must be present if and only if the availability derived by market, product, sku, and claims has terms.
   */
  termUnits?: string;

  /**
   * The billing period of the priceable node. Validation: Optional, Maximum length 128 characters. Only allowed if the availability derived by market, product, sku, and claims has terms and at least one of those terms has a billing period. When specified, termUnits must be specified.
   */
  billingPeriod?: string;

  /**
   * Must be present if the market, product, sku, and claims, and optional term information resolves to multiple availabilities that only differ by meter type. Validation: Maximum length 128 characters.
   */
  meterType?: string;

  /**
   * The set of market set prices of the priceable node. Validation: Required. Must contain at least one element.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  marketSetPrices: MarketSetPricesItems[];
}

/**
 * Catalog claim for a discount.
 */
model CatalogClaimsItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  catalogClaimsItemType?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: string;
}

/**
 * Items in the MarketSetPrices array.
 */
model MarketSetPricesItems {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  markets: string[];

  /**
   * The locked price for the priceable node. Validation: Required. Must be greater than or equal to 0. If the case of billing plans. This represents the price for each cycle charge.
   */
  value: float32;

  /**
   * The currency of the locked price value. Validation: Required. Must be a valid ISO 4217 3-letter currency code.
   */
  currency: string;
}

/**
 * Discount type properties including product family name, product id, sku, and custom price properties. Allows multiple entries in marketSetPrices.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-multiple-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DiscountTypeCustomPrice)
model DiscountTypeCustomPriceMultiCurrency extends DiscountTypeProperties {
  ...DiscountCommonProperties;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: DiscountType.CustomPriceMultiCurrency;
}

/**
 * Applied discount
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AppliedDiscount extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Discount properties
   */
  properties?: DiscountProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ExpandParameter {
  /**
   * The expand query parameter.
   */
  @query("$expand")
  $expand?: string;
}
