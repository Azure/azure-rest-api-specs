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
using TypeSpec.Versioning;

namespace Microsoft.BillingBenefits;

/**
 * Common versioned properties added to all benefit resources.
 * Spread this model into any benefit resource's properties to include these fields.
 * New cross-cutting properties for future versions should be added here.
 */
model BenefitCommonVersionedProperties {
  /**
   * Invitation identifier
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  invitationId?: string;
}

/**
 * Versioned expansion properties for Credit, MACC, and ConditionalCredit resources.
 * Contains properties common to these three resource types but not applicable to Discount or FreeServices.
 * Spreads BenefitCommonVersionedProperties to include all cross-cutting versioned properties.
 */
model BenefitVersionedExpansionProperties {
  ...BenefitCommonVersionedProperties;

  /**
   * Amount of benefit that has been consumed
   */
  @visibility(Lifecycle.Read)
  consumed?: Price;
}

/**
 * Canonical billing scope properties for benefit resources.
 * Contains readOnly billing account, billing profile, customer identifiers, plus versioned common properties.
 * Use `...BenefitBillingScopeProperties` in new resource properties models.
 * Currently used by Discount and FreeServices; recommended for all future benefit resources.
 */
model BenefitBillingScopeProperties {
  /**
   * Fully-qualified identifier of the billing account where the benefit is applied.
   */
  @visibility(Lifecycle.Read)
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Fully-qualified identifier of the billing profile where the benefit is applied.
   */
  @visibility(Lifecycle.Read)
  billingProfileResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/billingProfiles";
    }
  ]>;

  /**
   * Customer resource id where the benefit is scoped to.
   */
  @visibility(Lifecycle.Read)
  customerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/customers";
    }
  ]>;

  ...BenefitCommonVersionedProperties;
}

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
 * Provisioning state for billing benefit resources. Includes the standard terminal states
 * (Succeeded, Failed, Canceled) plus benefit-specific transition states.
 */
union BenefitProvisioningState {
  ResourceProvisioningState,

  /** The resource provisioning request has been accepted but processing has not yet started. */
  Pending: "Pending",
}

/**
 * Represent benefit term in ISO 8601 format.
 */
union Term {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  P1M: "P1M",
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
 * Grain.
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
 * Represents the renewal action for a reservation to be a new purchase or existing renewal.
 */
union RenewAction {
  string,

  /** Represents a new purchase renewal action. */
  CreateNew: "CreateNew",

  /** Represents renewal of an existing reservation. */
  RenewExisting: "RenewExisting",
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
 * List of applied scope types supported for benefit resources.
 */
union BenefitAppliedScopeType {
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

  /**
   * Azure promotion discount type.
   */
  AzurePromotion: "AzurePromotion",
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
 * Represents the current status of the MACC.
 */
union MaccStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ShortfallCharged: "ShortfallCharged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ShortfallWaived: "ShortfallWaived",
}

/**
 * Represents type of the object being operated on. Possible values are primary or contributor.
 */
union MaccEntityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Contributor: "Contributor",
}

/**
 * Represents the enablement status of a feature or settings.
 */
union EnablementMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Represents the current status of the Milestone.
 */
union MaccMilestoneStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Removed: "Removed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ShortfallCharged: "ShortfallCharged",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ShortfallWaived: "ShortfallWaived",
}

/**
 * Status of the credit
 */
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
 * Redemption policy of the Credit
 */
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
 * Expiration policy of the Credit
 */
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
 * Type of conditional credit entity
 */
union ConditionalCreditEntityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Contributor: "Contributor",
}

/**
 * The status of the conditional credit
 */
union ConditionalCreditStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingSettlement: "PendingSettlement",
}

/**
 * Current status of the milestone
 */
union MilestoneStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduled: "Scheduled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Removed: "Removed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingSettlement: "PendingSettlement",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Missed: "Missed",
}

/**
 * Represents benefit model type for validation. Includes all resource types
 * plus legacy singular-form values used by the validate API.
 */
union BenefitType {
  ResourceType,

  /** Savings Plan (singular form, used by validate API) */
  SavingsPlan: "SavingsPlan",

  /** MACC (legacy form, used by validate API) */
  MACC: "MACC",
}

/**
 * The top-level ARM resource type for a billing benefit (e.g., maccs, credits, savingsPlans, reservations).
 */
