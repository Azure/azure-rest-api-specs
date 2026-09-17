using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Errors returned by deleteDiskImage. */
alias DeleteDiskImageErrors =
  | UnauthorizedErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for deleting disk images. */
alias DiskImageDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteDiskImageErrors
>;

/** Errors returned by listDiskImages. */
alias ListDiskImageErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** Query parameters for listing disk images. */
alias ListDiskImageTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing disk images. */
alias DiskImageListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListDiskImageErrors
>;

/** Errors returned by listDiskImagesPublic. */
alias ListPublicDiskImageErrors =
  | UnauthorizedErrorResult
  | InternalServerErrorResult;

/** Query parameters for listing public disk images. */
alias ListPublicDiskImageTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query skipToken?: string;
  },
  TraitContext.List
>;

/** Standard resource operations for listing public disk images. */
alias PublicDiskImageListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListPublicDiskImageErrors
>;

/** Errors returned by getDiskImagePublic. */
alias GetDiskImagePublicErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for reading public disk images. */
alias PublicDiskImageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetDiskImagePublicErrors
>;

/** Errors returned by getDiskImage. */
alias GetDiskImageErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Standard resource operations for reading disk images. */
alias DiskImageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetDiskImageErrors
>;

/** Created. */
model PostDiskImageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: DiskImage;
}

/** Errors returned by postDiskImage. */
alias PostDiskImageErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | TooManyRequestsErrorResult
  | InternalServerErrorResult;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, query parameters, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("DiskImages")
interface DiskImagesOperations {
  /** Deletes a disk image by ID. */
  @summary("Deletes a disk image by ID.")
  deleteDiskImage is DiskImageDeleteOperations.ResourceDelete<DiskImage>;

  /** Returns disk images scoped to the specified sandbox group. */
  @summary("Lists disk images in a sandbox group, with pagination support.")
  listDiskImages is DiskImageListOperations.ResourceList<
    DiskImage,
    ListDiskImageTraits
  >;

  /** Public images are admin-curated and shared across all sandbox groups. */
  @summary("Lists all public disk images available to the caller.")
  listDiskImagesPublic is PublicDiskImageListOperations.ResourceList<
    PublicDiskImage,
    ListPublicDiskImageTraits
  >;

  /** Public images are global and shared across all sandbox groups. */
  @summary("Gets a specific public disk image by name.")
  getDiskImagePublic is PublicDiskImageGetOperations.ResourceRead<PublicDiskImage>;

  /** Gets a specific disk image by ID. */
  @summary("Gets a specific disk image by ID.")
  getDiskImage is DiskImageGetOperations.ResourceRead<DiskImage>;

  /** Creates a new disk image from an OCI image reference. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
  @summary("Creates a new disk image from an OCI image reference.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
  @post
  postDiskImage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateDiskImageContent;
    },
    PostDiskImageResult,
    DataPlaneStandardTraits,
    PostDiskImageErrors
  >;
}
