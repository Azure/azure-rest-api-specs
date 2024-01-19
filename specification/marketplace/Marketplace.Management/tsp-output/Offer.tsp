import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Collection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets information about a specific offer.")
  @operationId("PrivateStoreCollectionOffer_Get")
  get is ArmResourceRead<Offer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update or add an offer to a specific collection of the private store.")
  @operationId("PrivateStoreCollectionOffer_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Offer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an offer from the given collection of private store.")
  @operationId("PrivateStoreCollectionOffer_Delete")
  delete is ArmResourceDeleteSync<Offer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a list of all private offers in the given private store and collection")
  @operationId("PrivateStoreCollectionOffer_List")
  list is ArmResourceListByParent<Offer>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Upsert an offer with multiple context details.")
  @operationId("PrivateStoreCollectionOffer_UpsertOfferWithMultiContext")
  upsertOfferWithMultiContext is ArmResourceActionSync<
    Offer,
    MultiContextAndPlansPayload,
    Offer
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete Private store offer. This is a workaround.")
  @operationId("PrivateStoreCollectionOffer_Post")
  post is ArmResourceActionSync<Offer, Operation, void>;
}

@@projectedName(Offers.createOrUpdate::parameters.resource, "json", "payload");
@@extension(Offers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@doc(Offers.createOrUpdate::parameters.resource, "");
@@projectedName(Offers.upsertOfferWithMultiContext::parameters.body,
  "json",
  "payload"
);
@@extension(Offers.upsertOfferWithMultiContext::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(Offers.upsertOfferWithMultiContext::parameters.body, "");
@@projectedName(Offers.post::parameters.body, "json", "payload");
@@extension(Offers.post::parameters.body, "x-ms-client-name", "payload");
@@doc(Offers.post::parameters.body, "");