union ResourceType {
  string,

  /** Microsoft Azure Consumption Commitments */
  Maccs: "Maccs",

  /** Credits applied to the customer's billing account */
  Credits: "Credits",

  /** Conditional Credits */
  ConditionalCredits: "ConditionalCredits",

  /** Discounts that reduce charges on eligible services */
  Discounts: "Discounts",

  /** Services provided at no charge under the billing agreement */
  FreeServices: "FreeServices",

  /** Savings Plan */
  SavingsPlans: "SavingsPlans",

  /** Reserved capacity or reserved instances */
  Reservations: "Reservations",
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

  /**
   * A filter string passed to downstream services to categorize and apply usage benefits to specific resource models. Expected format: "key/value" (e.g., "contractId/2025 H2CPU"). The value is not validated by BillingBenefits and is forwarded as-is.
   */
  @example("clusterId/2025 H2CPU")
  benefitFilter?: string;
}

/**
 * Commitment towards the benefit.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Commitment extends Price {
  /**
   * The grain of the commitment.
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
   * Fully-qualified identifier of the billing profile where the benefit is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/billingProfiles";
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
   * Fully-qualified identifier of the billing account where the benefit is applied. Present only for Enterprise Agreement customers.
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
  startDate?: plainDate;

  /**
   * For recurring billing plans, indicates the date when next payment will be processed. Null when total is paid off.
   */
  nextPaymentDueDate?: plainDate;

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
   * Fully-qualified identifier of the billing profile where the benefit is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/billingProfiles";
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
   * Fully-qualified identifier of the billing account where the benefit is applied. Present only for Enterprise Agreement customers.
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
   * Represents the renewal action for a reservation to be a new purchase or existing renewal.
   */
  renewAction?: RenewAction;

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
   * Represents the renewal action for a reservation to be a new purchase or existing renewal.
   */
  renewAction?: RenewAction;

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
   * This is the DateTime when the reservation benefit started.
   */
  benefitStartTime?: utcDateTime;

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
   * Represents the renewal action for a reservation to be a new purchase or existing renewal.
   */
  renewAction?: RenewAction;

  /**
   * This is the date-time when the reservation was renewed.
   */
  @visibility(Lifecycle.Read)
  renewalPurchaseDateTime?: utcDateTime;

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
   * This is the DateTime when the reservation benefit started.
   */
  benefitStartTime?: utcDateTime;

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
   * End date of the discount. No duration will be supported. Allowed value is any date greater than or equal to startDate.
   */
  endAt?: utcDateTime;

  /**
   * This is the globally unique identifier of the Discount which will not change for the lifetime of the Discount.
   */
  systemId?: string;

  /**
   * The state of the resource. Supported values are Pending, Failed, Succeeded, Canceled.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

  ...BenefitBillingScopeProperties;

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
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/*";
    }
  ]>;

  /**
   * List of applied scopes supported for discounts.
   */
  appliedScopeType?: BenefitAppliedScopeType;

  /**
   * Product details including SKU title, product family, and product type.
   */
  @visibility(Lifecycle.Read)
  productDetails?: ProductDetailsBase;
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

  /**
   * End date of the discount. No duration will be supported. Allowed value is any date greater than or equal to startDate.
   */
  endAt?: utcDateTime;
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
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/discounts";
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
 * Discount type properties for Azure promotion discounts.
 */
