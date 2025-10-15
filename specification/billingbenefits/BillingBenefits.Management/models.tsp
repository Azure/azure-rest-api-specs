import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@removed(Versions.v2025_05_01_preview)
model SavingsPlanPurchaseValidateRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  benefits?: SavingsPlanOrderAliasModel[];
}

/**
 * Savings plan validate model
 */
@added(Versions.v2025_05_01_preview)
model SavingsPlanValidateModel extends BenefitValidateModel {
  ...SavingsPlanOrderAliasModel;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "SavingsPlan";
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
@added(Versions.v2025_05_01_preview)
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
@added(Versions.v2025_05_01_preview)
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * The type of identity that created the resource.
 */
@added(Versions.v2025_05_01_preview)
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Represents benefit model type for validation.
 */
@added(Versions.v2025_05_01_preview)
union BenefitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SavingsPlan: "SavingsPlan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MACC: "MACC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConditionalCredits: "ConditionalCredits",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Credits: "Credits",
}

/**
 * Abstract benefit model to validate.
 */
@added(Versions.v2025_05_01_preview)
@discriminator("benefitType")
model BenefitValidateModel {
  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: BenefitType;
}

/**
 * Request to validate any benefit.
 */
@added(Versions.v2025_05_01_preview)
model BenefitValidateRequest {
  /**
   * Defines benefits for validation.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  benefits?: BenefitValidateModel[];
}

/**
 * Benefit validate response.
 */
@added(Versions.v2025_05_01_preview)
model BenefitValidateResponse {
  /**
   * Defines benefit validation response for benefits.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  benefits?: BenefitValidateResponseProperty[];

  /**
   * Url to get the next page.
   */
  nextLink?: string;
}

/**
 * Benefit validate response property
 */
@added(Versions.v2025_05_01_preview)
model BenefitValidateResponseProperty {
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

  /**
   * Resource identifier of the benefit that was validated.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/*";
    }
  ]>;
}

// ===================================================================
// MACC (Microsoft Azure Consumption Commitment) MODELS - Added in 2025-05-01-preview
// ===================================================================

/**
 * Represents the current status of the MACC.
 */
@added(Versions.v2025_05_01_preview)
union MaccStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallCharged: "ShortfallCharged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallWaived: "ShortfallWaived",
}

/**
 * Provisioning states of MACC.
 */
@added(Versions.v2025_05_01_preview)
union MaccProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallPending: "ShortfallPending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallCharged: "ShortfallCharged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallWaived: "ShortfallWaived",
}

/**
 * Represents type of the object being operated on. Possible values are primary or contributor.
 */
@added(Versions.v2025_05_01_preview)
union MaccEntityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contributor: "Contributor",
}

/**
 * Represents the enablement status of a feature or settings.
 */
@added(Versions.v2025_05_01_preview)
union EnablementMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Represents the current status of the Milestone.
 */
@added(Versions.v2025_05_01_preview)
union MaccMilestoneStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Removed: "Removed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallCharged: "ShortfallCharged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ShortfallWaived: "ShortfallWaived",
}

/**
 * MACC properties
 */
