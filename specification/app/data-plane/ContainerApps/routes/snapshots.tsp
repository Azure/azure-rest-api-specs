using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteSnapshot operation. */
alias DeleteSnapshotErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for deleting snapshots. */
alias SnapshotDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteSnapshotErrors
>;

/** Error responses for the listSnapshot operation. */
alias ListSnapshotErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** Query parameters for listing snapshots. */
alias ListSnapshotTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Comma-separated key=value labels that all resources must match. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Shared operation traits for listing snapshots. */
alias SnapshotListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListSnapshotErrors
>;

/** The HTTP 200 response for the getSnapshotsCount operation. */
model GetSnapshotsCountResult {
  /** The HTTP 200 status code. */
  @statusCode statusCode: 200;

  /** The returned snapshot count. */
  @body body: SnapshotCountResponse;
}

/** Error responses for the getSnapshotsCount operation. */
alias GetSnapshotsCountErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Error responses for the getSnapshot operation. */
alias GetSnapshotErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading snapshots. */
alias SnapshotGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetSnapshotErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
@tag("snapshots")
interface SnapshotsOperations {
  /** Deletes a snapshot by ID. */
  @summary("Deletes a snapshot by ID.")
  deleteSnapshot is SnapshotDeleteOperations.ResourceDelete<Snapshot>;

  /** Lists snapshots with pagination support. */
  @summary("Lists snapshots with pagination support.")
  listSnapshots is SnapshotListOperations.ResourceList<
    Snapshot,
    ListSnapshotTraits
  >;

  /** Gets the total count of snapshots. */
  @summary("Gets the total count of snapshots.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/count")
  @get
  getSnapshotsCount is Foundations.Operation<
    {
      ...AzureResourceScope;
    },
    GetSnapshotsCountResult,
    DataPlaneStandardTraits,
    GetSnapshotsCountErrors
  >;

  /** Gets a specific snapshot by ID. */
  @summary("Gets a specific snapshot by ID.")
  getSnapshot is SnapshotGetOperations.ResourceRead<Snapshot>;
}
