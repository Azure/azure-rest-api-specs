using Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace AzureDevCompute;

/** Accepted. */
model DeleteDiskimagesResponse202 {
  /** HTTP response status code. */
  @statusCode statusCode: 202;
}

/** No Content. */
model DeleteDiskimagesResponse204 {
  /** HTTP response status code. */
  @statusCode statusCode: 204;
}

/** Successful responses returned by deleteDiskimages. */
alias DeleteDiskimagesResponse =
  | DeleteDiskimagesResponse202
  | DeleteDiskimagesResponse204;

/** Errors returned by deleteDiskimages. */
alias DeleteDiskimagesErrors =
  | ErrorResponse<401>
  | ErrorResponse<409>
  | InternalServerErrorNoBody;

/** OK. */
model ListDiskImageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse[];
}

/** Errors returned by listDiskimages. */
alias ListDiskImageErrors = ErrorResponse<401> | InternalServerErrorNoBody;

/** OK. */
model GetDiskimagesOperationsResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageOperationResponse;
}

/** Errors returned by getDiskimagesOperations. */
alias GetDiskimagesOperationsErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model ListPublicDiskImageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PublicDiskImageResponse[];
}

/** Errors returned by listDiskimagesPublic. */
alias ListPublicDiskImageErrors =
  | ErrorResponse<401>
  | InternalServerErrorNoBody;

/** OK. */
model GetPublicDiskImageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: PublicDiskImageResponse;
}

/** Errors returned by getDiskimagesPublic. */
alias GetPublicDiskImageErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
model GetDiskImageResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Errors returned by getDiskimages. */
alias GetDiskImageErrors =
  | ErrorResponse<401>
  | ErrorResponse<404>
  | InternalServerErrorNoBody;

/** OK. */
@removed(ApiVersions.v2026_09_01)
model PostDiskimagesDockerfileResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Errors returned by postDiskimagesDockerfile. */
alias PostDiskimagesDockerfileErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<404>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** Accepted. */
@removed(ApiVersions.v2026_09_01)
model PostDiskimagesDockerfileAsyncResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: DiskImageOperationResponse;
}

/** Errors returned by postDiskimagesDockerfileAsync. */
alias PostDiskimagesDockerfileAsyncErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** OK. */
@removed(ApiVersions.v2026_09_01)
model PutDiskimagesPreviewResponse200 {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Created. */
@removed(ApiVersions.v2026_09_01)
model PutDiskimagesPreviewResponse201 {
  /** HTTP response status code. */
  @statusCode statusCode: 201;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Successful responses returned by putDiskimagesPreview. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The named union preserves multiple success status codes from the source contract."
@removed(ApiVersions.v2026_09_01)
union PutDiskimagesPreviewResponse {
  /** OK. */
  Response200: PutDiskimagesPreviewResponse200,

  /** Created. */
  Response201: PutDiskimagesPreviewResponse201,
}

/** Errors returned by putDiskimagesPreview. */
alias PutDiskimagesPreviewErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<409>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** OK. */
@added(ApiVersions.v2026_09_01)
model PutDiskimagesResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Errors returned by putDiskimages. */
alias PutDiskimagesErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** Accepted. */
@removed(ApiVersions.v2026_09_01)
model PutDiskimagesAsyncPreviewResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: DiskImageOperationResponse;
}

/** Errors returned by putDiskimagesAsyncPreview. */
alias PutDiskimagesAsyncPreviewErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** Accepted. */
@added(ApiVersions.v2026_09_01)
model PutDiskimagesAsyncResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: DiskImageOperationResponse;
}

/** Errors returned by putDiskimagesAsync. */
alias PutDiskimagesAsyncErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** OK. */
@removed(ApiVersions.v2026_09_01)
model PutDiskimagesV2Response {
  /** HTTP response status code. */
  @statusCode statusCode: 200;

  /** Response body. */
  @body body: DiskImageResponse;
}

/** Errors returned by putDiskimagesV2. */
alias PutDiskimagesV2Errors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

/** Accepted. */
@removed(ApiVersions.v2026_09_01)
model PutDiskimagesV2AsyncResponse {
  /** HTTP response status code. */
  @statusCode statusCode: 202;

  /** Response body. */
  @body body: DiskImageOperationResponse;
}

/** Errors returned by putDiskimagesV2Async. */
alias PutDiskimagesV2AsyncErrors =
  | ErrorResponse<400>
  | ErrorResponse<401>
  | ErrorResponse<429>
  | InternalServerErrorNoBody;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom operations preserve the source OpenAPI response status codes, bare arrays, and route shapes."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation names are derived from the established source routes to keep generated names deterministic."
