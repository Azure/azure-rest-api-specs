import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.SoftwarePlan;
/** SoftwareLicense resource */
model SoftwareLicense is TrackedResource<SoftwareLicenseProperties> {
  /** Name of softwareLicense */
  @key("softwareLicenseName")
  @path
  @segment("softwareLicenses")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

/** SoftwareLicense properties */
model SoftwareLicenseProperties {
  /** Unique identifier for the product purchased */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  upn: string;

  /** Quantity of the product purchased */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  quantity: int32;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Date when the license benefit should start. Format : 2023-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  startDate?: string;

  /** Date when the license benefit should end. Format : 2023-02-01T01:01:01.1075056Z */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endDate?: string;
}

/** Product Key Properties for SoftwareLicense (masked or full) */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "SoftwareLicenseProductKey is a proxy resource"
model SoftwareLicenseProductKeyProperties {
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

  /** Product ID that uniquely identifies a software product configured by business. Format: ^[A-Z0-9]{12}$ */
  productId: string;

  /** SKU ID that uniquely identifies a software product SKU configured by business. Format: ^[A-Z0-9]{4}$ */
  skuId: string;

  /** Software version for L+SA products (optional). */
  softwareVersion?: string;

  /** Total number of keys purchased. */
  purchasedCount: int32;

  /** Total Number of activations for the key. */
  activationCount: int32;
}

/** SoftwareLicense Product Key Resource */
@parentResource(SoftwareLicense)
model SoftwareLicenseProductKey
  is ProxyResource<SoftwareLicenseProductKeyProperties> {
  /** Name of the product key */
  @visibility(Lifecycle.Read)
  @path
  @segment("productKeys")
  @key("productKeyName")
  @pattern("^[a-zA-Z0-9-:]{3,36}$")
  name: string;
}

/** List SoftwareLicense Product Keys Response */
model ListSoftwareLicenseProductKeysResponse {
  /** Array of product keys */
  value: SoftwareLicenseProductKey[];

  /** Link to the next page of results, if available */
  nextLink?: string;
}

/** Show Full Key Result for SoftwareLicense (same as SoftwareLicenseProductKey, but keyValue is full) */
model ShowFullSoftwareLicenseKeyResult is SoftwareLicenseProductKey;

/** Download option details for a product */
model SoftwareLicenseDownloadOptionProperties {
  /** Specifies the CPU architecture and file type configured by Product Teams (e.g., "64 Bit, ISO") */
  cpuAndFileType: string;

  /** Optional rank for display purposes. MinValue = 0 , MaxValue = 100 */
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

/** Properties for SoftwareLicenseProductDownloadOption resource */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "SoftwareLicenseProductDownloadOption is a proxy resource"
model SoftwareLicenseProductDownloadOptionProperties {
  /** Array of available download options */
  @identifiers(#["fileName"])
  downloadOptions: SoftwareLicenseDownloadOptionProperties[];
}

/** SoftwareLicenseProductDownloadOption Resource */
@parentResource(SoftwareLicense)
model SoftwareLicenseProductDownloadOption
  is ProxyResource<SoftwareLicenseProductDownloadOptionProperties> {
  /** Name of the download options */
  @visibility(Lifecycle.Read)
  @path
  @key("productDownloadOptionName")
  @segment("productDownloadOptions")
  @pattern("^[a-zA-Z0-9-:]{3,36}$")
  name: string;
}

/** List SoftwareLicenseProductDownloadOptions Response */
model ListSoftwareLicenseProductDownloadOptionsResponse {
  /** Array of product download options */
  value: SoftwareLicenseProductDownloadOption[];

  /** Link to the next page of results, if available */
  nextLink?: string;
}

/** Generate Download Links Response Item */
model SoftwareLicenseDownloadLinkItem {
  /** Name of the download file */
  fileName: string;

  /** URL to download software */
  @secret
  link: string;
}

/** Generate Download Links Response for SoftwareLicense */
model SoftwareLicenseGenerateDownloadLinksResponse {
  /** Array of download link items */
  @identifiers(#["fileName"])
  value: SoftwareLicenseDownloadLinkItem[];
}

/** Download option details for generateDownloadLinks POST action */
model SoftwareLicenseGenerateDownloadLinksInput {
  /** Specifies the CPU architecture and file type (e.g., "64 Bit, ISO") configured by Product Teams. */
  cpuAndFileType: string;

  /** Language code for the download option (e.g., "en") */
  iso2LanguageCode: string;

  /** Optional field for L+SA products to specify the version (e.g., "2019", "2022") */
  softwareVersion?: string;
}
