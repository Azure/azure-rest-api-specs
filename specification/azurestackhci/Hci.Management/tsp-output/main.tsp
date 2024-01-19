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
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Microsoft.AzureStackHCI Rest API spec.")
namespace Microsoft.AzureStackHCI;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-09-01-preview API version.")
  v2023_09_01_preview: "2023-09-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-02-01 API version.")
  v2023_02_01: "2023-02-01",
}
