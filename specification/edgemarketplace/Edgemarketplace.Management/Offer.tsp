import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeMarketplace;
/**
 * An offer.
 */
@extensionResource
model Offer is Azure.ResourceManager.ExtensionResource<OfferProperties> {
  ...ResourceNameParameter<
    Resource = Offer,
    KeyName = "offerId",
    SegmentName = "offers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Offers {
  /**
   * Get a Offer
   */
  get is ArmResourceRead<
    Offer,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * Id of the offer
       */
      @path
      offerId: string;
    }
  >;

  /**
   * List Offer resources by parent
   */
  list is ArmResourceListByParent<
    Offer,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * The number of result items to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of result items per page.
       */
      @query("maxpagesize")
      maxpagesize?: int32;

      /**
       * Filter the result list using the given expression.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skip over when retrieving results.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * A long-running resource action.
   */
  generateAccessToken is ArmResourceActionAsync<
    Offer,
    AccessTokenRequest,
    ArmResponse<DiskAccessToken>,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * Id of the offer
       */
      @path
      offerId: string;
    }
  >;

  /**
   * get access token.
   */
  getAccessToken is ArmResourceActionSync<
    Offer,
    AccessTokenReadRequest,
    ArmResponse<DiskAccessToken>,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The fully qualified Azure Resource manager identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * Id of the offer
       */
      @path
      offerId: string;
    }
  >;
}

@@doc(Offer.name, "Id of the offer");
@@doc(Offer.properties, "The resource-specific properties for this resource.");
