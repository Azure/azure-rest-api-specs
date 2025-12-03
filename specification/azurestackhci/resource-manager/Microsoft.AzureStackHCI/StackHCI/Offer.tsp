import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Publisher.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Offer details.
 */
@parentResource(Publisher)
model Offer is Azure.ResourceManager.ProxyResource<OfferProperties> {
  ...ResourceNameParameter<
    Resource = Offer,
    KeyName = "offerName",
    SegmentName = "offers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Offers {
  /**
   * Get Offer resource details within a publisher of HCI Cluster.
   */
  get is ArmResourceRead<
    Offer,
    Parameters = {
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
  listByPublisher is ArmResourceListByParent<
    Offer,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<OfferList>
  >;
}

@@doc(Offer.name, "The name of the offer available within HCI cluster.");
@@doc(Offer.properties, "Offer properties.");
