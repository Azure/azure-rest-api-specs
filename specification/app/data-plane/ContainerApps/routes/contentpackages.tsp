using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteContentPackage operation. */
alias DeleteContentPackageErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for deleting content packages. */
alias ContentPackageDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteContentPackageErrors
>;

/** Error responses for the listContentPackage operation. */
alias ListContentPackageErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Query parameters for listing content packages. */
alias ListContentPackageTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Comma-separated key=value labels that all resources must match. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Shared operation traits for listing content packages. */
alias ContentPackageListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListContentPackageErrors
>;

/** Error responses for the getContentPackage operation. */
alias GetContentPackageErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading content packages. */
alias ContentPackageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetContentPackageErrors
>;

/** The HTTP 201 response for the postContentPackageUpload operation. */
model PostContentPackageUploadResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned content package. */
  @body body: ContentPackage;
}

/** Error responses for the postContentPackageUpload operation. */
alias PostContentPackageUploadErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | InternalServerErrorResult
  | ServiceUnavailableErrorResult;

/** Shared operation traits for uploading content packages. */
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
  listContentPackages is ContentPackageListOperations.ResourceList<
    ContentPackage,
    ListContentPackageTraits
  >;

  /** Gets a specific content package by ID. */
  @summary("Gets a specific content package by ID.")
  getContentPackage is ContentPackageGetOperations.ResourceRead<ContentPackage>;

  /** Creates a content package from uploaded binary content and optional labels. */
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

      /** Comma-separated key=value labels that all resources must match. */
      @query labels?: string;
    },
    PostContentPackageUploadResult
  >;
}
