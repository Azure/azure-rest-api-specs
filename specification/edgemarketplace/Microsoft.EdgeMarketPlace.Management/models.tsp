import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeMarketplace;

@doc("Enum for CreatedBy")
union CreatedByType {
  string,

  @doc("The resource is created by user")
  User: "User",

  @doc("The resource is created by application")
  Application: "Application",

  @doc("The resource is created by managed identity")
  ManagedIdentity: "ManagedIdentity",

  @doc("The resource is created by key")
  Key: "Key",
}

@doc("Origin Enum")
union Origin {
  string,

  @doc("Origin is user")
  user: "user",

  @doc("Origin is system")
  system: "system",

  @doc("Origin is user and system")
  userAndSystem: "user,system",
}

@doc("ActionType Enum")
union ActionType {
  string,

  @doc("ActionType is internal")
  Internal: "Internal",
}

@doc("OfferAvailability Enum")
union OfferAvailability {
  string,
  @doc("The offer availability is private") Private: "Private",
  @doc("The offer availability is public") Public: "Public",
}

@doc("Offer release type Enum")
union OfferReleaseType {
  string,
  @doc("The offer in preview") Preview: "Preview",
  @doc("The offer in GA") GA: "GA",
}

@doc("Offer launch type Enum")
union OfferLaunchType {
  string,
  @doc("The offer has been certified") Trusted: "Trusted",
  @doc("The offer has not been certified") Unknown: "Unknown",
}

@doc("Publisher properties")
model PublisherProperties {
  @doc("The resource provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The offer properties")
model OfferProperties {
  @doc("The content version")
  contentVersion?: string;

  @doc("The content url")
  contentUrl?: string;

  @doc("The offer content")
  offerContent: OfferContent;

  @doc("The resource provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The marketplace skus")
  @Azure.ResourceManager.identifiers(#["marketplaceSkuId"])
  marketplaceSkus?: MarketplaceSku[];
}

@doc("The offer content")
model OfferContent {
  @doc("The display name of the offer")
  displayName: string;

  @doc("The summary")
  summary?: string;

  @doc("The long summary")
  longSummary?: string;

  @doc("The description")
  description?: string;

  @doc("The offer id")
  offerId: string;

  @doc("The offer type")
  offerType?: string;

  @doc("The support uri")
  supportUri?: string;

  @doc("The popularity of the offer")
  popularity?: int32;

  @doc("The publisher of the offer")
  offerPublisher?: OfferPublisher;

  @doc("The availability of the offer")
  availability?: OfferAvailability;

  @doc("The release type of the offer")
  releaseType?: OfferReleaseType;

  @doc("The icon files")
  iconFileUris?: IconFileUris;

  @doc("The terms and conditions")
  termsAndConditions?: TermsAndConditions;

  @doc("The category ids ")
  categoryIds?: string[];

  @doc("The operating systems")
  operatingSystems?: string[];
}

@doc("The offer publisher")
model OfferPublisher {
  @doc("The publisher Id")
  publisherId: string;

  @doc("The publisher name")
  publisherDisplayName: string;
}

@doc("Icon files")
model IconFileUris {
  @doc("uri of small icon")
  small?: string;

  @doc("uri of medium icon")
  medium?: string;

  @doc("uri of wide icon")
  wide?: string;

  @doc("uri of large icon")
  large?: string;
}

@doc("Terms and conditions")
model TermsAndConditions {
  @doc("The legal terms and conditions uri")
  legalTermsUri?: string;

  @doc("The type of legal terms")
  legalTermsType?: string;

  @doc("The privacy policy uri")
  privacyPolicyUri?: string;
}

@doc("The marketplace sku")
model MarketplaceSku {
  @doc("The catalog plan id")
  catalogPlanId: string;

  @doc("The marketplace sku id")
  marketplaceSkuId: string;

  @doc("The type of marketplace sku")
  type?: string;

  @doc("The display name of marketplace sku")
  displayName?: string;

  @doc("The summary")
  summary?: string;

  @doc("The long summary")
  longSummary?: string;

  @doc("The description")
  description?: string;

  @doc("The generation")
  generation?: string;

  @doc("The display rank of the sku")
  displayRank?: int32;

  @doc("The operating system supported")
  operatingSystem?: SkuOperatingSystem;

  @identifiers(#["name"])
  @doc("The marketplace sku version")
  marketplaceSkuVersions?: MarketplaceSkuVersion[];
}

@doc("The sku operating system")
model SkuOperatingSystem {
  @doc("The family of the operating system")
  family?: string;

  @doc("The type of the operating system")
  type?: string;

  @doc("The name of the operating system")
  name: string;
}

@doc("The marketplace sku version")
model MarketplaceSkuVersion {
  @doc("The name of sku version")
  name: string;

  @doc("The size of the image")
  sizeOnDiskInMb?: int32;

  @doc("The size of the download")
  minimumDownloadSizeInMb?: int32;

  @doc("The stage name")
  stageName?: string;

  @doc("The launch type")
  launchType?: OfferLaunchType;
}

@doc("Access token request object")
model AccessTokenRequest {
  @doc("The name of the publisher.")
  publisherName?: string;

  @doc("The region where the disk will be created.")
  edgeMarketPlaceRegion: string;

  @doc("The region where the disk will be created.")
  egeMarketPlaceResourceId?: string;

  @doc("The hyperv version.")
  hypervGeneration?: string;

  @doc("The marketplace sku.")
  marketPlaceSku?: string;

  @doc("The marketplace sku version.")
  marketPlaceSkuVersion?: string;

  @doc("The device sku.")
  deviceSku?: string;

  @doc("The device sku version.")
  deviceVersion?: string;
}

@doc("The disk access token")
model DiskAccessToken {
  @doc("The disk id.")
  diskId?: string;

  @doc("The access token creation status.")
  status?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @doc("The access token.")
  accessToken: string;
}

@doc("Access token request object")
model AccessTokenReadRequest {
  @doc("The name of the publisher.")
  requestId: string;
}
