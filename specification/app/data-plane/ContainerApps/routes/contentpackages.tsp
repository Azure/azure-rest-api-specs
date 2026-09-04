using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** Accepted. */
model DeleteContentPackageResult202 {
  /** HTTP response status code. */
  @statusCode statusCode: 202;
}

/** No Content. */
model DeleteContentPackageResult204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful responses returned by deleteContentPackage. */
alias DeleteContentPackageResult =
  | DeleteContentPackageResult202
  | DeleteContentPackageResult204;

/** Errors returned by deleteContentPackage. */
alias DeleteContentPackageErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model ListContentPackageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ContentPackageListResponse;
}

/** Errors returned by listContentPackages. */
alias ListContentPackageErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetContentPackageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ContentPackage;
}

/** Errors returned by getContentPackage. */
alias GetContentPackageErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Created. */
model PostContentPackageUploadResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: ContentPackage;
}

/** Service Unavailable. */
@error
model PostContentPackageUploadError503 {
  /** HTTP response status code. */
  @statusCode statusCode: 503;
}

/** Errors returned by postContentPackageUpload. */
alias PostContentPackageUploadErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<500>
  | PostContentPackageUploadError503;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("ContentPackages")
interface ContentPackagesOperations {
  /** Deletes a content package by ID. */
  @summary("Deletes a content package by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
  @delete
  deleteContentPackage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteContentPackageResult,
    DataPlaneStandardTraits,
    DeleteContentPackageErrors
  >;

  /** Lists content packages for the sandbox group. */
  @summary("Lists content packages for the sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages")
  @get
  listContentPackages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListContentPackageResult,
    DataPlaneStandardTraits,
    ListContentPackageErrors
  >;

  /** Gets a specific content package by ID. */
  @summary("Gets a specific content package by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/{id}")
  @get
  getContentPackage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetContentPackageResult,
    DataPlaneStandardTraits,
    GetContentPackageErrors
  >;

  /** Creates a content package by uploading binary content. The request body should contain the binary content of the package, and optional labels can be provided as query parameters. The response will include details of the created content package. */
  @summary("Uploads a content package.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages/upload")
  @post
  postContentPackageUpload is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Media type of the uploaded content. */
      @header contentType?: string;

      /** Binary content of the package. */
      @body content: bytes;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    PostContentPackageUploadResult,
    DataPlaneStandardTraits,
    PostContentPackageUploadErrors
  >;
}
