using Http;
using Azure.Core;

namespace AzureDevCompute;

/** Accepted. */
model DeleteSnapshotsResponse202 {
  /** HTTP response status code. */
  @statusCode statusCode: 202;
}

/** No Content. */
model DeleteSnapshotsResponse204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful responses returned by deleteSnapshots. */
alias DeleteSnapshotsResponse =
  | DeleteSnapshotsResponse202
  | DeleteSnapshotsResponse204;

/** Errors returned by deleteSnapshots. */
alias DeleteSnapshotsErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model ListSnapshotResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotResponse[];
}

/** Errors returned by listSnapshots. */
alias ListSnapshotErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetSnapshotsCountResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: int32;
}

/** Errors returned by getSnapshotsCount. */
alias GetSnapshotsCountErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetSnapshotResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: SnapshotResponse;
}

/** Errors returned by getSnapshots. */
alias GetSnapshotErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("snapshots")
interface SnapshotsOperations {
  /** Deletes a snapshot by ID. */
  @summary("Deletes a snapshot by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/{id}")
  @delete
  deleteSnapshots is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteSnapshotsResponse,
    DataPlaneStandardTraits,
    DeleteSnapshotsErrors
  >;

  /** Lists snapshots with pagination support. */
  @summary("Lists snapshots with pagination support.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots")
  @get
  listSnapshots is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListSnapshotResponse,
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
    GetSnapshotsCountResponse,
    DataPlaneStandardTraits,
    GetSnapshotsCountErrors
  >;

  /** Gets a specific snapshot by ID. */
  @summary("Gets a specific snapshot by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/snapshots/{id}")
  @get
  getSnapshots is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetSnapshotResponse,
    DataPlaneStandardTraits,
    GetSnapshotErrors
  >;
}
