import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Offer details.
 */
@parentResource(Publisher)
model Offer is ProxyResource<OfferProperties> {
  /**
   * The name of the offer available within HCI cluster.
   */
  @path
  @key("offerName")
  @segment("offers")
  name: string;
}

@armResourceOperations
interface Offers {
  /**
   * Get Offer resource details within a publisher of HCI Cluster.
   */
  get is ArmResourceRead<
    Offer,
    {
      ...BaseParameters<Offer>;

      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * List Offers available for a publisher within the HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Offers_ListByPublisher")
  listByPublisher is ArmResourceListByParent<
    Offer,
    {
      ...BaseParameters<Offer>;

      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}
