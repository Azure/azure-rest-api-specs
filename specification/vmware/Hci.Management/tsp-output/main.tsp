import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GalleryImage.tsp";
import "./LogicalNetwork.tsp";
import "./MarketplaceGalleryImage.tsp";
import "./NetworkInterface.tsp";
import "./StorageContainer.tsp";
import "./VirtualHardDisk.tsp";
import "./VirtualMachineInstance.tsp";
import "./HybridIdentityMetadata.tsp";
import "./GuestAgent.tsp";
import "./ArcSetting.tsp";
import "./HciCluster.tsp";
import "./ArcExtension.tsp";
import "./Offer.tsp";
import "./Publisher.tsp";
import "./HciSku.tsp";
import "./UpdateRun.tsp";
import "./UpdateSummary.tsp";
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
@doc("The Microsoft.AzureStackHCI Rest API spec.")
namespace Azure.ResourceManager.Hci;
