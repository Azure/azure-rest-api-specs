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
  get is ArmResourceRead<Offer, Error = ErrorResponse>;

  /**
   * Update or add an offer to a specific collection of the private store.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Offer,
    Response = ArmResourceUpdatedResponse<Offer>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an offer from the given collection of private store.
   */
  delete is ArmResourceDeleteSync<Offer, Error = ErrorResponse>;

  /**
   * Get a list of all private offers in the given private store and collection
   */
  list is ArmResourceListByParent<
    Offer,
    Response = ArmResponse<OfferListResponse>,
    Error = ErrorResponse
  >;

  /**
   * Retrieve offer information with plans under required contexts restrictions.
   */
  contextsView is ArmResourceActionSync<
    Offer,
    CollectionOffersByAllContextsPayload,
    ArmResponse<Offer>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Upsert an offer with multiple context details.
   */
  upsertOfferWithMultiContext is ArmResourceActionSync<
    Offer,
    MultiContextAndPlansPayload,
    ArmResponse<Offer>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;
}

@@doc(Offer.name, "The offer ID to update or delete");
@@doc(Offer.properties, "The privateStore offer data structure.");
@@doc(Offers.createOrUpdate::parameters.resource, "");
@@doc(Offers.contextsView::parameters.body, "");
@@doc(Offers.upsertOfferWithMultiContext::parameters.body, "");
