import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Marketplace;
@doc("The Collection data structure.")
@parentResource(PrivateStore)
model Collection is ProxyResource<CollectionProperties> {
  @doc("The collection ID")
  @key("collectionId")
  @segment("collections")
  name: string;
}

@armResourceOperations
interface PrivateStoreCollection {
  @doc("Gets private store collection")
  get is ArmResourceRead<Collection>;
  @doc("Create or update private store collection")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Collection>;
  @doc("Delete a collection from the given private store.")
  delete is ArmResourceDeleteSync<Collection>;
  @doc("Gets private store collections list")
  list is ArmResourceListByParent<Collection>;
  @doc("transferring offers (copy or move) from source collection to target collection(s)")
  transferOffers is ArmResourceActionSync<
    Collection,
    TransferOffersProperties,
    TransferOffersResponse
  >;
  @doc("Delete all existing offers from the collection and enable approve all items.")
  approveAllItems is ArmResourceActionSync<Collection, void, Collection>;
  @doc("Disable approve all items for the collection.")
  disableApproveAllItems is ArmResourceActionSync<Collection, void, Collection>;
  @doc("Delete Private store collection. This is a workaround.")
  post is ArmResourceActionSync<Collection, Operation, void>;
}

@armResourceOperations
interface PrivateStoreCollectionInfos {
  @doc("Set rule for specific private store and collection")
  setCollectionRules is ArmResourceActionSync<
    Collection,
    SetRulesRequest,
    void
  >;
  @doc("Get a list of all private store rules in the given private store and collection")
  queryRules is ArmResourceActionSync<Collection, void, RuleListResponse>;
}

@armResourceOperations
interface PrivateStoreCollectionOffer {
  @doc("Get a list of all offers in the given collection according to the required contexts.")
  listByContexts is ArmResourceActionSync<
    Collection,
    CollectionOffersByAllContextsPayload,
    CollectionOffersByContextList
  >;
}
