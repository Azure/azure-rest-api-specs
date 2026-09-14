using Http;
using Rest;
using Azure.Core;

namespace ContainerAppsSandbox;

/** Errors returned by deleteContentPackage. */
alias DeleteContentPackageErrors = ErrorResult<401> | ErrorResult<500>;

/** Standard resource operations for deleting content packages. */
alias ContentPackageDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteContentPackageErrors
>;

/** OK. */
model ListContentPackageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: ContentPackageListResponse;
}

/** Errors returned by listContentPackages. */
alias ListContentPackageErrors = ErrorResult<401> | ErrorResult<500>;

/** Errors returned by getContentPackage. */
alias GetContentPackageErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** Standard resource operations for reading content packages. */
alias ContentPackageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetContentPackageErrors
>;

/** Created. */
model PostContentPackageUploadResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: ContentPackage;
}

/** Errors returned by postContentPackageUpload. */
alias PostContentPackageUploadErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<500>
  | ErrorResult<503>;

/** Standard resource operations for uploading content packages. */
alias ContentPackageUploadOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostContentPackageUploadErrors
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
@tag("ContentPackages")
interface ContentPackagesOperations {
  /** Deletes a content package by ID. */
  @summary("Deletes a content package by ID.")
  deleteContentPackage is ContentPackageDeleteOperations.ResourceDelete<ContentPackage>;

  /** Lists content packages for the sandbox group. */
  @summary("Lists content packages for the sandbox group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/contentpackages")
  @list
  @get
  listContentPackages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Continuation token for paginated results. */
      @query continuationToken?: string;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListContentPackageResult,
    DataPlaneStandardTraits,
    ListContentPackageErrors
  >;

  /** Gets a specific content package by ID. */
  @summary("Gets a specific content package by ID.")
  getContentPackage is ContentPackageGetOperations.ResourceRead<ContentPackage>;

  /** Creates a content package by uploading binary content. The request body should contain the binary content of the package, and optional labels can be provided as query parameters. The response will include details of the created content package. */
  @summary("Uploads a content package.")
  @action("upload")
  @actionSeparator("/")
  postContentPackageUpload is ContentPackageUploadOperations.ResourceCollectionAction<
    ContentPackage,
    {
      /** Media type of the uploaded content. */
      @header contentType?: string;

      /** Binary content of the package. */
      @body content: bytes;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    PostContentPackageUploadResult
  >;
}
