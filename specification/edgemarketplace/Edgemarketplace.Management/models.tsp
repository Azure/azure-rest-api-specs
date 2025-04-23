import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.EdgeMarketplace;

/**
 * The provisioning state of a resource type.
 */
union ResourceProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",
}

/**
 * Says if the offer is public/private
 */
union OfferAvailability {
  string,

  /**
   * The offer availability is private
   */
  Private: "Private",

  /**
   * The offer availability is public
   */
  Public: "Public",
}

/**
 * Offer release type
 */
union OfferReleaseType {
  string,

  /**
   * The offer in preview
   */
  Preview: "Preview",

  /**
   * The offer in GA
   */
  GA: "GA",
}

/**
 * Publisher properties
 */
model PublisherProperties {
  /**
   * The resource provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  provisioningState: ResourceProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The offer properties
 */
model OfferProperties {
  /**
   * The content version
   */
  contentVersion?: string;

  /**
   * The content url
   */
  contentUrl?: string;

  /**
   * The offer content
   */
  offerContent: OfferContent;

  /**
   * The resource provisioning state
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
  provisioningState?: ResourceProvisioningState;

  /**
   * The marketplace skus
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  marketplaceSkus?: MarketplaceSku[];
}

/**
 * The offer content
 */
model OfferContent {
  /**
   * The display name of the offer
   */
  displayName: string;

  /**
   * The summary
   */
  summary?: string;

  /**
   * The long summary
   */
  longSummary?: string;

  /**
   * The description
   */
  description?: string;

  /**
   * The offer id
   */
  offerId: string;

  /**
   * The offer type
   */
  offerType?: string;

  /**
   * The support uri
   */
  supportUri?: string;

  /**
   * The popularity of the offer
   */
  popularity?: int32;

  /**
   * The publisher of the offer
   */
  offerPublisher?: OfferPublisher;

  /**
   * The availability of the offer
   */
  availability?: OfferAvailability;

  /**
   * The release type of the offer
   */
  releaseType?: OfferReleaseType;

  /**
   * The icon files
   */
  iconFileUris?: IconFileUris;

  /**
   * The terms and conditions
   */
  termsAndConditions?: TermsAndConditions;

  /**
   * The category ids
   */
  categoryIds?: string[];

  /**
   * The operating systems
   */
  operatingSystems?: string[];
}

/**
 * The offer publisher
 */
model OfferPublisher {
  /**
   * The publisher Id
   */
  publisherId: string;

  /**
   * The publisher name
   */
  publisherDisplayName: string;
}

/**
 * Icon files
 */
model IconFileUris {
  /**
   * uri of small icon
   */
  small?: string;

  /**
   * uri of medium icon
   */
  medium?: string;

  /**
   * uri of wide icon
   */
  wide?: string;

  /**
   * uri of large icon
   */
  large?: string;
}

/**
 * Terms and conditions
 */
model TermsAndConditions {
  /**
   * The legal terms and conditions uri
   */
  legalTermsUri?: string;

  /**
   * The type of legal terms
   */
  legalTermsType?: string;

  /**
   * The privacy policy uri
   */
  privacyPolicyUri?: string;
}

/**
 * The marketplace sku
 */
model MarketplaceSku {
  /**
   * The catalog plan id
   */
  catalogPlanId: string;

  /**
   * The marketplace sku id
   */
  marketplaceSkuId: string;

  /**
   * The type of marketplace sku
   */
  type?: string;

  /**
   * The display name of marketplace sku
   */
  displayName?: string;

  /**
   * The summary
   */
  summary?: string;

  /**
   * The long summary
   */
  longSummary?: string;

  /**
   * The description
   */
  description?: string;

  /**
   * The generation
   */
  generation?: string;

  /**
   * The display rank of the sku
   */
  displayRank?: int32;

  /**
   * The operating system supported
   */
  operatingSystem?: SkuOperatingSystem;

  /**
   * The marketplace sku version
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  marketplaceSkuVersions?: MarketplaceSkuVersion[];
}

/**
 * The sku operating system
 */
model SkuOperatingSystem {
  /**
   * The family of the operating system
   */
  family?: string;

  /**
   * The type of the operating system
   */
  type?: string;

  /**
   * The name of the operating system
   */
  name: string;
}

/**
 * The marketplace sku version
 */
model MarketplaceSkuVersion {
  /**
   * The name of sku version
   */
  name: string;

  /**
   * The size of the image
   */
  sizeOnDiskInMb?: int32;

  /**
   * The size of the download
   */
  minimumDownloadSizeInMb?: int32;

  /**
   * The stage name
   */
  stageName?: string;
}

/**
 * Access token request object
 */
model AccessTokenRequest {
  /**
   * The name of the publisher.
   */
  publisherName?: string;

  /**
   * The region where the disk will be created.
   */
  edgeMarketPlaceRegion: string;

  /**
   * The region where the disk will be created.
   */
  egeMarketPlaceResourceId?: string;

  /**
   * The hyperv version.
   */
  hypervGeneration?: string;

  /**
   * The marketplace sku.
   */
  marketPlaceSku?: string;

  /**
   * The marketplace sku version.
   */
  marketPlaceSkuVersion?: string;

  /**
   * The device sku.
   */
  deviceSku?: string;

  /**
   * The device sku version.
   */
  deviceVersion?: string;
}

/**
 * The disk access token
 */
model DiskAccessToken {
  /**
   * The disk id.
   */
  diskId?: string;

  /**
   * The access token creation status.
   */
  status?: string;

  /**
   * The access token.
   */
  accessToken: string;
}

/**
 * Access token request object
 */
model AccessTokenReadRequest {
  /**
   * The name of the publisher.
   */
  requestId: string;
}