model DiscountTypeAzurePromotion extends DiscountTypeProperties {
  /**
   * Product family for which the discount is given. Validation: Optional
   */
  productFamilyName?: string;

  /**
   * Defines the type of discount. Supported values are ProductFamily, Product, Sku, CustomPrice, and CustomPriceMultiCurrency.
   */
  discountType: DiscountType.AzurePromotion;
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
  discountType: DiscountType.ProductFamily;
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
  discountType: DiscountType.Product;
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
  discountType: DiscountType.Sku;
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

/**
 * Optional field to record suppression reason for automatic shortfall.
 */
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
 * MACC properties
 */
model MaccModelProperties {
  /**
   * Provisioning state of MACC as assigned by RPaaS. This indicates the last operation's status. For all practical purposes, this can be ignored. For current status of MACC resource, refer to MaccStatus.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

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
      scopes: ["Tenant"];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  milestones?: MaccMilestone[];

  /**
   * This is the resource identifier of either the primary MACC or the contributor. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/maccs";
    }
  ]>;

  /**
   * Setting this to true means multi-entity.
   */
  allowContributors?: boolean = false;

  /**
   * Fully-qualified resource identifier of the primary MACC. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/maccs";
    }
  ]>;

  /**
   * Fully-qualified billing account resource identifier of the primary MACC. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}.
   */
  primaryBillingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Product details including SKU title, product family, and product type.
   */
  @visibility(Lifecycle.Read)
  productDetails?: ProductDetailsBase;

  /**
   * Type of the applied scope for the MACC.
   */
  appliedScopeType?: BenefitAppliedScopeType;

  ...BenefitVersionedExpansionProperties;
}

/**
 * Macc patch request properties
 */
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
  allowContributors?: boolean = false;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  milestones?: MaccMilestone[];

  /**
   * Fully-qualified resource identifier of the primary MACC. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/maccs/{maccName}.
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/maccs";
    }
  ]>;

  /**
   * Fully-qualified billing account resource identifier of the primary MACC. Format must be Azure Resource ID: /providers/Microsoft.Billing/billingAccounts/{acctId:orgId}.
   */
  primaryBillingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;
}

/**
 * Macc patch request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaccPatchRequest {
  /**
   * Macc patch request properties
   */
  properties?: MaccPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * MACC list
 */
model MaccList is Azure.Core.Page<Macc>;

/**
 * Charge shortfall request
 */
model ChargeShortfallRequest {
  /**
   * Charge shortfall request properties
   */
  properties?: Shortfall;
}

/**
 * Contributor list
 */
model ContributorList is Azure.Core.Page<Contributor>;

/**
 * Request properties to list maccs under a billing account
 */
model SellerResourceListRequestProperties {
  /**
   * Fully-qualified billing account resource identifier where the benefit is applied. Present only for Enterprise Agreement customers.
   */
  billingAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
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
  primaryResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/maccs";
    }
  ]>;
}

/**
 * List MACCs under a billing account
 */
model SellerResourceListRequest {
  /**
   * Request properties to list maccs under a billing account
   */
  properties?: SellerResourceListRequestProperties;
}

/**
 * Applicable MACC.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicableMacc extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Applicable MACC properties
   */
  properties?: MaccModelProperties;
}

/**
 * Applicable MACC list
 */
model ApplicableMaccList {
  /**
   * List Applicable MACCs.
   */
  @pageItems
  @identifiers(#[])
  value?: ApplicableMacc[];

  /**
   * Url to get the next page.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The reason for the credit. Not required if not applicable.
 */
model CreditReason {
  /**
   * The reason code for credit.
   */
  code?: string;

  /**
   * The free string description of the credit.
   */
  description?: string;
}

/**
 * Credit breakdown item representing a milestone, line-item, or no-charge service
 */
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
 * Indicates where the credit benefit is applied
 */
union AppliedOn {
  string,

  /**
   * Applied on consume charges
   */
  Consumption: "Consumption",

  /**
   * Applied on invoice
   */
  Invoice: "Invoice",

  /**
   * Applied externally
   */
  External: "External",
}

/** Common product detail properties shared across all benefit resources */
model ProductDetailsBase {
  /** SKU title of the product */
  skuTitle?: string;

  /**
   * The product family, for example "Azure" or "M365".
   */
  productFamily?: string;

  /**
   * The type of the product.
   */
  productType?: string;
}

/**
 * Product details for a credit
 */
model CreditProductDetails {
  ...ProductDetailsBase;

  /**
   * Indicates where the credit benefit is applied (e.g., consume, invoice, or external application).
   */
  appliedOn?: AppliedOn[];

  /**
   * Specifies which price point is used when applying the credit. Known values include "MarketPrice", "UnitPrice", and "BenefitGroupPrice:<groupId>" where <groupId> identifies the benefit group.
   */
  appliedPrice?: string;
}

/**
 * Product details for a transaction
 */
model TransactionProductDetails {
  ...ProductDetailsBase;

  /**
   * Grouping of Azure services by core function (e.g., Compute, Databases).
   */
  serviceFamily?: string;

  /**
   * The publisher type of the product, for example "Microsoft" for first-party or a third-party publisher name. Additional values may be introduced in the future.
   */
  publisherType?: string;
}

/**
 * Properties of a credit
 */
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
   * Display name
   */
  displayName?: string;

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
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Fully-qualified identifier of the billing profile where the benefit is applied. Present only for Field-led or Customer-led customers.
   */
  @visibility(Lifecycle.Read)
  billingProfileResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/billingProfiles";
    }
  ]>;

  /**
   * Customer resource id where the benefit is scoped to.
   */
  @visibility(Lifecycle.Read)
  customerResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts/customers";
    }
  ]>;

  /**
   * Credit line-items/milestones/no-charge services breakdown
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  breakdown?: CreditBreakdownItem[];

  /**
   * Provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

  /**
   * System identifier
   */
  systemId?: string;

  /**
   * Identifier of the $0 transaction created during credit acquisition.
   */
  @visibility(Lifecycle.Read)
  orderId?: string;

  /**
   * Unique identifier (UUID) of the funding lot assigned by the benefit publisher. Used in credit transfer scenarios to trace the originating credit lot.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fundingSystemId?: string;

  /**
   * Fully-qualified resource identifier of the resource. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/{benefitType}/{benefitName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  ...BenefitVersionedExpansionProperties;

  /**
   * Product details including SKU title, product kind, offer type, and application details
   */
  @visibility(Lifecycle.Read)
  productDetails?: CreditProductDetails;

  /**
   * Type of the applied scope for the credit.
   */
  appliedScopeType?: BenefitAppliedScopeType;
}

