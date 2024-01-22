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
/**
 * The privateStore offer data structure.
 */
@parentResource(Collection)
model Offer is ProxyResource<OfferProperties> {
  /**
   * The offer ID to update or delete
   */
  @path
  @key("offerId")
  @segment("offers")
  name: string;
}

@armResourceOperations
interface Offers {
  /**
   * Gets information about a specific offer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_Get")
  get is ArmResourceRead<Offer>;

  /**
   * Update or add an offer to a specific collection of the private store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Offer>;

  /**
   * Deletes an offer from the given collection of private store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_Delete")
  delete is ArmResourceDeleteSync<Offer>;

  /**
   * Get a list of all private offers in the given private store and collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_List")
  list is ArmResourceListByParent<Offer>;

  /**
   * Upsert an offer with multiple context details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_UpsertOfferWithMultiContext")
  upsertOfferWithMultiContext is ArmResourceActionSync<
    Offer,
    MultiContextAndPlansPayload,
    Offer
  >;

  /**
   * Delete Private store offer. This is a workaround.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
