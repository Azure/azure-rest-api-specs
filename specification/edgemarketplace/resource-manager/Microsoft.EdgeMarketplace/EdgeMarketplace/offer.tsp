import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.EdgeMarketplace;

@doc("An offer.")
model Offer is ExtensionResource<OfferProperties> {
  ...ResourceNameParameter<Offer, KeyName = "offerId", NamePattern = "">;
}

@@doc(Offer.name, "Id of the offer");

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "backcompat, ARM reviewed"
@armResourceOperations
interface Offers {
  @doc("Get a Offer")
  get is ArmResourceRead<Offer>;
  @doc("List Offer resources by parent")
  list is ArmResourceListByParent<
    Offer,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<Offer>;

      @doc("The number of result items to return.")
      @query("$top")
      top?: int32;

      @doc("The number of result items to skip.")
      @query("skip")
      skip?: int32;

      @doc("The maximum number of result items per page.")
      @query("maxpagesize")
      maxpagesize?: int32;

      @doc("Filter the result list using the given expression.")
      @query("$filter")
      filter?: string;

      @doc("Skip over when retrieving results.")
      @query("$skipToken")
      skipToken?: string;
    }
  >;
  @doc("A long-running resource action.")
  generateAccessToken is ArmResourceActionAsync<
    Offer,
    AccessTokenRequest,
    DiskAccessToken
  >;
  @doc("get access token.")
  getAccessToken is ArmResourceActionSync<
    Offer,
    AccessTokenReadRequest,
    DiskAccessToken
  >;
  listBySubscription is ArmListBySubscription<Offer>;
}
