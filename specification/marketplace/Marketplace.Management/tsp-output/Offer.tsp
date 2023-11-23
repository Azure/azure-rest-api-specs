import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Collection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Marketplace;
@doc("The privateStore offer data structure.")
@parentResource(Collection)
model Offer is ProxyResource<OfferProperties> {
  @doc("The offer ID to update or delete")
  @path
  @key("offerId")
  @segment("offers")
  name: string;
}

@armResourceOperations
interface Offers {
  @doc("Gets information about a specific offer.")
  get is ArmResourceRead<Offer>;
  @doc("Update or add an offer to a specific collection of the private store.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Offer>;
  @doc("Deletes an offer from the given collection of private store.")
  delete is ArmResourceDeleteSync<Offer>;
  @doc("Get a list of all private offers in the given private store and collection")
  list is ArmResourceListByParent<Offer>;
  @doc("Upsert an offer with multiple context details.")
  upsertOfferWithMultiContext is ArmResourceActionSync<
    Offer,
    MultiContextAndPlansPayload,
    Offer
  >;
  @doc("Delete Private store offer. This is a workaround.")
  post is ArmResourceActionSync<Offer, Operation, {}>;
}
