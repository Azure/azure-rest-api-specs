import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Migrate;
@doc("Define the move collection.")
model MoveCollection is TrackedResource<MoveCollectionProperties> {
  @doc("The Move Collection Name.")
  @path
  @key("moveCollectionName")
  @segment("moveCollections")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MoveCollections {
  @doc("Gets the move collection.")
  get is ArmResourceRead<MoveCollection>;
  @doc("Creates or updates a move collection.")
  create is ArmResourceCreateOrReplaceSync<MoveCollection>;
  @doc("Updates a move collection.")
  update is ArmTagsPatchSync<MoveCollection>;
  @doc("Deletes a move collection.")
  delete is ArmResourceDeleteAsync<MoveCollection>;
  @doc("Get all the Move Collections in the resource group.")
  listMoveCollectionsByResourceGroup is ArmResourceListByParent<MoveCollection>;
  @doc("Get all the Move Collections in the subscription.")
  listMoveCollectionsBySubscription is ArmListBySubscription<MoveCollection>;
  @doc("Initiates prepare for the set of resources included in the request body. The prepare operation is on the moveResources that are in the moveState 'PreparePending' or 'PrepareFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.")
  prepare is ArmResourceActionAsync<
    MoveCollection,
    PrepareRequest,
    OperationStatus
  >;
  @doc("Moves the set of resources included in the request body. The move operation is triggered after the moveResources are in the moveState 'MovePending' or 'MoveFailed', on a successful completion the moveResource moveState do a transition to CommitPending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.")
  initiateMove is ArmResourceActionAsync<
    MoveCollection,
    ResourceMoveRequest,
    OperationStatus
  >;
  @doc("Commits the set of resources included in the request body. The commit operation is triggered on the moveResources in the moveState 'CommitPending' or 'CommitFailed', on a successful completion the moveResource moveState do a transition to Committed. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.")
  commit is ArmResourceActionAsync<
    MoveCollection,
    CommitRequest,
    OperationStatus
  >;
  @doc("Discards the set of resources included in the request body. The discard operation is triggered on the moveResources in the moveState 'CommitPending' or 'DiscardFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.")
  discard is ArmResourceActionAsync<
    MoveCollection,
    DiscardRequest,
    OperationStatus
  >;
  @doc("Computes, resolves and validate the dependencies of the moveResources in the move collection.")
  resolveDependencies is ArmResourceActionAsync<
    MoveCollection,
    {},
    OperationStatus
  >;
  @doc("Removes the set of move resources included in the request body from move collection. The orchestration is done by service. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.")
  bulkRemove is ArmResourceActionAsync<
    MoveCollection,
    BulkRemoveRequest,
    OperationStatus
  >;
  @doc("List of the move resources for which an arm resource is required for.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/requiredFor")
  @get
  ListRequiredFor is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name.")
      @path
      resourceGroupName: string;

      @doc("The Move Collection Name.")
      @path
      moveCollectionName: string;

      @doc("The sourceId for which the api is invoked.")
      @query("sourceId")
      sourceId: string;
    },
    RequiredForResourcesCollection
  >;

  @doc("Gets a list of unresolved dependencies.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/unresolvedDependencies")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name.")
      @path
      resourceGroupName: string;

      @doc("The Move Collection Name.")
      @path
      moveCollectionName: string;

      @doc("Defines the dependency level.")
      @query("dependencyLevel")
      dependencyLevel?: DependencyLevel;

      @doc("OData order by query option. For example, you can use $orderby=Count desc.")
      @query("$orderby")
      $orderby?: string;

      @doc("The filter to apply on the operation. For example, $apply=filter(count eq 2).")
      @query("$filter")
      $filter?: string;
    },
    UnresolvedDependencyCollection
  >;
}
