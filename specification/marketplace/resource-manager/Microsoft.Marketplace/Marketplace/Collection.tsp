import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
/**
 * The Collection data structure.
 */
@parentResource(PrivateStore)
model Collection is Azure.ResourceManager.ProxyResource<CollectionProperties> {
  ...ResourceNameParameter<
    Resource = Collection,
    KeyName = "collectionId",
    SegmentName = "collections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Collections {
  /**
   * Gets private store collection
   */
  get is ArmResourceRead<Collection, Error = ErrorResponse>;

  /**
   * Create or update private store collection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    Collection,
    Request = Collection,
    Response = ArmResourceUpdatedResponse<Collection>,
    Error = ErrorResponse,
    OptionalRequestBody = true
  >;

  /**
   * Delete a collection from the given private store.
   */
  delete is ArmResourceDeleteSync<Collection, Error = ErrorResponse>;

  /**
   * Gets private store collections list
   */
  list is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    Collection,
    Response = ArmResponse<CollectionsList>,
    Error = ErrorResponse
  >;

  /**
   * Set rule for specific private store and collection
   */
  @action("setRules")
  setCollectionRules is ArmResourceActionSync<
    Collection,
    SetRulesRequest,
    OkResponse,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Get a list of all private store rules in the given private store and collection
   */
  queryRules is ArmResourceActionSync<
    Collection,
    void,
    ArmResponse<RuleListResponse>,
    Error = ErrorResponse
  >;

  /**
   * transferring offers (copy or move) from source collection to target collection(s)
   */
  transferOffers is ArmResourceActionSync<
    Collection,
    TransferOffersProperties,
    ArmResponse<TransferOffersResponse>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Delete all existing offers from the collection and enable approve all items.
   */
  approveAllItems is ArmResourceActionSync<
    Collection,
    void,
    ArmResponse<Collection>,
    Error = ErrorResponse
  >;

  /**
   * Disable approve all items for the collection.
   */
  disableApproveAllItems is ArmResourceActionSync<
    Collection,
    void,
    ArmResponse<Collection>,
    Error = ErrorResponse
  >;

  /**
   * Get a list of all offers in the given collection according to the required contexts.
   */
  @action("mapOffersToContexts")
  @list
  listByContexts is ArmResourceActionSync<
    Collection,
    CollectionOffersByAllContextsPayload,
    ArmResponse<CollectionOffersByContextList>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;
}

@@doc(Collection.name, "The collection ID");
@@doc(Collection.properties, "The collection data structure.");
@@doc(Collections.createOrUpdate::parameters.resource, "");
@@doc(Collections.setCollectionRules::parameters.body, "");
@@doc(Collections.transferOffers::parameters.body, "");
@@doc(Collections.listByContexts::parameters.body, "");
