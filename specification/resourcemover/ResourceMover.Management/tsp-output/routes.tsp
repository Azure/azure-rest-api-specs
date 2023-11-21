import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ResourceMoverServiceAPI;

interface MoveCollectionsOperations {
  @doc("Creates or updates a move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
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

      @body body: MoveCollection;
    },
    MoveCollection
  >;

  @doc("Updates a move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
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

      @body body: UpdateMoveCollectionRequest;
    },
    MoveCollection
  >;

  @doc("Deletes a move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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
    },
    OperationStatus | void
  >;

  @doc("Gets the move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}")
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
    },
    MoveCollection
  >;

  @doc("""
Initiates prepare for the set of resources included in the request body. The
prepare operation is on the moveResources that are in the moveState
'PreparePending' or 'PrepareFailed', on a successful completion the
moveResource moveState do a transition to MovePending. To aid the user to
prerequisite the operation the client can call operation with validateOnly
property set to true.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/prepare")
  @post
  Prepare is Azure.Core.Foundations.Operation<
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

      @body body: PrepareRequest;
    },
    OperationStatus | void
  >;

  @doc("""
Moves the set of resources included in the request body. The move operation is
triggered after the moveResources are in the moveState 'MovePending' or
'MoveFailed', on a successful completion the moveResource moveState do a
transition to CommitPending. To aid the user to prerequisite the operation the
client can call operation with validateOnly property set to true.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/initiateMove")
  @post
  InitiateMove is Azure.Core.Foundations.Operation<
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

      @body body: ResourceMoveRequest;
    },
    OperationStatus | void
  >;

  @doc("""
Commits the set of resources included in the request body. The commit operation
is triggered on the moveResources in the moveState 'CommitPending' or
'CommitFailed', on a successful completion the moveResource moveState do a
transition to Committed. To aid the user to prerequisite the operation the
client can call operation with validateOnly property set to true.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/commit")
  @post
  Commit is Azure.Core.Foundations.Operation<
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

      @body body: CommitRequest;
    },
    OperationStatus | void
  >;

  @doc("""
Discards the set of resources included in the request body. The discard
operation is triggered on the moveResources in the moveState 'CommitPending' or
'DiscardFailed', on a successful completion the moveResource moveState do a
transition to MovePending. To aid the user to prerequisite the operation the
client can call operation with validateOnly property set to true.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/discard")
  @post
  Discard is Azure.Core.Foundations.Operation<
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

      @body body: DiscardRequest;
    },
    OperationStatus | void
  >;

  @doc("""
Computes, resolves and validate the dependencies of the moveResources in the
move collection.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/resolveDependencies")
  @post
  ResolveDependencies is Azure.Core.Foundations.Operation<
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
    },
    OperationStatus | void
  >;

  @doc("""
Removes the set of move resources included in the request body from move
collection. The orchestration is done by service. To aid the user to
prerequisite the operation the client can call operation with validateOnly
property set to true.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/bulkRemove")
  @post
  BulkRemove is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription ID.")
      @path
      subscriptionId: string;

      @path resourceGroupName: string;
      @path moveCollectionName: string;
      @body body: BulkRemoveRequest;
    },
    OperationStatus | void
  >;

  @summary("Get all Move Collections.")
  @doc("Get all the Move Collections in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Migrate/moveCollections")
  @get
  ListMoveCollectionsBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription ID.")
      @path
      subscriptionId: string;
    },
    MoveCollectionResultList
  >;

  @summary("Get all Move Collections.")
  @doc("Get all the Move Collections in the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections")
  @get
  ListMoveCollectionsByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Subscription ID.")
      @path
      subscriptionId: string;

      @doc("The Resource Group Name.")
      @path
      resourceGroupName: string;
    },
    MoveCollectionResultList
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
      @query
      sourceId: string;
    },
    RequiredForResourcesCollection
  >;
}

interface MoveResourcesOperations {
  @doc("Lists the Move Resources in the move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/moveResources")
  @get
  List is Azure.Core.Foundations.Operation<
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

      @doc("""
The filter to apply on the operation. For example, you can use
$filter=Properties/ProvisioningState eq 'Succeeded'.
""")
      @query
      $filter: string;
    },
    MoveResourceCollection
  >;

  @doc("Creates or updates a Move Resource in the move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/moveResources/{moveResourceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
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

      @doc("The Move Resource Name.")
      @path
      moveResourceName: string;

      @body body: MoveResource;
    },
    MoveResource | void
  >;

  @doc("Deletes a Move Resource from the move collection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/moveResources/{moveResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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

      @doc("The Move Resource Name.")
      @path
      moveResourceName: string;
    },
    OperationStatus | void
  >;

  @doc("Gets the Move Resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/moveResources/{moveResourceName}")
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

      @doc("The Move Resource Name.")
      @path
      moveResourceName: string;
    },
    MoveResource
  >;
}

interface UnresolvedDependenciesOperations {
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
      @query
      dependencyLevel: DependencyLevel;

      @doc("OData order by query option. For example, you can use $orderby=Count desc.")
      @query
      $orderby: string;

      @doc("The filter to apply on the operation. For example, $apply=filter(count eq 2).")
      @query
      $filter: string;
    },
    UnresolvedDependencyCollection
  >;
}

interface OperationsDiscoveryOperations {
  @route("/providers/Microsoft.Migrate/operations")
  @get
  Get is Azure.Core.Foundations.Operation<{}, OperationsDiscoveryCollection>;
}