@tag("diskimages")
interface DiskimagesOperations {
  /** Deletes a disk image by ID. */
  @summary("Deletes a disk image by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
  @delete
  deleteDiskimages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    DeleteDiskimagesResponse,
    DataPlaneStandardTraits,
    DeleteDiskimagesErrors
  >;

  /** Returns disk images scoped to the specified sandbox group. */
  @summary("Lists disk images in a sandbox group, with pagination support.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
  @get
  listDiskimages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Page number to retrieve. */
      @query("Page") page?: int32;

      /** Number of items to return per page. */
      @query("PageSize") pageSize?: int32;

      /** Label selector for filtering resources. Accepts comma-separated key=value pairs(e.g., "env=prod,team=backend"). Returns only resources that have all specified labels with matching values. */
      @query labels?: string;
    },
    ListDiskImageResponse,
    DataPlaneStandardTraits,
    ListDiskImageErrors
  >;

  /** Gets the status of an async disk image operation. */
  @summary("Gets the status of an async disk image operation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/operations/{operationId}")
  @get
  getDiskimagesOperations is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** operationId parameter. */
      @path operationId: string;
    },
    GetDiskimagesOperationsResponse,
    DataPlaneStandardTraits,
    GetDiskimagesOperationsErrors
  >;

  /** Public images are admin-curated and shared across all sandbox groups. */
  @summary("Lists all public disk images available to the caller.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public")
  @get
  listDiskimagesPublic is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** page parameter. */
      @query page?: int32;

      /** pageSize parameter. */
      @query pageSize?: int32;
    },
    ListPublicDiskImageResponse,
    DataPlaneStandardTraits,
    ListPublicDiskImageErrors
  >;

  /** Public images are global and shared across all sandbox groups. */
  @summary("Gets a specific public disk image by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/public/{name}")
  @get
  getDiskimagesPublic is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** name parameter. */
      @path name: string;
    },
    GetPublicDiskImageResponse,
    DataPlaneStandardTraits,
    GetPublicDiskImageErrors
  >;

  /** Gets a specific disk image by ID. */
  @summary("Gets a specific disk image by ID.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/{id}")
  @get
  getDiskimages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** id parameter. */
      @path id: string;
    },
    GetDiskImageResponse,
    DataPlaneStandardTraits,
    GetDiskImageErrors
  >;

  /** Builds a disk image from a Dockerfile (synchronous). */
  @removed(ApiVersions.v2026_09_01)
  @summary("Builds a disk image from a Dockerfile (synchronous).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile")
  @post
  postDiskimagesDockerfile is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: BuildDiskImageFromDockerfileRequest;
    },
    PostDiskimagesDockerfileResponse,
    DataPlaneStandardTraits,
    PostDiskimagesDockerfileErrors
  >;

  /** Builds a disk image from a Dockerfile (asynchronous). */
  @removed(ApiVersions.v2026_09_01)
  @summary("Builds a disk image from a Dockerfile (asynchronous).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/dockerfile/async")
  @post
  postDiskimagesDockerfileAsync is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: BuildDiskImageFromDockerfileRequest;
    },
    PostDiskimagesDockerfileAsyncResponse,
    DataPlaneStandardTraits,
    PostDiskimagesDockerfileAsyncErrors
  >;

  /** Creates a new disk image from an OCI image reference. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Creates a new disk image from an OCI image reference.")
  @sharedRoute
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
  @put
  putDiskimagesPreview is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: DiskImageRequest;
    },
    PutDiskimagesPreviewResponse,
    DataPlaneStandardTraits,
    PutDiskimagesPreviewErrors
  >;

  /** Creates a new disk image from an OCI image reference. */
  @added(ApiVersions.v2026_09_01)
  @summary("Creates a new disk image from an OCI image reference.")
  @sharedRoute
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages")
  @put
  putDiskimages is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateDiskImageRequest;
    },
    PutDiskimagesResponse,
    DataPlaneStandardTraits,
    PutDiskimagesErrors
  >;

  /** Creates a disk image asynchronously from an OCI image reference. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Creates a disk image asynchronously from an OCI image reference.")
  @sharedRoute
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/async")
  @put
  putDiskimagesAsyncPreview is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: DiskImageRequest;
    },
    PutDiskimagesAsyncPreviewResponse,
    DataPlaneStandardTraits,
    PutDiskimagesAsyncPreviewErrors
  >;

  /** Creates a disk image asynchronously from an OCI image reference. */
  @added(ApiVersions.v2026_09_01)
  @summary("Creates a disk image asynchronously from an OCI image reference.")
  @sharedRoute
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/async")
  @put
  putDiskimagesAsync is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateDiskImageRequest;
    },
    PutDiskimagesAsyncResponse,
    DataPlaneStandardTraits,
    PutDiskimagesAsyncErrors
  >;

  /** Creates a new disk image using the V2 discriminated source model. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Creates a new disk image using the V2 discriminated source model.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2")
  @put
  putDiskimagesV2 is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateDiskImageV2Request;
    },
    PutDiskimagesV2Response,
    DataPlaneStandardTraits,
    PutDiskimagesV2Errors
  >;

  /** Creates a disk image asynchronously from a discriminated V2 source model. */
  @removed(ApiVersions.v2026_09_01)
  @summary("Creates a disk image asynchronously from a discriminated V2 source model.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/sandboxGroups/{sandboxGroupName}/diskimages/v2/async")
  @put
  putDiskimagesV2Async is Foundations.Operation<
    {
      ...AzureResourceScope;

      /** Request body. */
      @body body: CreateDiskImageV2Request;
    },
    PutDiskimagesV2AsyncResponse,
    DataPlaneStandardTraits,
    PutDiskimagesV2AsyncErrors
  >;
}
