import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Offer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Sku details.
 */
@parentResource(Offer)
model Sku is ProxyResource<SkuProperties> {
  /**
   * The name of the SKU available within HCI cluster.
   */
  @path
  @key("skuName")
  @segment("skus")
  name: string;
}

@armResourceOperations
interface Skus {
  /**
   * Get SKU resource details within a offer of HCI Cluster.
   */
  get is ArmResourceRead<
    Sku,
    {
      ...BaseParameters<Sku>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Skus_ListByOffer")
  listByOffer is ArmResourceListByParent<
    Sku,
    {
      ...BaseParameters<Sku>;

      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}