@added(Versions.v2025_05_01_preview)
model MaccModelProperties {
  /**
   * Provisioning state of MACC as assigned by RPaaS. This indicates the last operation's status. For all practical purposes, this can be ignored. For current status of MACC resource, refer to MaccStatus.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MaccProvisioningState;

  /**
   * Represents the current status of the MACC.
   */
  status?: MaccStatus;

  /**
   * Represents type of the object being operated on. Possible values are primary or contributor.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  entityType: MaccEntityType;

  /**
   * Display name
   */
  displayName?: string;

  /**
   * Represents catalog UPN.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productCode?: string;

  /**
   * Fully-qualified identifier of the billing account where the MACC is applied. Present only for Enterprise Agreement customers. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}
   */
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * Must be start of month. Timestamp must be in the ISO date format YYYY-MM-DDT00:00:00Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * Must be end of month. Timestamp must be in the ISO date format YYYY-MM-DDT23:59:59Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * This is the globally unique identifier of the MACC which will not change for the lifetime of the MACC.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  systemId?: string;

  /**
   * Setting this to 'Enable' enables automatic shortfall charging when commitment is not met.
   */
  automaticShortfall?: EnablementMode;

  /**
   * Optional field to record suppression reason for automatic shortfall.
   */
  automaticShortfallSuppressReason?: AutomaticShortfallSuppressReason;

  /**
   * MACC shortfall
   */
  shortfall?: Shortfall;

  /**
   * List of milestones associated with this MACC.
   */
  @OpenAPI.extension("x-ms-identifiers", #["milestoneId"])
  milestones?: MaccMilestone[];

  /**
   * This is the resource identifier of either the primary MACC or the contributor. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Setting this to true means multi-entity.
   */
  allowContributors?: boolean;

  /**
   * Fully-qualified resource identifier of the primary MACC. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Fully-qualified billing account resource identifier of the primary MACC. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}.
   */
  primaryBillingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;
}

/**
 * Optional field to record suppression reason for automatic shortfall.
 */
@added(Versions.v2025_05_01_preview)
model AutomaticShortfallSuppressReason {
  /**
   * Code for the suppression reason.
   */
  code?: string;

  /**
   * Message for suppression reason.
   */
  message?: string;
}

/**
 * MACC shortfall
 */
@added(Versions.v2025_05_01_preview)
model Shortfall {
  /**
   * Represents catalog UPN.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productCode?: string;

  /**
   * Shortfall amount with grain.
   */
  charge?: Commitment;

  /**
   * Start DateTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Fully-qualified resource identifier of the credits associated with the shortfall.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Points to BalanceVersion document that indicates the remaining commitment balance when the credit was created.
   */
  balanceVersion?: float32;

  /**
   * This is an identifier of the shortfall which will not change for its lifetime.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  systemId?: string;
}

/**
 * MACC milestone represents interim targets within the period of MACC.
 */
@added(Versions.v2025_05_01_preview)
model MaccMilestone {
  /**
   * Globally unique identifier for the milestone. Format: {guid}
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  milestoneId?: string;

  /**
   * Commitment associated with this milestone.
   */
  commitment?: Price;

  /**
   * End date time for the milestone. Timestamp must be in the ISO date format YYYY-MM-DDT23:59:59Z.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Setting this to 'Enable' enables automatic shortfall invoicing when milestone commitment is not met.
   */
  automaticShortfall?: EnablementMode;

  /**
   * Optional field to record suppression reason for automatic shortfall.
   */
  automaticShortfallSuppressReason?: AutomaticShortfallSuppressReason;

  /**
   * Represents the current status of the Milestone.
   */
  status?: MaccMilestoneStatus;

  /**
   * Details of the shortfall associated with this milestone.
   */
  shortfall?: Shortfall;
}

/**
 * Macc patch request
 */
@added(Versions.v2025_05_01_preview)
model MaccPatchRequest {
  /**
   * Macc patch request properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MaccPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Macc patch request properties
 */
@added(Versions.v2025_05_01_preview)
model MaccPatchRequestProperties {
  /**
   * Commitment towards the benefit.
   */
  commitment?: Commitment;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Setting this to true means multi-entity.
   */
  allowContributors?: boolean;

  /**
   * Represents the enablement status of a feature or settings.
   */
  automaticShortfall?: EnablementMode;

  /**
   * Optional field to record suppression reason for automatic shortfall.
   */
  automaticShortfallSuppressReason?: AutomaticShortfallSuppressReason;

  /**
   * Display name
   */
  displayName?: string;

  /**
   * Represents the current status of the Milestone.
   */
  status?: MaccMilestoneStatus;

  /**
   * List of milestones to update or add.
   */
  @OpenAPI.extension("x-ms-identifiers", #["milestoneId"])
  milestones?: MaccMilestone[];

  /**
   * Fully-qualified resource identifier of the primary MACC. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Fully-qualified billing account resource identifier of the primary MACC. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}.
   */
  primaryBillingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;
}

/**
 * MACC list
 */
@added(Versions.v2025_05_01_preview)
model MaccList is Azure.Core.Page<Macc>;

/**
 * MACC validate model
 */
@added(Versions.v2025_05_01_preview)
model MaccValidateModel extends BenefitValidateModel {
  /**
   * MACC validate properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MaccModelProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "MACC";
}

/**
 * Contributor list
 */
@added(Versions.v2025_05_01_preview)
model ContributorList is Azure.Core.Page<Contributor>;

/**
 * List MACCs under a billing account
 */
@added(Versions.v2025_05_01_preview)
model SellerResourceListRequest {
  /**
   * Request properties to list maccs under a billing account
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: SellerResourceListRequestProperties;
}

/**
 * Request properties to list maccs under a billing account
 */
@added(Versions.v2025_05_01_preview)
model SellerResourceListRequestProperties {
  /**
   * Fully-qualified billing account resource identifier where the benefit is applied. Present only for Enterprise Agreement customers.
   */
  billingAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * This is an OData expresssion to filter the list of MACCs based on the properties of MACC passed in the filter.
   */
  $filter?: string;

  /**
   * Setting it to true will return the list of contributors associated with the MACC.
   */
  contributors?: boolean;

  /**
   * Setting it to true will return the list of milestones associated with the MACC.
   */
  milestones?: boolean;

  /**
   * Fully-qualified resource identifier of the primary MACC. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Applicable MACC list
 */
@added(Versions.v2025_05_01_preview)
model ApplicableMaccList is Azure.Core.Page<ApplicableMacc>;

/**
 * Applicable MACC.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@added(Versions.v2025_05_01_preview)
model ApplicableMacc extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Applicable MACC properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MaccModelProperties;
}

/**
 * Applicable Contributor list
 */
@added(Versions.v2025_05_01_preview)
model ApplicableContributorList is Azure.Core.Page<ApplicableContributor>;

/**
 * Applicable Contributor.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@added(Versions.v2025_05_01_preview)
model ApplicableContributor
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Applicable Contributor properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: MaccModelProperties;
}

// ===================================================================
// CREDITS MODELS - Added in 2025-05-01-preview
// ===================================================================

/**
 * Properties of a credit
 */
@added(Versions.v2025_05_01_preview)
model CreditProperties {
  /**
   * Status of the credit
   */
  status?: CreditStatus;

  /**
   * Product UPN for the credit type
   */
  productCode?: string;

  /**
   * The reason for the credit. Not required if not applicable.
   */
  reason?: CreditReason;

  /**
   * The entire investment amount for the credit contract, including currency and amount
   */
  credit?: Commitment;

  /**
   * Start DateTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Credit breakdown item representing a milestone, line-item, or no-charge service
   */
  policies?: CreditPolicies;

  /**
   * Fully-qualified identifier of the billing account where the benefit is applied. Present only for Enterprise Agreement customers.
   */
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Fully-qualified identifier of the billing profile where the benefit is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Credit line-items/milestones/no-charge services breakdown
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  breakdown?: CreditBreakdownItem[];

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * System identifier
   */
  systemId?: string;

  /**
   * Fully-qualified identifier of the customer where the savings plan is applied. Present only for Partner-led customers. Format is /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}
   */
  @visibility(Lifecycle.Read)
  customerId?: string;

  /**
   * Fully-qualified resource identifier of the resource. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/{benefitType}/{benefitName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Status of the credit
 */
@added(Versions.v2025_05_01_preview)
union CreditStatus {
  string,

  /**
   * Credit status is unknown
   */
  Unknown: "Unknown",

  /**
   * Credit is pending activation
   */
  Pending: "Pending",

  /**
   * Credit is active and available for use
   */
  Active: "Active",

  /**
   * Credit operation succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Credit has been cancelled
   */
  Canceled: "Canceled",

  /**
   * Credit operation failed
   */
  Failed: "Failed",

  /**
   * Credit has expired
   */
  Expired: "Expired",

  /**
   * Credit has been fully consumed
   */
  Exhausted: "Exhausted",

  /**
   * Credit application has not started yet
   */
  NotStarted: "NotStarted",
}

/**
 * Expiration policy of the Credit
 */
@added(Versions.v2025_05_01_preview)
union CreditExpirationPolicy {
  string,

  /**
   * No policy applied to the expiration of this credit
   */
  None: "None",

  /**
   * Billing profile is suspended when the credit expires
   */
  SuspendBillingProfile: "SuspendBillingProfile",
}

/**
 * The reason for the credit. Not required if not applicable.
 */
@added(Versions.v2025_05_01_preview)
model CreditReason {
  /**
   * The reason code for credit.
   */
  @visibility(Lifecycle.Read)
  code?: float32;

  /**
   * The free string description of the credit.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Credit breakdown item representing a milestone, line-item, or no-charge service
 */
@added(Versions.v2025_05_01_preview)
model CreditPolicies {
  /**
   * Redemption policy of the Credit
   */
  redemption?: CreditRedemptionPolicy;

  /**
   * Expiration policy of the Credit
   */
  expiration?: CreditExpirationPolicy;
}

/**
 * Redemption policy of the Credit
 */
@added(Versions.v2025_05_01_preview)
union CreditRedemptionPolicy {
  string,

  /**
   * Redemption policy is not applicable for this credit
   */
  NotApplicable: "NotApplicable",

  /**
   * Credit is automatically redeemed
   */
  AutoRedeem: "AutoRedeem",

  /**
   * Credit is manually redeemed
   */
  ManualRedeem: "ManualRedeem",
}

/**
 * Credit breakdown item representing a milestone, line-item, or no-charge service
 */
@added(Versions.v2025_05_01_preview)
model CreditBreakdownItem {
  /**
   * Allocation details including currency and amount for this breakdown item
   */
  allocation?: Commitment;

  /**
   * Start DateTime.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Key-value pairs for additional parameters and metadata
   */
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  dimensions?: CreditDimension[];
}

/**
 * Key-value pair for additional credit parameters and metadata
 */
@added(Versions.v2025_05_01_preview)
model CreditDimension {
  /**
   * The dimension key (e.g., productFamily, description, creditType)
   */
  key?: string;

  /**
   * The dimension value
   */
  value?: string;
}

/**
 * Credit patch request
 */
@added(Versions.v2025_05_01_preview)
model CreditPatchRequest {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Credit patch properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CreditPatchProperties;
}

/**
 * Credit patch properties
 */
@added(Versions.v2025_05_01_preview)
model CreditPatchProperties {
  /**
   * The entire investment amount for the credit contract, including currency and amount. Only amount can be modified.
   */
  credit?: Commitment;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Credit line-items/milestones/no-charge services breakdown. Entire breakdown will be replaced in a PATCH operation.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  breakdown?: CreditBreakdownItem[];
}

/**
 * List of credits
 */
@added(Versions.v2025_05_01_preview)
model CreditsList is Azure.Core.Page<Credit>;

/**
 * Properties of a credit source
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@added(Versions.v2025_05_01_preview)
model CreditSourceProperties {
  /**
   * Status of the credit
   */
  status?: CreditStatus;

  /**
   * The uri of the resource impacted which lead to the grant of the credit.
   */
  sourceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/credits";
    }
  ]>;

  /**
   * The billing period of the impact for the resource. Format YYYYMM
   */
  impactedBillingPeriod?: string;

  /**
   * Commitment towards the benefit.
   */
  credit?: Commitment;
}

/**
 * Credit patch request
 */
@added(Versions.v2025_05_01_preview)
model CreditSourcePatchRequest {
  /**
   * Resource Tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * List of credit sources
 */
@added(Versions.v2025_05_01_preview)
model CreditSourcesList is Azure.Core.Page<CreditSource>;

/**
 * Credits validate model
 */
@added(Versions.v2025_05_01_preview)
model CreditsValidateModel extends BenefitValidateModel {
  /**
   * Credits validate properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: Credit;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "Credits";
}

// ===================================================================
// CONDITIONAL CREDITS MODELS - Added in 2025-05-01-preview
// ===================================================================

/**
 * Properties belonging to conditional credits.
 */
@discriminator("entityType")
@added(Versions.v2025_05_01_preview)
model ConditionalCreditProperties {
  /**
   * Type of conditional credit entity
   */
  entityType: ConditionalCreditEntityType;

  /**
   * Display name for the conditional credit
   */
  displayName?: string;

  /**
   * The billing account resource ID
   */
  @visibility(Lifecycle.Read)
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * The provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConditionalCreditsProvisioningState;

  /**
   * The status of the conditional credit
   */
  @visibility(Lifecycle.Read)
  status?: ConditionalCreditStatus;

  /**
   * Start date of the conditional credit
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End date of the conditional credit (derived from last milestone)
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Product code for the conditional credit
   */
  productCode?: string;

  /**
   * Fully-qualified identifier of the benefit under applicable benefit list.
   */
  @visibility(Lifecycle.Read)
  benefitResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/*";
    }
  ]>;
}

/**
 * Type of conditional credit entity
 */
@added(Versions.v2025_05_01_preview)
union ConditionalCreditEntityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contributor: "Contributor",
}

/**
 * The provisioning state of the resource
 */
@added(Versions.v2025_05_01_preview)
union ConditionalCreditsProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
}

/**
 * The status of the conditional credit
 */
@added(Versions.v2025_05_01_preview)
union ConditionalCreditStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingSettlement: "PendingSettlement",
}

/**
 * Conditional credit patch request
 */
@added(Versions.v2025_05_01_preview)
model ConditionalCreditPatchRequest {
  /**
   * Conditional credit patch request properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConditionalCreditPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Conditional credit patch request properties
 */
@added(Versions.v2025_05_01_preview)
model ConditionalCreditPatchRequestProperties {
  /**
   * Display name for the conditional credit
   */
  displayName?: string;

  /**
   * Updated milestones list (only applicable for primary conditional credits)
   */
  milestones?: ConditionalCreditMilestone[];
}

/**
 * Milestone definition within a conditional credit
 */
alias ConditionalCreditMilestone = ConditionalCreditMilestoneBase;

/**
 * Base milestone definition for conditional credits
 */
@added(Versions.v2025_05_01_preview)
model ConditionalCreditMilestoneBase {
  /**
   * Unique identifier for the milestone
   */
  milestoneId?: string;

  /**
   * Display name for the milestone
   */
  name?: string;

  /**
   * Current status of the conditional credit milestone
   */
  @visibility(Lifecycle.Read)
  status?: ConditionalCreditMilestoneStatus;

  /**
   * End date for this milestone
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Spend target for this milestone
   */
  spendTarget?: Price;

  /**
   * Award details for this milestone (only present for primary conditional credits)
   */
  award?: Award;
}

/**
 * Current status of the conditional credit milestone
 */
@added(Versions.v2025_05_01_preview)
union ConditionalCreditMilestoneStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Missed: "Missed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingSettlement: "PendingSettlement",
}

/**
 * Award details for milestone completion
 */
@added(Versions.v2025_05_01_preview)
model Award {
  /**
   * Credit amount to be awarded
   */
  credit?: Commitment;

  /**
   * Start date when the credit becomes effective
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End date when the credit expires
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Resource ID for the awarded credit.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * This is the globally unique identifier of the credit which will not change for its lifetime.
   */
  @visibility(Lifecycle.Read)
  systemId?: string;

  /**
   * Points to BalanceVersion document that indicates the remaining commitment balance when the credit was created.
   */
  @visibility(Lifecycle.Read)
  balanceVersion?: float32;
}

/**
 * List of conditional credits
 */
@added(Versions.v2025_05_01_preview)
model ConditionalCreditList is Azure.Core.Page<ConditionalCredit>;

/**
 * Properties for primary conditional credit.
 */
@added(Versions.v2025_05_01_preview)
model PrimaryConditionalCreditProperties extends ConditionalCreditProperties {
  /**
   * System identifier shared between primary and contributor conditional credits representing the same conditional credit program
   */
  systemId: string;

  /**
   * Whether this conditional credit allows contributor billing accounts
   */
  allowContributors?: EnablementMode;

  /**
   * List of milestones for this conditional credit (must include awards)
   */
  milestones?: ConditionalCreditMilestone[];

  /**
   * Type of conditional credit entity
   */
  entityType: "Primary";
}

/**
 * Properties for contributor conditional credit.
 */
@added(Versions.v2025_05_01_preview)
model ContributorConditionalCreditProperties
  extends ConditionalCreditProperties {
  /**
   * Resource ID of the primary conditional credit (required for contributors)
   */
  primaryResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.BillingBenefits/conditionalCredits";
    }
  ]>;

  /**
   * System identifier shared between primary and contributor conditional credits representing the same conditional credit program
   */
  systemId: string;

  /**
   * List of milestones copied from primary conditional credit (excludes award details)
   */
  @visibility(Lifecycle.Read)
  milestones?: ContributorConditionalCreditMilestone[];

  /**
   * Fully-qualified billing account resource identifier of the primary CACO. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}.
   */
  primaryBillingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Type of conditional credit entity
   */
  entityType: "Contributor";
}

/**
 * Milestone definition for contributor conditional credit (excludes award details)
 */
alias ContributorConditionalCreditMilestone = ConditionalCreditMilestoneBase;

/**
 * Conditional Credits validate model
 */
@added(Versions.v2025_05_01_preview)
model ConditionalCreditsValidateModel extends BenefitValidateModel {
  /**
   * Conditional Credits validate properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: ConditionalCreditProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "ConditionalCredits";
}
