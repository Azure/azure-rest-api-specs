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


  /**
   * List Offers available across publishers for the HCI Cluster.
   */
  @get
  @action("offers")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<OfferList>,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

}

@@doc(Offer.name, "The name of the offer available within HCI cluster.");
@@doc(Offer.properties, "Offer properties.");

// Models

/**
 * List of Offer proxy resources for the HCI cluster.
 */
model OfferList is Azure.Core.Page<Offer>;

/**
 * Publisher properties.
 */
model OfferProperties {
  /**
   * Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Identifier of the Publisher for the offer
   */
  publisherId?: string;

  /**
   * JSON serialized catalog content of the offer
   */
  content?: string;

  /**
   * The API version of the catalog service used to serve the catalog content
   */
  contentVersion?: string;

  /**
   * Array of SKU mappings
   */
  @identifiers(#[])
  skuMappings?: SkuMappings[];
}

/**
 * SKU Mapping details.
 */
model SkuMappings {
  /**
   * Identifier of the CatalogPlan for the sku
   */
  catalogPlanId?: string;

  /**
   * Identifier for the sku
   */
  marketplaceSkuId?: string;

  /**
   * Array of SKU versions available
   */
  marketplaceSkuVersions?: string[];
}