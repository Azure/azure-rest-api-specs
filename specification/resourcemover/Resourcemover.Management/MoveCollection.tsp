import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Migrate;
/**
 * Define the move collection.
 */
model MoveCollection
  is Azure.ResourceManager.TrackedResource<MoveCollectionProperties> {
  ...ResourceNameParameter<
    Resource = MoveCollection,
    KeyName = "moveCollectionName",
    SegmentName = "moveCollections",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * Defines the MSI properties of the Move Collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface MoveCollections {
  /**
   * Gets the move collection.
   */
  get is ArmResourceRead<MoveCollection>;

  /**
   * Creates or updates a move collection.
   */
  create is ArmResourceCreateOrReplaceSync<MoveCollection>;

  /**
   * Updates a move collection.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MoveCollection,
    PatchModel = UpdateMoveCollectionRequest
  >;

  /**
   * Deletes a move collection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    MoveCollection,
    Response = ArmResponse<OperationStatus> | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the Move Collections in the resource group.
   */
  listMoveCollectionsByResourceGroup is ArmResourceListByParent<
    MoveCollection,
    Response = ArmResponse<MoveCollectionResultList>
  >;

  /**
   * Get all the Move Collections in the subscription.
   */
  listMoveCollectionsBySubscription is ArmListBySubscription<
    MoveCollection,
    Response = ArmResponse<MoveCollectionResultList>
  >;

  /**
   * Initiates prepare for the set of resources included in the request body. The prepare operation is on the moveResources that are in the moveState 'PreparePending' or 'PrepareFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  prepare is ArmResourceActionAsync<
    MoveCollection,
    {
      @bodyRoot
      body?: PrepareRequest;
    },
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Moves the set of resources included in the request body. The move operation is triggered after the moveResources are in the moveState 'MovePending' or 'MoveFailed', on a successful completion the moveResource moveState do a transition to CommitPending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  initiateMove is ArmResourceActionAsync<
    MoveCollection,
    {
      @bodyRoot
      body?: ResourceMoveRequest;
    },
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Commits the set of resources included in the request body. The commit operation is triggered on the moveResources in the moveState 'CommitPending' or 'CommitFailed', on a successful completion the moveResource moveState do a transition to Committed. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  commit is ArmResourceActionAsync<
    MoveCollection,
    {
      @bodyRoot
      body?: CommitRequest;
    },
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Discards the set of resources included in the request body. The discard operation is triggered on the moveResources in the moveState 'CommitPending' or 'DiscardFailed', on a successful completion the moveResource moveState do a transition to MovePending. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  discard is ArmResourceActionAsync<
    MoveCollection,
    {
      @bodyRoot
      body?: DiscardRequest;
    },
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Computes, resolves and validate the dependencies of the moveResources in the move collection.
   */
  resolveDependencies is ArmResourceActionAsync<
    MoveCollection,
    void,
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Removes the set of move resources included in the request body from move collection. The orchestration is done by service. To aid the user to prerequisite the operation the client can call operation with validateOnly property set to true.
   */
  bulkRemove is ArmResourceActionAsync<
    MoveCollection,
    {
      @bodyRoot
      body?: BulkRemoveRequest;
    },
    ArmResponse<OperationStatus>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List of the move resources for which an arm resource is required for.
   */
  @get
  @action("requiredFor")
  listRequiredFor is ArmResourceActionSync<
    MoveCollection,
    void,
    ArmResponse<RequiredForResourcesCollection>,
    Parameters = {
      /**
       * The sourceId for which the api is invoked.
       */
      @query("sourceId")
      sourceId: string;
    }
  >;

  /**
   * Gets a list of unresolved dependencies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("unresolvedDependencies")
  @operationId("UnresolvedDependencies_Get")
  unresolvedDependenciesGet is ArmResourceActionSync<
    MoveCollection,
    void,
    ArmResponse<UnresolvedDependencyCollection>,
    Parameters = {
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
    }
  >;
}

@@doc(MoveCollection.name, "The Move Collection Name.");
@@encodedName(MoveCollection.eTag, "application/json", "etag");
@@doc(MoveCollection.properties, "Defines the move collection properties.");
@@doc(MoveCollections.create::parameters.resource, "");
@@doc(MoveCollections.update::parameters.properties, "");