/**
 * Credit breakdown item representing a milestone, line-item, or no-charge service
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dimensions?: CreditDimension[];
}

/**
 * Key-value pair for additional credit parameters and metadata
 */
model CreditDimension {
  /**
   * The dimension key (e.g., productFamily, description, creditType)
   */
  key: string;

  /**
   * The dimension value
   */
  value: string;
}

/**
 * Credit patch request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CreditPatchRequest {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Credit patch properties
   */
  properties?: CreditPatchProperties;
}

/**
 * Credit patch properties
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  breakdown?: CreditBreakdownItem[];
}

/**
 * List of credits
 */
model CreditsList is Azure.Core.Page<Credit>;

/**
 * Request body for the changeSponsor action on a credit.
 */
model ChangeSponsorRequest {
  /** Financial code identifying the new sponsor. This is an alphanumeric identifier assigned by the billing system, for example P20567384. */
  @example("P30000001")
  sponsorId?: string;
}

/**
 * The type of charge for a transaction.
 */
union TransactionChargeType {
  string,

  /** Usage charge. Applicable to all benefits. */
  Usage: "Usage",

  /** Purchase charge. Applicable to MACC, CACO, ACO, MC only. */
  Purchase: "Purchase",

  /** Refund charge. Applicable to all benefits. */
  Refund: "Refund",
}

/**
 * Billing lifecycle status of a transaction.
 */
union TransactionBillingStatus {
  string,

  /** Charge may still change. */
  Open: "Open",

  /** Charge is finalized. */
  Closed: "Closed",
}

/**
 * Properties of a transaction
 */
model TransactionProperties {
  /**
   * Provisioning state of the transaction as assigned by RPaaS. This indicates the last operation's status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

  /**
   * This is the DateTime when the transaction occurred.
   */
  date?: utcDateTime;

  /**
   * The type of charge for this transaction.
   */
  chargeType?: TransactionChargeType;

  /**
   * Billing lifecycle status of this transaction.
   */
  billingStatus?: TransactionBillingStatus;

  /**
   * Fully-qualified identifier of the invoice.
   */
  invoiceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * Transaction amount in billing currency.
   */
  amountInBillingCurrency?: Price;

  /**
   * Transaction amount in pricing currency.
   */
  amountInPricingCurrency?: Price;

  /**
   * Catalog UPN for the product associated with this transaction.
   */
  productCode?: string;

  /**
   * Product details including SKU title, SKU properties, product family, type, and publisher type.
   */
  productDetails?: TransactionProductDetails;
}

/**
 * List of transactions
 */
model TransactionsList is Azure.Core.Page<CreditTransaction>;

/**
 * List of Macc transactions
 */
model MaccTransactionsList is Azure.Core.Page<MaccTransaction>;

/**
 * List of conditional credit transactions
 */
model ConditionalCreditTransactionsList
  is Azure.Core.Page<ConditionalCreditTransaction>;

/**
 * List of applicable conditional credits
 */
model ConditionalCreditList is Azure.Core.Page<ConditionalCredit>;

