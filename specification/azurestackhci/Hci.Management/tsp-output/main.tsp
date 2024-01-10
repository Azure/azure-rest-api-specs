import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GalleryImages.tsp";
import "./LogicalNetworks.tsp";
import "./MarketplaceGalleryImages.tsp";
import "./NetworkInterfaces.tsp";
import "./StorageContainers.tsp";
import "./VirtualHardDisks.tsp";
import "./VirtualMachineInstance.tsp";
import "./HybridIdentityMetadata.tsp";
import "./GuestAgent.tsp";
import "./ArcSetting.tsp";
import "./Cluster.tsp";
import "./Extension.tsp";
import "./Offer.tsp";
import "./Publisher.tsp";
import "./Sku.tsp";
import "./UpdateRun.tsp";
import "./UpdateSummaries.tsp";
import "./Update.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AzureStackHCI",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Microsoft.AzureStackHCI Rest API spec.")
namespace Microsoft.AzureStackHCI;
