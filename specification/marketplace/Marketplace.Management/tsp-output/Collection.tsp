import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
/**
 * The Collection data structure.
 */
@parentResource(PrivateStore)
model Collection is ProxyResource<CollectionProperties> {
  /**
   * The collection ID
   */
  @path
  @key("collectionId")
  @segment("collections")
  name: string;
}

@armResourceOperations
interface Collections {
  /**
   * Gets private store collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_Get")
  get is ArmResourceRead<Collection>;

  /**
   * Create or update private store collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Collection>;

  /**
   * Delete a collection from the given private store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_Delete")
  delete is ArmResourceDeleteSync<Collection>;

  /**
   * Gets private store collections list
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_List")
  list is ArmResourceListByParent<Collection>;

  /**
   * Set rule for specific private store and collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SetCollectionRules")
  setCollectionRules is ArmResourceActionSync<
    Collection,
    SetRulesRequest,
    void
  >;

  /**
   * Get a list of all private store rules in the given private store and collection
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryRules")
  queryRules is ArmResourceActionSync<Collection, void, RuleListResponse>;

  /**
   * transferring offers (copy or move) from source collection to target collection(s)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_TransferOffers")
  transferOffers is ArmResourceActionSync<
    Collection,
    TransferOffersProperties,
    TransferOffersResponse
  >;

  /**
   * Delete all existing offers from the collection and enable approve all items.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_ApproveAllItems")
  approveAllItems is ArmResourceActionSync<Collection, void, Collection>;

  /**
   * Disable approve all items for the collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_DisableApproveAllItems")
  disableApproveAllItems is ArmResourceActionSync<Collection, void, Collection>;

  /**
   * Get a list of all offers in the given collection according to the required contexts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollectionOffer_ListByContexts")
  listByContexts is ArmResourceActionSync<
    Collection,
    CollectionOffersByAllContextsPayload,
    CollectionOffersByContextList
  >;

  /**
   * Delete Private store collection. This is a workaround.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStoreCollection_Post")
  post is ArmResourceActionSync<Collection, Operation, void>;
}

@@projectedName(Collections.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@extension(Collections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@doc(Collections.createOrUpdate::parameters.resource, "");
@@projectedName(Collections.setCollectionRules::parameters.body,
  "json",
  "payload"
);
@@extension(Collections.setCollectionRules::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(Collections.setCollectionRules::parameters.body, "");
@@projectedName(Collections.transferOffers::parameters.body, "json", "payload");
@@extension(Collections.transferOffers::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(Collections.transferOffers::parameters.body, "");
@@projectedName(Collections.listByContexts::parameters.body, "json", "payload");
@@extension(Collections.listByContexts::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(Collections.listByContexts::parameters.body, "");
@@projectedName(Collections.post::parameters.body, "json", "payload");
@@extension(Collections.post::parameters.body, "x-ms-client-name", "payload");
@@doc(Collections.post::parameters.body, "");