/**
 * Conditional credit contributor list
 */
model ConditionalCreditContributorList
  is Azure.Core.Page<ConditionalCreditContributor>;

/**
 * Properties belonging to conditional credits.
 */
@discriminator("entityType")
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
  billingAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["Tenant"];
      type: "Microsoft.Billing/billingAccounts";
    }
  ]>;

  /**
   * The provisioning state of the resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

  /**
   * The status of the conditional credit
   */
  status?: ConditionalCreditStatus;

  /**
   * Start date of the conditional credit
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * End date of the conditional credit (derived from last milestone)
   */
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
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/*";
    }
  ]>;

  /**
   * Fully-qualified resource identifier of the resource. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BillingBenefits/{benefitType}/{benefitName}.
   */
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Product details including SKU title, product family, and product type.
   */
  @visibility(Lifecycle.Read)
  productDetails?: ProductDetailsBase;

  /**
   * Type of the applied scope for the conditional credit.
   */
  appliedScopeType?: BenefitAppliedScopeType;

  ...BenefitVersionedExpansionProperties;
}

/**
 * Conditional credit patch request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConditionalCreditPatchRequest {
  /**
   * Conditional credit patch request properties
   */
  properties?: ConditionalCreditPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Conditional credit patch request properties
 */
model ConditionalCreditPatchRequestProperties {
  /**
   * Display name for the conditional credit
   */
  displayName?: string;

  /**
   * End DateTime in UTC.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endAt?: utcDateTime;

  /**
   * Whether this conditional credit allows contributor billing accounts
   */
  allowContributors?: EnablementMode;

  /**
   * Updated milestones list (only applicable for primary conditional credits)
   */
  milestones?: ConditionalCreditMilestone[];
}

/**
 * Milestone definition within a conditional credit
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConditionalCreditMilestone extends ConditionalCreditMilestoneBase {
  /**
   * Award details for this milestone
   */
  award?: Award;
}

/**
 * Base milestone definition for conditional credits
 */
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
   * Current status of the milestone
   */
  status?: MilestoneStatus;

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
 * Award details for milestone completion
 */
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

  /**
   * Duration for which the benefit is active. Will be in format P{int}M or P{int}Y. Any values representing up to 12 years are valid. Upper limit examples: P144M, P12Y.
   */
  duration?: Term;
}

/**
 * Properties for contributor conditional credit.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContributorConditionalCreditProperties
  extends ConditionalCreditProperties {
  /**
   * Resource ID of the primary conditional credit (required for contributors)
   */
  primaryResourceId?: Azure.Core.armResourceIdentifier<[
    {
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/conditionalCredits";
    }
  ]>;

  /**
   * System identifier shared between primary and contributor conditional credits representing the same conditional credit program
   */
  systemId?: string;

  /**
   * Product code for the contributor conditional credit
   */
  productCode?: string;

  /**
   * Start date for the contributor conditional credit
   */
  startAt?: utcDateTime;

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
      scopes: ["Tenant"];
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ContributorConditionalCreditMilestone
  extends ConditionalCreditMilestoneBase {}

/**
 * ARM not found response
 */
@error
model ArmNotFoundResponse {
  ...Response<404>;
}

/**
 * Request to validate any benefit.
 */
model BenefitValidateRequest {
  /**
   * Defines benefits for validation.
   */
  @identifiers(#[])
  benefits?: BenefitValidateModel[];
}

/**
 * Abstract benefit model to validate.
 */
@discriminator("benefitType")
model BenefitValidateModel {
  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: BenefitType;
}

/**
 * Benefit validate response.
 */
model BenefitValidateResponse {
  /**
   * Defines benefit validation response for benefits.
   */
  @identifiers(#[])
  benefits?: BenefitValidateResponseProperty[];

  /**
   * Url to get the next page.
   */
  nextLink?: string;
}

/**
 * Benefit validate response property
 */
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
      scopes: ["ResourceGroup"];
      type: "Microsoft.BillingBenefits/maccs";
    }
  ]>;
}

/**
 * Properties of a credit source
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      scopes: ["ResourceGroup"];
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
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CreditSourcePatchRequest {
  /**
   * Resource Tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * List of credit sources
 */
model CreditSourcesList is Azure.Core.Page<CreditSource>;

/**
 * Conditional Credits validate model
 */
