using Http;
using Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace ContainerAppsSandbox;

/** Error responses for the deleteDiskImage operation. */
alias DeleteDiskImageErrors =
  | UnauthorizedErrorResult
  | ConflictErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for creating disk images. */
alias DiskImageCreateOperations = ResourceOperations<
  DataPlaneStandardTraits,
  PostDiskImageErrors
>;

/** Shared operation traits for deleting disk images. */
alias DiskImageDeleteOperations = ResourceOperations<
  DataPlaneStandardTraits,
  DeleteDiskImageErrors
>;

/** Error responses for the listDiskImage operation. */
alias ListDiskImageErrors = UnauthorizedErrorResult | InternalServerErrorResult;

/** Query parameters for listing disk images. */
alias ListDiskImageTraits = QueryParametersTrait<
  {
    /** Continuation token for paginated results. */
    @query @continuationToken skipToken?: string;

    /** Comma-separated key=value labels that all resources must match. */
    @query labels?: string;
  },
  TraitContext.List
>;

/** Shared operation traits for listing disk images. */
alias DiskImageListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListDiskImageErrors
>;

/** Error responses for the listPublicDiskImage operation. */
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

/** Shared operation traits for listing public disk images. */
alias PublicDiskImageListOperations = ResourceOperations<
  DataPlaneStandardTraits,
  ListPublicDiskImageErrors
>;

/** Error responses for the getDiskImagePublic operation. */
alias GetDiskImagePublicErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading public disk images. */
alias PublicDiskImageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetDiskImagePublicErrors
>;

/** Error responses for the getDiskImage operation. */
alias GetDiskImageErrors =
  | UnauthorizedErrorResult
  | NotFoundErrorResult
  | InternalServerErrorResult;

/** Shared operation traits for reading disk images. */
alias DiskImageGetOperations = ResourceOperations<
  DataPlaneStandardTraits,
  GetDiskImageErrors
>;

/** The HTTP 201 response for the postDiskImage operation. */
model PostDiskImageResult {
  /** The HTTP 201 status code. */
  @statusCode statusCode: 201;

  /** The returned disk image. */
  @body body: DiskImage;
}

/** Error responses for the postDiskImage operation. */
alias PostDiskImageErrors =
  | BadRequestErrorResult
  | UnauthorizedErrorResult
  | TooManyRequestsErrorResult
  | InternalServerErrorResult;

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
  @summary("Creates a new disk image from an OCI image reference.")
  @action("diskimages")
  @actionSeparator("/")
  postDiskImage is DiskImageCreateOperations.ResourceAction<
    SandboxGroupScope,
    {
      /** The source and metadata for the new disk image. */
      @body body: CreateDiskImageContent;
    },
    PostDiskImageResult
  >;
}
