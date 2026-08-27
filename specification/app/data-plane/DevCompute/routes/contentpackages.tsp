using Http;
using Azure.Core;

namespace AzureDevCompute;

/** Accepted. */
model DeleteContentpackagesResponse202 {
  /** HTTP response status code. */
  @statusCode statusCode: 202;
}

/** No Content. */
model DeleteContentpackagesResponse204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful responses returned by deleteContentpackages. */
alias DeleteContentpackagesResponse =
  | DeleteContentpackagesResponse202
  | DeleteContentpackagesResponse204;

/** Errors returned by deleteContentpackages. */
alias DeleteContentpackagesErrors =
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

/** OK. */
model ListContentPackageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ContentPackageListResponse;
}

/** Errors returned by listContentpackages. */
alias ListContentPackageErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetContentPackageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ContentPackageResponse;
}

/** Errors returned by getContentpackages. */
alias GetContentPackageErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** Created. */
model PostContentpackagesUploadResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: ContentPackageResponse;
}

/** Service Unavailable. */
@error
model PostContentpackagesUploadError503 {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Errors returned by postContentpackagesUpload. */
alias PostContentpackagesUploadErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<500>
  | PostContentpackagesUploadError503;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("contentpackages")
interface ContentpackagesOperations {
  /** Deletes a content package by ID. */
  @summary("Deletes a content package by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
  @delete
  deleteContentpackages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteContentpackagesResponse,
    DataPlaneStandardTraits,
    DeleteContentpackagesErrors
  >;

  /** Lists content packages for the sandbox group. */
  @summary("Lists content packages for the sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages")
  @get
  listContentpackages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListContentPackageResponse,
    DataPlaneStandardTraits,
    ListContentPackageErrors
  >;

  /** Gets a specific content package by ID. */
  @summary("Gets a specific content package by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
  @get
  getContentpackages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetContentPackageResponse,
    DataPlaneStandardTraits,
    GetContentPackageErrors
  >;

  /** Creates a content package by uploading binary content. The request body should contain the binary content of the package, and optional labels can be provided as query parameters. The response will include details of the created content package. */
  @summary("Uploads a content package.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/upload")
  @post
  postContentpackagesUpload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    PostContentpackagesUploadResponse,
    DataPlaneStandardTraits,
    PostContentpackagesUploadErrors
  >;
}
