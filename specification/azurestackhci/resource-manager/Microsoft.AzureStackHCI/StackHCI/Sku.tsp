import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Offer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Sku details.
 */
@parentResource(Offer)
model Sku is Azure.ResourceManager.ProxyResource<SkuProperties> {
  ...ResourceNameParameter<
    Resource = Sku,
    KeyName = "skuName",
    SegmentName = "skus",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Skus {
  /**
   * Get SKU resource details within a offer of HCI Cluster.
   */
  get is ArmResourceRead<
    Sku,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * List Skus available for a offer within the HCI Cluster.
   */
  listByOffer is ArmResourceListByParent<
    Sku,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<SkuList>
  >;
}

@@doc(Sku.name, "The name of the SKU available within HCI cluster.");
@@doc(Sku.properties, "SKU properties.");
