using Http;
using Azure.Core;

namespace ContainerAppsSandbox;

/** No Content. */
model DeleteDiskImageResult204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful response returned by deleteDiskImage. */
alias DeleteDiskImageResult = DeleteDiskImageResult204;

/** Errors returned by deleteDiskImage. */
alias DeleteDiskImageErrors =
  | ErrorResult<401>
  | ErrorResult<409>
  | ErrorResult<500>;

/** OK. */
model ListDiskImageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImage[];
}

/** Errors returned by listDiskImages. */
alias ListDiskImageErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model ListPublicDiskImageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PublicDiskImage[];
}

/** Errors returned by listDiskImagesPublic. */
alias ListPublicDiskImageErrors = ErrorResult<401> | ErrorResult<500>;

/** OK. */
model GetDiskImagePublicResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PublicDiskImage;
}

/** Errors returned by getDiskImagePublic. */
alias GetDiskImagePublicErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model GetDiskImageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImage;
}

/** Errors returned by getDiskImage. */
alias GetDiskImageErrors =
  | ErrorResult<401>
  | ErrorResult<404>
  | ErrorResult<500>;

/** OK. */
model PostDiskImageResult {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: DiskImage;
}

/** Errors returned by postDiskImage. */
alias PostDiskImageErrors =
  | ErrorResult<400>
  | ErrorResult<401>
  | ErrorResult<429>
  | ErrorResult<500>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("DiskImages")
interface DiskImagesOperations {
  /** Deletes a disk image by ID. */
  @summary("Deletes a disk image by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
  @delete
  deleteDiskImage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteDiskImageResult,
    DataPlaneStandardTraits,
    DeleteDiskImageErrors
  >;

  /** Returns disk images scoped to the specified sandbox group. */
  @summary("Lists disk images in a sandbox group, with pagination support.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
  @get
  listDiskImages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListDiskImageResult,
    DataPlaneStandardTraits,
    ListDiskImageErrors
  >;

  /** Public images are admin-curated and shared across all sandbox groups. */
  @summary("Lists all public disk images available to the caller.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public")
  @get
  listDiskImagesPublic is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** page parameter. */
      @query page?: int32;

      /** pageSize parameter. */
      @query pageSize?: int32;
    },
    ListPublicDiskImageResult,
    DataPlaneStandardTraits,
    ListPublicDiskImageErrors
  >;

  /** Public images are global and shared across all sandbox groups. */
  @summary("Gets a specific public disk image by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public/{name}")
  @get
  getDiskImagePublic is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** name parameter. */
      @path name: string;
    },
    GetDiskImagePublicResult,
    DataPlaneStandardTraits,
    GetDiskImagePublicErrors
  >;

  /** Gets a specific disk image by ID. */
  @summary("Gets a specific disk image by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
  @get
  getDiskImage is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetDiskImageResult,
    DataPlaneStandardTraits,
    GetDiskImageErrors
  >;

  /** Creates a new disk image from an OCI image reference. */
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
