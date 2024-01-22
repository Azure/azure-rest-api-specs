import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Migrate;
/**
 * Define the move collection.
 */
model MoveCollection is TrackedResource<MoveCollectionProperties> {
  /**
   * The Move Collection Name.
   */
  @path
  @key("moveCollectionName")
  @segment("moveCollections")
  name: string;

  /**
   * The etag of the resource.
   */
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface MoveCollections {
  /**
   * Gets the move collection.
   */
  get is ArmResourceRead<
    MoveCollection,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    }
  >;

  /**
   * Creates or updates a move collection.
   */
  create is ArmResourceCreateOrReplaceSync<
    MoveCollection,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    }
  >;

  /**
   * Updates a move collection.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    MoveCollection,
    UpdateMoveCollectionRequest,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    }
  >;

  /**
   * Get all the Move Collections in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MoveCollections_ListMoveCollectionsByResourceGroup")
  listMoveCollectionsByResourceGroup is ArmResourceListByParent<MoveCollection>;

  /**
   * Get all the Move Collections in the subscription.
   */
  listMoveCollectionsBySubscription is ArmListBySubscription<MoveCollection>;

  /**
   * Initiates prepare for the set of resources included in the request body. The prepare operation is on the moveResources that are in the moveState 'PreparePending' or 'PrepareFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  prepare is ArmResourceActionAsync<
    MoveCollection,
    PrepareRequest,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Moves the set of resources included in the request body. The move operation is triggered after the moveResources are in the moveState 'MovePending' or 'MoveFailed', on a successful completion the moveResource moveState do a transition to CommitPending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  initiateMove is ArmResourceActionAsync<
    MoveCollection,
    ResourceMoveRequest,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Commits the set of resources included in the request body. The commit operation is triggered on the moveResources in the moveState 'CommitPending' or 'CommitFailed', on a successful completion the moveResource moveState do a transition to Committed. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  commit is ArmResourceActionAsync<
    MoveCollection,
    CommitRequest,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Discards the set of resources included in the request body. The discard operation is triggered on the moveResources in the moveState 'CommitPending' or 'DiscardFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  discard is ArmResourceActionAsync<
    MoveCollection,
    DiscardRequest,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Computes, resolves and validate the dependencies of the moveResources in the move collection.
   */
  resolveDependencies is ArmResourceActionAsync<
    MoveCollection,
    void,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Removes the set of move resources included in the request body from move collection. The orchestration is done by service. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  bulkRemove is ArmResourceActionAsync<
    MoveCollection,
    BulkRemoveRequest,
    OperationStatus,
    {
      ...BaseParameters<MoveCollection>;

      @path
      moverResourceSetName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of the move resources for which an arm resource is required for.
   */
  // FIXME: MoveCollections_ListRequiredFor could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/requiredFor")
  @get
  listRequiredFor is Azure.Core.Foundations.Operation<
    {
      /**
       * The Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The Resource Group Name.
       */
      @path
      resourceGroupName: string;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * The sourceId for which the api is invoked.
       */
      @query("sourceId")
      sourceId: string;
    },
    RequiredForResourcesCollection
  >;

  /**
   * Gets a list of unresolved dependencies.
   */
  // FIXME: UnresolvedDependencies_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UnresolvedDependencies_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Migrate/moveCollections/{moveCollectionName}/unresolvedDependencies")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The Subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The Resource Group Name.
       */
      @path
      resourceGroupName: string;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * Defines the dependency level.
       */
      @query("dependencyLevel")
      dependencyLevel?: DependencyLevel;

      /**
       * OData order by query option. For example, you can use $orderby=Count desc.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * The filter to apply on the operation. For example, $apply=filter(count eq 2).
       */
      @query("$filter")
      $filter?: string;
    },
    UnresolvedDependencyCollection
  >;
}

@@projectedName(MoveCollections.create::parameters.resource, "json", "body");
@@extension(MoveCollections.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(MoveCollections.create::parameters.resource, "");
@@projectedName(MoveCollections.update::parameters.properties, "json", "body");
@@extension(MoveCollections.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(MoveCollections.update::parameters.properties, "");
@@doc(MoveCollections.prepare::parameters.body, "");
@@doc(MoveCollections.initiateMove::parameters.body, "");
@@doc(MoveCollections.commit::parameters.body, "");
@@doc(MoveCollections.discard::parameters.body, "");
@@doc(MoveCollections.bulkRemove::parameters.body, "");
