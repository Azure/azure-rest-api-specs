using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteSnapshotResult204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful response returned by deleteSnapshot. */
alias DeleteSnapshotResult = DeleteSnapshotResult204;

/** Errors returned by deleteSnapshot. */
alias DeleteSnapshotErrors = ErrorResult<401> | ErrorResult<500>;

/** A page of snapshots. */
model SnapshotList {
  /** Snapshots returned by the request. */
  @pageItems
  value: Snapshot[];

  /** Link to the next page of snapshots, if one is available. */
  @nextLink
  nextLink?: string;
}

/** OK. */
model ListSnapshotResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotList;
}

/** Errors returned by listSnapshots. */
alias ListSnapshotErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetSnapshotsCountResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: int32;
}

/** Errors returned by getSnapshotsCount. */
alias GetSnapshotsCountErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetSnapshotResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: Snapshot;
}

/** Errors returned by getSnapshot. */
alias GetSnapshotErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, pagination models, query parameters, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("snapshots")
interface SnapshotsOperations {
  /** Deletes a snapshot by ID. */
  @summary("Deletes a snapshot by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/{id}")
  @delete
  deleteSnapshot is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteSnapshotResult,
    DataPlaneStandardTraits,
    DeleteSnapshotErrors
  >;

  /** Lists snapshots with pagination support. */
  @summary("Lists snapshots with pagination support.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots")
  @list
  @get
  listSnapshots is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Continuation token for paginated results. */
      @query continuationToken?: string;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListSnapshotResult,
    DataPlaneStandardTraits,
    ListSnapshotErrors
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/{id}")
  @get
  getSnapshot is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSnapshotResult,
    DataPlaneStandardTraits,
    GetSnapshotErrors
  >;
}
