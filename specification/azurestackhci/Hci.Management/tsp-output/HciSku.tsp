import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Offer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Sku details.")
@parentResource(Offer)
model HciSku is ProxyResource<SkuProperties> {
  @doc("The name of the SKU available within HCI cluster.")
  @path
  @key("skuName")
  @segment("skus")
  name: string;
}

@armResourceOperations
interface HciSkus {
  @doc("Get SKU resource details within a offer of HCI Cluster.")
  get is ArmResourceRead<
    HciSku,
    {
      ...BaseParameters<HciSku>;

      @doc("Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("List Skus available for a offer within the HCI Cluster.")
  listByOffer is ArmResourceListByParent<
    HciSku,
    {
      ...BaseParameters<HciSku>;

      @doc("Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.")
      @query("$expand")
      $expand?: string;
    }
  >;
}
