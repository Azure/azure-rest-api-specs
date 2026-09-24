import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingProfile.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

/**
 * A purchase order mapping that associates specific products to a purchase order.
 */
@added(Versions.v2024_08_01_preview)
@tenantResource
@parentResource(BillingProfile)
model PurchaseOrderMapping
  is Azure.ResourceManager.ProxyResource<PurchaseOrderMappingProperties> {
  ...ResourceNameParameter<
    Resource = PurchaseOrderMapping,
    KeyName = "purchaseOrderMappingName",
    SegmentName = "purchaseOrderMappings",
    NamePattern = PoMappingPattern
  >;
}

alias PurchaseOrderMappingListParameters = {
  /**
   * Can be used to get only active purchase order mappings.
   */
  @query
  allowOnlyActive?: boolean = false;
};

alias PurchaseOrderMappingByBillingProfilePurchaseOrderOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The resource provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;

    /** The purchase order (PO) number. */
    @path
    @segment("purchaseOrders")
    @key
    @pattern(PoNumberPattern)
    poNumber: string;
  },
  {},
  {
    /** The ID that uniquely identifies a purchase order mapping. */
    @path
    @segment("purchaseOrderMappings")
    @key
    @pattern(PoMappingPattern)
    purchaseOrderMappingName: string;
  },
  "BillingProfilePurchaseOrderMapping"
>;

alias PurchaseOrderMappingByBillingAccountPurchaseOrderOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The resource provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The purchase order (PO) number. */
    @path
    @segment("purchaseOrders")
    @key
    @pattern(PoNumberPattern)
    poNumber: string;
  },
  {},
  {
    /** The ID that uniquely identifies a purchase order mapping. */
    @path
    @segment("purchaseOrderMappings")
    @key
    @pattern(PoMappingPattern)
    purchaseOrderMappingName: string;
  },
  "BillingAccountPurchaseOrderMapping"
>;

alias PurchaseOrderMappingByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The resource provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a purchase order mapping. */
    @path
    @segment("purchaseOrderMappings")
    @key
    @pattern(PoMappingPattern)
    purchaseOrderMappingName: string;
  },
  "BillingAccountPurchaseOrderMapping"
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Purchase order mappings do not support deletion."
@armResourceOperations(#{ omitTags: true })
interface PurchaseOrderMappings {
  /**
   * Gets a specific purchase order mapping by ID for a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  get is ArmResourceRead<
    PurchaseOrderMapping,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Creates or updates a purchase order mapping for a billing profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing purchase order mapping endpoint returns only 200."
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  createOrUpdateByBillingProfile is ArmResourceCreateOrReplaceAsync<
    PurchaseOrderMapping,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<PurchaseOrderMapping>
  >;

  /**
   * Gets a list of purchase order mappings for a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  listByBillingProfile is ArmResourceListByParent<
    PurchaseOrderMapping,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = PurchaseOrderMappingListParameters,
    Response = ArmResponse<PurchaseOrderMappingListResult>
  >;

  /**
   * Validates purchase order mappings for a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  @action("validate")
  validateByBillingProfile is ArmResourceActionSync<
    PurchaseOrderMapping,
    PurchaseOrderMappingValidationRequest,
    ArmResponse<PurchaseOrderMappingValidationResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Gets a specific purchase order mapping by ID for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  getByBillingAccount is PurchaseOrderMappingByBillingAccountOps.Read<PurchaseOrderMapping>;

  /**
   * Creates or updates a purchase order mapping for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  createOrUpdateByBillingAccount is PurchaseOrderMappingByBillingAccountOps.CreateOrUpdateSync<
    PurchaseOrderMapping,
    Response = ArmResponse<PurchaseOrderMapping>
  >;

  /**
   * Gets a list of purchase order mappings for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  listByBillingAccount is PurchaseOrderMappingByBillingAccountOps.List<
    PurchaseOrderMapping,
    Parameters = PurchaseOrderMappingListParameters,
    Response = ArmResponse<PurchaseOrderMappingListResult>
  >;

  /**
   * Gets a list of purchase order mappings for a purchase order in a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  listByBillingProfilePurchaseOrder is PurchaseOrderMappingByBillingProfilePurchaseOrderOps.List<
    PurchaseOrderMapping,
    Parameters = PurchaseOrderMappingListParameters,
    Response = ArmResponse<PurchaseOrderMappingListResult>
  >;

  /**
   * Gets a list of purchase order mappings for a purchase order in a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  listByBillingAccountPurchaseOrder is PurchaseOrderMappingByBillingAccountPurchaseOrderOps.List<
    PurchaseOrderMapping,
    Parameters = PurchaseOrderMappingListParameters,
    Response = ArmResponse<PurchaseOrderMappingListResult>
  >;

  /**
   * Validates purchase order mappings for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PurchaseOrderMapping")
  @action("validate")
  validateByBillingAccount is PurchaseOrderMappingByBillingAccountOps.ActionSync<
    PurchaseOrderMapping,
    PurchaseOrderMappingValidationRequest,
    ArmResponse<PurchaseOrderMappingValidationResponse>
  >;
}
