using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteSnapshot. */
alias DeleteSnapshotErrors = ErrorResult<401> | ErrorResult<500>;

/** Standard resource operations for deleting snapshots. */
alias SnapshotDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteSnapshotErrors
>;

/** Errors returned by listSnapshots. */
alias ListSnapshotErrors = ErrorResult<401> | ErrorResult<500>;

/** Query parameters for listing snapshots. */
alias ListSnapshotTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing snapshots. */
alias SnapshotListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListSnapshotErrors
>;

/** OK. */
model GetSnapshotsCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotCountResponse;
}

/** Errors returned by getSnapshotsCount. */
alias GetSnapshotsCountErrors = ErrorResult<401> | ErrorResult<500>;

/** Errors returned by getSnapshot. */
alias GetSnapshotErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for reading snapshots. */
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
