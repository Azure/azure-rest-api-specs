import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SoftwarePlan;
/** SoftwareSubscription resource */
model SoftwareSubscription is TrackedResource<SoftwareSubscriptionProperties> {
  /** Name of softwareSubscription */
  #suppress "@typespec/http/metadata-ignored" "The name property is not required in the request body"
  @key("softwareSubscriptionName")
  @path
  @segment("softwareSubscriptions")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

/** SoftwareSubscription expand query parameter */
model ExpandSoftwareSubscriptionQueryParameter {
  /** The $expand OData query parameter. This is a comma-separated list of additional properties to include in the response. Possible values include: 'licenseSummary', 'associatedSoftwareSubscriptionIds'. */
  @query("$expand")
  expand?: string;
}

/** SoftwareSubscription update request */
model SoftwareSubscriptionUpdateRequest {
  /** SoftwareSubscription properties to be updated */
  properties: SoftwareSubscriptionUpdateProperties;
}

/** SoftwareSubscription properties */
model SoftwareSubscriptionProperties {
  /** Friendly name for the subscription */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  displayName: string;

  /** The type of the software subscription. */
  @visibility(Lifecycle.Read)
  softwareSubscriptionType: SoftwareSubscriptionType;

  /** Unique identifier for the product purchased */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  productCode: string;

  /** If softwareSubscriptionType is SoftwareSubscription, the count of Software Subscriptions purchased. If softwareSubscriptionType is LicenseSoftwareAssurance, the count of Software Assurances purchased. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quantity: int32;

  /** Count of Licenses purchased for this product. Applicable for LicenseSoftwareAssurance. */
  @visibility(Lifecycle.Read)
  licenseQuantity?: int32;

  /** Summary of the license information for this software subscription. Applicable for LicenseSoftwareAssurance. Returned only if requested in the $expand query parameter. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  licenseSummary?: SoftwareSubscriptionLicenseSummary[];

  /** The resource provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The status of the software subscription. */
  @visibility(Lifecycle.Read)
  status: SoftwareSubscriptionStatus;

  /** Date when the subscription benefit should start. Format : 2023-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  startAt?: string;

  /** Date when the subscription benefit should end. Format : 2026-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endDate?: string;

  /** The billing subscription id of the asset that this subscription is cotermed with. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName} */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cotermBillingSubscriptionId?: string;

  ...SoftwareSubscriptionUpdateProperties;

  /** The ID of the billing subscription corresponding to this software subscription. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName} */
  @visibility(Lifecycle.Read)
  billingSubscriptionId: string;

  /** ID of the base/initial software subscription purchased. Format : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SoftwarePlan/softwareSubscriptions/{softwareSubscriptionName} */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  parentSoftwareSubscriptionId?: string;

  /** ID of the True up or Licenses that are added on top of the base/initial software subscription purchase (parent). Returned only if requested in the $expand query parameter. Format : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SoftwarePlan/softwareSubscriptions/{softwareSubscriptionName} */
  @visibility(Lifecycle.Read)
  associatedSoftwareSubscriptionIds?: string[];
}

/** SoftwareSubscription properties that can be updated */
model SoftwareSubscriptionUpdateProperties {
  /** Indicates whether the subscription is configured for automatic renewal upon expiration. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  autoRenew?: AutoRenewSetting;

  /** Contains information about renewal of this product */
  @visibility(Lifecycle.Read, Lifecycle.Update)
  renewal?: SoftwareSubscriptionRenewalProperties;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /** Resource is being provisioned. */
  Pending: "Pending",

  /** Resource is being canceled. */
  Canceling: "Canceling",

  /** Resource has been canceled. */
  Canceled: "Canceled",
}

/** The status of the software subscription. */
union SoftwareSubscriptionStatus {
  string,

  /** Software subscription is pending. */
  Pending: "Pending",

  /** Software subscription is active. */
  Active: "Active",

  /** Software subscription failed creation. */
  Failed: "Failed",

  /** Software subscription has been canceled. */
  Canceled: "Canceled",

  /** Software subscription has expired. */
  Expired: "Expired",
}

/** Indicates whether the subscription is configured for automatic renewal upon expiration. */
union AutoRenewSetting {
  string,

  /** AutoRenew is disabled. Subscription will not renew automatically upon expiration. */
  Disabled: "Disabled",

  /** AutoRenew is enabled. Subscription will renew automatically upon expiration. */
  Enabled: "Enabled",
}

/** productCode to be used during renewal */
model SoftwareSubscriptionRenewalProperties {
  /** productCode to be used during renewal */
  productCode: string;

  /** Date when the subscription benefit ends after renewal. Format : 2026-02-01T01:01:01.1075056Z */
  endDate?: string;

  /** The billing subscription id of the asset that this subscription is cotermed with. Format : /providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingSubscriptions/{billingSubscriptionName} */
  cotermBillingSubscriptionId?: string;
}

/** Summary of License & Software Assurance for the software subscription */
model SoftwareSubscriptionLicenseSummary {
  /** Name of the product */
  productName: string;

  /** Version of the product */
  productVersion: string;

  /** Number of licenses */
  licenseQuantity: int32;

  /** Number of active software assurances */
  softwareAssuranceQuantity: int32;
}

/** Provisioned software key info */
model SoftwareKey {
  /** Type of key provisioned */
  keyType: string;

  /** Status of key provisioned */
  keyStatus?: string;

  /** 5x5 software activation key */
  @secret
  keyValue?: string;

  /** URL to download software */
  @secret
  downloadLink?: string;

  /** Count of purchased keys */
  purchasedCount?: int32;

  /** Count of activated keys */
  activationCount?: int32;

  /** Catalog product Id for this software */
  productId?: string;

  /** Catalog sku Id for this software */
  skuId?: string;
}

/** Input model for ListKeys operation */
model SoftwareSubscriptionsListKeysParameters {
  /** The language code of software to be downloaded. */
  @query
  languageCode: string;

  /** The CPU and file type of software to be downloaded. */
  @query
  cpuFileType: string;

  /** Whether to return unmasked key in the response. */
  @query
  showKey: boolean;
}

/** Status of a long-running operation result. */
union OperationResultStatus {
  string,

  /** Operation is pending. */
  Pending: "Pending",

  /** Operation succeeded. */
  Succeeded: "Succeeded",

  /** Operation failed. */
  Failed: "Failed",
}

/** Represents the result of a long-running operation. */
model OperationResult {
  /** Unique identifier for the operation result. */
  id: string;

  /** Name of the operation result. */
  name: string;

  /** Status of the operation result. */
  status: OperationResultStatus;

  /** Properties associated with the operation result. */
  properties: {
    /** Resource ID related to the operation result. */
    resourceId: string;
  };

  /** Type of the operation result. */
  type: string;
}

/** Supported values for keyType */
union KeyType {
  string,

  /** Key Management Service (KMS) Key. Used for activating systems within an organization's network via a KMS host. Commonly used in volume activation scenarios. */
  KMS: "KMS",

  /** Multiple Activation Key (MAK). Activates a specific number of systems. Each activation reduces the remaining activation count. */
  MAK: "MAK",

  /** Setup Key. A non-unique 5x5 key, with no activation count associated. */
  Setup: "Setup",

  /** Retail Key. A unique 5x5 key issued to each customer for every order. Activation behavior may vary depending on the product. Refer to the specific product documentation for details on key usage and activation count. */
  Retail: "Retail",

  /** None. No activation key is provided. */
  None: "None",
}

/** Supported values for keyStatus */
union KeyStatus {
  string,

  /** Key is active and available for activation. */
  Active: "Active",

  /** Key is not valid for activation (e.g., expired, not provisioned, or disabled). */
  Inactive: "Inactive",

  /** Key is blocked due to policy, compliance, or security issues (e.g., fraud or piracy). */
  Blocked: "Blocked",

  /** Key is permanently revoked (e.g., due to refund or cancellation). */
  Revoked: "Revoked",

  /** Key has been replaced or all activations consumed. No longer usable. */
  Replaced: "Replaced",

  /** No 5x5 key is assigned */
  None: "None",
}

/** Product Key Properties (masked or full) */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ProductKey is a proxy resource"
model ProductKeyProperties {
  /** Type of key provisioned */
  keyType: KeyType;

  /** Status of key provisioned */
  keyStatus: KeyStatus;

  /** 5x5 software activation key value - masked. Null in ShowFullKey response. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "maskedKey is an intentionally masked (partial) key value, not a secret"
  maskedKey?: string;

  /** 5x5 software activation key value. This is actual key which is a secret. Null in List and Get ProductKeys response. */
  @secret
  fullKey?: string;

  /** Product ID associated with the key. */
  productId: string;

  /** SKU ID associated with the key. */
  skuId: string;

  /** Software version for L+SA products (optional). */
  softwareVersion?: string;

  /** Total number of keys purchased. */
  purchasedCount: int32;

  /** Total Number of activations for the key. */
  activationCount: int32;

  /** Change in Activations in Units Requested by Support. */
  activationUnits?: int32;

  /** Total number of activations done by the User. */
  activationCountUsed?: int32;
}

/** Product Key Resource */
@parentResource(SoftwareSubscription)
model ProductKey is ProxyResource<ProductKeyProperties> {
  /** Name of the product key */
  @visibility(Lifecycle.Read)
  @path
  @segment("productKeys")
  @key("productKeyName")
  @pattern("^[a-zA-Z0-9-:]{3,36}$")
  name: string;
}

/** Input model for ListProductKeys operation */
model ListProductKeysParameters {
  /** Filter by keyStatus */
  @query
  keyStatus?: KeyStatus;
}

/** List Product Keys Response */
model ListProductKeysResponse {
  /** Array of product keys */
  value: ProductKey[];

  /** Link to the next page of results, if available */
  nextLink?: string;
}

/** Show Full Key Response (same as ProductKey, but keyValue is full) */
model ShowFullKeyResult is ProductKey;

/** Download option details for a product */
model DownloadOptionProperties {
  /** Specifies the CPU architecture and file type (e.g., "64 Bit, ISO") */
  cpuAndFileType: string;

  /** Optional rank for display purposes */
  displayRank: int32;

  /** Size of the download file */
  fileSize: int64;

  /** Name of the download file */
  fileName: string;

  /** Language code for the download option (e.g., "en") */
  iso2LanguageCode: string;

  /** Title or description of the download option */
  optionTitle?: string;

  /** Optional field for L+SA products to specify the version (e.g., "2019", "2022") */
  softwareVersion?: string;
}

/** Properties for ProductDownloadOption resource */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ProductDownloadOption is a proxy resource"
model ProductDownloadOptionProperties {
  /** Array of available download options */
  @identifiers(#["fileName"])
  downloadOptions: DownloadOptionProperties[];
}

/** ProductDownloadOption Resource */
@parentResource(SoftwareSubscription)
model ProductDownloadOption is ProxyResource<ProductDownloadOptionProperties> {
  /** Name of the download options */
  @visibility(Lifecycle.Read)
  @path
  @key("productDownloadOptionName")
  @segment("productDownloadOptions")
  @pattern("^[a-zA-Z0-9-:]{3,36}$")
  name: string;
}

/** List ProductDownloadOptions Response */
model ListProductDownloadOptionsResponse {
  /** Array of product download options */
  value: ProductDownloadOption[];

  /** Link to the next page of results, if available */
  nextLink?: string;
}

/** GenerateDownloadLinks Response Item */
model DownloadLinkItem {
  /** Name of the download file */
  fileName: string;

  /** URL to download software */
  @secret
  link: string;
}

/** GenerateDownloadLinks Response */
model GenerateDownloadLinksResponse {
  /** Array of download link items */
  @identifiers(#["fileName"])
  value: DownloadLinkItem[];
}

/** Download option details for generateDownloadLinks POST action */
model GenerateDownloadLinksInput {
  /** Specifies the CPU architecture and file type (e.g., "64 Bit, ISO") */
  cpuAndFileType: string;

  /** Language code for the download option (e.g., "en") */
  iso2LanguageCode: string;

  /** Optional field for L+SA products to specify the version (e.g., "2019", "2022") */
  softwareVersion?: string;
}

/** Input model for processActivationUnitsOffset operation */
model ProcessActivationUnitsOffsetInput {
  /** Activation Units to be offset to existing activations count as requested by Support. */
  activationUnitsOffset: int32;
}

/** Supported reasons for ReplaceKey operation */
union ReplaceKeyReason {
  string,

  /** Replacement due to Chargeback */
  Chargeback: "Chargeback",

  /** Replacement due to Customer Cancellation */
  CustomerCancellation: "CustomerCancellation",

  /** Replacement due to Dunning Abandonment */
  DunningAbandoned: "DunningAbandoned",

  /** Replacement due to Expiration */
  Expiration: "Expiration",

  /** Replacement due to Fraud */
  Fraud: "Fraud",

  /** Replacement due to Settlement Reversal */
  SettlementReversal: "SettlementReversal",
}

/** Input model for ReplaceKey POST operation */
model ReplaceKeyInput {
  /** Reason for replacing the key */
  reason: ReplaceKeyReason;
}
