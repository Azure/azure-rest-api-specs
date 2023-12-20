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
model PrivateStoreCollectionInfo is ProxyResource<CollectionProperties> {
  @doc("The collection ID")
  @path
  @key("collectionId")
  @segment("collections")
  name: string;
}

@armResourceOperations
interface PrivateStoreCollectionInfos {
  @doc("Gets private store collection")
  get is ArmResourceRead<PrivateStoreCollectionInfo>;
  @doc("Create or update private store collection")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateStoreCollectionInfo>;
  @doc("Delete a collection from the given private store.")
  delete is ArmResourceDeleteSync<PrivateStoreCollectionInfo>;
  @doc("Gets private store collections list")
  list is ArmResourceListByParent<PrivateStoreCollectionInfo>;
  @doc("Set rule for specific private store and collection")
  setCollectionRules is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    SetRulesRequest,
    void
  >;
  @doc("Get a list of all private store rules in the given private store and collection")
  queryRules is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    void,
    RuleListResponse
  >;
  @doc("transferring offers (copy or move) from source collection to target collection(s)")
  transferOffers is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    TransferOffersProperties,
    TransferOffersResponse
  >;
  @doc("Delete all existing offers from the collection and enable approve all items.")
  approveAllItems is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    void,
    PrivateStoreCollectionInfo
  >;
  @doc("Disable approve all items for the collection.")
  disableApproveAllItems is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    void,
    PrivateStoreCollectionInfo
  >;
  @doc("Get a list of all offers in the given collection according to the required contexts.")
  listByContexts is ArmResourceActionSync<
    PrivateStoreCollectionInfo,
    CollectionOffersByAllContextsPayload,
    CollectionOffersByContextList
  >;
  @doc("Delete Private store collection. This is a workaround.")
  post is ArmResourceActionSync<PrivateStoreCollectionInfo, Operation, void>;
}