model ConditionalCreditsValidateModel extends BenefitValidateModel {
  /**
   * Conditional Credits validate properties
   */
  properties?: ConditionalCreditProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "ConditionalCredits";
}

/**
 * List of applicable conditional credits
 */
model ApplicableConditionalCreditList {
  /**
   * List of applicable conditional credits
   */
  value?: ApplicableConditionalCredit[];

  /**
   * URL to get the next set of results
   */
  nextLink?: string;
}

/**
 * Applicable Conditional Credit.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicableConditionalCredit
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Applicable Conditional Credit properties
   */
  properties?: ConditionalCreditProperties;
}

/**
 * Credits validate model
 */
model CreditsValidateModel extends BenefitValidateModel {
  /**
   * Credits validate properties
   */
  properties?: Credit;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "Credits";
}

/**
 * Properties for primary conditional credit.
 */
model PrimaryConditionalCreditProperties extends ConditionalCreditProperties {
  /**
   * System identifier shared between primary and contributor conditional credits representing the same conditional credit program
   */
  systemId?: string;

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
 * MACC validate model
 */
model MaccValidateModel extends BenefitValidateModel {
  /**
   * MACC validate properties
   */
  properties?: MaccModelProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "MACC";
}

/**
 * Maccs validate model
 */
model MaccsValidateModel extends BenefitValidateModel {
  /**
   * MACC validate properties
   */
  properties?: MaccModelProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "Maccs";
}

/** Shared properties for savings plan validate models. */
alias SavingsPlanValidateProperties = {
  /**
   * Savings plan order alias properties
   */
  properties?: SavingsPlanOrderAliasProperties;

  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: Azure.Core.armResourceType;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  /**
   * Savings plan SKU
   */
  sku: ResourceSku;

  /**
   * Resource provider kind
   */
  kind?: string;
};

/**
 * Savings Plans validate model
 */
model SavingsPlansValidateModel extends BenefitValidateModel {
  ...SavingsPlanValidateProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "SavingsPlans";
}

/**
 * Savings plan validate model
 */
model SavingsPlanValidateModel extends BenefitValidateModel {
  ...SavingsPlanValidateProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "SavingsPlan";
}

/**
 * Discount validate model
 */
model DiscountValidateModel extends BenefitValidateModel {
  /**
   * Discount validate properties
   */
  properties?: DiscountProperties;

  /**
   * Type of benefit to validate. This is used to determine the model type for validation.
   */
  benefitType: "Discounts";
}

/**
 * Properties of free services
 */
model FreeServicesProperties {
  /**
   * This is the catalog UPN for the product.
   */
  productCode?: string;

  /**
   * Display name
   */
  displayName?: string;

  /**
   * Current status of the free services
   */
  status?: FreeServicesStatus;

  /**
   * Date and time when the free services become active
   */
  startAt?: utcDateTime;

  /**
   * Expiration date and time of the free services
   */
  endAt?: utcDateTime;

  /**
   * Provisioning state of Free Services as assigned by RPaaS. This indicates the last operation's status. For all practical purposes, this can be ignored. For current status of Free Services resource, refer to FreeServicesStatus.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BenefitProvisioningState;

  ...BenefitBillingScopeProperties;

  /**
   * This is the globally unique identifier of the free services which will not change for its lifetime. Generated by the benefit publisher.
   */
  systemId?: string;

  /**
   * Product details including SKU title, product family, and product type.
   */
  @visibility(Lifecycle.Read)
  productDetails?: ProductDetailsBase;
}

/**
 * Status of the free services
 */
union FreeServicesStatus {
  string,

  /**
   * Free services status is unknown
   */
  Unknown: "Unknown",

  /**
   * Free services are pending activation
   */
  Pending: "Pending",

  /**
   * Free services are active
   */
  Active: "Active",

  /**
   * Free services have been canceled
   */
  Canceled: "Canceled",

  /**
   * Free services have been fully consumed or completed
   */
  Completed: "Completed",
}

/**
 * Free services patch request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FreeServicesPatchRequest {
  /**
   * Free services patch request properties
   */
  properties?: FreeServicesPatchRequestProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Free services patch request properties
 */
model FreeServicesPatchRequestProperties {
  /**
   * Updated expiration date and time of the free services
   */
  endAt?: utcDateTime;
}

/**
 * This operation lists the free services that are available under the specified subscription.
 */
model FreeServicesList {
  /**
   * The list of free services
   */
  @pageItems
  value?: FreeServices[];

  /**
   * The URL to get the next set of results
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

// ─── CatalogGroup models ──────────────────────────────────────────────────────

/**
 * Properties of a catalog group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only proxy resource with no provisioning lifecycle"
model CatalogGroupProperties {
  /**
   * The top-level benefit resource type (e.g., maccs, credits, conditionalCredits, discounts, savingsPlans, reservations).
   */
  benefitResourceType: ResourceType;

  /**
   * Display name for the catalog group.
   */
  displayName?: string;

  /**
   * Short description of the catalog group.
   */
  shortDescription?: string;

  /**
   * Long description of the catalog group.
   */
  longDescription?: string;

  /**
   * Link to learn more about this catalog group. Uses the forward-link format https://go.microsoft.com/fwlink/?linkid=<linkId>.
   */
  learnMoreLink?: url;

  /**
   * Manifest-sourced array of search terms for this catalog group. Omitted when empty.
   */
  keywords?: string[];

  /**
   * The benefit type's icon as JSON-escaped SVG markup. After parsing, the value is a complete `<svg>…</svg>` element.
   */
  @example("<svg viewBox=\"0 0 18 18\" class=\"\" role=\"presentation\" focusable=\"false\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" id=\"FxSymbol0-026\"><defs><linearGradient id=\"0069e7e8-fdae-4c19-9033-1c9110b94edb\" x1=\"8.88\" y1=\"12.21\" x2=\"8.88\" y2=\".21\" gradientUnits=\"userSpaceOnUse\"><stop offset=\"0\" stop-color=\"#0078d4\"/><stop offset=\".82\" stop-color=\"#5ea0ef\"/></linearGradient><linearGradient id=\"a7c881fe-6333-4255-971a-27e7240497ec\" x1=\"8.88\" y1=\"16.84\" x2=\"8.88\" y2=\"12.21\" gradientUnits=\"userSpaceOnUse\"><stop offset=\".15\" stop-color=\"#ccc\"/><stop offset=\"1\" stop-color=\"#707070\"/></linearGradient></defs><rect x=\"-.12\" y=\".21\" width=\"18\" height=\"12\" rx=\".6\" fill=\"url(#0069e7e8-fdae-4c19-9033-1c9110b94edb)\"></rect><path fill=\"#50e6ff\" d=\"M11.88 4.46v3.49l-3 1.76v-3.5l3-1.75z\"></path><path fill=\"#c3f1ff\" d=\"M11.88 4.46l-3 1.76-3-1.76 3-1.75 3 1.75z\"></path><path fill=\"#9cebff\" d=\"M8.88 6.22v3.49l-3-1.76V4.46l3 1.76z\"></path><path fill=\"#c3f1ff\" d=\"M5.88 7.95l3-1.74v3.5l-3-1.76z\"></path><path fill=\"#9cebff\" d=\"M11.88 7.95l-3-1.74v3.5l3-1.76z\"></path><path d=\"M12.49 15.84c-1.78-.28-1.85-1.56-1.85-3.63H7.11c0 2.07-.06 3.35-1.84 3.63a1 1 0 0 0-.89 1h9a1 1 0 0 0-.89-1z\" fill=\"url(#a7c881fe-6333-4255-971a-27e7240497ec)\"></path></svg>")
  icon?: string;

  /**
   * Capabilities of the catalog group as key-value pairs. Omitted when a benefit type has no defined capabilities.
   */
  @identifiers(#[])
  capabilities?: CatalogGroupCapability[];

  /**
   * Optional disclaimers (legal or eligibility caveats) for the catalog group. Included only when caveats apply.
   */
  disclaimers?: string[];
}

/**
 * A key-value pair representing a capability of the catalog group (for example, exchange or renewal support).
 */
model CatalogGroupCapability {
  /**
   * The capability name (e.g., SelfServiceExchange, Renewability).
   */
  name: string;

  /**
   * The capability value (e.g., Supported, Not Supported).
   */
  value: string;
}

/**
 * The list of catalog groups.
 */
model CatalogGroupList {
  /**
   * The list of catalog groups.
   */
  @pageItems
  value?: CatalogGroup[];

  /**
   * URL to get the next page of results, or `null` if this is the last page.
   */
  @nextLink
  nextLink?: url;
}
