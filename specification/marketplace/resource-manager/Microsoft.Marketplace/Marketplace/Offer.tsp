import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Collection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
/**
 * The privateStore offer data structure.
 */
@parentResource(Collection)
model Offer is Azure.ResourceManager.ProxyResource<OfferProperties> {
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
   * Gets information about a specific offer.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStoreCollectionOffer_Get")
  get is ArmResourceRead<Offer>;

  /**
   * Update or add an offer to a specific collection of the private store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Offer,
    Response = ArmResourceUpdatedResponse<Offer>
  >;

  /**
   * Deletes an offer from the given collection of private store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStoreCollectionOffer_Delete")
  delete is ArmResourceDeleteSync<Offer>;

  /**
   * Get a list of all private offers in the given private store and collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStoreCollectionOffer_List")
  list is ArmResourceListByParent<
    Offer,
    Response = ArmResponse<OfferListResponse>
  >;

  /**
   * Retrieve offer information with plans under required contexts restrictions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStoreCollectionOffer_ContextsView")
  contextsView is ArmResourceActionSync<
    Offer,
    CollectionOffersByAllContextsPayload,
    ArmResponse<Offer>,
    OptionalRequestBody = true
  >;

  /**
   * Upsert an offer with multiple context details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStoreCollectionOffer_UpsertOfferWithMultiContext")
  upsertOfferWithMultiContext is ArmResourceActionSync<
    Offer,
    MultiContextAndPlansPayload,
    ArmResponse<Offer>,
    OptionalRequestBody = true
  >;
}

@@doc(Offer.name, "The offer ID to update or delete");
@@doc(Offer.properties, "The privateStore offer data structure.");
@@doc(Offers.createOrUpdate::parameters.resource, "");
@@doc(Offers.contextsView::parameters.body, "");
@@doc(Offers.upsertOfferWithMultiContext::parameters.body, "");
