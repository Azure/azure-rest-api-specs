import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "EdgeMarketPlaceClient",
  version: "2023-04-01-preview",
})
@doc("Edge Market Place Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeMarketPlace;

@doc("Access token request object")
model AccessTokenRequest{
	@doc("The region where the disk will be created.")
	edgeMarketPlaceRegion: string;

	@doc("The region where the disk will be created.")
	egeMarketPlaceResourceId: string;

	@doc("The hyperv version.")
	hypervGeneration: string;

	@doc("The marketplace sku.")
	marketPlaceSku: string;
  
	@doc("The marketplace sku version.")
	marketPlaceSkuVersion: string;
  
	@doc("The device sku.")
	deviceSku: string;
  
	@doc("The device sku version.")
	deviceVersion: string;
}

@doc("Offer search request")
model OfferSearchRequest{
	@doc("The publisher name.")
	publisherName: string;

	@doc("The offer Id.")
	offerId: string;

	@doc("The category.")
	category: string;
}

@doc("The disk access token")
model DiskAccessToken{
	@doc("The disk id.")
	diskId: string;

	@doc("The access token creation status.")
	status: string;

	@doc("The access token.")
	accessToken: string;
}

@doc("An offer.")
model Offer is ExtensionResource<OfferProperties> {
  @doc("Id of the offer")
  @key("offerId")
  @path
  @segment("offers")
  name: string;
}

@doc("The offer properties")
model OfferProperties  {
    @doc("The content version")
	contentVersion: string;
	
	@doc("The content url")
	contentUrl?: string;
	
	@doc("The offer content")
  offerContent: OfferContent;

	@doc("The resource provisioning state")
  provisioningState: ResourceProvisioningState;

  @doc("The marketplace skus")
  marketplaceSkus: Array<MarketplaceSku>;

}

@doc("The offer content")
model OfferContent
{
	@doc("The display name of the offer")
	displayName: string; 
		
	@doc("The summary")
    summary: string;
		 
    @doc("The long summary")
    longSummary: string;  
		 
    @doc("The description")
    description: string;  
		 
    @doc("The offer id")
    offerId: string;  

	@doc("The offer type")
    offerType: string;
		 
	@doc("The support uri")
	supportUri: string;  

	@doc("The popularity of the offer")
    popularity : integer;   
	
	@doc("The publisher of the offer")
    offerPublisher : OfferPublisher; 

	@doc("The availability of the offer")
	availability:OfferAvailability;
	
	@doc("The release type of the offer")
	releaseType:OfferReleaseType;
	
	@doc("The terms and conditions of the offer")
	termsAndConditions:TermsAndConditions;
	
	@doc("The icon files")
	iconFileUris:IconFileUris;
  
	@doc("The category ids ")
	categoryIds?:Array<string>;
	
}

@doc("Says if the offer is public/private")
enum OfferAvailability {

 @doc("Private") 
  Private,

  @doc("Public") 
  Public
}

@doc("Offer release type")
enum OfferReleaseType {
  @doc("Preview") 
  Preview,
  
  @doc("GA") 
  GA
}

@doc("Terms and conditions") 
model TermsAndConditions
{
	@doc("The legal terms and conditions uri")
	legalTermsUri:string;
	
	@doc("The type of legal terms")
	legalTermsType: string;
	
	@doc("The privacy policy uri")
	privacyPolicyUri: string;
}	

@doc("The offer publisher") 
model OfferPublisher
{
	@doc("The publisher Id")
	publisherId:string;
	
	@doc("The publisher name")
	publisherDisplayName: string;
}	

@doc("Icon files") 
model IconFileUris
{
	@doc("uri of small icon")
	small:string;
	
	@doc("uri of medium icon")
	medium: string;
	
	@doc("uri of wide icon")
	wide: string;
		
	@doc("uri of large icon")
	large: string;
}	

@doc("The marketplace sku") 
model MarketplaceSku
{
	@doc("The catalog plan id")
	catalogPlanId:string;
	
	@doc("The marketplace sku id")
	marketplaceSkuId: string;
	
	@doc("The type of marketplace sku")
	type: string;
		
	@doc("The display name of marketplace sku")
	displayName: string;
	
	@doc("The summary")
	summary?:string;
	
	@doc("The long summary")
	longSummary?: string;
	
	@doc("The description")
	description?: string;
	
	@doc("The operating system supported")
	operatingSystem: SkuOperatingSystem;

	@doc("The marketplace sku version")
	marketplaceSkuVersions: Array<MarketplaceSkuVersion>;

}	

@doc("The marketplace sku version") 
model MarketplaceSkuVersion
{
	@doc("The name of sku version")
	name:string;
	
	@doc("The size of the image")
	sizeOnDiskInMb?: integer;
	
	@doc("The size of the download")
	minimumDownloadSizeInMb?: integer;
	
	@doc("The stage name")
	stageName?: string;	
}

@doc("The sku operating system") 
model SkuOperatingSystem
{
	@doc("The family of the operating system")
	family:string;
	
	@doc("The type of the operating system")
	type: string;
	
	@doc("The name of the operating system")
	name: string;
}

@armResourceOperations
interface Offers
{
  list is ArmResourceListByParent<Offer,Azure.ResourceManager.Foundations.BaseParameters<Offer> &
			Azure.Core.StandardListQueryParameters &
			Azure.Core.FilterQueryParameter
	>;
  get is ArmResourceRead<Offer>;
  getAccessToken is ArmResourceActionAsync<Offer, AccessTokenRequest,
  DiskAccessToken>;
  search is ArmResourceActionSync<Offer, OfferSearchRequest, ResourceListResult<Offer>>;

}